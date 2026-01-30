import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../app/router.dart';
import '../../../shared/contracts/app_contracts.dart';
import '../../../shared/theme/app_theme.dart';
import '../../../shared/utils/eth_format.dart';
import '../../wallet/state/evm_balance.dart';
import '../../wallet/state/wallet_secrets.dart';
import '../state/swap_quote.dart';
import '../state/swap_state.dart';
import '../state/swap_tokens.dart';

class SwapMainScreen extends ConsumerStatefulWidget {
  const SwapMainScreen({super.key});

  @override
  ConsumerState<SwapMainScreen> createState() => _SwapMainScreenState();
}

class _SwapMainScreenState extends ConsumerState<SwapMainScreen> {
  final _amountCtrl = TextEditingController();

  Timer? _debounce;

  @override
  void dispose() {
    _debounce?.cancel();
    _amountCtrl.dispose();
    super.dispose();
  }

  Future<void> _pickToken({
    required bool isFrom,
    required List<SwapToken> tokens,
  }) async {
    final picked = await showModalBottomSheet<SwapToken>(
      context: context,
      backgroundColor: AppColors.surface,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(18)),
      ),
      builder: (ctx) => SafeArea(
        child: ListView(
          shrinkWrap: true,
          padding: const EdgeInsets.all(12),
          children: [
            const Padding(
              padding: EdgeInsets.all(12),
              child: Text(
                'Select Token',
                style: TextStyle(
                  color: AppColors.textPrimary,
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
            ...tokens.map(
              (t) => ListTile(
                title: Text(
                  t.symbol,
                  style: const TextStyle(color: AppColors.textPrimary),
                ),
                subtitle: Text(
                  t.isNative ? 'Native' : t.address,
                  style: const TextStyle(
                    color: AppColors.textSecondary,
                    fontSize: 12,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                onTap: () => Navigator.of(ctx).pop(t),
              ),
            ),
          ],
        ),
      ),
    );

    if (!mounted || picked == null) return;

    final c = ref.read(swapFormProvider.notifier);
    if (isFrom) {
      c.setFromToken(
        address: picked.address,
        symbol: picked.symbol,
        decimals: picked.decimals,
      );
    } else {
      c.setToToken(
        address: picked.address,
        symbol: picked.symbol,
        decimals: picked.decimals,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final form = ref.watch(swapFormProvider);
    final mnemonic = ref.watch(currentMnemonicProvider);
    final session = ref.watch(walletSessionProvider);
    final canSign =
        (mnemonic != null && mnemonic.trim().isNotEmpty) && session.isUnlocked;

    final balanceAsync = ref.watch(evmNativeBalanceWeiProvider);
    final quoteAsync = ref.watch(swapQuoteProvider);
    final tokensAsync = ref.watch(swapTokensProvider);

    if (_amountCtrl.text != form.amount) {
      _amountCtrl.text = form.amount;
      _amountCtrl.selection =
          TextSelection.collapsed(offset: _amountCtrl.text.length);
    }

    final balanceText = balanceAsync.when(
      data: (wei) => 'Available: ${formatWeiToEth(wei, maxFractionDigits: 6)} ETH',
      loading: () => 'Loading balance...',
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
            onPressed: () => Navigator.of(context).pushNamed(AppRoutes.swapSettings),
            icon: const Icon(Icons.settings_outlined, color: AppColors.textPrimary),
          ),
        ],
      ),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(20),
          children: [
            if (!canSign)
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: AppColors.surface,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: AppColors.border, width: 0.5),
                ),
                child: const Text(
                  'Watch-only wallet: swapping is disabled.',
                  style: TextStyle(color: AppColors.textSecondary),
                  textAlign: TextAlign.center,
                ),
              ),
            if (!canSign) const SizedBox(height: 12),
            tokensAsync.when(
              loading: () => const Center(child: CircularProgressIndicator()),
              error: (e, _) => Text(
                'Failed to load tokens: $e',
                style: const TextStyle(color: AppColors.error),
              ),
              data: (tokens) => Column(
                children: [
                  _TokenCard(
                    label: 'You Pay',
                    symbol: form.fromSymbol,
                    controller: _amountCtrl,
                    enabledAmount: canSign,
                    helperText: balanceText,
                    onSymbolTap: () => _pickToken(isFrom: true, tokens: tokens),
                    onAmountChanged: (v) {
                      _debounce?.cancel();
                      _debounce = Timer(const Duration(milliseconds: 250), () {
                        ref.read(swapFormProvider.notifier).setAmount(v.trim());
                      });
                    },
                  ),
                  const SizedBox(height: 12),
                  Center(
                    child: Container(
                      width: 48,
                      height: 48,
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: AppColors.primary,
                      ),
                      child: IconButton(
                        onPressed: canSign
                            ? () => ref.read(swapFormProvider.notifier).flip()
                            : null,
                        icon: const Icon(Icons.swap_vert, color: Colors.black),
                      ),
                    ),
                  ),
                  const SizedBox(height: 12),
                  _TokenCard(
                    label: 'You Get',
                    symbol: form.toSymbol,
                    controller: TextEditingController(
                      text: quoteAsync.maybeWhen(
                        data: (q) => _formatFromSmallestUnit(
                          q.amountOut,
                          form.toDecimals,
                        ),
                        orElse: () => '',
                      ),
                    ),
                    enabledAmount: false,
                    helperText: quoteAsync.maybeWhen(
                      loading: () => 'Estimating…',
                      data: (_) => 'Estimated',
                      orElse: () => 'Estimated',
                    ),
                    onSymbolTap: () => _pickToken(isFrom: false, tokens: tokens),
                    onAmountChanged: null,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 14),
            _DexCard(),
            const SizedBox(height: 16),
            quoteAsync.when(
              loading: () => const SizedBox.shrink(),
              error: (e, _) => Text(
                e.toString(),
                style: const TextStyle(color: AppColors.textSecondary),
                textAlign: TextAlign.center,
              ),
              data: (q) => Column(
                children: [
                  if (q.warnings.isNotEmpty)
                    Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: AppColors.surface,
                        borderRadius: BorderRadius.circular(12),
                        border:
                            Border.all(color: AppColors.border, width: 0.5),
                      ),
                      child: Text(
                        q.warnings.join('\n'),
                        style: const TextStyle(color: AppColors.textSecondary),
                      ),
                    ),
                ],
              ),
            ),
            const SizedBox(height: 24),
            SizedBox(
              height: 56,
              child: FilledButton(
                onPressed: canSign
                    ? () => Navigator.of(context).pushNamed(AppRoutes.swapConfirm)
                    : null,
                child: const Text('Swap'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _DexCard extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final form = ref.watch(swapFormProvider);
    return Container(
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
        trailing:
            const Icon(Icons.chevron_right, color: AppColors.textSecondary),
        onTap: () => Navigator.of(context).pushNamed(AppRoutes.swapDex),
      ),
    );
  }
}

class _TokenCard extends StatelessWidget {
  const _TokenCard({
    required this.label,
    required this.symbol,
    required this.controller,
    required this.onSymbolTap,
    required this.onAmountChanged,
    this.enabledAmount = true,
    this.helperText,
  });

  final String label;
  final String symbol;
  final TextEditingController controller;
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
                  controller: controller,
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
