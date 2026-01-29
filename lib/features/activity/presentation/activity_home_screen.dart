import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

import '../../../shared/contracts/app_contracts.dart';
import '../../../shared/theme/app_theme.dart';
import '../data/transaction_history_provider.dart';
import '../data/token_balance_provider.dart';

class ActivityHomeScreen extends ConsumerStatefulWidget {
  const ActivityHomeScreen({super.key});

  @override
  ConsumerState<ActivityHomeScreen> createState() => _ActivityHomeScreenState();
}

class _ActivityHomeScreenState extends ConsumerState<ActivityHomeScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final network = ref.watch(selectedNetworkProvider);

    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Activity',
                    style: TextStyle(
                      color: AppColors.textPrimary,
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  // Network selector chip
                  _NetworkChip(network: network),
                ],
              ),
            ),
            const SizedBox(height: 16),
            // Tab bar
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 20),
              decoration: const BoxDecoration(
                border: Border(
                  bottom: BorderSide(color: AppColors.border, width: 1),
                ),
              ),
              child: TabBar(
                controller: _tabController,
                indicatorColor: AppColors.primary,
                indicatorWeight: 2,
                labelColor: AppColors.primary,
                unselectedLabelColor: AppColors.textSecondary,
                labelStyle: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                ),
                tabs: const [
                  Tab(text: 'Transactions'),
                  Tab(text: 'Tokens'),
                ],
              ),
            ),
            // Tab content
            Expanded(
              child: TabBarView(
                controller: _tabController,
                children: const [
                  _TransactionsTab(),
                  _TokensTab(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _NetworkChip extends StatelessWidget {
  const _NetworkChip({required this.network});

  final ChainConfig network;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: AppColors.border),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 20,
            height: 20,
            decoration: BoxDecoration(
              color: network.chainId == 11155111
                  ? AppColors.primary
                  : const Color(0xFF627EEA),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Center(
              child: Text(
                network.chainId == 11155111 ? 'S' : 'E',
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          const SizedBox(width: 8),
          Text(
            network.name,
            style: const TextStyle(
              color: AppColors.textPrimary,
              fontSize: 13,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(width: 4),
          const Icon(
            Icons.keyboard_arrow_down,
            color: AppColors.textSecondary,
            size: 18,
          ),
        ],
      ),
    );
  }
}

class _TransactionsTab extends ConsumerWidget {
  const _TransactionsTab();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final txAsync = ref.watch(transactionHistoryProvider);
    final network = ref.watch(selectedNetworkProvider);

    return txAsync.when(
      loading: () => const Center(
        child: CircularProgressIndicator(color: AppColors.primary),
      ),
      error: (e, _) => _EmptyState(
        icon: Icons.error_outline,
        title: 'Failed to load transactions',
        subtitle: 'Please try again later',
      ),
      data: (transactions) {
        if (transactions.isEmpty) {
          return _EmptyState(
            icon: Icons.receipt_long_outlined,
            title: 'You have no transactions!',
            subtitle: null,
            action: _ViewHistoryLink(network: network),
          );
        }

        return RefreshIndicator(
          color: AppColors.primary,
          backgroundColor: AppColors.surface,
          onRefresh: () async {
            ref.invalidate(transactionHistoryProvider);
            await ref.read(transactionHistoryProvider.future);
          },
          child: ListView.separated(
            padding: const EdgeInsets.all(20),
            itemCount: transactions.length,
            separatorBuilder: (_, __) => const Divider(
              color: AppColors.border,
              height: 1,
            ),
            itemBuilder: (context, index) {
              final tx = transactions[index];
              return _TransactionTile(tx: tx);
            },
          ),
        );
      },
    );
  }
}

class _TransactionTile extends StatelessWidget {
  const _TransactionTile({required this.tx});

  final TransactionRecord tx;

  @override
  Widget build(BuildContext context) {
    final dateFormat = DateFormat('MMM d, yyyy');

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: Row(
        children: [
          // Direction icon
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: tx.isIncoming
                  ? AppColors.success.withValues(alpha: 38)
                  : AppColors.error.withValues(alpha: 38),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Icon(
              tx.isIncoming ? Icons.arrow_downward : Icons.arrow_upward,
              color: tx.isIncoming ? AppColors.success : AppColors.error,
              size: 20,
            ),
          ),
          const SizedBox(width: 12),
          // Details
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  tx.isIncoming ? 'Received' : 'Sent',
                  style: const TextStyle(
                    color: AppColors.textPrimary,
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  tx.isIncoming ? 'From: ${tx.shortFrom}' : 'To: ${tx.shortTo}',
                  style: const TextStyle(
                    color: AppColors.textSecondary,
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ),
          // Amount and date
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                '${tx.isIncoming ? '+' : '-'}${tx.valueInEth} ETH',
                style: TextStyle(
                  color:
                      tx.isIncoming ? AppColors.success : AppColors.textPrimary,
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 2),
              Text(
                dateFormat.format(tx.timeStamp),
                style: const TextStyle(
                  color: AppColors.textSecondary,
                  fontSize: 11,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _TokensTab extends ConsumerWidget {
  const _TokensTab();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final tokensAsync = ref.watch(tokenBalanceProvider);

    return tokensAsync.when(
      loading: () => const Center(
        child: CircularProgressIndicator(color: AppColors.primary),
      ),
      error: (e, _) => _EmptyState(
        icon: Icons.error_outline,
        title: 'Failed to load tokens',
        subtitle: 'Please try again later',
      ),
      data: (tokens) {
        if (tokens.isEmpty) {
          return _EmptyState(
            icon: Icons.account_balance_wallet_outlined,
            title: 'No tokens found',
            subtitle: 'Your ERC-20 tokens will appear here',
          );
        }

        return RefreshIndicator(
          color: AppColors.primary,
          backgroundColor: AppColors.surface,
          onRefresh: () async {
            ref.invalidate(tokenBalanceProvider);
            await ref.read(tokenBalanceProvider.future);
          },
          child: ListView.separated(
            padding: const EdgeInsets.all(20),
            itemCount: tokens.length,
            separatorBuilder: (_, __) => const Divider(
              color: AppColors.border,
              height: 1,
            ),
            itemBuilder: (context, index) {
              final token = tokens[index];
              return _TokenTile(token: token);
            },
          ),
        );
      },
    );
  }
}

class _TokenTile extends StatelessWidget {
  const _TokenTile({required this.token});

  final TokenBalance token;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: Row(
        children: [
          // Token icon placeholder
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: AppColors.primary.withValues(alpha: 51),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Center(
              child: Text(
                token.symbol.isNotEmpty ? token.symbol[0].toUpperCase() : '?',
                style: const TextStyle(
                  color: AppColors.primary,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          const SizedBox(width: 12),
          // Token details
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  token.symbol,
                  style: const TextStyle(
                    color: AppColors.textPrimary,
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  token.name,
                  style: const TextStyle(
                    color: AppColors.textSecondary,
                    fontSize: 12,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
          // Balance
          Text(
            token.formattedBalance,
            style: const TextStyle(
              color: AppColors.textPrimary,
              fontSize: 14,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}

class _EmptyState extends StatelessWidget {
  const _EmptyState({
    required this.icon,
    required this.title,
    this.subtitle,
    this.action,
  });

  final IconData icon;
  final String title;
  final String? subtitle;
  final Widget? action;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(40),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              size: 64,
              color: AppColors.textSecondary.withValues(alpha: 128),
            ),
            const SizedBox(height: 16),
            Text(
              title,
              style: const TextStyle(
                color: AppColors.textSecondary,
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
              textAlign: TextAlign.center,
            ),
            if (subtitle != null) ...[
              const SizedBox(height: 8),
              Text(
                subtitle!,
                style: TextStyle(
                  color: AppColors.textSecondary.withValues(alpha: 179),
                  fontSize: 14,
                ),
                textAlign: TextAlign.center,
              ),
            ],
            if (action != null) ...[
              const SizedBox(height: 24),
              action!,
            ],
          ],
        ),
      ),
    );
  }
}

class _ViewHistoryLink extends StatelessWidget {
  const _ViewHistoryLink({required this.network});

  final ChainConfig network;

  @override
  Widget build(BuildContext context) {
    final explorerUrl = network.chainId == 11155111
        ? 'https://sepolia.etherscan.io'
        : 'https://etherscan.io';

    return TextButton(
      onPressed: () {
        // In production, would open browser with URL
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('View history on $explorerUrl')),
        );
      },
      child: Text(
        'View full history on ${network.name}',
        style: const TextStyle(
          color: AppColors.primary,
          fontSize: 14,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}
