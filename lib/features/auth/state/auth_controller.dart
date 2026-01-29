import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../shared/contracts/app_contracts.dart';
import '../../wallet/state/wallet_secrets.dart';

final authControllerProvider =
    AutoDisposeNotifierProvider<AuthController, AsyncValue<void>>(
  AuthController.new,
);

class AuthController extends AutoDisposeNotifier<AsyncValue<void>> {
  @override
  AsyncValue<void> build() => const AsyncData(null);

  Future<void> register({
    required String email,
    required String password,
    required String phone,
  }) async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() async {
      final env = ref.read(envProvider);
      final repo = ref.read(authRepositoryProvider);
      final res = await repo.register(
        email: email,
        password: password,
        deviceId: env.deviceId,
      );

      ref.read(authSessionProvider.notifier).state = AuthSession(
        accessToken: res.accessToken,
        refreshToken: res.refreshToken,
        isLoggedIn: true,
      );

      await _ensureDevWalletInitialized();
    });
  }

  Future<void> login({
    required String email,
    required String password,
  }) async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() async {
      final env = ref.read(envProvider);
      final repo = ref.read(authRepositoryProvider);
      final res = await repo.login(
        email: email,
        password: password,
        deviceId: env.deviceId,
      );

      ref.read(authSessionProvider.notifier).state = AuthSession(
        accessToken: res.accessToken,
        refreshToken: res.refreshToken,
        isLoggedIn: true,
      );

      await _ensureDevWalletInitialized();
    });
  }

  Future<void> logout() async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() async {
      final env = ref.read(envProvider);
      final session = ref.read(authSessionProvider);
      final refresh = session.refreshToken;
      if (refresh != null && refresh.isNotEmpty) {
        await ref
            .read(authRepositoryProvider)
            .logout(refreshToken: refresh, deviceId: env.deviceId);
      }

      ref.read(authSessionProvider.notifier).state =
          const AuthSession(isLoggedIn: false);

      ref.read(currentMnemonicProvider.notifier).state = null;
      ref.read(walletSessionProvider.notifier).state =
          const WalletSession(isUnlocked: false);
    });
  }

  Future<void> _ensureDevWalletInitialized() async {
    final existing = ref.read(currentMnemonicProvider);
    if (existing != null && existing.isNotEmpty) return;

    final engine = ref.read(walletEngineProvider);
    final mnemonic = await engine.createMnemonic(words: 12);
    final address = await engine.deriveAddressFromMnemonic(mnemonic: mnemonic);

    ref.read(currentMnemonicProvider.notifier).state = mnemonic;
    ref.read(walletSessionProvider.notifier).state = WalletSession(
      isUnlocked: true,
      activeAddress: address,
    );
  }
}
