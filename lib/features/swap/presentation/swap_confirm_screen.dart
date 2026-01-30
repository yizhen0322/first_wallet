import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../shared/contracts/app_contracts.dart';
import '../../../shared/theme/app_theme.dart';
import '../../../shared/data/local_tx_store.dart';
import '../../wallet/state/evm_balance.dart';
import '../../wallet/state/wallet_secrets.dart';
import '../../wallet/state/wallet_state.dart';
import '../state/swap_quote.dart';
import '../state/swap_state.dart';
import '../../wallet/presentation/tx_status_screen.dart';
import '../state/swap_tokens.dart';

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
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.background,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: AppColors.textPrimary),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: const Text(
          'Confirm',
          style: TextStyle(color: AppColors.textPrimary),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(20),
          children: [
            const Text(
              'Swap',
              style: TextStyle(
                color: AppColors.textPrimary,
                fontSize: 20,
                fontWeight: FontWeight.w800,
              ),
            ),
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
                style: const TextStyle(color: AppColors.error),
              ),
              data: (quote) => Column(
                children: [
                  _Row(
                    label: 'Price',
                    value:
                        '1 ${form.fromSymbol} → ${_formatFromSmallestUnit(quote.amountOut, form.toDecimals)} ${form.toSymbol}',
                  ),
                  _Row(
                    label: 'Guaranteed Amount',
                    value:
                        '${_formatFromSmallestUnit(quote.minOut, form.toDecimals)} ${form.toSymbol}',
                  ),
                  const SizedBox(height: 12),
                  Card(
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      side: const BorderSide(color: AppColors.border),
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
                            value:
                                '${_formatFromSmallestUnit(quote.amountOut, form.toDecimals)} ${form.toSymbol}',
                          ),
                          const SizedBox(height: 8),
                          _Row(
                            label: 'Network Fee',
                            value: '${quote.route.estimatedGas} gas',
                          ),
                          if (quote.approval.isRequired) ...[
                            const SizedBox(height: 8),
                            _Row(
                              label: 'Approval',
                              value: 'Required',
                            ),
                          ],
                        ],
                      ),
                    ),
                  ),
                  if (quote.warnings.isNotEmpty) ...[
                    const SizedBox(height: 12),
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: AppColors.surface,
                        borderRadius: BorderRadius.circular(14),
                        border: Border.all(color: AppColors.border, width: 0.5),
                      ),
                      child: Text(
                        quote.warnings.join('\n'),
                        style: const TextStyle(color: AppColors.textSecondary),
                      ),
                    ),
                  ],
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

      final mnemonic = await _ensureMnemonic();
      if (mnemonic == null || mnemonic.isEmpty) {
        throw Exception('Wallet mnemonic missing');
      }

      // If approval is required, send approve() first and wait for receipt.
      if (quote.approval.isRequired &&
          form.fromToken.toLowerCase() != kNativeTokenAddress.toLowerCase()) {
        final approvalTx = await _buildApprovalTx(
          tokenContract: form.fromToken,
          spender: quote.approval.spender,
          amount: quote.approval.amount,
          taker: taker,
        );

        final nonce = await ref.read(evmChainRepositoryProvider).getNonce(taker);
        final signedApproval = await ref.read(walletEngineProvider).signEvmTx(
              mnemonic: mnemonic,
              chainId: network.chainId,
              tx: approvalTx,
              nonce: nonce,
            );

        final approvalHash =
            await ref.read(evmChainRepositoryProvider).sendRawTx(signedApproval);
        final receipt = await _waitForReceipt(approvalHash);
        if (receipt == null || receipt.success != true) {
          throw Exception('Approval failed');
        }
      }

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

      final nonce = await ref.read(evmChainRepositoryProvider).getNonce(taker);
      final signedRaw = await ref.read(walletEngineProvider).signEvmTx(
            mnemonic: mnemonic,
            chainId: network.chainId,
            tx: build.tx,
            nonce: nonce,
          );

      final txHash =
          await ref.read(evmChainRepositoryProvider).sendRawTx(signedRaw);
      await ref.read(localTxStoreProvider).addOutgoing(
            chainId: network.chainId,
            from: taker,
            to: build.tx.to,
            hash: txHash,
            valueWei: build.tx.value,
          );

      ref.invalidate(evmNativeBalanceWeiProvider);
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

  Future<String?> _ensureMnemonic() async {
    var mnemonic = ref.read(currentMnemonicProvider);
    if (mnemonic != null && mnemonic.isNotEmpty) return mnemonic;

    final selectedId = ref.read(selectedWalletIdProvider);
    if (selectedId == null) return null;

    mnemonic = await ref.read(walletRepositoryProvider).getMnemonic(selectedId);
    ref.read(currentMnemonicProvider.notifier).state = mnemonic;
    return mnemonic;
  }

  Future<EvmTxRequest> _buildApprovalTx({
    required String tokenContract,
    required String spender,
    required String amount,
    required String taker,
  }) async {
    final repo = ref.read(evmChainRepositoryProvider);
    final fee = await repo.getFeeSuggestion();

    final data = _buildApproveData(spender: spender, amount: amount);
    final estimate = await repo.estimateGas(
      EvmUnsignedTx(
        from: taker,
        to: tokenContract,
        data: data,
        valueWei: '0',
      ),
    );
    final gasLimit = (estimate * 15 / 10).ceil(); // +50% buffer

    return EvmTxRequest(
      to: tokenContract,
      data: data,
      value: '0',
      gasLimit: gasLimit.toString(),
      type: fee.type,
      gasPrice: fee.gasPrice,
      maxFeePerGas: fee.maxFeePerGas,
      maxPriorityFeePerGas: fee.maxPriorityFeePerGas,
    );
  }

  String _buildApproveData({
    required String spender,
    required String amount,
  }) {
    // approve(address,uint256) -> 0x095ea7b3
    const selector = '095ea7b3';
    final spenderHex = spender.toLowerCase().replaceFirst('0x', '');
    final spenderPadded = spenderHex.padLeft(64, '0');

    final amountBig = BigInt.tryParse(amount) ?? BigInt.zero;
    final amountHex = amountBig.toRadixString(16);
    final amountPadded = amountHex.padLeft(64, '0');
    return '0x$selector$spenderPadded$amountPadded';
  }

  Future<TxReceipt?> _waitForReceipt(String txHash) async {
    final repo = ref.read(evmChainRepositoryProvider);
    final deadline = DateTime.now().add(const Duration(minutes: 2));
    while (DateTime.now().isBefore(deadline)) {
      final r = await repo.getReceipt(txHash);
      if (r != null) return r;
      await Future<void>.delayed(const Duration(seconds: 3));
    }
    return null;
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
            style: const TextStyle(color: AppColors.textSecondary),
          ),
        ),
        const SizedBox(width: 12),
        Text(
          value,
          style: const TextStyle(
            color: AppColors.textPrimary,
            fontWeight: FontWeight.w700,
          ),
          textAlign: TextAlign.right,
        ),
      ],
    );
  }
}

String _formatFromSmallestUnit(String raw, int decimals) {
  final v = BigInt.tryParse(raw) ?? BigInt.zero;
  if (v == BigInt.zero) return '0';
  final divisor = BigInt.from(10).pow(decimals);
  final whole = v ~/ divisor;
  final remainder = v % divisor;
  if (remainder == BigInt.zero) return whole.toString();
  final remainderStr = remainder.toString().padLeft(decimals, '0');
  final trimmed = remainderStr.replaceAll(RegExp(r'0+$'), '');
  final shown = trimmed.length > 6 ? trimmed.substring(0, 6) : trimmed;
  return '$whole.$shown';
}
