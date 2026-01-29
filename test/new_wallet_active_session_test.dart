import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:firstwallet/features/wallet/presentation/new_wallet_screen.dart';
import 'package:firstwallet/features/wallet/state/wallet_secrets.dart';
import 'package:firstwallet/features/wallet/state/wallet_state.dart';
import 'package:firstwallet/shared/contracts/app_contracts.dart';

class _InMemoryWalletRepository implements WalletRepository {
  final List<WalletSummary> _wallets = [];
  final Map<String, String?> _mnemonics = {};
  final Map<String, String?> _watchAddresses = {};

  String? lastSavedId;

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
    lastSavedId = id;
    final isWatchOnly = mnemonic == null || mnemonic.trim().isEmpty;
    final label = isWatchOnly
        ? 'Watch'
        : (usePassphrase
            ? '$wordCount words with passphrase'
            : '$wordCount words');
    final needsBackup = backupRequired ?? !isWatchOnly;

    final summary = WalletSummary(
      id: id,
      name: name,
      backupLabel: label,
      backupRequired: needsBackup,
    );

    final index = _wallets.indexWhere((w) => w.id == id);
    if (index >= 0) {
      _wallets[index] = summary;
    } else {
      _wallets.add(summary);
    }

    _mnemonics[id] = mnemonic;
    _watchAddresses[id] = watchAddress;
  }

  @override
  Future<List<WalletSummary>> listWallets() async =>
      List.unmodifiable(_wallets);

  @override
  Future<String?> getMnemonic(String id) async => _mnemonics[id];

  @override
  Future<String?> getWatchAddress(String id) async => _watchAddresses[id];

  @override
  Future<void> deleteWallet(String id) async {
    _wallets.removeWhere((w) => w.id == id);
    _mnemonics.remove(id);
    _watchAddresses.remove(id);
  }
}

class _FakeWalletEngine implements WalletEngine {
  const _FakeWalletEngine();

  static const mnemonic =
      'alpha beta gamma delta epsilon zeta eta theta iota kappa lambda mu';

  @override
  Future<String> createMnemonic({int words = 12}) async => mnemonic;

  @override
  Future<String> deriveAddressFromMnemonic({
    required String mnemonic,
    String derivationPath = "m/44'/60'/0'/0/0",
  }) async {
    return '0xNEW';
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
  testWidgets(
      'Creating a wallet keeps an active wallet session (mnemonic not cleared)',
      (tester) async {
    final repo = _InMemoryWalletRepository();

    // Existing wallet is watch-only and will hydrate to a null mnemonic if selected.
    await repo.saveWallet(
      id: 'watch1',
      name: 'Watch Wallet',
      mnemonic: null,
      wordCount: 12,
      usePassphrase: false,
    );

    final container = ProviderContainer(
      overrides: [
        walletRepositoryProvider.overrideWithValue(repo),
        walletEngineProvider.overrideWithValue(const _FakeWalletEngine()),
      ],
    );
    addTearDown(container.dispose);

    await tester.pumpWidget(
      UncontrolledProviderScope(
        container: container,
        child: MaterialApp(
          home: Builder(
            builder: (context) => Scaffold(
              body: Center(
                child: ElevatedButton(
                  onPressed: () => Navigator.of(context).push(
                    MaterialPageRoute(builder: (_) => const NewWalletScreen()),
                  ),
                  child: const Text('open'),
                ),
              ),
            ),
          ),
        ),
      ),
    );

    await tester.tap(find.text('open'));
    await tester.pumpAndSettle();

    await tester.tap(find.text('Create New Wallet'));
    await tester.pumpAndSettle();

    // Ensure wallets list is updated (reload may be async).
    await container.read(walletsProvider.future);

    expect(container.read(currentMnemonicProvider), _FakeWalletEngine.mnemonic);
    expect(container.read(walletSessionProvider).isUnlocked, isTrue);
    expect(container.read(walletSessionProvider).activeAddress, '0xNEW');

    // Also ensure the newly created wallet is selected.
    expect(container.read(selectedWalletIdProvider), repo.lastSavedId);
  });
}
