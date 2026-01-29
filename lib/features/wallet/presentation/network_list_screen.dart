import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../shared/contracts/app_contracts.dart';
import '../../../shared/theme/app_theme.dart';

class NetworkListScreen extends ConsumerWidget {
  const NetworkListScreen({super.key, this.onSelected});

  final void Function(BuildContext context, ChainConfig network)? onSelected;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final networks = ref.watch(availableNetworksProvider);
    final selected = ref.watch(selectedNetworkProvider);

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.background,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: AppColors.textPrimary),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: const Text(
          'Network',
          style: TextStyle(color: AppColors.textPrimary),
        ),
      ),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(20),
          children: [
            const Padding(
              padding: EdgeInsets.only(bottom: 14),
              child: Text(
                'Choose network to get an address to receive',
                style: TextStyle(color: AppColors.textSecondary, fontSize: 12),
              ),
            ),
            ...networks.map(
              (n) {
                final isSelected = n.chainId == selected.chainId;
                final rpcConfigured = n.rpcUrl.trim().isNotEmpty;
                return Container(
                margin: const EdgeInsets.only(bottom: 12),
                decoration: BoxDecoration(
                  color: AppColors.surface,
                  borderRadius: BorderRadius.circular(14),
                  border: Border.all(color: AppColors.border, width: 0.5),
                ),
                child: ListTile(
                  leading: Container(
                    width: 34,
                    height: 34,
                    decoration: BoxDecoration(
                      color: AppColors.border,
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  title: Text(
                    n.name,
                    style: TextStyle(
                      color: rpcConfigured
                          ? AppColors.textPrimary
                          : AppColors.textSecondary,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  subtitle: Text(
                    n.chainId == 11155111
                        ? 'Sepolia testnet'
                        : 'Ethereum mainnet',
                    style: const TextStyle(color: AppColors.textSecondary),
                  ),
                  trailing: isSelected
                      ? const Icon(Icons.check, color: AppColors.primary)
                      : const Icon(Icons.chevron_right,
                          color: AppColors.textSecondary),
                  onTap: rpcConfigured
                      ? () {
                          ref.read(selectedNetworkProvider.notifier).state = n;
                          onSelected?.call(context, n);
                          if (onSelected == null) {
                            Navigator.of(context).pop();
                          }
                        }
                      : () {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('RPC not configured for this network'),
                            ),
                          );
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
