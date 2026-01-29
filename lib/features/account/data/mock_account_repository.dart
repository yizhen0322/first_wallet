import '../../../shared/contracts/app_contracts.dart';

class MockAccountRepository implements AccountRepository {
  MockAccountRepository();

  @override
  Future<MeResponse> getMe() async {
    await Future<void>.delayed(const Duration(milliseconds: 300));
    return const MeResponse(
      id: 'me',
      email: 'user@example.com',
      baseCurrency: 'USD',
      kycStatus: KycStatus.not_started,
      phoneVerified: false,
    );
  }

  @override
  Future<void> updateMe({String? baseCurrency}) async {
    await Future<void>.delayed(const Duration(milliseconds: 250));
    // no-op for mock
  }

  @override
  Future<FeatureFlagsResponse> getFeatureFlags() async {
    await Future<void>.delayed(const Duration(milliseconds: 250));

    // Sepolia-first, but keep room for networks later.
    return const FeatureFlagsResponse(
      chains: [
        ChainFlag(chainId: 11155111, enabled: true),
      ],
      features: FeatureFlags(
        cardsEnabled: true,
        swapEnabled: true,
        exportKeysEnabled: true,
        tronEnabled: false,
      ),
      policies: Policies(
        maxSlippageBps: 50,
        requireKycForCardOrder: true,
      ),
    );
  }
}
