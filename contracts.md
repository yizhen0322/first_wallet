# First Wallet - Flutter Frontend (Production) + API Contracts (Sepolia-testnet)

This document is meant to be pasted into the team channel as a single source of truth for the Flutter production frontend setup and the initial API/data contracts.

Scope here:
- Mobile-only Flutter app
- State management: Riverpod
- Networking: Dio
- Observability: Firebase Crashlytics (required) + optional Sentry
- Logging: dev-friendly logger, production-safe (PII-aware)
- Retry strategy: required (can be custom, but recommended to standardize)
- i18n: intl
- Chain: Sepolia testnet (chainId=11155111) in Phase 1, with explicit room to expand later
- Swap: app signs locally; backend never signs
- Card + Account: requires backend (yours or third-party), but app integration contract is included

---

## 1) What we are building first

Phase 1 (Sepolia testnet only):
- Wallet session (unlock state + active address)
- Send / Receive / Swap UI flows (based on Figma)
- Swap: quote -> build tx -> sign + send -> show status
- Fee display: show estimated network fee before confirmation
- Feature flags: backend-driven gates (swap enabled, cards enabled, etc.)

Phase 2+:
- Add more EVM networks via ChainConfig + backend flags
- Add more swap aggregators behind a thin Swap Gateway (recommended)
- Integrate card/account backend flows (KYC, card ordering, limits, transactions)

---

## 2) High-level architecture

The app is split by layers:
- Presentation (screens/widgets)
- State (Riverpod providers/notifiers)
- Data (repositories using Dio)
- Domain contracts (models + repository interfaces)
- EVM engine (wallet key mgmt + signing) - local only

Important rule: **backend never signs**. Backend returns tx request (`to`, `data`, `value`, fee suggestions). App signs locally and broadcasts.

---

## 3) Recommended project directory (Flutter)

Example structure (keep it boring and predictable):

```
lib/
  app/
    app.dart
    router.dart
    bootstrap.dart
  config/
    env.dart
    build_config.dart
  core/
    network/
      dio_client.dart
      interceptors/
      auth_interceptor.dart
      retry_interceptor.dart
      error_mapper.dart
    observability/
      crashlytics.dart
      sentry.dart
      logger.dart
    i18n/
      l10n.dart
  features/
    auth/
      data/
      presentation/
      state/
    wallet/
    swap/
    cards/
    account/
  shared/
    contracts/
      app_contracts.dart   <-- (single file below)
    utils/
      formatters.dart
      validators.dart

test/
```

If the team prefers a **feature-first** approach, keep it consistent; do not mix styles.

---

## 4) Packages (minimum)

Required (you already decided):
- `firebase_core`
- `firebase_crashlytics`

Strongly recommended:
- `flutter_riverpod`
- `dio`
- `freezed_annotation`, `json_annotation`
- `build_runner`, `freezed`, `json_serializable` (dev)
- `logger`
- `intl`

Optional:
- `sentry_flutter` (if you want richer tracing/perf)
- `flutter_secure_storage` (for tokens / encrypted local data)
- `local_auth` (biometric unlock)

---

## 5) Firebase setup (Crashlytics)

You can use FlutterFire CLI:

```bash
dart pub global activate flutterfire_cli
flutterfire configure
```

Then ensure:
- `Firebase.initializeApp()` is called in `main()` / bootstrap
- Crashlytics collection rules match your release policy

---

## 6) Swap flow: what the UI needs (from your Figma)

You said Swap has 6 screens:
1) Swap main
2) Dex selector
3) Swap settings (slippage + recipient)
4) Confirm
5) Receive (network selection list)
6) Network list

Fee requirement:
- The app must compute/display fees before confirm.
- For ETH, show estimated **network fee in ETH + fiat** (if fiat price feed exists), and disclose that it's an estimate.

Implementation hint:
- Quote response should include estimated gas/fee inputs.
- Build response returns tx request; app can re-estimate gas with RPC as a second check.

---

## 7) Backend strategy (swap gateway) - recommended even if using 3rd party

Even when "no in-house backend", for production stability it is safer to add a thin Swap Gateway:
- Vendor switching without app releases
- Rate-limit/caching/retry/failover
- Central policy (supported tokens/chains, max slippage, blocklists)
- Hide API keys

App talks only to:
- `GET /swap/quote`
- `POST /swap/build`

The gateway talks to aggregators like 0x / 1inch / ParaSwap.

---

## 8) Single-file contract (replace previous multiple files)

Below is a **single Dart file** that replaces:
- your providers file
- repository contracts
- API models

Copy as:
- `lib/shared/contracts/app_contracts.dart`

Then run codegen:

```bash
flutter pub run build_runner build --delete-conflicting-outputs
```

### app_contracts.dart

```dart
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

  const ChainConfig({required this.chainId, required this.name});
}

/// Phase 1: Sepolia testnet only.
final selectedNetworkProvider = StateProvider<ChainConfig>(
  (ref) => const ChainConfig(chainId: 11155111, name: 'Sepolia'),
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
class ApiErrorEnvelope with _$ApiErrorEnvelope {
  const factory ApiErrorEnvelope({
    required ApiError error,
  }) = _ApiErrorEnvelope;

  factory ApiErrorEnvelope.fromJson(Map<String, dynamic> json) =>
      _$ApiErrorEnvelopeFromJson(json);
}

@freezed
class ApiError with _$ApiError {
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
class AuthTokens with _$AuthTokens {
  const factory AuthTokens({
    required String accessToken,
    required String refreshToken,
  }) = _AuthTokens;

  factory AuthTokens.fromJson(Map<String, dynamic> json) =>
      _$AuthTokensFromJson(json);
}

@freezed
class UserSummary with _$UserSummary {
  const factory UserSummary({
    required String id,
    required String email,
  }) = _UserSummary;

  factory UserSummary.fromJson(Map<String, dynamic> json) =>
      _$UserSummaryFromJson(json);
}

@freezed
class AuthResponse with _$AuthResponse {
  const factory AuthResponse({
    required String accessToken,
    required String refreshToken,
    required UserSummary user,
  }) = _AuthResponse;

  factory AuthResponse.fromJson(Map<String, dynamic> json) =>
      _$AuthResponseFromJson(json);
}

enum KycStatus {
  not_started,
  pending,
  approved,
  rejected,
}

@freezed
class MeResponse with _$MeResponse {
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
class FeatureFlagsResponse with _$FeatureFlagsResponse {
  const factory FeatureFlagsResponse({
    required List<ChainFlag> chains,
    required FeatureFlags features,
    required Policies policies,
  }) = _FeatureFlagsResponse;

  factory FeatureFlagsResponse.fromJson(Map<String, dynamic> json) =>
      _$FeatureFlagsResponseFromJson(json);
}

@freezed
class ChainFlag with _$ChainFlag {
  const factory ChainFlag({
    required int chainId,
    required bool enabled,
  }) = _ChainFlag;

  factory ChainFlag.fromJson(Map<String, dynamic> json) =>
      _$ChainFlagFromJson(json);
}

@freezed
class FeatureFlags with _$FeatureFlags {
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
class Policies with _$Policies {
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
class KycStartResponse with _$KycStartResponse {
  const factory KycStartResponse({
    required String provider,
    required String sdkToken,
    required DateTime expiresAt,
  }) = _KycStartResponse;

  factory KycStartResponse.fromJson(Map<String, dynamic> json) =>
      _$KycStartResponseFromJson(json);
}

@freezed
class KycStatusResponse with _$KycStatusResponse {
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
class OtpRequestResponse with _$OtpRequestResponse {
  const factory OtpRequestResponse({
    /// e.g. "sent"
    required String status,
  }) = _OtpRequestResponse;

  factory OtpRequestResponse.fromJson(Map<String, dynamic> json) =>
      _$OtpRequestResponseFromJson(json);
}

@freezed
class OtpVerifyResponse with _$OtpVerifyResponse {
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
class ShippingAddress with _$ShippingAddress {
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
class CardSummary with _$CardSummary {
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
class CardsListResponse with _$CardsListResponse {
  const factory CardsListResponse({
    required List<CardSummary> cards,
  }) = _CardsListResponse;

  factory CardsListResponse.fromJson(Map<String, dynamic> json) =>
      _$CardsListResponseFromJson(json);
}

@freezed
class CardTransaction with _$CardTransaction {
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
class CardTransactionsResponse with _$CardTransactionsResponse {
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
class SwapQuoteRequest with _$SwapQuoteRequest {
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
class SwapRoute with _$SwapRoute {
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
class SwapApproval with _$SwapApproval {
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
class SwapQuoteResponse with _$SwapQuoteResponse {
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
class EvmTxRequest with _$EvmTxRequest {
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
class SwapFee with _$SwapFee {
  const factory SwapFee({
    /// Estimated network fee in wei (string)
    required String estimatedNetworkFeeWei,
  }) = _SwapFee;

  factory SwapFee.fromJson(Map<String, dynamic> json) =>
      _$SwapFeeFromJson(json);
}

@freezed
class SwapBuildRequest with _$SwapBuildRequest {
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
class SwapBuildResponse with _$SwapBuildResponse {
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
  final String to;
  final String data;
  final String valueWei;

  const EvmUnsignedTx({
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
```

---

## 9) Notes / Corrections vs your previous draft

Key fixes in this consolidated version:
- Everything is in **one file** with one `part` set (`app_contracts.freezed.dart` + `app_contracts.g.dart`).
- `KycStatusResponse` and `ShippingAddress` are now `@freezed` for consistent serialization.
- Provider wiring stays, but implementations are intentionally `UnimplementedError()` until your data layer plugs in.
- Clear Sepolia testnet default via `selectedNetworkProvider`, while still future-proof.

---

## 10) Next action items (practical)

1) Put `app_contracts.dart` into `lib/shared/contracts/`.
2) Add packages + run codegen.
3) Implement `SwapRepository` (Dio calls to your gateway) and `EvmChainRepository` (RPC provider) behind providers.
4) Build Swap UI screens from Figma; wire flow:
   - Quote -> show fee estimate -> Confirm -> Build -> Sign -> Send -> Receipt polling.

If you paste your current backend API routes (even stubbed), I can align request/response naming exactly to avoid churn.
