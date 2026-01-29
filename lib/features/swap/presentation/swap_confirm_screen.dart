import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../shared/contracts/app_contracts.dart';
import '../../wallet/state/wallet_secrets.dart';
import '../state/swap_quote.dart';
import '../state/swap_state.dart';
import '../../wallet/presentation/tx_status_screen.dart';

class SwapConfirmScreen extends ConsumerStatefulWidget {
  const SwapConfirmScreen({super.key});

  @override
  ConsumerState<SwapConfirmScreen> createState() => _SwapConfirmScreenState();
}

class _SwapConfirmScreenState extends ConsumerState<SwapConfirmScreen> {
  bool _submitting = false;

  @override
  Widget build(BuildContext context) {
    final form = ref.watch(swapFormProvider);
    final quoteAsync = ref.watch(swapQuoteProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Confirm')),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(20),
          children: [
            Text('Swap', style: Theme.of(context).textTheme.titleLarge),
            const SizedBox(height: 12),
            quoteAsync.when(
              loading: () => const Center(
                child: Padding(
                  padding: EdgeInsets.all(24),
                  child: CircularProgressIndicator(),
                ),
              ),
              error: (e, _) => Text(
                'Failed to load quote: $e',
                style: const TextStyle(color: Colors.red),
              ),
              data: (quote) => Column(
                children: [
                  _Row(
                    label: 'Price',
                    value: '1 ${form.fromSymbol} = 1.0000 ${form.toSymbol}',
                  ),
                  _Row(
                    label: 'Guaranteed Amount',
                    value: quote.minOut,
                  ),
                  const SizedBox(height: 12),
                  Card(
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      side: BorderSide(color: Theme.of(context).dividerColor),
                      borderRadius: BorderRadius.circular(18),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        children: [
                          _Row(
                            label: 'You Pay',
                            value: '${form.amount} ${form.fromSymbol}',
                          ),
                          const SizedBox(height: 8),
                          _Row(
                            label: 'You Get',
                            value: quote.amountOut,
                          ),
                          const SizedBox(height: 8),
                          _Row(
                            label: 'Network Fee',
                            value: '${quote.route.estimatedGas} gas',
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 18),
            FilledButton(
              onPressed: _submitting ? null : _onConfirm,
              child: _submitting
                  ? const SizedBox(
                      height: 18,
                      width: 18,
                      child: CircularProgressIndicator(strokeWidth: 2),
                    )
                  : const Text('Confirm Swap'),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _onConfirm() async {
    setState(() => _submitting = true);
    try {
      final form = ref.read(swapFormProvider);
      final quote = await ref.read(swapQuoteProvider.future);
      final network = ref.read(selectedNetworkProvider);
      final wallet = ref.read(walletSessionProvider);
      final taker = wallet.activeAddress;
      if (taker == null || taker.isEmpty) {
        throw Exception('Wallet not initialized');
      }

      final recipient = form.recipient.isEmpty ? taker : form.recipient;

      final build = await ref.read(swapRepositoryProvider).build(
            SwapBuildRequest(
              quoteId: quote.quoteId,
              taker: taker,
              recipient: recipient,
            ),
          );

      // Prevent broadcasting placeholder txs when swap backend is not configured.
      if (build.tx.to.toLowerCase() ==
          '0x0000000000000000000000000000000000000000') {
        throw Exception('Swap backend not configured yet');
      }

      final mnemonic = ref.read(currentMnemonicProvider);
      if (mnemonic == null || mnemonic.isEmpty) {
        throw Exception('Wallet mnemonic missing');
      }

      final nonce = await ref.read(evmChainRepositoryProvider).getNonce(taker);
      final signedRaw = await ref.read(walletEngineProvider).signEvmTx(
            mnemonic: mnemonic,
            chainId: network.chainId,
            tx: build.tx,
            nonce: nonce,
          );

      final txHash =
          await ref.read(evmChainRepositoryProvider).sendRawTx(signedRaw);

      if (!mounted) return;
      await Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (_) => TxStatusScreen(
            txHash: txHash,
            title: 'Swap Status',
          ),
        ),
      );
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(e.toString())),
      );
    } finally {
      if (mounted) setState(() => _submitting = false);
    }
  }
}

class _Row extends StatelessWidget {
  const _Row({required this.label, required this.value});

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Text(
            label,
            style: Theme.of(context).textTheme.bodyMedium,
          ),
        ),
        const SizedBox(width: 12),
        Text(
          value,
          style: const TextStyle(fontWeight: FontWeight.w700),
          textAlign: TextAlign.right,
        ),
      ],
    );
  }
}
