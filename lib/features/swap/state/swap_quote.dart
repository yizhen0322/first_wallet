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

  final req = SwapQuoteRequest(
    chainId: network.chainId,
    fromToken: form.fromSymbol,
    toToken: form.toSymbol,
    amountIn: form.amount,
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
