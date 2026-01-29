import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../shared/theme/app_theme.dart';
import '../state/swap_state.dart';

class SwapSettingsScreen extends ConsumerStatefulWidget {
  const SwapSettingsScreen({super.key});

  @override
  ConsumerState<SwapSettingsScreen> createState() => _SwapSettingsScreenState();
}

class _SwapSettingsScreenState extends ConsumerState<SwapSettingsScreen> {
  final _recipientCtrl = TextEditingController();

  @override
  void dispose() {
    _recipientCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final form = ref.watch(swapFormProvider);
    _recipientCtrl.text = form.recipient;

    final options = const [0.5, 0.1, 0.5, 1.0, 3.0];

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.background,
        title: const Text(
          'Swap Settings',
          style: TextStyle(color: AppColors.textPrimary),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: AppColors.textPrimary),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(28),
          children: [
            const Text(
              'Recipient Address',
              style: TextStyle(
                color: AppColors.textPrimary,
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: _recipientCtrl,
              style: const TextStyle(color: AppColors.textPrimary),
              decoration: InputDecoration(
                hintText: 'Address or Domain',
                suffixIcon: IconButton(
                  icon: const Icon(Icons.qr_code_scanner,
                      color: AppColors.textSecondary),
                  onPressed: () {},
                ),
              ),
              onChanged: (v) =>
                  ref.read(swapFormProvider.notifier).setRecipient(v.trim()),
            ),
            const SizedBox(height: 8),
            const Text(
              'After the exchange operation, the amount will be transferred to the specified address',
              style: TextStyle(
                color: AppColors.textSecondary,
                fontSize: 12,
              ),
            ),
            const SizedBox(height: 28),
            const Text(
              'Slippage Tolerance',
              style: TextStyle(
                color: AppColors.textPrimary,
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 12),
            Wrap(
              spacing: 10,
              runSpacing: 10,
              children: [
                for (final o in options)
                  ChoiceChip(
                    label: Text('${o.toStringAsFixed(o == 1 ? 0 : 1)}%'),
                    selected: form.slippage == o,
                    onSelected: (_) =>
                        ref.read(swapFormProvider.notifier).setSlippage(o),
                    selectedColor: AppColors.primary,
                    backgroundColor: AppColors.surface,
                    side: BorderSide(
                      color: form.slippage == o
                          ? AppColors.primary
                          : AppColors.border,
                    ),
                    labelStyle: TextStyle(
                      color: form.slippage == o
                          ? Colors.black
                          : AppColors.textPrimary,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
              ],
            ),
            const SizedBox(height: 8),
            const Text(
              'Your transaction will revert if the price changes unfavorably by more than this percentage',
              style: TextStyle(
                color: AppColors.textSecondary,
                fontSize: 12,
              ),
            ),
            const SizedBox(height: 28),
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: AppColors.surface,
                borderRadius: BorderRadius.circular(14),
                border: Border.all(color: AppColors.border),
              ),
              child: const Text(
                'A service fee for the swap action on the platform typically either 0.25%',
                style: TextStyle(
                  color: AppColors.textSecondary,
                  fontSize: 13,
                ),
              ),
            ),
            const SizedBox(height: 32),
            SizedBox(
              height: 56,
              child: FilledButton(
                onPressed: () => Navigator.of(context).pop(),
                child: const Text('Apply'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
