import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../shared/contracts/app_contracts.dart';
import '../../../shared/theme/app_theme.dart';
import '../../../shared/utils/eth_format.dart';
import '../../activity/data/token_balance_provider.dart';
import '../state/evm_balance.dart';
import '../state/wallet_secrets.dart';
import '../state/wallet_state.dart';
import 'tx_status_screen.dart';

class SendTokenConfirmScreen extends ConsumerStatefulWidget {
  const SendTokenConfirmScreen({
    super.key,
    required this.token,
    required this.to,
    required this.amountRaw,
  });

  final TokenBalance token;
  final String to;
  final BigInt amountRaw;

  @override
  ConsumerState<SendTokenConfirmScreen> createState() =>
      _SendTokenConfirmScreenState();
}

class _SendTokenConfirmScreenState
    extends ConsumerState<SendTokenConfirmScreen> {
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

  /// Build ERC-20 transfer calldata: transfer(address,uint256)
  String _buildTransferData() {
    // Function selector: keccak256("transfer(address,uint256)") first 4 bytes
    const functionSelector = 'a9059cbb';

    // Encode address (32 bytes, left-padded)
    final toAddress = widget.to.toLowerCase().replaceFirst('0x', '');
    final addressPadded = toAddress.padLeft(64, '0');

    // Encode amount (32 bytes)
    final amountHex = widget.amountRaw.toRadixString(16);
    final amountPadded = amountHex.padLeft(64, '0');

    return '0x$functionSelector$addressPadded$amountPadded';
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

      // Build transfer data
      final data = _buildTransferData();

      final estimate = await repo.estimateGas(
        EvmUnsignedTx(
          from: session.activeAddress,
          to: widget.token.contractAddress,
          data: data,
          valueWei: '0', // No ETH transferred for ERC-20
        ),
      );

      // Add safety buffer for token transfers (more complex than ETH)
      final gasLimit = max(65000, (estimate * 15 / 10).ceil());

      final tx = EvmTxRequest(
        to: widget.token.contractAddress,
        data: data,
        value: '0',
        gasLimit: gasLimit.toString(),
        type: fee.type,
        gasPrice: fee.gasPrice,
        maxFeePerGas: fee.maxFeePerGas,
        maxPriorityFeePerGas: fee.maxPriorityFeePerGas,
      );

      final gasLimitBig = BigInt.from(gasLimit);
      final feePerGas = switch (fee.type) {
        TxType.legacy => BigInt.tryParse(fee.gasPrice ?? '') ?? BigInt.zero,
        TxType.eip1559 =>
          BigInt.tryParse(fee.maxFeePerGas ?? '') ?? BigInt.zero,
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

  String get _formattedAmount {
    final decimals = widget.token.decimals;
    final divisor = BigInt.from(10).pow(decimals);
    final whole = widget.amountRaw ~/ divisor;
    final remainder = widget.amountRaw % divisor;

    if (remainder == BigInt.zero) {
      return whole.toString();
    }

    final remainderStr = remainder.toString().padLeft(decimals, '0');
    final trimmed = remainderStr.replaceAll(RegExp(r'0+$'), '');
    return '$whole.${trimmed.isEmpty ? '0' : trimmed}';
  }

  @override
  Widget build(BuildContext context) {
    final network = ref.watch(selectedNetworkProvider);
    final balanceAsync = ref.watch(evmNativeBalanceWeiProvider);
    final feeEth = formatWeiToEth(_feeWei, maxFractionDigits: 6);

    final bool insufficientForFee = balanceAsync.maybeWhen(
      data: (b) => _feeWei > b,
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
                        // Token info card
                        Container(
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            color: AppColors.surface,
                            borderRadius: BorderRadius.circular(14),
                          ),
                          child: Row(
                            children: [
                              Container(
                                width: 48,
                                height: 48,
                                decoration: BoxDecoration(
                                  color:
                                      AppColors.primary.withValues(alpha: 51),
                                  borderRadius: BorderRadius.circular(24),
                                ),
                                child: Center(
                                  child: Text(
                                    widget.token.symbol[0].toUpperCase(),
                                    style: const TextStyle(
                                      color: AppColors.primary,
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(width: 12),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      '$_formattedAmount ${widget.token.symbol}',
                                      style: const TextStyle(
                                        color: AppColors.textPrimary,
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    Text(
                                      widget.token.name,
                                      style: const TextStyle(
                                        color: AppColors.textSecondary,
                                        fontSize: 12,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 16),
                        // Transaction details
                        Container(
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            color: AppColors.surface,
                            borderRadius: BorderRadius.circular(14),
                            border:
                                Border.all(color: AppColors.primary, width: 1),
                          ),
                          child: Column(
                            children: [
                              _Row(label: 'Network', value: network.name),
                              const SizedBox(height: 10),
                              _Row(
                                label: 'To',
                                value: _shortAddress(widget.to),
                              ),
                              const SizedBox(height: 10),
                              _Row(
                                label: 'Contract',
                                value:
                                    _shortAddress(widget.token.contractAddress),
                              ),
                              const Divider(
                                  height: 22, color: AppColors.border),
                              _Row(
                                label: 'Network Fee',
                                value: '$feeEth ETH',
                              ),
                            ],
                          ),
                        ),
                        if (insufficientForFee) ...[
                          const SizedBox(height: 12),
                          const Text(
                            'Insufficient ETH for network fee',
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
                            onPressed: (_submitting || insufficientForFee)
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
                                    child: CircularProgressIndicator(
                                        strokeWidth: 2),
                                  )
                                : const Text(
                                    'Confirm & Send',
                                    style:
                                        TextStyle(fontWeight: FontWeight.w800),
                                  ),
                          ),
                        ),
                      ],
                    ),
        ),
      ),
    );
  }

  String _shortAddress(String addr) {
    if (addr.length <= 12) return addr;
    return '${addr.substring(0, 6)}...${addr.substring(addr.length - 4)}';
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

      // Check ETH balance for gas
      final ethBalance = await ref.read(evmNativeBalanceWeiProvider.future);
      if (_feeWei > ethBalance) {
        throw Exception('Insufficient ETH for network fee');
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

      // Invalidate balances
      ref.invalidate(evmNativeBalanceWeiProvider);
      ref.invalidate(tokenBalanceProvider);

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
