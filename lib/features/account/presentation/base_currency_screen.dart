import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../shared/currency/currency_provider.dart';
import '../../../shared/theme/app_theme.dart';

class BaseCurrencyScreen extends ConsumerWidget {
  const BaseCurrencyScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentCurrency = ref.watch(currencyProvider);

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: const Text('Base Currency'),
        backgroundColor: AppColors.background,
        iconTheme: const IconThemeData(color: AppColors.textPrimary),
        titleTextStyle: const TextStyle(
          color: AppColors.textPrimary,
          fontSize: 20,
          fontWeight: FontWeight.w700,
        ),
      ),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(20),
          children: [
            ...kSupportedCurrencies.map(
              (c) {
                final isSelected = c.code == currentCurrency.code;
                return Card(
                  elevation: 0,
                  color: AppColors.surface,
                  shape: RoundedRectangleBorder(
                    side: BorderSide(
                        color:
                            isSelected ? AppColors.primary : AppColors.border,
                        width: isSelected ? 1.5 : 0.5),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: ListTile(
                    contentPadding:
                        const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    leading: Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                        color: AppColors.background,
                        shape: BoxShape.circle,
                        border: Border.all(color: AppColors.border, width: 0.5),
                      ),
                      child: Center(
                        child: Text(
                          c.symbol,
                          style: const TextStyle(
                            color: AppColors.textPrimary,
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                          ),
                        ),
                      ),
                    ),
                    title: Text(
                      c.code,
                      style: const TextStyle(
                        color: AppColors.textPrimary,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    subtitle: Text(
                      c.name,
                      style: const TextStyle(color: AppColors.textSecondary),
                    ),
                    trailing: isSelected
                        ? const Icon(Icons.check_circle,
                            color: AppColors.primary)
                        : const Icon(Icons.circle_outlined,
                            color: AppColors.textSecondary),
                    onTap: () {
                      ref.read(currencyProvider.notifier).setCurrency(c);
                    },
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
