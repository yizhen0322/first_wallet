import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../shared/contracts/app_contracts.dart';
import '../../../shared/theme/app_theme.dart';
import '../../../shared/utils/local_auth_gate.dart';
import '../../../shared/widgets/risk_of_copy_dialog.dart';
import '../../../shared/widgets/security_warning_banner.dart';
import '../state/wallet_secrets.dart';
import '../state/wallet_state.dart';

/// Screen displaying BIP32 root key with copy functionality
class Bip32RootKeyScreen extends ConsumerStatefulWidget {
  const Bip32RootKeyScreen({super.key});

  @override
  ConsumerState<Bip32RootKeyScreen> createState() =>
      _Bip32RootKeyScreenState();
}

class _Bip32RootKeyScreenState extends ConsumerState<Bip32RootKeyScreen> {
  bool _rehydrating = false;
  String? _rehydrateAttemptForId;
  bool _unlocked = false;

  @override
  void initState() {
    super.initState();
    Future.microtask(_tryRehydrateIfNeeded);
    Future.microtask(() async {
      final available = await LocalAuthGate.isAvailable();
      if (!mounted) return;
      if (!available) setState(() => _unlocked = true);
    });
  }

  Future<void> _unlock() async {
    final ok = await LocalAuthGate.authenticate(
      reason: 'Authenticate to view your root key',
    );
    if (!mounted) return;
    if (!ok) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Authentication cancelled')),
      );
      return;
    }
    setState(() => _unlocked = true);
  }

  Future<void> _tryRehydrateIfNeeded() async {
    final selectedId = ref.read(selectedWalletIdProvider);
    final existing = ref.read(currentMnemonicProvider);

    if (selectedId == null) return;
    if (existing != null && existing.trim().isNotEmpty) return;
    if (_rehydrateAttemptForId == selectedId) return;

    _rehydrateAttemptForId = selectedId;
    if (mounted) setState(() => _rehydrating = true);
    try {
      await ref.read(walletsProvider.notifier).selectWallet(selectedId);
    } finally {
      if (mounted) setState(() => _rehydrating = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final mnemonic = ref.watch(currentMnemonicProvider);
    ref.watch(selectedWalletIdProvider);
    final engine = ref.watch(walletEngineProvider);

    if (!_rehydrating) {
      Future.microtask(_tryRehydrateIfNeeded);
    }

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.background,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: AppColors.textPrimary),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: const Text(
          'BIP32 Root Key',
          style: TextStyle(color: AppColors.textPrimary),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.keyboard_arrow_down,
                color: AppColors.textPrimary),
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                    content: Text('Additional options (coming soon)')),
              );
            },
          ),
        ],
      ),
      body: SafeArea(
        child: (mnemonic == null || mnemonic.trim().isEmpty)
            ? Center(
                child: _rehydrating
                    ? const CircularProgressIndicator()
                    : const Text(
                        'No active wallet session',
                        style: TextStyle(color: AppColors.textPrimary),
                      ),
              )
            : !_unlocked
                ? Padding(
                    padding: const EdgeInsets.all(28),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        const SecurityWarningBanner(
                          text:
                              'Never share this key with anyone.\nPavilion support team will never ask for it',
                        ),
                        const SizedBox(height: 18),
                        const Text(
                          'This is sensitive information.',
                          style: TextStyle(
                            color: AppColors.textSecondary,
                            fontSize: 13,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 18),
                        FilledButton(
                          onPressed: _unlock,
                          style: FilledButton.styleFrom(
                            minimumSize: const Size.fromHeight(56),
                            backgroundColor: AppColors.primary,
                            foregroundColor: Colors.black,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                          child: const Text(
                            'Unlock to view',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w800,
                            ),
                          ),
                        ),
                      ],
                    ),
                  )
                : FutureBuilder<String>(
                future: engine.getExtendedPrivateKey(mnemonic: mnemonic),
                builder: (context, snapshot) {
                  if (snapshot.hasError) {
                    return Center(
                        child: Text('Error: ${snapshot.error}',
                            style:
                                const TextStyle(color: AppColors.textPrimary)));
                  }
                  if (!snapshot.hasData) {
                    return const Center(child: CircularProgressIndicator());
                  }

                  final rootKey = snapshot.data!;
                  return Padding(
                    padding: const EdgeInsets.all(28),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        // Warning banner
                        const SecurityWarningBanner(
                          text:
                              'Never share this key with anyone.\nPavilion support team will never ask for it',
                        ),
                        const SizedBox(height: 24),

                        // Root key display
                        Container(
                          padding: const EdgeInsets.all(20),
                          decoration: BoxDecoration(
                            color: AppColors.surface,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: SelectableText(
                            rootKey,
                            style: const TextStyle(
                              color: AppColors.textPrimary,
                              fontSize: 14,
                              fontFamily: 'monospace',
                              height: 1.5,
                            ),
                          ),
                        ),

                        const Spacer(),

                        // Copy button
                        FilledButton(
                          onPressed: () => _copyToClipboard(context, rootKey),
                          style: FilledButton.styleFrom(
                            minimumSize: const Size.fromHeight(56),
                            backgroundColor: AppColors.primary,
                            foregroundColor: Colors.black,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                          child: const Text(
                            'Copy',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
      ),
    );
  }

  Future<void> _copyToClipboard(BuildContext context, String text) async {
    final ok = await showRiskOfCopyDialog(context);
    if (ok != true) return;

    await Clipboard.setData(ClipboardData(text: text));
    if (!context.mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Root key copied to clipboard'),
        duration: Duration(seconds: 2),
      ),
    );
  }
}
