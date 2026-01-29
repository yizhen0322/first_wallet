import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../app/router.dart';
import '../../../shared/theme/app_theme.dart';
import '../../../shared/utils/eth_format.dart';
import '../../wallet/state/evm_balance.dart';
import '../../wallet/state/wallet_state.dart';
import '../state/swap_state.dart';

class SwapMainScreen extends ConsumerWidget {
  const SwapMainScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final form = ref.watch(swapFormProvider);
    final assets = ref.watch(walletAssetsProvider);
    final balanceAsync = ref.watch(evmNativeBalanceWeiProvider);
    final fromAsset = assets.firstWhere((a) => a.symbol == form.fromSymbol,
        orElse: () => assets[0]);
    final toAsset = assets.firstWhere((a) => a.symbol == form.toSymbol,
        orElse: () => assets[1]);

    final balanceText = balanceAsync.when(
      data: (wei) =>
          'Available: ${formatWeiToEth(wei, maxFractionDigits: 6)} ETH',
      loading: () => 'Loading balance…',
      error: (_, __) => 'Balance unavailable',
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
          'Swap',
          style: TextStyle(color: AppColors.textPrimary),
        ),
        actions: [
          IconButton(
            tooltip: 'Swap Settings',
            onPressed: () =>
                Navigator.of(context).pushNamed(AppRoutes.swapSettings),
            icon: const Icon(Icons.settings_outlined,
                color: AppColors.textPrimary),
          ),
        ],
      ),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(20),
          children: [
            _TokenCard(
              label: 'You Pay',
              symbol: fromAsset.symbol,
              amount: form.amount,
              onSymbolTap: () {},
              onAmountChanged: (v) =>
                  ref.read(swapFormProvider.notifier).setAmount(v),
              helperText: balanceText,
            ),
            const SizedBox(height: 12),
            Center(
              child: Container(
                width: 48,
                height: 48,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: AppColors.primary,
                ),
                child: IconButton(
                  onPressed: () => ref.read(swapFormProvider.notifier).flip(),
                  icon: const Icon(Icons.swap_vert, color: Colors.black),
                ),
              ),
            ),
            const SizedBox(height: 12),
            _TokenCard(
              label: 'You Get',
              symbol: toAsset.symbol,
              amount: '0',
              onSymbolTap: () {},
              enabledAmount: false,
              helperText: 'Estimated',
            ),
            const SizedBox(height: 14),
            Container(
              decoration: BoxDecoration(
                color: AppColors.surface,
                borderRadius: BorderRadius.circular(14),
                border: Border.all(color: AppColors.border, width: 0.5),
              ),
              child: ListTile(
                title: const Text(
                  'DEX',
                  style: TextStyle(color: AppColors.textPrimary),
                ),
                subtitle: Text(
                  form.dex,
                  style: const TextStyle(color: AppColors.textSecondary),
                ),
                trailing: const Icon(Icons.chevron_right,
                    color: AppColors.textSecondary),
                onTap: () => Navigator.of(context).pushNamed(AppRoutes.swapDex),
              ),
            ),
            const SizedBox(height: 24),
            SizedBox(
              height: 56,
              child: FilledButton(
                onPressed: () =>
                    Navigator.of(context).pushNamed(AppRoutes.swapConfirm),
                child: const Text('Swap'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _TokenCard extends StatelessWidget {
  const _TokenCard({
    required this.label,
    required this.symbol,
    required this.amount,
    required this.onSymbolTap,
    this.onAmountChanged,
    this.enabledAmount = true,
    this.helperText,
  });

  final String label;
  final String symbol;
  final String amount;
  final VoidCallback onSymbolTap;
  final ValueChanged<String>? onAmountChanged;
  final bool enabledAmount;
  final String? helperText;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: AppColors.border, width: 0.5),
      ),
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                label,
                style: const TextStyle(
                  color: AppColors.textPrimary,
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const Spacer(),
              if (helperText != null)
                Text(
                  helperText!,
                  style: const TextStyle(
                    color: AppColors.textSecondary,
                    fontSize: 12,
                  ),
                ),
            ],
          ),
          const SizedBox(height: 10),
          Row(
            children: [
              Expanded(
                child: TextField(
                  controller: TextEditingController(text: amount),
                  enabled: enabledAmount,
                  keyboardType:
                      const TextInputType.numberWithOptions(decimal: true),
                  onChanged: onAmountChanged,
                  style: const TextStyle(
                    color: AppColors.textPrimary,
                    fontSize: 24,
                    fontWeight: FontWeight.w600,
                  ),
                  decoration: const InputDecoration(
                    hintText: '0.0',
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.zero,
                  ),
                ),
              ),
              const SizedBox(width: 12),
              OutlinedButton.icon(
                onPressed: onSymbolTap,
                icon: const Icon(Icons.token, size: 18),
                label: Text(symbol),
                style: OutlinedButton.styleFrom(
                  foregroundColor: AppColors.textPrimary,
                  side: const BorderSide(color: AppColors.border),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
