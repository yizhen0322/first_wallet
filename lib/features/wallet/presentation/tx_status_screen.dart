import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../shared/contracts/app_contracts.dart';
import '../../../shared/theme/app_theme.dart';
import '../state/evm_balance.dart';

class TxStatusScreen extends ConsumerStatefulWidget {
  const TxStatusScreen({
    super.key,
    required this.txHash,
    this.title = 'Transaction Status',
  });

  final String txHash;
  final String title;

  @override
  ConsumerState<TxStatusScreen> createState() => _TxStatusScreenState();
}

class _TxStatusScreenState extends ConsumerState<TxStatusScreen> {
  Timer? _timer;
  TxReceipt? _receipt;
  String? _error;

  @override
  void initState() {
    super.initState();
    _pollOnce();
    _timer = Timer.periodic(const Duration(seconds: 4), (_) => _pollOnce());
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  Future<void> _pollOnce() async {
    if (_receipt != null) return;
    try {
      final repo = ref.read(evmChainRepositoryProvider);
      final receipt = await repo.getReceipt(widget.txHash);
      if (!mounted) return;
      if (receipt != null) {
        setState(() => _receipt = receipt);
        _timer?.cancel();
        ref.invalidate(evmNativeBalanceWeiProvider);
      }
    } catch (e) {
      if (!mounted) return;
      setState(() => _error = e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    final network = ref.watch(selectedNetworkProvider);
    final status = _receipt == null
        ? 'Pending'
        : _receipt!.success
            ? 'Success'
            : 'Failed';
    final statusColor = _receipt == null
        ? AppColors.textSecondary
        : _receipt!.success
            ? AppColors.success
            : AppColors.error;

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.background,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: AppColors.textPrimary),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text(
          widget.title,
          style: const TextStyle(color: AppColors.textPrimary),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(28),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                network.name,
                style: const TextStyle(
                  color: AppColors.textSecondary,
                  fontSize: 12,
                  fontWeight: FontWeight.w700,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 10),
              Text(
                status,
                style: TextStyle(
                  color: statusColor,
                  fontSize: 22,
                  fontWeight: FontWeight.w800,
                ),
                textAlign: TextAlign.center,
              ),
              if (_receipt != null) ...[
                const SizedBox(height: 10),
                Text(
                  'Block: ${_receipt!.blockNumber}',
                  style: const TextStyle(
                    color: AppColors.textPrimary,
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
              if (_error != null) ...[
                const SizedBox(height: 10),
                Text(
                  _error!,
                  style: const TextStyle(color: AppColors.error, fontSize: 12),
                  textAlign: TextAlign.center,
                ),
              ],
              const SizedBox(height: 18),
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                decoration: BoxDecoration(
                  color: AppColors.surface,
                  borderRadius: BorderRadius.circular(14),
                  border: Border.all(color: AppColors.primary, width: 1),
                ),
                child: Text(
                  widget.txHash,
                  style: const TextStyle(
                    color: AppColors.textPrimary,
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              const Spacer(),
              FilledButton(
                onPressed: () => _copy(context, widget.txHash),
                style: FilledButton.styleFrom(
                  minimumSize: const Size.fromHeight(56),
                  backgroundColor: AppColors.primary,
                  foregroundColor: Colors.black,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: const Text(
                  'Copy Tx Hash',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w800),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _copy(BuildContext context, String text) async {
    await Clipboard.setData(ClipboardData(text: text));
    if (!context.mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Copied')),
    );
  }
}
