import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:firstwallet/features/wallet/presentation/bip32_root_key_screen.dart';
import 'package:firstwallet/features/wallet/presentation/evm_private_key_screen.dart';
import 'package:firstwallet/features/wallet/state/wallet_secrets.dart';
import 'package:firstwallet/features/wallet/state/wallet_state.dart';
import 'package:firstwallet/shared/contracts/app_contracts.dart';

class _FakeWalletRepository implements WalletRepository {
  _FakeWalletRepository({
    required this.wallet,
    required this.mnemonic,
  });

  final WalletSummary wallet;
  final String mnemonic;

  @override
  Future<void> saveWallet({
    required String id,
    required String name,
    String? mnemonic,
    required int wordCount,
    required bool usePassphrase,
    bool? backupRequired,
    String? watchAddress,
  }) async {
    throw UnimplementedError();
  }

  @override
  Future<List<WalletSummary>> listWallets() async => [wallet];

  @override
  Future<String?> getMnemonic(String id) async =>
      id == wallet.id ? mnemonic : null;

  @override
  Future<String?> getWatchAddress(String id) async => null;

  @override
  Future<void> deleteWallet(String id) async {
    throw UnimplementedError();
  }
}

class _FakeWalletEngine implements WalletEngine {
  const _FakeWalletEngine();

  @override
  Future<String> deriveAddressFromMnemonic({
    required String mnemonic,
    String derivationPath = "m/44'/60'/0'/0/0",
  }) async {
    return '0xADDR';
  }

  @override
  Future<String> getPrivateKey({
    required String mnemonic,
    String derivationPath = "m/44'/60'/0'/0/0",
  }) async {
    return 'PRIVATE_KEY';
  }

  @override
  Future<String> getExtendedPrivateKey({required String mnemonic}) async {
    return 'BIP32_ROOT_KEY';
  }

  @override
  Future<String> createMnemonic({int words = 12}) async {
    throw UnimplementedError();
  }

  @override
  Future<String> signEvmTx({
    required String mnemonic,
    required int chainId,
    required EvmTxRequest tx,
    required int nonce,
  }) async {
    throw UnimplementedError();
  }

  @override
  Future<String> getAccountExtendedPublicKey({required String mnemonic}) async {
    throw UnimplementedError();
  }
}

void main() {
  const id = 'w1';
  const mnemonic =
      'alpha beta gamma delta epsilon zeta eta theta iota kappa lambda mu';

  ProviderContainer createContainer() {
    return ProviderContainer(
      overrides: [
        walletRepositoryProvider.overrideWithValue(
          _FakeWalletRepository(
            wallet: const WalletSummary(
              id: id,
              name: 'Wallet 1',
              backupLabel: '12 words',
              backupRequired: true,
            ),
            mnemonic: mnemonic,
          ),
        ),
        walletEngineProvider.overrideWithValue(const _FakeWalletEngine()),
      ],
    );
  }

  testWidgets('EVM private key screen rehydrates after secrets cleared',
      (tester) async {
    final container = createContainer();
    addTearDown(container.dispose);

    await container.read(walletsProvider.future);
    container.read(currentMnemonicProvider.notifier).state = null;

    await tester.pumpWidget(
      UncontrolledProviderScope(
        container: container,
        child: const MaterialApp(home: EvmPrivateKeyScreen()),
      ),
    );
    await tester.pumpAndSettle();

    expect(find.text('No active wallet session'), findsNothing);
    expect(find.text('PRIVATE_KEY'), findsOneWidget);
  });

  testWidgets('BIP32 root key screen rehydrates after secrets cleared',
      (tester) async {
    final container = createContainer();
    addTearDown(container.dispose);

    await container.read(walletsProvider.future);
    container.read(currentMnemonicProvider.notifier).state = null;

    await tester.pumpWidget(
      UncontrolledProviderScope(
        container: container,
        child: const MaterialApp(home: Bip32RootKeyScreen()),
      ),
    );
    await tester.pumpAndSettle();

    expect(find.text('No active wallet session'), findsNothing);
    expect(find.text('BIP32_ROOT_KEY'), findsOneWidget);
  });
}
