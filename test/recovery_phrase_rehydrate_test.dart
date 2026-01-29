import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:firstwallet/features/wallet/presentation/recovery_phrase_screen.dart';
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
  Future<String> getPrivateKey({
    required String mnemonic,
    String derivationPath = "m/44'/60'/0'/0/0",
  }) async {
    throw UnimplementedError();
  }

  @override
  Future<String> getExtendedPrivateKey({required String mnemonic}) async {
    throw UnimplementedError();
  }

  @override
  Future<String> getAccountExtendedPublicKey({required String mnemonic}) async {
    throw UnimplementedError();
  }
}

void main() {
  testWidgets('Recovery phrase screen rehydrates after secrets cleared',
      (tester) async {
    const id = 'w1';
    const mnemonic =
        'alpha beta gamma delta epsilon zeta eta theta iota kappa lambda mu';

    final repo = _FakeWalletRepository(
      wallet: const WalletSummary(
        id: id,
        name: 'Wallet 1',
        backupLabel: '12 words',
        backupRequired: true,
      ),
      mnemonic: mnemonic,
    );

    final container = ProviderContainer(
      overrides: [
        walletRepositoryProvider.overrideWithValue(repo),
        walletEngineProvider.overrideWithValue(const _FakeWalletEngine()),
      ],
    );
    addTearDown(container.dispose);

    // Build wallets provider once (hydrates mnemonic), then simulate app background.
    await container.read(walletsProvider.future);
    container.read(currentMnemonicProvider.notifier).state = null;

    await tester.pumpWidget(
      UncontrolledProviderScope(
        container: container,
        child: const MaterialApp(home: RecoveryPhraseScreen()),
      ),
    );

    // Allow any async rehydration to complete.
    await tester.pumpAndSettle();

    expect(find.text('No active wallet session'), findsNothing);
    expect(find.text('alpha'), findsOneWidget);
  });
}
