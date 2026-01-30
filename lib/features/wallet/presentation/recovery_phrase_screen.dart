import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../shared/theme/app_theme.dart';
import '../../../shared/utils/local_auth_gate.dart';
import '../../../shared/widgets/risk_of_copy_dialog.dart';
import '../../../shared/widgets/security_warning_banner.dart';
import '../state/wallet_secrets.dart';
import '../state/wallet_state.dart';

class RecoveryPhraseScreen extends ConsumerStatefulWidget {
  const RecoveryPhraseScreen({super.key});

  @override
  ConsumerState<RecoveryPhraseScreen> createState() =>
      _RecoveryPhraseScreenState();
}

class _RecoveryPhraseScreenState extends ConsumerState<RecoveryPhraseScreen> {
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
      reason: 'Authenticate to view your recovery phrase',
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
    final walletsAsync = ref.watch(walletsProvider);
    final selectedId = ref.watch(selectedWalletIdProvider);

    if (!_rehydrating) {
      Future.microtask(_tryRehydrateIfNeeded);
    }

    final bool passphraseEnabled = walletsAsync.maybeWhen(
      data: (wallets) {
        if (wallets.isEmpty) return false;
        final selected = wallets.firstWhere(
          (w) => w.id == selectedId,
          orElse: () => wallets.first,
        );
        return selected.backupLabel.toLowerCase().contains('passphrase');
      },
      orElse: () => false,
    );

    final words = (mnemonic ?? '')
        .trim()
        .split(RegExp(r'\s+'))
        .where((w) => w.isNotEmpty)
        .toList(growable: false);

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.background,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: AppColors.textPrimary),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: const Text(
          'Recovery Phrase',
          style: TextStyle(color: AppColors.textPrimary),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: mnemonic == null || words.isEmpty
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
                : Padding(
                padding: const EdgeInsets.all(28),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Expanded(
                      child: SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            const SecurityWarningBanner(
                              text:
                                  'Never share this key with anyone.\nPavilion support team will never ask for it',
                            ),
                            const SizedBox(height: 18),
                            GridView.builder(
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              itemCount: words.length,
                              gridDelegate:
                                  const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 4,
                                mainAxisSpacing: 10,
                                crossAxisSpacing: 10,
                                childAspectRatio: 2.2,
                              ),
                              itemBuilder: (context, index) {
                                final word = words[index];
                                return Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10, vertical: 8),
                                  decoration: BoxDecoration(
                                    color: AppColors.surface,
                                    borderRadius: BorderRadius.circular(6),
                                  ),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        '${index + 1}',
                                        style: const TextStyle(
                                          color: AppColors.textSecondary,
                                          fontSize: 12,
                                          fontWeight: FontWeight.w700,
                                        ),
                                      ),
                                      const SizedBox(width: 6),
                                      Flexible(
                                        child: Text(
                                          word,
                                          overflow: TextOverflow.ellipsis,
                                          style: const TextStyle(
                                            color: AppColors.textPrimary,
                                            fontSize: 12,
                                            fontWeight: FontWeight.w700,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              },
                            ),
                            const SizedBox(height: 18),
                            Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 16, vertical: 14),
                              decoration: BoxDecoration(
                                color: AppColors.background,
                                borderRadius: BorderRadius.circular(14),
                                border: Border.all(
                                    color: AppColors.primary, width: 1),
                              ),
                              child: Row(
                                children: [
                                  const Icon(Icons.key,
                                      color: AppColors.textPrimary, size: 20),
                                  const SizedBox(width: 12),
                                  const Expanded(
                                    child: Text(
                                      'Passphrase',
                                      style: TextStyle(
                                        color: AppColors.textPrimary,
                                        fontSize: 14,
                                        fontWeight: FontWeight.w700,
                                      ),
                                    ),
                                  ),
                                  Text(
                                    passphraseEnabled ? 'Enabled' : 'Not set',
                                    style: const TextStyle(
                                      color: AppColors.textPrimary,
                                      fontSize: 14,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 18),
                    FilledButton(
                      onPressed: () => _copyRecoveryPhrase(context, mnemonic),
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
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
      ),
    );
  }

  Future<void> _copyRecoveryPhrase(BuildContext context, String text) async {
    final ok = await showRiskOfCopyDialog(context);
    if (ok != true) return;

    await Clipboard.setData(ClipboardData(text: text));
    if (!context.mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Recovery phrase copied to clipboard'),
        duration: Duration(seconds: 2),
      ),
    );
  }
}
