import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../shared/contracts/app_contracts.dart';
import '../../../shared/theme/app_theme.dart';
import '../state/wallet_state.dart';

class WatchWalletScreen extends ConsumerStatefulWidget {
  const WatchWalletScreen({super.key});

  @override
  ConsumerState<WatchWalletScreen> createState() => _WatchWalletScreenState();
}

class _WatchWalletScreenState extends ConsumerState<WatchWalletScreen> {
  final _nameCtrl = TextEditingController(text: 'Watch Wallet');
  final _addressCtrl = TextEditingController();
  bool _isSubmitting = false;
  String? _addressError;

  @override
  void dispose() {
    _nameCtrl.dispose();
    _addressCtrl.dispose();
    super.dispose();
  }

  bool _isValidEvmAddress(String address) {
    // Basic EVM address validation (0x + 40 hex characters)
    final regex = RegExp(r'^0x[a-fA-F0-9]{40}$');
    return regex.hasMatch(address);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.background,
        title: const Text(
          'Watch Wallet',
          style: TextStyle(color: AppColors.textPrimary),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: AppColors.textPrimary),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(20),
          children: [
            const Text(
              'Add a watch-only wallet to monitor balances without private keys.',
              style: TextStyle(
                color: AppColors.textSecondary,
                fontSize: 14,
              ),
            ),
            const SizedBox(height: 24),
            TextField(
              controller: _nameCtrl,
              style: const TextStyle(color: AppColors.textPrimary),
              decoration: InputDecoration(
                labelText: 'Wallet Name',
                labelStyle: const TextStyle(color: AppColors.textSecondary),
                filled: true,
                fillColor: AppColors.surface,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: const BorderSide(color: AppColors.border),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: const BorderSide(color: AppColors.border),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: const BorderSide(color: AppColors.primary),
                ),
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _addressCtrl,
              maxLines: 2,
              style: const TextStyle(color: AppColors.textPrimary),
              decoration: InputDecoration(
                labelText: 'Ethereum Address',
                hintText: '0x...',
                hintStyle: const TextStyle(color: AppColors.textSecondary),
                labelStyle: const TextStyle(color: AppColors.textSecondary),
                errorText: _addressError,
                filled: true,
                fillColor: AppColors.surface,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: const BorderSide(color: AppColors.border),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: const BorderSide(color: AppColors.border),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: const BorderSide(color: AppColors.primary),
                ),
                errorBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: const BorderSide(color: AppColors.error),
                ),
              ),
              onChanged: (_) {
                if (_addressError != null) {
                  setState(() => _addressError = null);
                }
              },
            ),
            const SizedBox(height: 8),
            const Text(
              'Enter an EVM address (0x...) to watch.',
              style: TextStyle(
                color: AppColors.textSecondary,
                fontSize: 12,
              ),
            ),
            const SizedBox(height: 24),
            FilledButton(
              onPressed: _isSubmitting ? null : _add,
              child: _isSubmitting
                  ? const SizedBox(
                      height: 18,
                      width: 18,
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                        color: Colors.black,
                      ),
                    )
                  : const Text('Add Watch Wallet'),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _add() async {
    final address = _addressCtrl.text.trim();
    final name =
        _nameCtrl.text.trim().isEmpty ? 'Watch Wallet' : _nameCtrl.text.trim();

    // Validate address
    if (address.isEmpty) {
      setState(() => _addressError = 'Please enter an address');
      return;
    }

    if (!_isValidEvmAddress(address)) {
      setState(() => _addressError = 'Invalid EVM address format');
      return;
    }

    setState(() => _isSubmitting = true);

    try {
      final repository = ref.read(walletRepositoryProvider);
      final id = 'w${DateTime.now().millisecondsSinceEpoch}';

      await repository.saveWallet(
        id: id,
        name: name,
        wordCount: 0,
        usePassphrase: false,
        backupRequired: false,
        watchAddress: address,
      );

      ref.read(walletsProvider.notifier).reload();
      ref.read(selectedWalletIdProvider.notifier).state = id;

      // Update wallet session with the watched address
      ref.read(walletSessionProvider.notifier).state = WalletSession(
        isUnlocked: true,
        activeAddress: address,
      );

      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Watch wallet added')),
      );
      Navigator.of(context).pop();
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: ${e.toString()}')),
      );
    } finally {
      if (mounted) setState(() => _isSubmitting = false);
    }
  }
}
