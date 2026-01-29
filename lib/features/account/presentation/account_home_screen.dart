import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../app/router.dart';
import '../../../shared/theme/app_theme.dart';
import '../../auth/state/auth_controller.dart';
import '../../wallet/presentation/address_book_screen.dart';

class AccountHomeScreen extends ConsumerWidget {
  const AccountHomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.background,
        title: const Text(
          'Profile',
          style: TextStyle(color: AppColors.textPrimary),
        ),
      ),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(20),
          children: [
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: AppColors.surface,
                borderRadius: BorderRadius.circular(14),
                border: Border.all(color: AppColors.border, width: 0.5),
              ),
              child: Row(
                children: [
                  Container(
                    width: 56,
                    height: 56,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: AppColors.primary,
                    ),
                    child: const Center(
                      child: Icon(Icons.person, color: Colors.black, size: 28),
                    ),
                  ),
                  const SizedBox(width: 16),
                  const Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'User',
                          style: TextStyle(
                            color: AppColors.textPrimary,
                            fontSize: 18,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        SizedBox(height: 4),
                        Text(
                          'user@example.com',
                          style: TextStyle(
                            color: AppColors.textSecondary,
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),
            Container(
              decoration: BoxDecoration(
                color: AppColors.surface,
                borderRadius: BorderRadius.circular(14),
                border: Border.all(color: AppColors.border, width: 0.5),
              ),
              child: Column(
                children: [
                  ListTile(
                    leading: const Icon(Icons.contacts_outlined,
                        color: AppColors.textPrimary),
                    title: const Text(
                      'Address Book',
                      style: TextStyle(color: AppColors.textPrimary),
                    ),
                    trailing: const Icon(Icons.chevron_right,
                        color: AppColors.textSecondary),
                    onTap: () => Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (_) => const AddressBookScreen(),
                      ),
                    ),
                  ),
                  const Divider(height: 1, color: AppColors.border),
                  ListTile(
                    leading: const Icon(Icons.support_agent,
                        color: AppColors.textPrimary),
                    title: const Text(
                      'Support Center',
                      style: TextStyle(color: AppColors.textPrimary),
                    ),
                    trailing: const Icon(Icons.chevron_right,
                        color: AppColors.textSecondary),
                    onTap: () => Navigator.of(context)
                        .pushNamed(AppRoutes.supportCenter),
                  ),
                  const Divider(height: 1, color: AppColors.border),
                  ListTile(
                    leading: const Icon(Icons.attach_money,
                        color: AppColors.textPrimary),
                    title: const Text(
                      'Base Currency',
                      style: TextStyle(color: AppColors.textPrimary),
                    ),
                    trailing: const Icon(Icons.chevron_right,
                        color: AppColors.textSecondary),
                    onTap: () =>
                        Navigator.of(context).pushNamed(AppRoutes.baseCurrency),
                  ),
                  const Divider(height: 1, color: AppColors.border),
                  ListTile(
                    leading: const Icon(Icons.email_outlined,
                        color: AppColors.textPrimary),
                    title: const Text(
                      'Change Email',
                      style: TextStyle(color: AppColors.textPrimary),
                    ),
                    trailing: const Icon(Icons.chevron_right,
                        color: AppColors.textSecondary),
                    onTap: () =>
                        Navigator.of(context).pushNamed(AppRoutes.changeEmail),
                  ),
                  const Divider(height: 1, color: AppColors.border),
                  ListTile(
                    leading: const Icon(Icons.lock_outline,
                        color: AppColors.textPrimary),
                    title: const Text(
                      'Change Password',
                      style: TextStyle(color: AppColors.textPrimary),
                    ),
                    trailing: const Icon(Icons.chevron_right,
                        color: AppColors.textSecondary),
                    onTap: () => Navigator.of(context)
                        .pushNamed(AppRoutes.changePassword),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),
            SizedBox(
              height: 56,
              child: FilledButton.icon(
                onPressed: () async {
                  await ref.read(authControllerProvider.notifier).logout();
                },
                icon: const Icon(Icons.logout),
                label: const Text('Log Out'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
