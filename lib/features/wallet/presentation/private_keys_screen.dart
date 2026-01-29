import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../app/router.dart';
import '../../../shared/theme/app_theme.dart';

/// Screen showing list of private key options
class PrivateKeysScreen extends ConsumerWidget {
  const PrivateKeysScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.background,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: AppColors.textPrimary),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: const Text(
          'Private Keys',
          style: TextStyle(color: AppColors.textPrimary),
        ),
      ),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(28),
          children: [
            _PrivateKeyOption(
              title: 'EVM Private Key',
              description:
                  'Grants full control over EVM based crypto i.e Ethereum, Binance Smart Chain etc. Within respective wallet.',
              onTap: () =>
                  Navigator.of(context).pushNamed(AppRoutes.evmPrivateKey),
            ),
            const SizedBox(height: 16),
            _PrivateKeyOption(
              title: 'BIP32 Root Key',
              description:
                  'Grants full control over the assets on the respective wallet.',
              onTap: () =>
                  Navigator.of(context).pushNamed(AppRoutes.bip32RootKey),
            ),
            const SizedBox(height: 16),
            _PrivateKeyOption(
              title: 'Account Extended Private Key',
              description:
                  'Grants full control over Bitcoin and other UTXO based crypto i.e. Litecoin, Bitcoin Cash, Dash etc. within respective wallet.',
              onTap: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                      content:
                          Text('Account Extended Private Key (coming soon)')),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

class _PrivateKeyOption extends StatelessWidget {
  final String title;
  final String description;
  final VoidCallback onTap;

  const _PrivateKeyOption({
    required this.title,
    required this.description,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: AppColors.background,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: AppColors.primary, width: 1),
          ),
          child: Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: const TextStyle(
                        color: AppColors.textPrimary,
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      description,
                      style: TextStyle(
                        color: AppColors.textSecondary,
                        fontSize: 13,
                        height: 1.4,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 12),
              const Icon(Icons.chevron_right, color: AppColors.textSecondary),
            ],
          ),
        ),
      ),
    );
  }
}
