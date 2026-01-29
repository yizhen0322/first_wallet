import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:web3dart/web3dart.dart';

import '../../../shared/theme/app_theme.dart';
import '../../activity/data/token_balance_provider.dart';
import '../data/address_book_repository.dart';
import 'address_book_screen.dart';
import 'send_token_confirm_screen.dart';

class SendTokenScreen extends ConsumerStatefulWidget {
  const SendTokenScreen({super.key, this.preselectedToken});

  /// Optional pre-selected token from Activity screen.
  final TokenBalance? preselectedToken;

  @override
  ConsumerState<SendTokenScreen> createState() => _SendTokenScreenState();
}

class _SendTokenScreenState extends ConsumerState<SendTokenScreen> {
  final _amountCtrl = TextEditingController();
  final _toCtrl = TextEditingController();
  TokenBalance? _selectedToken;

  @override
  void initState() {
    super.initState();
    _selectedToken = widget.preselectedToken;
  }

  @override
  void dispose() {
    _amountCtrl.dispose();
    _toCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final tokensAsync = ref.watch(tokenBalanceProvider);

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.background,
        title: const Text(
          'Send Token',
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
            // Token selector
            _TokenSelector(
              tokens: tokensAsync.valueOrNull ?? [],
              selected: _selectedToken,
              onSelect: (token) => setState(() => _selectedToken = token),
            ),
            const SizedBox(height: 16),
            // Balance display
            if (_selectedToken != null)
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                decoration: BoxDecoration(
                  color: AppColors.surface,
                  borderRadius: BorderRadius.circular(14),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Available',
                      style: TextStyle(
                        color: AppColors.textSecondary,
                        fontSize: 14,
                      ),
                    ),
                    Text(
                      '${_selectedToken!.formattedBalance} ${_selectedToken!.symbol}',
                      style: const TextStyle(
                        color: AppColors.textPrimary,
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
                ),
              ),
            const SizedBox(height: 16),
            // Amount input
            TextField(
              controller: _amountCtrl,
              keyboardType:
                  const TextInputType.numberWithOptions(decimal: true),
              style: const TextStyle(color: AppColors.textPrimary),
              decoration: InputDecoration(
                hintText: 'Amount',
                hintStyle: const TextStyle(color: AppColors.textSecondary),
                filled: true,
                fillColor: AppColors.surface,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide.none,
                ),
                suffixIcon: _selectedToken != null
                    ? TextButton(
                        onPressed: _setMax,
                        child: const Text(
                          'MAX',
                          style: TextStyle(
                            color: AppColors.primary,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      )
                    : null,
              ),
            ),
            const SizedBox(height: 16),
            // Recipient input
            TextField(
              controller: _toCtrl,
              style: const TextStyle(color: AppColors.textPrimary),
              decoration: InputDecoration(
                hintText: 'Recipient Address',
                hintStyle: const TextStyle(color: AppColors.textSecondary),
                filled: true,
                fillColor: AppColors.surface,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide.none,
                ),
                suffixIcon: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                      icon: const Icon(Icons.contacts,
                          color: AppColors.textPrimary),
                      onPressed: _selectFromAddressBook,
                    ),
                    IconButton(
                      icon: const Icon(Icons.content_paste,
                          color: AppColors.textSecondary),
                      onPressed: _pasteFromClipboard,
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 24),
            // Next button
            SizedBox(
              height: 56,
              child: FilledButton(
                onPressed: _onNext,
                style: FilledButton.styleFrom(
                  backgroundColor: AppColors.primary,
                  foregroundColor: Colors.black,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: const Text(
                  'Next',
                  style: TextStyle(fontWeight: FontWeight.w800),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _setMax() {
    if (_selectedToken == null) return;
    _amountCtrl.text = _selectedToken!.formattedBalance;
  }

  Future<void> _selectFromAddressBook() async {
    final contact = await Navigator.of(context).push<Contact>(
      MaterialPageRoute(
        builder: (_) => const AddressBookScreen(selectMode: true),
      ),
    );
    if (!mounted || contact == null) return;
    _toCtrl.text = contact.address;
  }

  Future<void> _pasteFromClipboard() async {
    final data = await Clipboard.getData(Clipboard.kTextPlain);
    if (!mounted || data?.text == null) return;
    _toCtrl.text = data!.text!.trim();
  }

  Future<void> _onNext() async {
    if (_selectedToken == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Select a token')),
      );
      return;
    }

    final amountInput = _amountCtrl.text.trim();
    final to = _toCtrl.text.trim();

    if (amountInput.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Enter amount')),
      );
      return;
    }

    if (to.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Enter recipient address')),
      );
      return;
    }

    // Validate address
    try {
      EthereumAddress.fromHex(to);
    } catch (_) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Invalid recipient address')),
      );
      return;
    }

    // Parse amount
    BigInt amountRaw;
    try {
      amountRaw = _parseTokenAmount(amountInput, _selectedToken!.decimals);
      if (amountRaw <= BigInt.zero) {
        throw const FormatException('Amount must be greater than 0');
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Invalid amount: $e')),
      );
      return;
    }

    // Check balance
    final balanceRaw = BigInt.tryParse(_selectedToken!.balance) ?? BigInt.zero;
    if (amountRaw > balanceRaw) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Insufficient token balance')),
      );
      return;
    }

    if (!mounted) return;
    await Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => SendTokenConfirmScreen(
          token: _selectedToken!,
          to: to,
          amountRaw: amountRaw,
        ),
      ),
    );
  }

  BigInt _parseTokenAmount(String input, int decimals) {
    final parts = input.split('.');
    final wholePart = parts[0].isEmpty ? '0' : parts[0];
    String fractionalPart = parts.length > 1 ? parts[1] : '';

    // Pad or truncate fractional part to match decimals
    if (fractionalPart.length > decimals) {
      fractionalPart = fractionalPart.substring(0, decimals);
    } else {
      fractionalPart = fractionalPart.padRight(decimals, '0');
    }

    final combined = '$wholePart$fractionalPart';
    return BigInt.parse(combined);
  }
}

class _TokenSelector extends StatelessWidget {
  const _TokenSelector({
    required this.tokens,
    required this.selected,
    required this.onSelect,
  });

  final List<TokenBalance> tokens;
  final TokenBalance? selected;
  final ValueChanged<TokenBalance> onSelect;

  @override
  Widget build(BuildContext context) {
    if (tokens.isEmpty) {
      return Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: AppColors.surface,
          borderRadius: BorderRadius.circular(14),
        ),
        child: const Text(
          'No tokens found. Transfer some tokens to your wallet first.',
          style: TextStyle(color: AppColors.textSecondary, fontSize: 14),
          textAlign: TextAlign.center,
        ),
      );
    }

    return GestureDetector(
      onTap: () => _showTokenPicker(context),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        decoration: BoxDecoration(
          color: AppColors.surface,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(color: AppColors.border),
        ),
        child: Row(
          children: [
            // Token icon
            Container(
              width: 36,
              height: 36,
              decoration: BoxDecoration(
                color: AppColors.primary.withValues(alpha: 51),
                borderRadius: BorderRadius.circular(18),
              ),
              child: Center(
                child: Text(
                  selected != null ? selected!.symbol[0].toUpperCase() : '?',
                  style: const TextStyle(
                    color: AppColors.primary,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                selected?.symbol ?? 'Select Token',
                style: TextStyle(
                  color: selected != null
                      ? AppColors.textPrimary
                      : AppColors.textSecondary,
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            const Icon(
              Icons.keyboard_arrow_down,
              color: AppColors.textSecondary,
            ),
          ],
        ),
      ),
    );
  }

  void _showTokenPicker(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: AppColors.surface,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (ctx) => SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Padding(
              padding: EdgeInsets.all(16),
              child: Text(
                'Select Token',
                style: TextStyle(
                  color: AppColors.textPrimary,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const Divider(color: AppColors.border, height: 1),
            ConstrainedBox(
              constraints: BoxConstraints(
                maxHeight: MediaQuery.of(ctx).size.height * 0.4,
              ),
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: tokens.length,
                itemBuilder: (_, index) {
                  final token = tokens[index];
                  final isSelected =
                      selected?.contractAddress == token.contractAddress;
                  return ListTile(
                    leading: Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                        color: AppColors.primary.withValues(alpha: 51),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Center(
                        child: Text(
                          token.symbol[0].toUpperCase(),
                          style: const TextStyle(
                            color: AppColors.primary,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                    title: Text(
                      token.symbol,
                      style: const TextStyle(
                        color: AppColors.textPrimary,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    subtitle: Text(
                      token.formattedBalance,
                      style: const TextStyle(color: AppColors.textSecondary),
                    ),
                    trailing: isSelected
                        ? const Icon(Icons.check, color: AppColors.primary)
                        : null,
                    onTap: () {
                      onSelect(token);
                      Navigator.of(ctx).pop();
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
