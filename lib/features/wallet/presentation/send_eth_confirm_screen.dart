import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../shared/contracts/app_contracts.dart';
import '../../../shared/data/local_tx_store.dart';
import '../../../shared/theme/app_theme.dart';
import '../../../shared/utils/eth_format.dart';
import '../state/evm_balance.dart';
import '../state/wallet_secrets.dart';
import '../state/wallet_state.dart';
import 'tx_status_screen.dart';

class SendEthConfirmScreen extends ConsumerStatefulWidget {
  const SendEthConfirmScreen({
    super.key,
    required this.to,
    required this.valueWei,
  });

  final String to;
  final BigInt valueWei;

  @override
  ConsumerState<SendEthConfirmScreen> createState() =>
      _SendEthConfirmScreenState();
}

class _SendEthConfirmScreenState extends ConsumerState<SendEthConfirmScreen> {
  bool _loading = true;
  bool _submitting = false;
  String? _error;
  EvmTxRequest? _tx;
  BigInt _feeWei = BigInt.zero;

  @override
  void initState() {
    super.initState();
    _prepare();
  }

  Future<void> _prepare() async {
    setState(() {
      _loading = true;
      _error = null;
    });

    try {
      final repo = ref.read(evmChainRepositoryProvider);
      final session = ref.read(walletSessionProvider);
      final fee = await repo.getFeeSuggestion();
      final estimate = await repo.estimateGas(
        EvmUnsignedTx(
          from: session.activeAddress,
          to: widget.to,
          data: '0x',
          valueWei: widget.valueWei.toString(),
        ),
      );

      // Add a small safety buffer.
      final gasLimit = max(21000, (estimate * 12 / 10).ceil());

      final tx = EvmTxRequest(
        to: widget.to,
        data: '0x',
        value: widget.valueWei.toString(),
        gasLimit: gasLimit.toString(),
        type: fee.type,
        gasPrice: fee.gasPrice,
        maxFeePerGas: fee.maxFeePerGas,
        maxPriorityFeePerGas: fee.maxPriorityFeePerGas,
      );

      final gasLimitBig = BigInt.from(gasLimit);
      final feePerGas = switch (fee.type) {
        TxType.legacy => BigInt.tryParse(fee.gasPrice ?? '') ?? BigInt.zero,
        TxType.eip1559 => BigInt.tryParse(fee.maxFeePerGas ?? '') ?? BigInt.zero,
      };

      if (!mounted) return;
      setState(() {
        _tx = tx;
        _feeWei = feePerGas * gasLimitBig;
        _loading = false;
      });
    } catch (e) {
      if (!mounted) return;
      setState(() {
        _error = e.toString();
        _loading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final network = ref.watch(selectedNetworkProvider);
    final balanceAsync = ref.watch(evmNativeBalanceWeiProvider);
    final amountEth = formatWeiToEth(widget.valueWei, maxFractionDigits: 6);
    final feeEth = formatWeiToEth(_feeWei, maxFractionDigits: 6);
    final totalWei = widget.valueWei + _feeWei;
    final totalEth = formatWeiToEth(totalWei, maxFractionDigits: 6);

    final bool insufficientForTotal = balanceAsync.maybeWhen(
      data: (b) => totalWei > b,
      orElse: () => false,
    );

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
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: _loading
              ? const Center(child: CircularProgressIndicator())
              : _error != null
                  ? Center(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            _error!,
                            style: const TextStyle(color: AppColors.error),
                            textAlign: TextAlign.center,
                          ),
                          const SizedBox(height: 12),
                          FilledButton(
                            onPressed: _prepare,
                            child: const Text('Retry'),
                          ),
                        ],
                      ),
                    )
                  : Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Container(
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            color: AppColors.surface,
                            borderRadius: BorderRadius.circular(14),
                            border: Border.all(color: AppColors.primary, width: 1),
                          ),
                          child: Column(
                            children: [
                              _Row(label: 'Network', value: network.name),
                              const SizedBox(height: 10),
                              _Row(label: 'To', value: widget.to),
                              const SizedBox(height: 10),
                              _Row(label: 'Amount', value: '$amountEth ETH'),
                              const SizedBox(height: 10),
                              _Row(label: 'Fee (est.)', value: '$feeEth ETH'),
                              const Divider(height: 22, color: AppColors.border),
                              _Row(label: 'Total', value: '$totalEth ETH'),
                            ],
                          ),
                        ),
                        if (insufficientForTotal) ...[
                          const SizedBox(height: 12),
                          const Text(
                            'Insufficient balance for amount + network fee',
                            style: TextStyle(
                              color: AppColors.error,
                              fontSize: 12,
                              fontWeight: FontWeight.w700,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ],
                        const Spacer(),
                        SizedBox(
                          height: 56,
                          child: FilledButton(
                            onPressed: (_submitting || insufficientForTotal)
                                ? null
                                : _send,
                            style: FilledButton.styleFrom(
                              backgroundColor: AppColors.primary,
                              foregroundColor: Colors.black,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                            child: _submitting
                                ? const SizedBox(
                                    width: 18,
                                    height: 18,
                                    child: CircularProgressIndicator(strokeWidth: 2),
                                  )
                                : const Text(
                                    'Confirm & Send',
                                    style: TextStyle(fontWeight: FontWeight.w800),
                                  ),
                          ),
                        ),
                      ],
                    ),
        ),
      ),
    );
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

  Future<void> _send() async {
    final tx = _tx;
    if (tx == null) return;

    setState(() => _submitting = true);
    try {
      final session = ref.read(walletSessionProvider);
      final from = session.activeAddress;
      if (from == null || from.isEmpty) {
        throw Exception('Wallet not initialized');
      }

      final mnemonic = await _ensureMnemonic();
      if (mnemonic == null || mnemonic.isEmpty) {
        throw Exception('Wallet mnemonic missing');
      }

      final balance = await ref.read(evmNativeBalanceWeiProvider.future);
      if (widget.valueWei + _feeWei > balance) {
        throw Exception('Insufficient balance for amount + network fee');
      }

      final repo = ref.read(evmChainRepositoryProvider);
      final network = ref.read(selectedNetworkProvider);

      final nonce = await repo.getNonce(from);
      final signedRaw = await ref.read(walletEngineProvider).signEvmTx(
            mnemonic: mnemonic,
            chainId: network.chainId,
            tx: tx,
            nonce: nonce,
          );

      final txHash = await repo.sendRawTx(signedRaw);
      await ref.read(localTxStoreProvider).addOutgoing(
            chainId: network.chainId,
            from: from,
            to: widget.to,
            hash: txHash,
            valueWei: widget.valueWei.toString(),
          );
      ref.invalidate(evmNativeBalanceWeiProvider);

      if (!mounted) return;
      await Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (_) => TxStatusScreen(txHash: txHash),
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
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Text(
            label,
            style: const TextStyle(
              color: AppColors.textSecondary,
              fontSize: 12,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          flex: 2,
          child: Text(
            value,
            style: const TextStyle(
              color: AppColors.textPrimary,
              fontSize: 12,
              fontWeight: FontWeight.w700,
            ),
            textAlign: TextAlign.right,
          ),
        ),
      ],
    );
  }
}
