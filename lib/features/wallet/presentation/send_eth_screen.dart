import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:web3dart/web3dart.dart';

import '../../../shared/theme/app_theme.dart';
import '../../../shared/utils/eth_format.dart';
import '../data/address_book_repository.dart';
import '../state/evm_balance.dart';
import 'address_book_screen.dart';
import 'qr_scanner_screen.dart';
import 'send_eth_confirm_screen.dart';

class SendEthScreen extends ConsumerStatefulWidget {
  const SendEthScreen({super.key});

  @override
  ConsumerState<SendEthScreen> createState() => _SendEthScreenState();
}

class _SendEthScreenState extends ConsumerState<SendEthScreen> {
  final _amountCtrl = TextEditingController();
  final _toCtrl = TextEditingController();

  @override
  void dispose() {
    _amountCtrl.dispose();
    _toCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final balanceAsync = ref.watch(evmNativeBalanceWeiProvider);

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.background,
        title: const Text(
          'Send ETH',
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
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 18),
              decoration: BoxDecoration(
                color: AppColors.surface,
                borderRadius: BorderRadius.circular(14),
              ),
              child: balanceAsync.when(
                loading: () => const Center(
                  child: SizedBox(
                    height: 18,
                    width: 18,
                    child: CircularProgressIndicator(strokeWidth: 2),
                  ),
                ),
                error: (e, _) => Column(
                  children: [
                    const Text(
                      '—',
                      style: TextStyle(
                        color: AppColors.textPrimary,
                        fontSize: 20,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      e.toString(),
                      style: const TextStyle(
                        color: AppColors.textSecondary,
                        fontSize: 12,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
                data: (wei) => Column(
                  children: [
                    Text(
                      '${formatWeiToEth(wei, maxFractionDigits: 6)} ETH',
                      style: const TextStyle(
                        color: AppColors.textPrimary,
                        fontSize: 20,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                    const SizedBox(height: 4),
                    const Text(
                      'Available Balance',
                      style: TextStyle(
                        color: AppColors.textSecondary,
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 18),
            _AmountBox(
              controller: _amountCtrl,
              onClear: _amountCtrl.clear,
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _toCtrl,
              style: const TextStyle(color: AppColors.textPrimary),
              decoration: InputDecoration(
                hintText: 'Address or Domain',
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
                      icon: const Icon(
                        Icons.qr_code_scanner_outlined,
                        color: AppColors.textSecondary,
                      ),
                      onPressed: _scanQr,
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

  Future<void> _scanQr() async {
    final scanned = await Navigator.of(context).push<String>(
      MaterialPageRoute(builder: (_) => const QrScannerScreen()),
    );
    if (!mounted || scanned == null) return;
    _toCtrl.text = scanned;
  }

  Future<void> _onNext() async {
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

    BigInt valueWei;
    try {
      valueWei = parseEthToWei(amountInput);
      if (valueWei <= BigInt.zero) {
        throw const FormatException('Amount must be greater than 0');
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Invalid amount: $e')),
      );
      return;
    }

    try {
      EthereumAddress.fromHex(to);
    } catch (_) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Invalid recipient address')),
      );
      return;
    }

    final balance = await ref.read(evmNativeBalanceWeiProvider.future);
    if (valueWei > balance) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Insufficient balance')),
      );
      return;
    }

    if (!mounted) return;
    await Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => SendEthConfirmScreen(to: to, valueWei: valueWei),
      ),
    );
  }
}

class _AmountBox extends StatelessWidget {
  const _AmountBox({required this.controller, required this.onClear});

  final TextEditingController controller;
  final VoidCallback onClear;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      decoration: BoxDecoration(
        color: AppColors.background,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: AppColors.primary, width: 1),
      ),
      child: Stack(
        alignment: Alignment.center,
        children: [
          Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: controller,
                      keyboardType:
                          const TextInputType.numberWithOptions(decimal: true),
                      style: const TextStyle(
                        color: AppColors.textPrimary,
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                      ),
                      decoration: const InputDecoration(
                        isDense: true,
                        border: InputBorder.none,
                        hintText: '0',
                        hintStyle: TextStyle(color: AppColors.textSecondary),
                      ),
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.delete_outline,
                        color: AppColors.textPrimary),
                    onPressed: onClear,
                  ),
                ],
              ),
              const Divider(
                height: 1,
                thickness: 1,
                color: AppColors.primary,
              ),
              const SizedBox(height: 10),
              const Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  '\$0.00',
                  style: TextStyle(
                    color: AppColors.textPrimary,
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ],
          ),
          const IgnorePointer(
            child: Icon(Icons.swap_vert, color: AppColors.primary),
          ),
        ],
      ),
    );
  }
}
