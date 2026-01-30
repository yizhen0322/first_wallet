import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../shared/contracts/app_contracts.dart';
import '../../../shared/theme/app_theme.dart';
import '../data/market_data_provider.dart';
import '../state/wallet_secrets.dart';
import 'send_eth_screen.dart';
import 'send_token_screen.dart';
import '../../shared/currency/currency_provider.dart';

class SendAssetScreen extends ConsumerStatefulWidget {
  const SendAssetScreen({super.key});

  @override
  ConsumerState<SendAssetScreen> createState() => _SendAssetScreenState();
}

class _SendAssetScreenState extends ConsumerState<SendAssetScreen> {
  final _searchCtrl = TextEditingController();
  String _searchQuery = '';

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(_lifecycleObserver);
  }

  final _lifecycleObserver = _SimpleLifecycleObserver();

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(_lifecycleObserver);
    _searchCtrl.dispose();
    super.dispose();
  }

  Color _getAssetColor(String symbol) {
    switch (symbol.toUpperCase()) {
      case 'BTC':
        return const Color(0xFFF7931A);
      case 'ETH':
        return const Color(0xFF627EEA);
      case 'DCR':
        return const Color(0xFF2ED8A7);
      case 'NAV':
        return const Color(0xFF7D59B5);
      case 'EMC':
        return const Color(0xFFB8B8B8);
      default:
        return AppColors.primary;
    }
  }

  @override
  Widget build(BuildContext context) {
    final assetsAsync = ref.watch(marketDataProvider);
    final mnemonic = ref.watch(currentMnemonicProvider);
    final session = ref.watch(walletSessionProvider);
    final currency = ref.watch(currencyProvider);
    final canSign =
        (mnemonic != null && mnemonic.trim().isNotEmpty) && session.isUnlocked;

    _lifecycleObserver.onResumed = () {
      if (!mounted) return;
      ref.invalidate(marketDataProvider);
    };

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.background,
        title: const Text(
          'Send',
          style: TextStyle(color: AppColors.textPrimary),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: AppColors.textPrimary),
          onPressed: () => Navigator.of(context).pop(),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.search, color: AppColors.textPrimary),
            onPressed: _showSearchDialog,
          ),
        ],
      ),
      body: SafeArea(
        child: Column(
          children: [
            if (!canSign)
              Container(
                margin: const EdgeInsets.fromLTRB(20, 12, 20, 0),
                padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                decoration: BoxDecoration(
                  color: AppColors.surface,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: AppColors.border, width: 0.5),
                ),
                child: const Text(
                  'Watch-only wallet: sending is disabled.',
                  style: TextStyle(color: AppColors.textSecondary),
                  textAlign: TextAlign.center,
                ),
              ),
            if (_searchQuery.isNotEmpty)
              Container(
                margin: const EdgeInsets.fromLTRB(20, 8, 20, 0),
                padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                decoration: BoxDecoration(
                  color: AppColors.surface,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: Text(
                        'Searching: "$_searchQuery"',
                        style: const TextStyle(color: AppColors.textSecondary),
                      ),
                    ),
                    IconButton(
                      icon: const Icon(Icons.close, size: 18),
                      onPressed: () => setState(() => _searchQuery = ''),
                      padding: EdgeInsets.zero,
                      constraints: const BoxConstraints(),
                    ),
                  ],
                ),
              ),
            Expanded(
              child: assetsAsync.when(
                loading: () => const Center(child: CircularProgressIndicator()),
                error: (e, _) => Center(
                  child: Text(
                    'Failed to load assets',
                    style: TextStyle(color: AppColors.textSecondary),
                  ),
                ),
                data: (assets) {
                  final filtered = _searchQuery.isEmpty
                      ? assets
                      : assets
                          .where((a) =>
                              a.symbol
                                  .toLowerCase()
                                  .contains(_searchQuery.toLowerCase()) ||
                              a.name
                                  .toLowerCase()
                                  .contains(_searchQuery.toLowerCase()))
                          .toList();

                  if (filtered.isEmpty) {
                    return Center(
                      child: Text(
                        'No assets found',
                        style: TextStyle(color: AppColors.textSecondary),
                      ),
                    );
                  }

                  return RefreshIndicator(
                    color: AppColors.primary,
                    backgroundColor: AppColors.surface,
                    onRefresh: () async {
                      ref.invalidate(marketDataProvider);
                      await ref.read(marketDataProvider.future);
                    },
                    child: ListView(
                      padding: const EdgeInsets.all(20),
                      children: [
                        // Send ERC-20 Tokens entry
                        Container(
                          margin: const EdgeInsets.only(bottom: 16),
                          decoration: BoxDecoration(
                            color: AppColors.surface,
                            borderRadius: BorderRadius.circular(14),
                            border:
                                Border.all(color: AppColors.primary, width: 1),
                          ),
                          child: ListTile(
                            leading: Container(
                              width: 40,
                              height: 40,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: AppColors.primary.withValues(alpha: 51),
                              ),
                              child: const Icon(
                                Icons.token,
                                color: AppColors.primary,
                                size: 22,
                              ),
                            ),
                            title: const Text(
                              'Send ERC-20 Tokens',
                              style: TextStyle(
                                color: AppColors.textPrimary,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            subtitle: const Text(
                              'Transfer your tokens',
                              style: TextStyle(color: AppColors.textSecondary),
                            ),
                            trailing: const Icon(
                              Icons.arrow_forward_ios,
                              color: AppColors.textSecondary,
                              size: 16,
                            ),
                            onTap: () {
                              if (!canSign) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text(
                                        'Watch-only wallet cannot send funds'),
                                  ),
                                );
                                return;
                              }
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (_) => const SendTokenScreen(),
                                ),
                              );
                            },
                          ),
                        ),
                        const Padding(
                          padding: EdgeInsets.only(bottom: 12),
                          child: Text(
                            'Or select native asset:',
                            style: TextStyle(
                              color: AppColors.textSecondary,
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                        ...filtered.map(
                          (a) => Container(
                            margin: const EdgeInsets.only(bottom: 12),
                            decoration: BoxDecoration(
                              color: AppColors.surface,
                              borderRadius: BorderRadius.circular(14),
                              border: Border.all(
                                  color: AppColors.border, width: 0.5),
                            ),
                            child: ListTile(
                              leading: Container(
                                width: 40,
                                height: 40,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: _getAssetColor(a.symbol),
                                ),
                                child: Center(
                                  child: Text(
                                    a.symbol[0].toUpperCase(),
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 18,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                ),
                              ),
                              title: Text(
                                a.name,
                                style: const TextStyle(
                                  color: AppColors.textPrimary,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              subtitle: Text(
                                a.symbol,
                                style: const TextStyle(
                                    color: AppColors.textSecondary),
                              ),
                              trailing: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Text(
                                    '${currency.symbol}${a.price.toStringAsFixed(1)}',
                                    style: const TextStyle(
                                      color: AppColors.textPrimary,
                                      fontWeight: FontWeight.w600,
                                      fontSize: 14,
                                    ),
                                  ),
                                  const SizedBox(height: 2),
                                  Text(
                                    '${a.changePct >= 0 ? '+' : ''}${a.changePct.toStringAsFixed(2)}%',
                                    style: TextStyle(
                                      color: a.changePct >= 0
                                          ? Colors.green[400]
                                          : Colors.red[400],
                                      fontSize: 12,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ],
                              ),
                              onTap: () {
                                if (!canSign) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                      content: Text(
                                          'Watch-only wallet cannot send funds'),
                                    ),
                                  );
                                  return;
                                }
                                if (a.symbol.toUpperCase() != 'ETH') {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                        content: Text(
                                            'Use "Send ERC-20 Tokens" for token transfers')),
                                  );
                                  return;
                                }

                                Navigator.of(context).push(
                                  MaterialPageRoute(
                                      builder: (_) => const SendEthScreen()),
                                );
                              },
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showSearchDialog() {
    _searchCtrl.text = _searchQuery;
    showDialog<void>(
      context: context,
      builder: (ctx) => AlertDialog(
        backgroundColor: AppColors.surface,
        title: const Text(
          'Search Assets',
          style: TextStyle(color: AppColors.textPrimary),
        ),
        content: TextField(
          controller: _searchCtrl,
          autofocus: true,
          style: const TextStyle(color: AppColors.textPrimary),
          decoration: const InputDecoration(
            hintText: 'Enter asset name or symbol',
            hintStyle: TextStyle(color: AppColors.textSecondary),
          ),
          onSubmitted: (_) {
            setState(() => _searchQuery = _searchCtrl.text.trim());
            Navigator.of(ctx).pop();
          },
        ),
        actions: [
          TextButton(
            onPressed: () {
              _searchCtrl.clear();
              setState(() => _searchQuery = '');
              Navigator.of(ctx).pop();
            },
            child: const Text('Clear'),
          ),
          TextButton(
            onPressed: () {
              setState(() => _searchQuery = _searchCtrl.text.trim());
              Navigator.of(ctx).pop();
            },
            child: const Text('Search'),
          ),
        ],
      ),
    );
  }
}

class _SimpleLifecycleObserver with WidgetsBindingObserver {
  VoidCallback? onResumed;

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      onResumed?.call();
    }
  }
}
