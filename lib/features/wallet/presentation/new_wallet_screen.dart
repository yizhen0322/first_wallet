import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../shared/contracts/app_contracts.dart';
import '../../../shared/theme/app_theme.dart';
import '../state/wallet_secrets.dart';
import '../state/wallet_state.dart';

class NewWalletScreen extends ConsumerStatefulWidget {
  const NewWalletScreen({super.key});

  @override
  ConsumerState<NewWalletScreen> createState() => _NewWalletScreenState();
}

class _NewWalletScreenState extends ConsumerState<NewWalletScreen> {
  final _nameCtrl = TextEditingController(text: 'Wallet 6');
  final _passwordCtrl = TextEditingController();
  final _confirmCtrl = TextEditingController();

  bool _usePassphrase = false;
  int _wordCount = 12;
  bool _obscurePassword = true;
  bool _obscureConfirm = true;

  @override
  void dispose() {
    _nameCtrl.dispose();
    _passwordCtrl.dispose();
    _confirmCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.background,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: AppColors.textPrimary),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: const Text(
          'New Wallet',
          style: TextStyle(color: AppColors.textPrimary),
        ),
      ),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(28),
          children: [
            // Name input
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
                hintText: 'Wallet 6',
                hintStyle: const TextStyle(color: AppColors.textSecondary),
                filled: true,
                fillColor: AppColors.background,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide:
                      const BorderSide(color: AppColors.textPrimary, width: 1),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide:
                      const BorderSide(color: AppColors.textPrimary, width: 1),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide:
                      const BorderSide(color: AppColors.primary, width: 1.5),
                ),
                suffixIcon: IconButton(
                  icon: const Icon(Icons.delete_outline,
                      color: AppColors.textPrimary),
                  onPressed: () => _nameCtrl.clear(),
                ),
              ),
            ),
            const SizedBox(height: 24),

            // Create button
            FilledButton(
              onPressed: _createWallet,
              style: FilledButton.styleFrom(
                minimumSize: const Size.fromHeight(56),
                backgroundColor: AppColors.primary,
                foregroundColor: Colors.black,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: const Text(
                'Create New Wallet',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
            const SizedBox(height: 32),

            // Advanced Settings
            const Text(
              'Advanced Settings',
              style: TextStyle(
                color: AppColors.textPrimary,
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 16),

            // Recovery Phrase dropdown
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              decoration: BoxDecoration(
                color: AppColors.surface,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: AppColors.primary, width: 1),
              ),
              child: Row(
                children: [
                  const Icon(Icons.key, color: AppColors.textPrimary, size: 20),
                  const SizedBox(width: 12),
                  const Expanded(
                    child: Text(
                      'Recovery Phrase',
                      style: TextStyle(
                        color: AppColors.textPrimary,
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  DropdownButton<int>(
                    value: _wordCount,
                    dropdownColor: AppColors.surface,
                    underline: const SizedBox(),
                    style: const TextStyle(color: AppColors.textPrimary),
                    items: const [
                      DropdownMenuItem(value: 12, child: Text('12 words')),
                      DropdownMenuItem(value: 24, child: Text('24 words')),
                    ],
                    onChanged: (value) {
                      if (value != null) {
                        setState(() => _wordCount = value);
                      }
                    },
                  ),
                  const Icon(Icons.keyboard_arrow_down,
                      color: AppColors.textPrimary),
                ],
              ),
            ),
            const SizedBox(height: 12),

            // Passphrase toggle
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              decoration: BoxDecoration(
                color: AppColors.surface,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: AppColors.primary, width: 1),
              ),
              child: Row(
                children: [
                  const Icon(Icons.key, color: AppColors.textPrimary, size: 20),
                  const SizedBox(width: 12),
                  const Expanded(
                    child: Text(
                      'Passphrase',
                      style: TextStyle(
                        color: AppColors.textPrimary,
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  Switch(
                    value: _usePassphrase,
                    onChanged: (value) =>
                        setState(() => _usePassphrase = value),
                    activeColor: AppColors.primary,
                  ),
                ],
              ),
            ),

            if (_usePassphrase) ...[
              const SizedBox(height: 12),
              // Password field
              TextField(
                controller: _passwordCtrl,
                obscureText: _obscurePassword,
                style: const TextStyle(color: AppColors.textPrimary),
                decoration: InputDecoration(
                  hintText: 'Password',
                  hintStyle: const TextStyle(color: AppColors.textSecondary),
                  filled: true,
                  fillColor: AppColors.surface,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide.none,
                  ),
                  suffixIcon: IconButton(
                    icon: Icon(
                      _obscurePassword
                          ? Icons.visibility_off
                          : Icons.visibility,
                      color: AppColors.textSecondary,
                    ),
                    onPressed: () =>
                        setState(() => _obscurePassword = !_obscurePassword),
                  ),
                ),
              ),
              const SizedBox(height: 12),
              // Confirm field
              TextField(
                controller: _confirmCtrl,
                obscureText: _obscureConfirm,
                style: const TextStyle(color: AppColors.textPrimary),
                decoration: InputDecoration(
                  hintText: 'Confirm',
                  hintStyle: const TextStyle(color: AppColors.textSecondary),
                  filled: true,
                  fillColor: AppColors.surface,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide.none,
                  ),
                  suffixIcon: IconButton(
                    icon: Icon(
                      _obscureConfirm ? Icons.visibility_off : Icons.visibility,
                      color: AppColors.textSecondary,
                    ),
                    onPressed: () =>
                        setState(() => _obscureConfirm = !_obscureConfirm),
                  ),
                ),
              ),
              const SizedBox(height: 12),
              // Helper text
              Text(
                'Passphrases add additional security layer for wallets. To restore such wallet a user required both a recovery phrase as well as a passphrase',
                style: TextStyle(
                  color: AppColors.textSecondary,
                  fontSize: 12,
                  height: 1.4,
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }

  Future<void> _createWallet() async {
    if (_usePassphrase) {
      if (_passwordCtrl.text != _confirmCtrl.text) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Passwords do not match')),
        );
        return;
      }
    }

    final engine = ref.read(walletEngineProvider);
    final mnemonic = await engine.createMnemonic(words: _wordCount);
    final address = await engine.deriveAddressFromMnemonic(mnemonic: mnemonic);

    // Update app session (dev/in-memory).
    ref.read(currentMnemonicProvider.notifier).state = mnemonic;
    ref.read(walletSessionProvider.notifier).state =
        WalletSession(isUnlocked: true, activeAddress: address);

    // Save to repository
    final repository = ref.read(walletRepositoryProvider);
    final id =
        'w${DateTime.now().millisecondsSinceEpoch}'; // Simple ID generation

    await repository.saveWallet(
      id: id,
      name: _nameCtrl.text.trim().isEmpty
          ? 'Wallet' // Default name
          : _nameCtrl.text.trim(),
      mnemonic: mnemonic,
      wordCount: _wordCount,
      usePassphrase: _usePassphrase,
    );

    // Refresh list
    ref.read(walletsProvider.notifier).reload();
    ref.read(selectedWalletIdProvider.notifier).state = id;

    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Created wallet: $address')),
    );
    Navigator.of(context).pop();
  }
}
