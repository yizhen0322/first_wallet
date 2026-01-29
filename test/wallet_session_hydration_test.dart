import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:firstwallet/features/wallet/state/wallet_secrets.dart';
import 'package:firstwallet/features/wallet/state/wallet_state.dart';
import 'package:firstwallet/shared/contracts/app_contracts.dart';

class _FakeWalletRepository implements WalletRepository {
  _FakeWalletRepository({
    required List<WalletSummary> wallets,
    required Map<String, String?> mnemonics,
  })  : _wallets = wallets,
        _mnemonics = mnemonics;

  final List<WalletSummary> _wallets;
  final Map<String, String?> _mnemonics;

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
  Future<List<WalletSummary>> listWallets() async => _wallets;

  @override
  Future<String?> getMnemonic(String id) async => _mnemonics[id];

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
    return '0xFAKE';
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
  test('WalletsNotifier hydrates session on initial load', () async {
    const id = 'w1';
    const mnemonic = 'test test test test test test test test test test test';

    final repo = _FakeWalletRepository(
      wallets: const [
        WalletSummary(
          id: id,
          name: 'Wallet 1',
          backupLabel: '12 words',
          backupRequired: true,
        ),
      ],
      mnemonics: const {id: mnemonic},
    );

    final container = ProviderContainer(
      overrides: [
        walletRepositoryProvider.overrideWithValue(repo),
        walletEngineProvider.overrideWithValue(const _FakeWalletEngine()),
      ],
    );
    addTearDown(container.dispose);

    await container.read(walletsProvider.future);

    expect(container.read(selectedWalletIdProvider), id);
    expect(container.read(currentMnemonicProvider), mnemonic);
    expect(container.read(walletSessionProvider).isUnlocked, isTrue);
    expect(container.read(walletSessionProvider).activeAddress, '0xFAKE');
  });
}
