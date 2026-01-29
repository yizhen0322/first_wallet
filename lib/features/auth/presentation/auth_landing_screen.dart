import 'package:flutter/material.dart';

import '../../../app/router.dart';
import '../../../shared/theme/app_theme.dart';

class AuthLandingScreen extends StatelessWidget {
  const AuthLandingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Spacer(flex: 2),
            // PAVILION Logo (placeholder until actual logo asset is added)
            Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    width: 120,
                    height: 120,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                          colors: [
                            AppColors.primary,
                            AppColors.primary.withValues(alpha: 153),
                          ],
                        ),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: const Center(
                      child: Text(
                        'P',
                        style: TextStyle(
                          fontSize: 64,
                          fontWeight: FontWeight.w900,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 24),
                  const Text(
                    'PAVILION',
                    style: TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.w700,
                      color: AppColors.textPrimary,
                      letterSpacing: 2,
                    ),
                  ),
                ],
              ),
            ),
            const Spacer(flex: 3),
            // Buttons
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 28),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  OutlinedButton(
                    onPressed: () =>
                        Navigator.of(context).pushNamed(AppRoutes.login),
                    child: const Text('Log In'),
                  ),
                  const SizedBox(height: 16),
                  FilledButton(
                    onPressed: () =>
                        Navigator.of(context).pushNamed(AppRoutes.register),
                    child: const Text('Register'),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 40),
            // Bottom Navigation Preview (non-functional)
            Container(
              padding: const EdgeInsets.symmetric(vertical: 12),
              decoration: BoxDecoration(
                border: Border(
                  top: BorderSide(color: AppColors.border, width: 0.5),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  _NavPreviewItem(
                    icon: Icons.account_balance_wallet_outlined,
                    label: 'Wallet',
                  ),
                  _NavPreviewItem(
                    icon: Icons.credit_card_outlined,
                    label: 'Cards',
                  ),
                  _NavPreviewItem(
                    icon: Icons.person_outline,
                    label: 'Account',
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _NavPreviewItem extends StatelessWidget {
  const _NavPreviewItem({
    required this.icon,
    required this.label,
  });

  final IconData icon;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(
          icon,
          color: AppColors.textTertiary,
          size: 26,
        ),
        const SizedBox(height: 4),
        Text(
          label,
          style: const TextStyle(
            color: AppColors.textTertiary,
            fontSize: 11,
          ),
        ),
      ],
    );
  }
}
