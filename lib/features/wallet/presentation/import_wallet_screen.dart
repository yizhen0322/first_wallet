import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../shared/contracts/app_contracts.dart';
import '../../../shared/theme/app_theme.dart';
import '../../../shared/widgets/pavilion_outlined_card.dart';
import '../state/wallet_secrets.dart';
import '../state/wallet_state.dart';

/// Main import wallet screen showing 3 import options
class ImportWalletScreen extends ConsumerWidget {
  const ImportWalletScreen({super.key});

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
          'Import Wallet',
          style: TextStyle(color: AppColors.textPrimary),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(28),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              _ImportOption(
                icon: Icons.edit_note,
                title: 'From Recovery Phrase',
                subtitle: 'Import using recovery phrase or private key',
                onTap: () => Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (_) => const ImportFromPhraseScreen(),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              _ImportOption(
                icon: Icons.folder_outlined,
                title: 'From File',
                subtitle: 'Import a backup file from your local folder',
                onTap: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                        content: Text('Import from file (coming soon)')),
                  );
                },
              ),
              const SizedBox(height: 16),
              _ImportOption(
                icon: Icons.link,
                title: 'From Exchange Wallet',
                subtitle: 'Connect to a wallet on centralized exchange',
                onTap: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                        content: Text('Exchange wallet (coming soon)')),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _ImportOption extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final VoidCallback onTap;

  const _ImportOption({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: AppColors.surface,
      borderRadius: BorderRadius.circular(12),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Container(
          padding: const EdgeInsets.all(20),
          child: Row(
            children: [
              Icon(icon, color: AppColors.textPrimary, size: 24),
              const SizedBox(width: 16),
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
                    const SizedBox(height: 4),
                    Text(
                      subtitle,
                      style: TextStyle(
                        color: AppColors.textSecondary,
                        fontSize: 13,
                      ),
                    ),
                  ],
                ),
              ),
              const Icon(Icons.chevron_right, color: AppColors.textSecondary),
            ],
          ),
        ),
      ),
    );
  }
}

enum ImportBy {
  recoveryPhrase,
  privateKey,
}

class ImportAdvancedSettings {
  const ImportAdvancedSettings({
    required this.importBy,
    required this.wordList,
    required this.usePassphrase,
  });

  final ImportBy importBy;
  final String wordList;
  final bool usePassphrase;

  String get importByLabel {
    switch (importBy) {
      case ImportBy.recoveryPhrase:
        return 'Recovery Phrase';
      case ImportBy.privateKey:
        return 'Private Key';
    }
  }

  ImportAdvancedSettings copyWith({
    ImportBy? importBy,
    String? wordList,
    bool? usePassphrase,
  }) {
    return ImportAdvancedSettings(
      importBy: importBy ?? this.importBy,
      wordList: wordList ?? this.wordList,
      usePassphrase: usePassphrase ?? this.usePassphrase,
    );
  }
}

/// Detail screen for importing from recovery phrase
class ImportFromPhraseScreen extends ConsumerStatefulWidget {
  const ImportFromPhraseScreen({super.key});

  @override
  ConsumerState<ImportFromPhraseScreen> createState() =>
      _ImportFromPhraseScreenState();
}

class _ImportFromPhraseScreenState
    extends ConsumerState<ImportFromPhraseScreen> {
  final _nameCtrl = TextEditingController(text: 'Wallet 6');
  final _phraseCtrl = TextEditingController();
  ImportAdvancedSettings _advancedSettings = const ImportAdvancedSettings(
    importBy: ImportBy.recoveryPhrase,
    wordList: 'English',
    usePassphrase: false,
  );

  @override
  void dispose() {
    _nameCtrl.dispose();
    _phraseCtrl.dispose();
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
          'Import Wallet',
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
                      const BorderSide(color: AppColors.primary, width: 1),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide:
                      const BorderSide(color: AppColors.primary, width: 1),
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
            const SizedBox(height: 20),

            // Recovery phrase input
            TextField(
              controller: _phraseCtrl,
              maxLines: 4,
              style: const TextStyle(color: AppColors.textPrimary),
              decoration: InputDecoration(
                hintText: 'Enter Recovery Phrase',
                hintStyle: const TextStyle(color: AppColors.textSecondary),
                filled: true,
                fillColor: AppColors.surface,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide.none,
                ),
                suffixIcon: IconButton(
                  icon: const Icon(Icons.qr_code_scanner,
                      color: AppColors.textPrimary),
                  onPressed: _pasteFromClipboard,
                ),
              ),
            ),
            const SizedBox(height: 20),

            // Advanced button
            Container(
              decoration: BoxDecoration(
                color: AppColors.surface,
                borderRadius: BorderRadius.circular(12),
              ),
              child: ListTile(
                leading: const Icon(Icons.settings,
                    color: AppColors.textPrimary, size: 20),
                title: const Text(
                  'Advanced',
                  style: TextStyle(
                    color: AppColors.textPrimary,
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                trailing: const Icon(Icons.chevron_right,
                    color: AppColors.textSecondary),
                onTap: () {
                  _openAdvancedSettings();
                },
              ),
            ),
            const SizedBox(height: 24),

            // Watch/Import button
            FilledButton(
              onPressed: _import,
              style: FilledButton.styleFrom(
                minimumSize: const Size.fromHeight(56),
                backgroundColor: AppColors.primary,
                foregroundColor: Colors.black,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: const Text(
                'Watch',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _openAdvancedSettings() async {
    final result = await Navigator.of(context).push<ImportAdvancedSettings>(
      MaterialPageRoute(
        builder: (_) => ImportAdvancedSettingsScreen(
          nameController: _nameCtrl,
          phraseController: _phraseCtrl,
          initialSettings: _advancedSettings,
        ),
      ),
    );

    if (result != null && mounted) {
      setState(() => _advancedSettings = result);
    }
  }

  Future<void> _pasteFromClipboard() async {
    final data = await Clipboard.getData(Clipboard.kTextPlain);
    if (data?.text != null) {
      _phraseCtrl.text = data!.text!;
    }
  }

  Future<void> _import() async {
    final phrase = _phraseCtrl.text.trim();
    if (phrase.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Enter recovery phrase')),
      );
      return;
    }

    try {
      final engine = ref.read(walletEngineProvider);

      // Verify mnemonic by attempting to derive address
      // This will throw if mnemonic is invalid
      final address = await engine.deriveAddressFromMnemonic(mnemonic: phrase);

      // Update app session (dev/in-memory)
      ref.read(currentMnemonicProvider.notifier).state = phrase;
      ref.read(walletSessionProvider.notifier).state =
          WalletSession(isUnlocked: true, activeAddress: address);

      // Save to repository
      final repository = ref.read(walletRepositoryProvider);
      final id = 'w${DateTime.now().millisecondsSinceEpoch}';

      await repository.saveWallet(
        id: id,
        name: _nameCtrl.text.trim().isEmpty
            ? 'Imported Wallet'
            : _nameCtrl.text.trim(),
        mnemonic: phrase,
        wordCount: phrase.split(' ').length,
        usePassphrase: false, // Import flow simplistic for now
        backupRequired: false,
      );

      // Refresh list
      ref.read(walletsProvider.notifier).reload();
      ref.read(selectedWalletIdProvider.notifier).state = id;

      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Wallet imported successfully: $address')),
      );

      // Pop twice to return to main wallet screen (Import Detail -> Import Menu -> Main)
      Navigator.of(context).popUntil((route) => route.isFirst);
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Invalid recovery phrase: $e')),
      );
    }
  }
}

class ImportAdvancedSettingsScreen extends StatefulWidget {
  const ImportAdvancedSettingsScreen({
    super.key,
    required this.nameController,
    required this.phraseController,
    required this.initialSettings,
  });

  final TextEditingController nameController;
  final TextEditingController phraseController;
  final ImportAdvancedSettings initialSettings;

  @override
  State<ImportAdvancedSettingsScreen> createState() =>
      _ImportAdvancedSettingsScreenState();
}

class _ImportAdvancedSettingsScreenState
    extends State<ImportAdvancedSettingsScreen> {
  late ImportAdvancedSettings _settings = widget.initialSettings;

  void _popWithResult() {
    Navigator.of(context).pop(_settings);
  }

  @override
  Widget build(BuildContext context) {
    return PopScope<ImportAdvancedSettings>(
      canPop: false,
      onPopInvokedWithResult: (didPop, result) {
        if (didPop) return;
        _popWithResult();
      },
      child: Scaffold(
        backgroundColor: AppColors.background,
        appBar: AppBar(
          backgroundColor: AppColors.background,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back, color: AppColors.textPrimary),
            onPressed: _popWithResult,
          ),
          title: const Text(
            'Advanced Settings',
            style: TextStyle(color: AppColors.textPrimary),
          ),
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
                controller: widget.nameController,
                style: const TextStyle(color: AppColors.textPrimary),
                decoration: InputDecoration(
                  hintText: 'Wallet 6',
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
                    borderSide:
                        const BorderSide(color: AppColors.primary, width: 1.5),
                  ),
                  suffixIcon: IconButton(
                    icon: const Icon(Icons.delete_outline,
                        color: AppColors.textPrimary),
                    onPressed: widget.nameController.clear,
                  ),
                ),
              ),
              const SizedBox(height: 20),
              TextField(
                controller: widget.phraseController,
                maxLines: 4,
                style: const TextStyle(color: AppColors.textPrimary),
                decoration: InputDecoration(
                  hintText: 'Enter Recovery Phrase',
                  hintStyle: const TextStyle(color: AppColors.textSecondary),
                  filled: true,
                  fillColor: AppColors.surface,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide.none,
                  ),
                  suffixIcon: IconButton(
                    icon: const Icon(Icons.qr_code_scanner,
                        color: AppColors.textPrimary),
                    onPressed: _pasteFromClipboard,
                  ),
                ),
              ),
              const SizedBox(height: 20),
              PavilionOutlinedCard(
                padding: EdgeInsets.zero,
                borderRadius: 12,
                child: Column(
                  children: [
                    _AdvancedRow(
                      icon: Icons.settings,
                      label: 'Import By',
                      trailing: _ValueChevron(
                        value: _settings.importByLabel,
                      ),
                      onTap: _selectImportBy,
                    ),
                    const Divider(
                      height: 1,
                      thickness: 1,
                      color: AppColors.primary,
                    ),
                    _AdvancedRow(
                      icon: Icons.language,
                      label: 'Word List',
                      trailing: _ValueChevron(value: _settings.wordList),
                      onTap: _selectWordList,
                    ),
                    const Divider(
                      height: 1,
                      thickness: 1,
                      color: AppColors.primary,
                    ),
                    _AdvancedRow(
                      icon: Icons.key,
                      label: 'Passphrase',
                      trailing: Switch(
                        value: _settings.usePassphrase,
                        onChanged: (value) {
                          setState(() {
                            _settings =
                                _settings.copyWith(usePassphrase: value);
                          });
                        },
                        activeColor: AppColors.primary,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              Material(
                color: AppColors.surface,
                borderRadius: BorderRadius.circular(12),
                child: InkWell(
                  borderRadius: BorderRadius.circular(12),
                  onTap: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                          content: Text('Non-standard import (coming soon)')),
                    );
                  },
                  child: Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                    child: Row(
                      children: const [
                        Expanded(
                          child: Text(
                            'Non-Standard Import',
                            style: TextStyle(
                              color: AppColors.textPrimary,
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                        Icon(Icons.chevron_right,
                            color: AppColors.textSecondary),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _pasteFromClipboard() async {
    final data = await Clipboard.getData(Clipboard.kTextPlain);
    if (!mounted || data?.text == null) return;
    widget.phraseController.text = data!.text!;
  }

  Future<void> _selectImportBy() async {
    final result = await showModalBottomSheet<ImportBy>(
      context: context,
      backgroundColor: AppColors.surface,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(18)),
      ),
      builder: (_) => SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            _BottomSheetTile(
              label: 'Recovery Phrase',
              selected: _settings.importBy == ImportBy.recoveryPhrase,
              onTap: () => Navigator.of(context).pop(ImportBy.recoveryPhrase),
            ),
            _BottomSheetTile(
              label: 'Private Key',
              selected: _settings.importBy == ImportBy.privateKey,
              onTap: () => Navigator.of(context).pop(ImportBy.privateKey),
            ),
            const SizedBox(height: 6),
          ],
        ),
      ),
    );

    if (result != null) {
      setState(() => _settings = _settings.copyWith(importBy: result));
    }
  }

  Future<void> _selectWordList() async {
    final result = await showModalBottomSheet<String>(
      context: context,
      backgroundColor: AppColors.surface,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(18)),
      ),
      builder: (_) => SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            _BottomSheetTile(
              label: 'English',
              selected: _settings.wordList == 'English',
              onTap: () => Navigator.of(context).pop('English'),
            ),
            const SizedBox(height: 6),
          ],
        ),
      ),
    );

    if (result != null) {
      setState(() => _settings = _settings.copyWith(wordList: result));
    }
  }
}

class _AdvancedRow extends StatelessWidget {
  const _AdvancedRow({
    required this.icon,
    required this.label,
    required this.trailing,
    this.onTap,
  });

  final IconData icon;
  final String label;
  final Widget trailing;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final content = Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Row(
        children: [
          Icon(icon, color: AppColors.textPrimary, size: 20),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              label,
              style: const TextStyle(
                color: AppColors.textPrimary,
                fontSize: 14,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          trailing,
        ],
      ),
    );

    if (onTap == null) return content;
    return InkWell(
      onTap: onTap,
      child: content,
    );
  }
}

class _ValueChevron extends StatelessWidget {
  const _ValueChevron({required this.value});

  final String value;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          value,
          style: const TextStyle(
            color: AppColors.textPrimary,
            fontSize: 13,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(width: 4),
        const Icon(Icons.keyboard_arrow_down, color: AppColors.textPrimary),
      ],
    );
  }
}

class _BottomSheetTile extends StatelessWidget {
  const _BottomSheetTile({
    required this.label,
    required this.selected,
    required this.onTap,
  });

  final String label;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onTap,
      title: Text(
        label,
        style: const TextStyle(color: AppColors.textPrimary),
      ),
      trailing: selected
          ? const Icon(Icons.check, color: AppColors.primary)
          : null,
    );
  }
}
