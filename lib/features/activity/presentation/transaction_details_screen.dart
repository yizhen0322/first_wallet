import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../shared/theme/app_theme.dart';
import '../data/transaction_history_provider.dart';

class TransactionDetailsScreen extends StatelessWidget {
  const TransactionDetailsScreen({
    super.key,
    required this.transaction,
    required this.isSepolia,
  });

  final TransactionRecord transaction;
  final bool isSepolia;

  String get _explorerUrl {
    final base =
        isSepolia ? 'https://sepolia.etherscan.io' : 'https://etherscan.io';
    return '$base/tx/${transaction.hash}';
  }

  @override
  Widget build(BuildContext context) {
    final isOutgoing = !transaction.isIncoming;
    final isSuccess = !transaction.isError;
    final statusColor = isSuccess ? Colors.green : AppColors.error;
    final dateFormat = DateFormat('MMM d, yyyy HH:mm');

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.background,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: AppColors.textPrimary),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: const Text(
          'Transaction Details',
          style: TextStyle(color: AppColors.textPrimary),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(20),
          children: [
            // Status card
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: AppColors.surface,
                borderRadius: BorderRadius.circular(14),
              ),
              child: Column(
                children: [
                  Container(
                    width: 64,
                    height: 64,
                    decoration: BoxDecoration(
                      color: statusColor.withValues(alpha: 51),
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      isSuccess
                          ? (isOutgoing
                              ? Icons.arrow_upward
                              : Icons.arrow_downward)
                          : Icons.close,
                      color: statusColor,
                      size: 32,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    '${isOutgoing ? '-' : '+'}${transaction.valueInEth} ETH',
                    style: TextStyle(
                      color: isOutgoing ? AppColors.error : Colors.green,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    isSuccess ? 'Confirmed' : 'Failed',
                    style: TextStyle(
                      color: statusColor,
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            // Details card
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: AppColors.surface,
                borderRadius: BorderRadius.circular(14),
                border: Border.all(color: AppColors.border, width: 0.5),
              ),
              child: Column(
                children: [
                  _DetailRow(
                    label: 'Status',
                    value: isSuccess ? 'Success' : 'Failed',
                    valueColor: statusColor,
                  ),
                  const Divider(height: 24, color: AppColors.border),
                  _DetailRow(
                    label: 'Date',
                    value: dateFormat.format(transaction.timeStamp),
                  ),
                  const Divider(height: 24, color: AppColors.border),
                  _DetailRow(
                    label: 'From',
                    value: transaction.shortFrom,
                    onCopy: () => _copyToClipboard(context, transaction.from),
                  ),
                  const Divider(height: 24, color: AppColors.border),
                  _DetailRow(
                    label: 'To',
                    value: transaction.shortTo,
                    onCopy: () => _copyToClipboard(context, transaction.to),
                  ),
                  const Divider(height: 24, color: AppColors.border),
                  _DetailRow(
                    label: 'Transaction Hash',
                    value: _shortHash(transaction.hash),
                    onCopy: () => _copyToClipboard(context, transaction.hash),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),
            // View on Etherscan button
            SizedBox(
              height: 56,
              child: FilledButton.icon(
                onPressed: () => _openEtherscan(context),
                icon: const Icon(Icons.open_in_new),
                label: const Text('View on Etherscan'),
                style: FilledButton.styleFrom(
                  backgroundColor: AppColors.primary,
                  foregroundColor: Colors.black,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  String _shortHash(String hash) {
    if (hash.length <= 16) return hash;
    return '${hash.substring(0, 10)}...${hash.substring(hash.length - 6)}';
  }

  void _copyToClipboard(BuildContext context, String text) {
    Clipboard.setData(ClipboardData(text: text));
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Copied to clipboard'),
        duration: Duration(seconds: 1),
      ),
    );
  }

  Future<void> _openEtherscan(BuildContext context) async {
    final uri = Uri.parse(_explorerUrl);
    try {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    } catch (e) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Could not open browser')),
        );
      }
    }
  }
}

class _DetailRow extends StatelessWidget {
  const _DetailRow({
    required this.label,
    required this.value,
    this.valueColor,
    this.onCopy,
  });

  final String label;
  final String value;
  final Color? valueColor;
  final VoidCallback? onCopy;

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
              fontSize: 13,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          flex: 2,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Flexible(
                child: Text(
                  value,
                  style: TextStyle(
                    color: valueColor ?? AppColors.textPrimary,
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                  ),
                  textAlign: TextAlign.right,
                ),
              ),
              if (onCopy != null) ...[
                const SizedBox(width: 8),
                GestureDetector(
                  onTap: onCopy,
                  child: const Icon(
                    Icons.copy,
                    size: 16,
                    color: AppColors.textSecondary,
                  ),
                ),
              ],
            ],
          ),
        ),
      ],
    );
  }
}
