import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../app/router.dart';
import '../../../shared/contracts/app_contracts.dart';
import '../../../shared/theme/app_theme.dart';
import '../../../shared/utils/eth_format.dart';
import '../state/evm_balance.dart';
import '../state/wallet_state.dart';

class ManageWalletsScreen extends ConsumerWidget {
  const ManageWalletsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final walletsAsync = ref.watch(walletsProvider);
    final selectedId = ref.watch(selectedWalletIdProvider);

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.background,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: AppColors.textPrimary),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: const Text(
          'Manage Wallets',
          style: TextStyle(color: AppColors.textPrimary),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(28),
          child: Column(
            children: [
              Expanded(
                child: walletsAsync.when(
                  loading: () =>
                      const Center(child: CircularProgressIndicator()),
                  error: (e, _) => Center(
                    child: Text(
                      'Failed to load wallets: $e',
                      style: const TextStyle(color: AppColors.textPrimary),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  data: (wallets) {
                    if (wallets.isEmpty) {
                      return Center(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: const [
                            Text(
                              'No wallets yet',
                              style: TextStyle(
                                color: AppColors.textPrimary,
                                fontSize: 18,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            SizedBox(height: 12),
                            Text(
                              'Create, import, or watch a wallet to get started.',
                              style: TextStyle(color: AppColors.textSecondary),
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                      );
                    }

                    return Container(
                      decoration: BoxDecoration(
                        color: AppColors.background,
                        borderRadius: BorderRadius.circular(14),
                        border: Border.all(color: AppColors.primary, width: 1),
                      ),
                      child: Column(
                        children: [
                          for (var i = 0; i < wallets.length; i++) ...[
                            _WalletRow(
                              wallet: wallets[i],
                              selected: wallets[i].id == selectedId,
                              onSelect: () {
                                ref
                                    .read(walletsProvider.notifier)
                                    .selectWallet(wallets[i].id)
                                    .catchError((e) {
                                  if (!context.mounted) return;
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                        content: Text(
                                            'Failed to select wallet: $e')),
                                  );
                                });
                              },
                              onMore: () =>
                                  _showWalletMenu(context, ref, wallets[i]),
                              balanceAsync: ref
                                  .watch(walletBalanceProvider(wallets[i].id)),
                            ),
                            if (i != wallets.length - 1)
                              Divider(
                                height: 1,
                                thickness: 1,
                                color: AppColors.primary,
                              ),
                          ],
                        ],
                      ),
                    );
                  },
                ),
              ),
              const SizedBox(height: 28),
              Row(
                children: [
                  Expanded(
                    child: _SquareAction(
                      icon: Icons.add,
                      label: 'Add New',
                      onTap: () =>
                          Navigator.of(context).pushNamed(AppRoutes.newWallet),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: _SquareAction(
                      icon: Icons.download_rounded,
                      label: 'Import',
                      onTap: () => Navigator.of(context)
                          .pushNamed(AppRoutes.importWallet),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: _SquareAction(
                      icon: Icons.visibility_outlined,
                      label: 'Watch',
                      onTap: () => Navigator.of(context)
                          .pushNamed(AppRoutes.watchWallet),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showWalletMenu(
    BuildContext context,
    WidgetRef ref,
    WalletSummary wallet,
  ) {
    showModalBottomSheet<void>(
      context: context,
      backgroundColor: AppColors.surface,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(18)),
      ),
      builder: (_) => SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(height: 8),
            Container(
              width: 44,
              height: 4,
              decoration: BoxDecoration(
                color: AppColors.border,
                borderRadius: BorderRadius.circular(999),
              ),
            ),
            const SizedBox(height: 8),
            ListTile(
              leading: const Icon(Icons.settings, color: AppColors.textPrimary),
              title: const Text(
                'Wallet Settings',
                style: TextStyle(color: AppColors.textPrimary),
              ),
              onTap: () {
                Navigator.of(context).pop();
                Navigator.of(context).pushNamed(AppRoutes.walletDetails);
              },
            ),
            ListTile(
              leading: const Icon(Icons.delete_outline, color: AppColors.error),
              title: const Text(
                'Delete Wallet',
                style: TextStyle(color: AppColors.error),
              ),
              onTap: () async {
                Navigator.of(context).pop();
                final ok = await showDialog<bool>(
                  context: context,
                  builder: (_) => AlertDialog(
                    backgroundColor: AppColors.surface,
                    title: const Text(
                      'Delete wallet?',
                      style: TextStyle(color: AppColors.textPrimary),
                    ),
                    content: Text(
                      'This removes "${wallet.name}" from this device.',
                      style: const TextStyle(color: AppColors.textSecondary),
                    ),
                    actions: [
                      TextButton(
                        onPressed: () => Navigator.of(context).pop(false),
                        child: const Text('Cancel'),
                      ),
                      TextButton(
                        onPressed: () => Navigator.of(context).pop(true),
                        style: TextButton.styleFrom(
                            foregroundColor: AppColors.error),
                        child: const Text('Delete'),
                      ),
                    ],
                  ),
                );
                if (ok != true) return;

                await ref
                    .read(walletsProvider.notifier)
                    .deleteWallet(wallet.id);
                if (!context.mounted) return;
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Wallet deleted')),
                );
              },
            ),
            const SizedBox(height: 10),
          ],
        ),
      ),
    );
  }
}

class _WalletRow extends StatelessWidget {
  const _WalletRow({
    required this.wallet,
    required this.selected,
    required this.onSelect,
    required this.onMore,
    required this.balanceAsync,
  });

  final WalletSummary wallet;
  final bool selected;
  final VoidCallback onSelect;
  final VoidCallback onMore;
  final AsyncValue<BigInt> balanceAsync;

  @override
  Widget build(BuildContext context) {
    final subtitleColor =
        wallet.backupRequired ? AppColors.success : AppColors.textSecondary;

    return InkWell(
      onTap: onSelect,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 16),
        child: Row(
          children: [
            _SelectDot(selected: selected),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    wallet.name,
                    style: const TextStyle(
                      color: AppColors.textPrimary,
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    wallet.backupRequired
                        ? 'Backup Required'
                        : wallet.backupLabel,
                    style: TextStyle(
                      color: subtitleColor,
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
            // Balance display
            Padding(
              padding: const EdgeInsets.only(right: 4),
              child: balanceAsync.when(
                loading: () => const SizedBox(
                  width: 16,
                  height: 16,
                  child: CircularProgressIndicator(strokeWidth: 2),
                ),
                error: (_, __) => const Text(
                  '—',
                  style: TextStyle(
                    color: AppColors.textSecondary,
                    fontSize: 12,
                  ),
                ),
                data: (wei) => Text(
                  '${formatWeiToEth(wei, maxFractionDigits: 4)} ETH',
                  style: const TextStyle(
                    color: AppColors.textPrimary,
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
            IconButton(
              onPressed: onMore,
              icon: const Icon(
                Icons.more_vert,
                color: AppColors.textSecondary,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _SelectDot extends StatelessWidget {
  const _SelectDot({required this.selected});

  final bool selected;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 18,
      height: 18,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(color: AppColors.primary, width: 2),
        color: selected ? AppColors.primary : Colors.transparent,
      ),
    );
  }
}

class _SquareAction extends StatelessWidget {
  const _SquareAction({
    required this.icon,
    required this.label,
    required this.onTap,
  });

  final IconData icon;
  final String label;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 92,
      child: Material(
        color: AppColors.primary,
        borderRadius: BorderRadius.circular(14),
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(14),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(icon, color: Colors.black, size: 26),
                const SizedBox(height: 8),
                Text(
                  label,
                  style: const TextStyle(
                    color: Colors.black,
                    fontSize: 13,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
