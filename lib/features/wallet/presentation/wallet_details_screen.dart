import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../app/router.dart';
import '../../../shared/contracts/app_contracts.dart';
import '../../../shared/theme/app_theme.dart';
import '../state/wallet_state.dart';

class WalletDetailsScreen extends ConsumerStatefulWidget {
  const WalletDetailsScreen({super.key});

  @override
  ConsumerState<WalletDetailsScreen> createState() =>
      _WalletDetailsScreenState();
}

class _WalletDetailsScreenState extends ConsumerState<WalletDetailsScreen> {
  int _backupMode = 0; // 0 = manual, 1 = local
  final _nameCtrl = TextEditingController();
  String? _editingWalletId;

  @override
  void dispose() {
    _nameCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final walletsAsync = ref.watch(walletsProvider);
    final selectedId = ref.watch(selectedWalletIdProvider);

    return walletsAsync.when(
      loading: () => const Scaffold(
        backgroundColor: AppColors.background,
        body: Center(child: CircularProgressIndicator()),
      ),
      error: (e, _) => Scaffold(
        backgroundColor: AppColors.background,
        body: Center(
          child: Text(
            'Failed to load wallets: $e',
            style: const TextStyle(color: AppColors.textPrimary),
            textAlign: TextAlign.center,
          ),
        ),
      ),
      data: (wallets) {
        if (wallets.isEmpty) {
          return Scaffold(
            backgroundColor: AppColors.background,
            appBar: AppBar(
              backgroundColor: AppColors.background,
              leading: IconButton(
                icon:
                    const Icon(Icons.arrow_back, color: AppColors.textPrimary),
                onPressed: () => Navigator.of(context).pop(),
              ),
              title: const Text(
                'Wallet',
                style: TextStyle(color: AppColors.textPrimary),
              ),
              centerTitle: true,
            ),
            body: const Center(
              child: Text(
                'No wallets found',
                style: TextStyle(color: AppColors.textPrimary),
              ),
            ),
          );
        }

        final selected = wallets.firstWhere(
          (w) => w.id == selectedId,
          orElse: () => wallets.first,
        );
        if (_editingWalletId != selected.id) {
          _editingWalletId = selected.id;
          _nameCtrl.text = selected.name;
        }

        return Scaffold(
          backgroundColor: AppColors.background,
          appBar: AppBar(
            backgroundColor: AppColors.background,
            leading: IconButton(
              icon: const Icon(Icons.arrow_back, color: AppColors.textPrimary),
              onPressed: () => Navigator.of(context).pop(),
            ),
            title: Text(
              selected.name,
              style: const TextStyle(color: AppColors.textPrimary),
            ),
            centerTitle: true,
          ),
          body: SafeArea(
            child: ListView(
              padding: const EdgeInsets.all(28),
              children: [
                const Text(
                  'Name',
                  style: TextStyle(
                    color: AppColors.textPrimary,
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 8),
                TextField(
                  controller: _nameCtrl,
                  style: const TextStyle(color: AppColors.textPrimary),
                  decoration: InputDecoration(
                    hintText: 'Wallet name',
                    hintStyle: const TextStyle(color: AppColors.textSecondary),
                    filled: true,
                    fillColor: AppColors.background,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide:
                          const BorderSide(color: AppColors.primary, width: 1),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide:
                          const BorderSide(color: AppColors.primary, width: 1),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: const BorderSide(
                          color: AppColors.primary, width: 1.5),
                    ),
                  ),
                ),
                const SizedBox(height: 32),
                const Text(
                  'Settings',
                  style: TextStyle(
                    color: AppColors.textPrimary,
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 12),
                _Group(
                  children: [
                    _GroupItem(
                      icon: Icons.settings_outlined,
                      title: 'Recovery Phrase',
                      onTap: () {
                        Navigator.of(context)
                            .pushNamed(AppRoutes.recoveryPhrase);
                      },
                    ),
                    _GroupItem(
                      icon: Icons.vpn_key_outlined,
                      title: 'Private Keys',
                      onTap: () => Navigator.of(context)
                          .pushNamed(AppRoutes.privateKeys),
                    ),
                    _GroupItem(
                      icon: Icons.public,
                      title: 'Public Keys',
                      onTap: () {
                        Navigator.of(context).pushNamed(AppRoutes.publicKeys);
                      },
                    ),
                  ],
                ),
                const SizedBox(height: 22),
                _Group(
                  children: [
                    _SelectRow(
                      title: 'Manual Backup',
                      selected: _backupMode == 0,
                      onTap: () => setState(() => _backupMode = 0),
                    ),
                    _SelectRow(
                      title: 'Local Backup',
                      selected: _backupMode == 1,
                      onTap: () => setState(() => _backupMode = 1),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                const Text(
                  'It\'s recommended to have a manual backup for each wallet',
                  style: TextStyle(
                    color: AppColors.textSecondary,
                    fontSize: 12,
                  ),
                ),
                const SizedBox(height: 28),
                TextButton(
                  onPressed: () => _confirmUnlink(context, selected),
                  style: TextButton.styleFrom(
                    foregroundColor: AppColors.error,
                    padding: EdgeInsets.zero,
                  ),
                  child: const Text(
                    'Unlink Wallet',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Future<void> _confirmUnlink(
      BuildContext context, WalletSummary wallet) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        backgroundColor: AppColors.surface,
        title: const Text(
          'Unlink Wallet',
          style: TextStyle(color: AppColors.textPrimary),
        ),
        content: Text(
          'Are you sure you want to unlink "${wallet.name}"?\n\n'
          'This will remove the wallet from this device. '
          'Make sure you have backed up your recovery phrase.',
          style: const TextStyle(color: AppColors.textSecondary),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(false),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(true),
            style: TextButton.styleFrom(foregroundColor: AppColors.error),
            child: const Text('Unlink'),
          ),
        ],
      ),
    );

    if (confirmed != true) return;
    if (!context.mounted) return;

    await ref.read(walletsProvider.notifier).deleteWallet(wallet.id);

    if (!context.mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Wallet unlinked')),
    );
    Navigator.of(context).pop(); // Go back to manage wallets
  }
}

class _Group extends StatelessWidget {
  const _Group({required this.children});

  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    return Container(
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        color: AppColors.background,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: AppColors.primary, width: 1),
      ),
      child: Column(
        children: [
          for (var i = 0; i < children.length; i++) ...[
            children[i],
            if (i != children.length - 1)
              Divider(
                height: 1,
                thickness: 1,
                color: AppColors.primary,
              ),
          ],
        ],
      ),
    );
  }
}

class _GroupItem extends StatelessWidget {
  const _GroupItem({
    required this.icon,
    required this.title,
    required this.onTap,
  });

  final IconData icon;
  final String title;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 16),
        child: Row(
          children: [
            Icon(icon, color: AppColors.textPrimary, size: 20),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                title,
                style: const TextStyle(
                  color: AppColors.textPrimary,
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            const Icon(
              Icons.chevron_right,
              color: AppColors.textSecondary,
            ),
          ],
        ),
      ),
    );
  }
}

class _SelectRow extends StatelessWidget {
  const _SelectRow({
    required this.title,
    required this.selected,
    required this.onTap,
  });

  final String title;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 16),
        child: Row(
          children: [
            Expanded(
              child: Text(
                title,
                style: const TextStyle(
                  color: AppColors.textPrimary,
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            Icon(
              selected ? Icons.check : null,
              color: AppColors.textPrimary,
              size: 20,
            ),
          ],
        ),
      ),
    );
  }
}
