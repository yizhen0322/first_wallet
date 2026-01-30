import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

import '../../../app/router.dart';
import '../../../shared/contracts/app_contracts.dart';
import '../../../shared/theme/app_theme.dart';
import '../../../shared/widgets/pavilion_outlined_card.dart';
import '../data/market_data_provider.dart';
import '../state/evm_balance.dart';
import '../state/wallet_secrets.dart';
import '../state/wallet_state.dart';
import '../../shared/currency/currency_provider.dart';

class WalletHomeScreen extends ConsumerStatefulWidget {
  const WalletHomeScreen({super.key});

  @override
  ConsumerState<WalletHomeScreen> createState() => _WalletHomeScreenState();
}

class _WalletHomeScreenState extends ConsumerState<WalletHomeScreen>
    with WidgetsBindingObserver {
  Timer? _balanceTimer;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    _balanceTimer = Timer.periodic(const Duration(seconds: 15), (_) {
      if (!mounted) return;
      ref.invalidate(evmNativeBalanceWeiProvider);
    });
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      ref.invalidate(evmNativeBalanceWeiProvider);
    }
  }

  @override
  void dispose() {
    _balanceTimer?.cancel();
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final walletsAsync = ref.watch(walletsProvider);
    final selectedId = ref.watch(selectedWalletIdProvider);

    final marketAsync = ref.watch(marketDataProvider);
    final balanceAsync = ref.watch(evmNativeBalanceWeiProvider);
    final session = ref.watch(walletSessionProvider);
    final mnemonic = ref.watch(currentMnemonicProvider);
    final currency = ref.watch(currencyProvider);

    return walletsAsync.when(
      loading: () => const Scaffold(
        backgroundColor: AppColors.background,
        body: Center(child: CircularProgressIndicator()),
      ),
      error: (e, _) => Scaffold(
        backgroundColor: AppColors.background,
        body: Center(
          child: Text(
            'Failed to load wallets: $e',
            style: const TextStyle(color: AppColors.textPrimary),
            textAlign: TextAlign.center,
          ),
        ),
      ),
      data: (wallets) {
        if (wallets.isEmpty) {
          return Scaffold(
            backgroundColor: AppColors.background,
            appBar: AppBar(
              backgroundColor: AppColors.background,
              title: const Text(
                'Wallet',
                style: TextStyle(color: AppColors.textPrimary),
              ),
              centerTitle: true,
            ),
            body: Center(
              child: Padding(
                padding: const EdgeInsets.all(28),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Text(
                      'No wallets yet',
                      style: TextStyle(
                        color: AppColors.textPrimary,
                        fontSize: 18,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const SizedBox(height: 12),
                    const Text(
                      'Create or import a wallet to start using Pavilion.',
                      style: TextStyle(color: AppColors.textSecondary),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 18),
                    FilledButton(
                      onPressed: () => Navigator.of(context)
                          .pushNamed(AppRoutes.manageWallets),
                      child: const Text('Add Wallet'),
                    ),
                  ],
                ),
              ),
            ),
          );
        }

        final selected = wallets.firstWhere(
          (w) => w.id == selectedId,
          orElse: () => wallets.first,
        );

        double? ethPrice;
        double? ethChangePct;
        final market = marketAsync.valueOrNull;
        if (market != null) {
          for (final a in market) {
            if (a.symbol.toUpperCase() == 'ETH') {
              if (a.price > 0) {
                ethPrice = a.price;
                ethChangePct = a.changePct;
              } else {
                ethPrice = null;
                ethChangePct = null;
              }
              break;
            }
          }
        }

        final balanceText = balanceAsync.when(
          data: (wei) {
            if (ethPrice == null) return '${currency.symbol}—';
            final eth = wei / BigInt.from(10).pow(18);
            final value = eth * ethPrice;
            return '${currency.symbol}${NumberFormat('#,##0.00', 'en_US').format(value)}';
          },
          loading: () => '...',
          error: (_, __) => '${currency.symbol}—',
        );

        return Scaffold(
          backgroundColor: AppColors.background,
          appBar: AppBar(
            backgroundColor: AppColors.background,
            title: Text(
              selected.name,
              style: const TextStyle(color: AppColors.textPrimary),
            ),
            centerTitle: true,
            leading: IconButton(
              tooltip: 'Switch Wallet',
              onPressed: () =>
                  Navigator.of(context).pushNamed(AppRoutes.manageWallets),
              icon: const Icon(
                Icons.credit_card_outlined,
                color: AppColors.textPrimary,
              ),
            ),
            actions: [
              IconButton(
                tooltip: 'Scan',
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Scan (coming soon)')),
                  );
                },
                icon: const Icon(
                  Icons.qr_code_scanner_outlined,
                  color: AppColors.textPrimary,
                ),
              ),
            ],
          ),
          body: SafeArea(
            child: RefreshIndicator(
              color: AppColors.primary,
              backgroundColor: AppColors.surface,
              onRefresh: () async {
                ref.invalidate(evmNativeBalanceWeiProvider);
                ref.invalidate(marketDataProvider);
                try {
                  await ref.read(evmNativeBalanceWeiProvider.future);
                } catch (_) {
                  // ignore
                }
              },
              child: ListView(
                physics: const AlwaysScrollableScrollPhysics(),
                padding: const EdgeInsets.all(20),
                children: [
                  _WalletOverviewCard(
                    balanceText: balanceText,
                    currency: currency,
                    changePct: ethChangePct,
                    isChangeLoading: marketAsync.isLoading,
                    onSend: () {
                      final canSign =
                          (mnemonic != null && mnemonic.trim().isNotEmpty) &&
                              session.isUnlocked;
                      if (!canSign) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content:
                                Text('Watch-only wallet cannot send funds'),
                          ),
                        );
                        return;
                      }
                      Navigator.of(context).pushNamed(AppRoutes.send);
                    },
                    onReceive: () =>
                        Navigator.of(context).pushNamed(AppRoutes.receive),
                    onSwap: () {
                      final canSign =
                          (mnemonic != null && mnemonic.trim().isNotEmpty) &&
                              session.isUnlocked;
                      if (!canSign) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content:
                                Text('Watch-only wallet cannot swap tokens'),
                          ),
                        );
                        return;
                      }
                      Navigator.of(context).pushNamed(AppRoutes.swap);
                    },
                  ),
                  const SizedBox(height: 22),
                  _MarketTrendCard(assetsAsync: marketAsync),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

class _WalletOverviewCard extends StatelessWidget {
  const _WalletOverviewCard({
    required this.balanceText,
    required this.currency,
    required this.changePct,
    required this.isChangeLoading,
    required this.onSend,
    required this.onReceive,
    required this.onSwap,
  });

  final String balanceText;
  final Currency currency;
  final double? changePct;
  final bool isChangeLoading;
  final VoidCallback onSend;
  final VoidCallback onReceive;
  final VoidCallback onSwap;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: AppColors.background,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: AppColors.primary, width: 1),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const Text(
            'Total Balance',
            style: TextStyle(
              color: AppColors.textSecondary,
              fontSize: 12,
              fontWeight: FontWeight.w600,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 10),
          Row(
            children: [
              Expanded(
                child: Center(
                  child: FittedBox(
                    fit: BoxFit.scaleDown,
                    child: Text(
                      balanceText,
                      style: const TextStyle(
                        color: AppColors.textPrimary,
                        fontSize: 32,
                        fontWeight: FontWeight.w700,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 12),
              _CurrencyAndChange(
                currency: currency,
                changePct: changePct,
                isLoading: isChangeLoading,
              ),
            ],
          ),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _CircularActionButton(
                icon: Icons.arrow_upward,
                label: 'Send',
                onPressed: onSend,
              ),
              _CircularActionButton(
                icon: Icons.arrow_downward,
                label: 'Receive',
                onPressed: onReceive,
              ),
              _CircularActionButton(
                icon: Icons.swap_horiz,
                label: 'Swap',
                onPressed: onSwap,
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _CurrencyAndChange extends ConsumerWidget {
  const _CurrencyAndChange({
    required this.currency,
    required this.changePct,
    required this.isLoading,
  });

  final Currency currency;
  final double? changePct;
  final bool isLoading;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final hasChange = changePct != null;
    final pct = changePct ?? 0;
    final isUp = hasChange && pct >= 0;
    final pctColor = !hasChange
        ? AppColors.textSecondary
        : isUp
            ? AppColors.success
            : AppColors.error;

    return IntrinsicWidth(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          InkWell(
            onTap: () {
              showModalBottomSheet(
                context: context,
                backgroundColor: AppColors.background,
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
                ),
                builder: (context) => SafeArea(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Padding(
                        padding: EdgeInsets.all(16),
                        child: Text(
                          'Select Currency',
                          style: TextStyle(
                            color: AppColors.textPrimary,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Flexible(
                        child: ListView(
                          shrinkWrap: true,
                          children: kSupportedCurrencies.map((c) {
                            final isSelected = c.code == currency.code;
                            return ListTile(
                              leading: Text(
                                c.symbol,
                                style: const TextStyle(
                                  color: AppColors.textPrimary,
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              title: Text(
                                c.code,
                                style: const TextStyle(
                                  color: AppColors.textPrimary,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              subtitle: Text(
                                c.name,
                                style: const TextStyle(
                                    color: AppColors.textSecondary),
                              ),
                              trailing: isSelected
                                  ? const Icon(Icons.check,
                                      color: AppColors.primary)
                                  : null,
                              onTap: () {
                                ref
                                    .read(currencyProvider.notifier)
                                    .setCurrency(c);
                                Navigator.of(context).pop();
                              },
                            );
                          }).toList(),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
            borderRadius: BorderRadius.circular(12),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
              decoration: BoxDecoration(
                color: AppColors.surface,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: AppColors.border, width: 0.5),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    currency.code,
                    style: const TextStyle(
                      color: AppColors.textPrimary,
                      fontSize: 12,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(width: 2),
                  const Icon(
                    Icons.keyboard_arrow_down,
                    color: AppColors.textSecondary,
                    size: 18,
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 6),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
            decoration: BoxDecoration(
              color: !hasChange
                  ? AppColors.surface
                  : pctColor.withValues(alpha: 38),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: !hasChange ? AppColors.border : Colors.transparent,
                width: 0.5,
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                if (isLoading && !hasChange)
                  const SizedBox(
                    width: 12,
                    height: 12,
                    child: CircularProgressIndicator(strokeWidth: 2),
                  )
                else if (hasChange)
                  Icon(
                    isUp ? Icons.arrow_drop_up : Icons.arrow_drop_down,
                    color: pctColor,
                    size: 16,
                  ),
                if ((isLoading && !hasChange) || hasChange)
                  const SizedBox(width: 2),
                Text(
                  !hasChange
                      ? '—'
                      : '${isUp ? '+' : ''}${pct.toStringAsFixed(2)}%',
                  style: TextStyle(
                    color: pctColor,
                    fontSize: 12,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _CircularActionButton extends StatelessWidget {
  const _CircularActionButton({
    required this.icon,
    required this.label,
    required this.onPressed,
  });

  final IconData icon;
  final String label;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        InkWell(
          onTap: onPressed,
          borderRadius: BorderRadius.circular(32),
          child: Container(
            width: 64,
            height: 64,
            decoration: BoxDecoration(
              color: AppColors.primary,
              shape: BoxShape.circle,
            ),
            child: Icon(
              icon,
              color: Colors.black,
              size: 28,
            ),
          ),
        ),
        const SizedBox(height: 8),
        Text(
          label,
          style: const TextStyle(
            color: AppColors.textPrimary,
            fontSize: 13,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }
}

class _MarketTrendCard extends StatelessWidget {
  const _MarketTrendCard({required this.assetsAsync});

  final AsyncValue<List<WalletAsset>> assetsAsync;

  @override
  Widget build(BuildContext context) {
    return PavilionOutlinedCard(
      padding: EdgeInsets.zero,
      borderRadius: 14,
      clipBehavior: Clip.antiAlias,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            color: AppColors.primary,
            child: Row(
              children: [
                const Text(
                  'Market Trend',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 14,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                const Spacer(),
                if (assetsAsync.isLoading)
                  const SizedBox(
                    width: 14,
                    height: 14,
                    child: CircularProgressIndicator(
                      strokeWidth: 2,
                      color: Colors.black54,
                    ),
                  ),
              ],
            ),
          ),
          assetsAsync.when(
            loading: () => const Padding(
              padding: EdgeInsets.all(24),
              child: Center(child: CircularProgressIndicator()),
            ),
            error: (e, _) => Padding(
              padding: const EdgeInsets.all(16),
              child: Text(
                'Failed to load market data',
                style: TextStyle(color: AppColors.textSecondary),
                textAlign: TextAlign.center,
              ),
            ),
            data: (assets) {
              if (assets.isEmpty) {
                return const Padding(
                  padding: EdgeInsets.all(16),
                  child: Text(
                    'No market data available',
                    style: TextStyle(color: AppColors.textSecondary),
                    textAlign: TextAlign.center,
                  ),
                );
              }
              return Column(
                children: [
                  for (var i = 0; i < assets.length; i++) ...[
                    _MarketRow(asset: assets[i]),
                    if (i != assets.length - 1)
                      Divider(
                        height: 1,
                        thickness: 0.5,
                        indent: 16,
                        endIndent: 16,
                        color: AppColors.primary.withValues(alpha: 160),
                      ),
                  ],
                ],
              );
            },
            skipLoadingOnRefresh: true,
            skipLoadingOnReload: true,
          ),
        ],
      ),
    );
  }
}

class _MarketRow extends StatelessWidget {
  const _MarketRow({required this.asset});

  final WalletAsset asset;

  // Map asset symbols to colors (mocked colors from Figma)
  Color _getAssetColor(String symbol) {
    switch (symbol) {
      case 'BTC':
        return const Color(0xFFF7931A); // Bitcoin Orange
      case 'ETH':
        return const Color(0xFF627EEA); // Ethereum Blue
      case 'DCR':
        return const Color(0xFF2ED8A7); // Decred Teal
      case 'EMC':
        return const Color(0xFF5B4FFF); // Emercoin Purple
      default:
        return AppColors.primary;
    }
  }

  @override
  Widget build(BuildContext context) {
    final pct = asset.changePct;
    final pctColor = pct >= 0 ? AppColors.success : AppColors.error;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      child: Row(
        children: [
          Container(
            width: 38,
            height: 38,
            decoration: BoxDecoration(
              color: AppColors.surface,
              shape: BoxShape.circle,
            ),
            child: Center(
              child: Text(
                asset.symbol.substring(0, 1),
                style: TextStyle(
                  color: _getAssetColor(asset.symbol),
                  fontSize: 18,
                  fontWeight: FontWeight.w800,
                ),
              ),
            ),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  asset.name,
                  style: const TextStyle(
                    color: AppColors.textPrimary,
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  asset.symbol,
                  style: const TextStyle(
                    color: AppColors.textSecondary,
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                '${asset.currency == 'USD' ? '\$' : ''}${asset.price.toStringAsFixed(asset.price < 1 ? 4 : 2)}',
                style: const TextStyle(
                  color: AppColors.textPrimary,
                  fontSize: 14,
                  fontWeight: FontWeight.w800,
                ),
              ),
              const SizedBox(height: 2),
              Text(
                '${pct >= 0 ? '+' : ''}${pct.toStringAsFixed(2)}%',
                style: TextStyle(
                  color: pctColor,
                  fontSize: 12,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
