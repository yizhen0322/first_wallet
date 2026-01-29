// lib/shared/contracts/app_contracts.dart
// Single-file contract: Providers + Repository interfaces + API models.
// Notes:
// - Backend never signs EVM tx.
// - Testnet-first (Sepolia, chainId=11155111). Future networks via feature flags.
// - DateTime expects ISO-8601 strings from backend.

import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'app_contracts.freezed.dart';
part 'app_contracts.g.dart';

// -----------------------------------------------------------------------------
// Env
// -----------------------------------------------------------------------------

@immutable
class Env {
  final String apiBaseUrl;
  final String deviceId;

  const Env({required this.apiBaseUrl, required this.deviceId});

  /// Replace with your actual environment selection strategy.
  factory Env.production() => const Env(
        apiBaseUrl: 'https://api.example.com',
        deviceId: 'device-id-placeholder',
      );
}

final envProvider = Provider<Env>((ref) => Env.production());

// -----------------------------------------------------------------------------
// Session state
// -----------------------------------------------------------------------------

@immutable
class AuthSession {
  final String? accessToken;
  final String? refreshToken;
  final bool isLoggedIn;

  const AuthSession({
    this.accessToken,
    this.refreshToken,
    required this.isLoggedIn,
  });
}

final authSessionProvider = StateProvider<AuthSession>(
  (ref) => const AuthSession(isLoggedIn: false),
);

@immutable
class ChainConfig {
  final int chainId;
  final String name;
  final String rpcUrl;
  final String? explorerBaseUrl;

  const ChainConfig({
    required this.chainId,
    required this.name,
    required this.rpcUrl,
    this.explorerBaseUrl,
  });
}

@freezed
sealed class WalletSummary with _$WalletSummary {
  const factory WalletSummary({
    required String id,
    required String name,
    required String backupLabel,
    required bool backupRequired,
  }) = _WalletSummary;

  factory WalletSummary.fromJson(Map<String, dynamic> json) =>
      _$WalletSummaryFromJson(json);
}

const String _defaultSepoliaRpcUrl = String.fromEnvironment(
  'SEPOLIA_RPC_URL',
  defaultValue: 'https://rpc.sepolia.org',
);

const String _defaultMainnetRpcUrl = String.fromEnvironment(
  'MAINNET_RPC_URL',
  defaultValue: '',
);

final availableNetworksProvider = Provider<List<ChainConfig>>((ref) {
  return const [
    ChainConfig(
      chainId: 11155111,
      name: 'Sepolia',
      rpcUrl: _defaultSepoliaRpcUrl,
      explorerBaseUrl: 'https://sepolia.etherscan.io',
    ),
    ChainConfig(
      chainId: 1,
      name: 'Ethereum',
      rpcUrl: _defaultMainnetRpcUrl,
      explorerBaseUrl: 'https://etherscan.io',
    ),
  ];
});

/// Phase 1: Sepolia testnet by default.
final selectedNetworkProvider = StateProvider<ChainConfig>(
  (ref) => ref.read(availableNetworksProvider).first,
);

@immutable
class WalletSession {
  final bool isUnlocked;
  final String? activeAddress;

  const WalletSession({required this.isUnlocked, this.activeAddress});
}

final walletSessionProvider = StateProvider<WalletSession>(
  (ref) => const WalletSession(isUnlocked: false),
);

// -----------------------------------------------------------------------------
// Dio client
// -----------------------------------------------------------------------------

final dioProvider = Provider<Dio>((ref) {
  final env = ref.read(envProvider);

  final dio = Dio(
    BaseOptions(
      baseUrl: env.apiBaseUrl,
      connectTimeout: const Duration(seconds: 15),
      receiveTimeout: const Duration(seconds: 20),
      sendTimeout: const Duration(seconds: 20),
      headers: <String, dynamic>{
        'Accept': 'application/json',
      },
    ),
  );

  dio.interceptors.add(
    InterceptorsWrapper(
      onRequest: (options, handler) {
        final session = ref.read(authSessionProvider);
        final token = session.accessToken;

        if (token != null && token.isNotEmpty) {
          options.headers['Authorization'] = 'Bearer $token';
        }

        // Device id for risk / fraud / support correlation.
        options.headers['X-Device-Id'] = env.deviceId;

        handler.next(options);
      },
      // NOTE: Token refresh is implementation-specific.
      // In production, you typically intercept 401 and call AuthRepository.refresh,
      // then retry the original request. Keep it centralized.
      onError: (err, handler) {
        handler.next(err);
      },
    ),
  );

  return dio;
});

// -----------------------------------------------------------------------------
// Repository interfaces (contracts)
// -----------------------------------------------------------------------------

abstract class AuthRepository {
  Future<AuthResponse> register({
    required String email,
    required String password,
    required String deviceId,
  });

  Future<AuthResponse> login({
    required String email,
    required String password,
    required String deviceId,
  });

  Future<AuthTokens> refresh({
    required String refreshToken,
    required String deviceId,
  });

  Future<void> logout({
    required String refreshToken,
    required String deviceId,
  });
}

abstract class AccountRepository {
  Future<MeResponse> getMe();

  Future<void> updateMe({
    String? baseCurrency,
  });

  Future<FeatureFlagsResponse> getFeatureFlags();
}

abstract class KycRepository {
  Future<KycStartResponse> startKyc();

  Future<KycStatusResponse> getStatus();
}

abstract class OtpRepository {
  Future<OtpRequestResponse> requestOtp({required String phone});

  Future<OtpVerifyResponse> verifyOtp({
    required String phone,
    required String code,
  });
}

abstract class CardsRepository {
  Future<String> orderCard({
    required CardType type,
    ShippingAddress? shipping,
  });

  Future<List<CardSummary>> listCards();

  Future<CardStatus> setFreeze({required String cardId, required bool freeze});

  Future<void> setLimits({
    required String cardId,
    required String currency,
    required double dailyLimit,
    required double monthlyLimit,
  });

  Future<CardTransactionsResponse> listTransactions({
    required String cardId,
    String? cursor,
    int limit = 50,
  });
}

abstract class SwapRepository {
  Future<SwapQuoteResponse> quote(SwapQuoteRequest req);

  Future<SwapBuildResponse> build(SwapBuildRequest req);
}

/// Local storage for wallets.
abstract class WalletRepository {
  /// Saves a new wallet with encrypted mnemonic.
  Future<void> saveWallet({
    required String id,
    required String name,

    /// If null, this is a watch-only wallet (no private keys stored).
    String? mnemonic,
    required int wordCount,
    required bool usePassphrase,

    /// If null, repo may infer from [mnemonic].
    bool? backupRequired,

    /// The address to watch (for watch-only wallets).
    String? watchAddress,
  });

  /// Lists all saved wallets (metadata only, no private keys).
  Future<List<WalletSummary>> listWallets();

  /// Retrieves the decrypted mnemonic for a specific wallet.
  /// BE CAREFUL: Use only when needed (signing/export).
  Future<String?> getMnemonic(String id);

  /// Retrieves the stored watch address for a watch-only wallet.
  /// Returns null if not a watch-only wallet or not set.
  Future<String?> getWatchAddress(String id);

  /// Deletes a wallet by ID.
  Future<void> deleteWallet(String id);
}

/// EVM (mobile-side): chain RPC + signing.
/// Backend never signs.
abstract class EvmChainRepository {
  Future<String> getNativeBalanceWei(String address);

  Future<int> getNonce(String address);

  /// Returns EIP-1559 or legacy suggestion.
  Future<FeeSuggestion> getFeeSuggestion();

  Future<int> estimateGas(EvmUnsignedTx tx);

  Future<String> sendRawTx(String rawTxHex);

  Future<TxReceipt?> getReceipt(String txHash);
}

abstract class WalletEngine {
  Future<String> createMnemonic({int words = 12});

  Future<String> deriveAddressFromMnemonic({
    required String mnemonic,
    String derivationPath = "m/44'/60'/0'/0/0",
  });

  /// Returns signed raw tx hex.
  Future<String> signEvmTx({
    required String mnemonic,
    required int chainId,
    required EvmTxRequest tx,
    required int nonce,
  });

  /// Exports the raw private key (EVM) for display.
  /// BE CAREFUL: Only show after strict user auth.
  Future<String> getPrivateKey({
    required String mnemonic,
    String derivationPath = "m/44'/60'/0'/0/0",
  });

  /// Exports the BIP32 Root Key (xprv).
  Future<String> getExtendedPrivateKey({required String mnemonic});

  /// Exports the Account Extended Public Key (xpub).
  Future<String> getAccountExtendedPublicKey({required String mnemonic});
}

// Providers for implementations (wire them in your data layer)
final authRepositoryProvider = Provider<AuthRepository>(
  (ref) => throw UnimplementedError(),
);
final accountRepositoryProvider = Provider<AccountRepository>(
  (ref) => throw UnimplementedError(),
);
final kycRepositoryProvider = Provider<KycRepository>(
  (ref) => throw UnimplementedError(),
);
final otpRepositoryProvider = Provider<OtpRepository>(
  (ref) => throw UnimplementedError(),
);
final cardsRepositoryProvider = Provider<CardsRepository>(
  (ref) => throw UnimplementedError(),
);
final swapRepositoryProvider = Provider<SwapRepository>(
  (ref) => throw UnimplementedError(),
);
final walletRepositoryProvider = Provider<WalletRepository>(
  (ref) => throw UnimplementedError(),
);

final evmChainRepositoryProvider = Provider<EvmChainRepository>(
  (ref) => throw UnimplementedError(),
);
final walletEngineProvider = Provider<WalletEngine>(
  (ref) => throw UnimplementedError(),
);

/// Feature flags cache.
final featureFlagsProvider = FutureProvider<FeatureFlagsResponse>((ref) async {
  final repo = ref.read(accountRepositoryProvider);
  return repo.getFeatureFlags();
});

// -----------------------------------------------------------------------------
// Error envelope
// -----------------------------------------------------------------------------

@freezed
sealed class ApiErrorEnvelope with _$ApiErrorEnvelope {
  const factory ApiErrorEnvelope({
    required ApiError error,
  }) = _ApiErrorEnvelope;

  factory ApiErrorEnvelope.fromJson(Map<String, dynamic> json) =>
      _$ApiErrorEnvelopeFromJson(json);
}

@freezed
sealed class ApiError with _$ApiError {
  const factory ApiError({
    required String code,
    required String message,
    @Default(<String, dynamic>{}) Map<String, dynamic> details,
  }) = _ApiError;

  factory ApiError.fromJson(Map<String, dynamic> json) =>
      _$ApiErrorFromJson(json);
}

// -----------------------------------------------------------------------------
// Auth + Account
// -----------------------------------------------------------------------------

@freezed
sealed class AuthTokens with _$AuthTokens {
  const factory AuthTokens({
    required String accessToken,
    required String refreshToken,
  }) = _AuthTokens;

  factory AuthTokens.fromJson(Map<String, dynamic> json) =>
      _$AuthTokensFromJson(json);
}

@freezed
sealed class UserSummary with _$UserSummary {
  const factory UserSummary({
    required String id,
    required String email,
  }) = _UserSummary;

  factory UserSummary.fromJson(Map<String, dynamic> json) =>
      _$UserSummaryFromJson(json);
}

@freezed
sealed class AuthResponse with _$AuthResponse {
  const factory AuthResponse({
    required String accessToken,
    required String refreshToken,
    required UserSummary user,
  }) = _AuthResponse;

  factory AuthResponse.fromJson(Map<String, dynamic> json) =>
      _$AuthResponseFromJson(json);
}

enum KycStatus {
  // ignore: constant_identifier_names
  not_started,
  pending,
  approved,
  rejected,
}

@freezed
sealed class MeResponse with _$MeResponse {
  const factory MeResponse({
    required String id,
    required String email,
    required String baseCurrency,
    required KycStatus kycStatus,
    required bool phoneVerified,
  }) = _MeResponse;

  factory MeResponse.fromJson(Map<String, dynamic> json) =>
      _$MeResponseFromJson(json);
}

// -----------------------------------------------------------------------------
// Feature flags
// -----------------------------------------------------------------------------

@freezed
sealed class FeatureFlagsResponse with _$FeatureFlagsResponse {
  const factory FeatureFlagsResponse({
    required List<ChainFlag> chains,
    required FeatureFlags features,
    required Policies policies,
  }) = _FeatureFlagsResponse;

  factory FeatureFlagsResponse.fromJson(Map<String, dynamic> json) =>
      _$FeatureFlagsResponseFromJson(json);
}

@freezed
sealed class ChainFlag with _$ChainFlag {
  const factory ChainFlag({
    required int chainId,
    required bool enabled,
  }) = _ChainFlag;

  factory ChainFlag.fromJson(Map<String, dynamic> json) =>
      _$ChainFlagFromJson(json);
}

@freezed
sealed class FeatureFlags with _$FeatureFlags {
  const factory FeatureFlags({
    required bool cardsEnabled,
    required bool swapEnabled,
    required bool exportKeysEnabled,
    required bool tronEnabled,
  }) = _FeatureFlags;

  factory FeatureFlags.fromJson(Map<String, dynamic> json) =>
      _$FeatureFlagsFromJson(json);
}

@freezed
sealed class Policies with _$Policies {
  const factory Policies({
    /// Example: 50 = 0.50%
    required int maxSlippageBps,
    required bool requireKycForCardOrder,
  }) = _Policies;

  factory Policies.fromJson(Map<String, dynamic> json) =>
      _$PoliciesFromJson(json);
}

// -----------------------------------------------------------------------------
// KYC
// -----------------------------------------------------------------------------

@freezed
sealed class KycStartResponse with _$KycStartResponse {
  const factory KycStartResponse({
    required String provider,
    required String sdkToken,
    required DateTime expiresAt,
  }) = _KycStartResponse;

  factory KycStartResponse.fromJson(Map<String, dynamic> json) =>
      _$KycStartResponseFromJson(json);
}

@freezed
sealed class KycStatusResponse with _$KycStatusResponse {
  const factory KycStatusResponse({
    required KycStatus status,
    required DateTime updatedAt,
  }) = _KycStatusResponse;

  factory KycStatusResponse.fromJson(Map<String, dynamic> json) =>
      _$KycStatusResponseFromJson(json);
}

// -----------------------------------------------------------------------------
// OTP
// -----------------------------------------------------------------------------

@freezed
sealed class OtpRequestResponse with _$OtpRequestResponse {
  const factory OtpRequestResponse({
    /// e.g. "sent"
    required String status,
  }) = _OtpRequestResponse;

  factory OtpRequestResponse.fromJson(Map<String, dynamic> json) =>
      _$OtpRequestResponseFromJson(json);
}

@freezed
sealed class OtpVerifyResponse with _$OtpVerifyResponse {
  const factory OtpVerifyResponse({
    /// e.g. "verified"
    required String status,
  }) = _OtpVerifyResponse;

  factory OtpVerifyResponse.fromJson(Map<String, dynamic> json) =>
      _$OtpVerifyResponseFromJson(json);
}

// -----------------------------------------------------------------------------
// Cards
// -----------------------------------------------------------------------------

enum CardType { virtual, physical }

enum CardStatus { processing, active, frozen, closed, failed }

@freezed
sealed class ShippingAddress with _$ShippingAddress {
  const factory ShippingAddress({
    required String name,
    required String address1,
    String? address2,
    required String city,
    required String postcode,
    required String country,
  }) = _ShippingAddress;

  factory ShippingAddress.fromJson(Map<String, dynamic> json) =>
      _$ShippingAddressFromJson(json);
}

@freezed
sealed class CardSummary with _$CardSummary {
  const factory CardSummary({
    required String id,
    required CardType type,
    required CardStatus status,
    required String last4,
  }) = _CardSummary;

  factory CardSummary.fromJson(Map<String, dynamic> json) =>
      _$CardSummaryFromJson(json);
}

@freezed
sealed class CardsListResponse with _$CardsListResponse {
  const factory CardsListResponse({
    required List<CardSummary> cards,
  }) = _CardsListResponse;

  factory CardsListResponse.fromJson(Map<String, dynamic> json) =>
      _$CardsListResponseFromJson(json);
}

@freezed
sealed class CardTransaction with _$CardTransaction {
  const factory CardTransaction({
    required String id,
    required double amount,
    required String currency,
    required String merchant,

    /// e.g. authorized/settled/declined
    required String status,
    required DateTime time,
    @Default(<String, dynamic>{}) Map<String, dynamic> metadata,
  }) = _CardTransaction;

  factory CardTransaction.fromJson(Map<String, dynamic> json) =>
      _$CardTransactionFromJson(json);
}

@freezed
sealed class CardTransactionsResponse with _$CardTransactionsResponse {
  const factory CardTransactionsResponse({
    String? cursor,
    required List<CardTransaction> transactions,
  }) = _CardTransactionsResponse;

  factory CardTransactionsResponse.fromJson(Map<String, dynamic> json) =>
      _$CardTransactionsResponseFromJson(json);
}

// -----------------------------------------------------------------------------
// Swap
// -----------------------------------------------------------------------------

@freezed
sealed class SwapQuoteRequest with _$SwapQuoteRequest {
  const factory SwapQuoteRequest({
    required int chainId,

    /// Token address. Use 0x000..000 for native ETH OR standardize to WETH.
    required String fromToken,
    required String toToken,

    /// In smallest unit (wei for ETH, token decimals for ERC20)
    required String amountIn,

    /// Active EOA address
    required String taker,

    /// Example: 50 = 0.50%
    required int slippageBps,

    /// "auto" or specific DEX name
    required String preferredDex,
  }) = _SwapQuoteRequest;

  factory SwapQuoteRequest.fromJson(Map<String, dynamic> json) =>
      _$SwapQuoteRequestFromJson(json);
}

@freezed
sealed class SwapRoute with _$SwapRoute {
  const factory SwapRoute({
    /// "0x", "1inch", "paraswap", etc.
    required String aggregator,

    /// Suggested DEX route name
    required String dex,

    /// Gas estimate (string to avoid int overflow)
    required String estimatedGas,
  }) = _SwapRoute;

  factory SwapRoute.fromJson(Map<String, dynamic> json) =>
      _$SwapRouteFromJson(json);
}

@freezed
sealed class SwapApproval with _$SwapApproval {
  const factory SwapApproval({
    required bool isRequired,
    required String spender,

    /// Approval amount in smallest unit
    required String amount,
  }) = _SwapApproval;

  factory SwapApproval.fromJson(Map<String, dynamic> json) =>
      _$SwapApprovalFromJson(json);
}

@freezed
sealed class SwapQuoteResponse with _$SwapQuoteResponse {
  const factory SwapQuoteResponse({
    required String quoteId,
    required int chainId,
    required String amountIn,
    required String amountOut,

    /// AmountOut after slippage protection
    required String minOut,
    required SwapRoute route,
    required SwapApproval approval,
    required DateTime expiresAt,
    @Default(<String>[]) List<String> warnings,
  }) = _SwapQuoteResponse;

  factory SwapQuoteResponse.fromJson(Map<String, dynamic> json) =>
      _$SwapQuoteResponseFromJson(json);
}

enum TxType { legacy, eip1559 }

@freezed
sealed class EvmTxRequest with _$EvmTxRequest {
  const factory EvmTxRequest({
    required String to,
    required String data,

    /// Hex or decimal string. Standardize in backend.
    required String value,

    /// Gas limit as string (avoid int overflow)
    required String gasLimit,
    required TxType type,

    /// Legacy
    String? gasPrice,

    /// EIP-1559
    String? maxFeePerGas,
    String? maxPriorityFeePerGas,
  }) = _EvmTxRequest;

  factory EvmTxRequest.fromJson(Map<String, dynamic> json) =>
      _$EvmTxRequestFromJson(json);
}

@freezed
sealed class SwapFee with _$SwapFee {
  const factory SwapFee({
    /// Estimated network fee in wei (string)
    required String estimatedNetworkFeeWei,
  }) = _SwapFee;

  factory SwapFee.fromJson(Map<String, dynamic> json) =>
      _$SwapFeeFromJson(json);
}

@freezed
sealed class SwapBuildRequest with _$SwapBuildRequest {
  const factory SwapBuildRequest({
    required String quoteId,

    /// The signer EOA
    required String taker,

    /// Recipient address for output tokens
    required String recipient,
  }) = _SwapBuildRequest;

  factory SwapBuildRequest.fromJson(Map<String, dynamic> json) =>
      _$SwapBuildRequestFromJson(json);
}

@freezed
sealed class SwapBuildResponse with _$SwapBuildResponse {
  const factory SwapBuildResponse({
    required EvmTxRequest tx,
    required SwapFee fee,
  }) = _SwapBuildResponse;

  factory SwapBuildResponse.fromJson(Map<String, dynamic> json) =>
      _$SwapBuildResponseFromJson(json);
}

// -----------------------------------------------------------------------------
// EVM helper models
// -----------------------------------------------------------------------------

@immutable
class FeeSuggestion {
  final TxType type;
  final String? gasPrice;
  final String? maxFeePerGas;
  final String? maxPriorityFeePerGas;

  const FeeSuggestion({
    required this.type,
    this.gasPrice,
    this.maxFeePerGas,
    this.maxPriorityFeePerGas,
  });
}

@immutable
class EvmUnsignedTx {
  final String? from;
  final String to;
  final String data;
  final String valueWei;

  const EvmUnsignedTx({
    this.from,
    required this.to,
    required this.data,
    required this.valueWei,
  });
}

@immutable
class TxReceipt {
  final String txHash;
  final bool success;
  final int blockNumber;

  const TxReceipt({
    required this.txHash,
    required this.success,
    required this.blockNumber,
  });
}
