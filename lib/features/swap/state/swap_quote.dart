import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../shared/contracts/app_contracts.dart';
import '../../wallet/state/wallet_secrets.dart';
import 'swap_state.dart';

final swapQuoteProvider = FutureProvider.autoDispose<SwapQuoteResponse>((ref) async {
  final form = ref.watch(swapFormProvider);
  final network = ref.watch(selectedNetworkProvider);
  final walletSession = ref.watch(walletSessionProvider);
  final taker = walletSession.activeAddress;

  if (taker == null || taker.isEmpty) {
    throw Exception('Wallet not initialized');
  }

  final amountIn = _parseAmountToSmallestUnit(form.amount, form.fromDecimals);

  final req = SwapQuoteRequest(
    chainId: network.chainId,
    fromToken: form.fromToken,
    toToken: form.toToken,
    amountIn: amountIn.toString(),
    taker: taker,
    slippageBps: (form.slippage * 100).round(),
    preferredDex: form.dex,
  );

  return ref.read(swapRepositoryProvider).quote(req);
});

/// Exposes mnemonic for swap signing (dev only).
final _mnemonicProvider =
    Provider<String?>((ref) => ref.watch(currentMnemonicProvider));

String requireMnemonic(WidgetRef ref) {
  final m = ref.read(_mnemonicProvider);
  if (m == null || m.isEmpty) {
    throw Exception('Wallet mnemonic missing');
  }
  return m;
}

BigInt _parseAmountToSmallestUnit(String input, int decimals) {
  final v = input.trim();
  if (v.isEmpty) throw Exception('Enter amount');

  // Allow "1", "1.", ".1", "1.23". Disallow negatives, multiple dots, letters.
  if (!RegExp(r'^\d*\.?\d*$').hasMatch(v) || v == '.') {
    throw Exception('Invalid amount');
  }

  final parts = v.split('.');
  final wholePart = parts[0].isEmpty ? '0' : parts[0];
  var fractionalPart = parts.length > 1 ? parts[1] : '';

  if (fractionalPart.length > decimals) {
    fractionalPart = fractionalPart.substring(0, decimals);
  } else {
    fractionalPart = fractionalPart.padRight(decimals, '0');
  }

  final combined = '$wholePart$fractionalPart';
  final normalized = combined.replaceFirst(RegExp(r'^0+'), '');
  if (normalized.isEmpty) return BigInt.zero;
  try {
    return BigInt.parse(normalized);
  } catch (_) {
    throw Exception('Invalid amount');
  }
}
