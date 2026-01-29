import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../shared/contracts/app_contracts.dart';

final evmNativeBalanceWeiProvider =
    FutureProvider.autoDispose<BigInt>((ref) async {
  // Recompute when network changes (Sepolia/Mainnet etc.)
  ref.watch(selectedNetworkProvider);

  final session = ref.watch(walletSessionProvider);
  final address = session.activeAddress;
  if (address == null || address.isEmpty) return BigInt.zero;

  final weiStr = await ref.read(evmChainRepositoryProvider).getNativeBalanceWei(
        address,
      );
  return BigInt.tryParse(weiStr) ?? BigInt.zero;
});

/// Provider to get balance for a specific wallet by its ID.
/// Derives the address from the stored mnemonic, or uses the stored
/// watch address for watch-only wallets.
final walletBalanceProvider =
    FutureProvider.autoDispose.family<BigInt, String>((ref, walletId) async {
  ref.watch(selectedNetworkProvider);

  if (walletId.isEmpty) return BigInt.zero;

  final repository = ref.read(walletRepositoryProvider);

  // First, try to get mnemonic for this wallet
  final mnemonic = await repository.getMnemonic(walletId);

  String address = '';

  if (mnemonic != null && mnemonic.trim().isNotEmpty) {
    // Regular wallet - derive address from mnemonic
    address = await ref
        .read(walletEngineProvider)
        .deriveAddressFromMnemonic(mnemonic: mnemonic);
  } else {
    // Watch-only wallet - try to get stored watch address
    final watchAddr = await repository.getWatchAddress(walletId);
    if (watchAddr != null && watchAddr.isNotEmpty) {
      address = watchAddr;
    }
  }

  if (address.isEmpty) return BigInt.zero;

  // Fetch balance
  final weiStr =
      await ref.read(evmChainRepositoryProvider).getNativeBalanceWei(address);
  return BigInt.tryParse(weiStr) ?? BigInt.zero;
});
