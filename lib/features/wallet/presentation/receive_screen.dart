import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../app/router.dart';
import '../../../shared/theme/app_theme.dart';
import '../data/market_data_provider.dart';
import 'network_list_screen.dart';

class ReceiveScreen extends ConsumerStatefulWidget {
  const ReceiveScreen({super.key});

  @override
  ConsumerState<ReceiveScreen> createState() => _ReceiveScreenState();
}

class _ReceiveScreenState extends ConsumerState<ReceiveScreen> {
  final _searchCtrl = TextEditingController();
  String _searchQuery = '';

  @override
  void dispose() {
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

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.background,
        title: const Text(
          'Receive',
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

                  return ListView(
                    padding: const EdgeInsets.all(20),
                    children: [
                      ...filtered.map(
                        (a) => Container(
                          margin: const EdgeInsets.only(bottom: 12),
                          decoration: BoxDecoration(
                            color: AppColors.surface,
                            borderRadius: BorderRadius.circular(14),
                            border:
                                Border.all(color: AppColors.border, width: 0.5),
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
                                  '\$${a.priceUsd.toStringAsFixed(1)}',
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
                            onTap: () => Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (_) => NetworkListScreen(
                                  onSelected: (context, _) {
                                    Navigator.of(context).pushReplacementNamed(
                                        AppRoutes.receiveAddress);
                                  },
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
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
