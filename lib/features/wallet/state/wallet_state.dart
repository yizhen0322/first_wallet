import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../shared/contracts/app_contracts.dart';
import 'wallet_secrets.dart';

// WalletSummary is now in app_contracts.dart

@immutable
class WalletAsset {
  final String symbol;
  final String name;
  final double price; // Dynamic price based on selected currency
  final double changePct;
  final String currency; // ISO code, e.g. "USD", "MYR"

  const WalletAsset({
    required this.symbol,
    required this.name,
    required this.price,
    required this.changePct,
    this.currency = 'USD',
  });
}

// ... (keep WalletAsset)

class WalletsNotifier extends AsyncNotifier<List<WalletSummary>> {
  String? _hydratedWalletId;

  @override
  Future<List<WalletSummary>> build() async {
    final list = await ref.read(walletRepositoryProvider).listWallets();
    _ensureSelection(list);
    await _hydrateSelectionIfNeeded();
    return list;
  }

  Future<void> reload() async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() async {
      final list = await ref.read(walletRepositoryProvider).listWallets();
      _ensureSelection(list);
      await _hydrateSelectionIfNeeded();
      return list;
    });
  }

  Future<void> deleteWallet(String id) async {
    final wasSelected = ref.read(selectedWalletIdProvider) == id;
    await ref.read(walletRepositoryProvider).deleteWallet(id);
    await reload();

    // If the selected wallet was deleted, clear in-memory secrets/session.
    if (wasSelected) {
      _hydratedWalletId = null;
      ref.read(currentMnemonicProvider.notifier).state = null;
      ref.read(walletSessionProvider.notifier).state =
          const WalletSession(isUnlocked: false);
    }
  }

  Future<void> selectWallet(String id) async {
    ref.read(selectedWalletIdProvider.notifier).state = id;

    // Best-effort hydrate mnemonic + active address for flows that need signing.
    final mnemonic = await ref.read(walletRepositoryProvider).getMnemonic(id);
    ref.read(currentMnemonicProvider.notifier).state = mnemonic;
    if (mnemonic == null || mnemonic.isEmpty) {
      final watchAddress =
          await ref.read(walletRepositoryProvider).getWatchAddress(id);
      ref.read(walletSessionProvider.notifier).state = WalletSession(
        isUnlocked: false,
        activeAddress: watchAddress,
      );
      _hydratedWalletId = id;
      return;
    }

    final address = await ref
        .read(walletEngineProvider)
        .deriveAddressFromMnemonic(mnemonic: mnemonic);
    ref.read(walletSessionProvider.notifier).state = WalletSession(
      isUnlocked: true,
      activeAddress: address,
    );
    _hydratedWalletId = id;
  }

  Future<void> _hydrateSelectionIfNeeded() async {
    final selectedId = ref.read(selectedWalletIdProvider);
    if (selectedId == null) {
      _hydratedWalletId = null;
      return;
    }

    if (_hydratedWalletId == selectedId) return;
    await selectWallet(selectedId);
  }

  void _ensureSelection(List<WalletSummary> list) {
    final selectedId = ref.read(selectedWalletIdProvider);

    if (list.isEmpty) {
      if (selectedId != null) {
        ref.read(selectedWalletIdProvider.notifier).state = null;
      }
      _hydratedWalletId = null;
      return;
    }

    if (selectedId == null || !list.any((w) => w.id == selectedId)) {
      ref.read(selectedWalletIdProvider.notifier).state = list.first.id;
    }
  }
}

final walletsProvider =
    AsyncNotifierProvider<WalletsNotifier, List<WalletSummary>>(
  WalletsNotifier.new,
);

final selectedWalletIdProvider = StateProvider<String?>((ref) => null);

final walletAssetsProvider = Provider<List<WalletAsset>>((ref) {
  // Matches the coins shown in the Figma export.
  return const [
    WalletAsset(
        symbol: 'ETH',
        name: 'Ethereum',
        price: 2345.6,
        changePct: 1.25,
        currency: 'USD'),
    WalletAsset(
        symbol: 'BTC',
        name: 'Bitcoin',
        price: 32567.7,
        changePct: 2.30,
        currency: 'USD'),
    WalletAsset(
        symbol: 'DCR',
        name: 'Decred',
        price: 43567.7,
        changePct: 7.80,
        currency: 'USD'),
    WalletAsset(
        symbol: 'EMC',
        name: 'Emercoin',
        price: 13567.7,
        changePct: -4.30,
        currency: 'USD'),
    WalletAsset(
        symbol: 'NAV',
        name: 'NavCoin',
        price: 12567.7,
        changePct: 6.13,
        currency: 'USD'),
  ];
});

// Mnemonic secrets live in wallet_secrets.dart.
