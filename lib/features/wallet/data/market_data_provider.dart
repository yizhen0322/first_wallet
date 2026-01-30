import 'dart:async';
import 'dart:convert';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;

import '../../shared/currency/currency_provider.dart';
import '../state/wallet_state.dart';

/// CoinGecko API IDs for the coins we display
const _coinIds = {
  'ETH': 'ethereum',
  'BTC': 'bitcoin',
  'DCR': 'decred',
  'EMC': 'emercoin',
  'NAV': 'nav-coin',
};

const _coinNames = {
  'ETH': 'Ethereum',
  'BTC': 'Bitcoin',
  'DCR': 'Decred',
  'EMC': 'Emercoin',
  'NAV': 'NavCoin',
};

/// Fetches real-time market data from CoinGecko (free, no API key required).
/// Auto-refreshes every 60 seconds.
final marketDataProvider =
    FutureProvider.autoDispose<List<WalletAsset>>((ref) async {
  // Auto-refresh every 60 seconds while there are listeners.
  final timer = Timer.periodic(
    const Duration(seconds: 60),
    (_) => ref.invalidateSelf(),
  );
  ref.onDispose(timer.cancel);

  final currency = ref.watch(currencyProvider);
  final currencyCode = currency.code.toLowerCase();

  try {
    final ids = _coinIds.values.join(',');
    final uri = Uri.parse(
      'https://api.coingecko.com/api/v3/simple/price'
      '?ids=$ids'
      '&vs_currencies=$currencyCode'
      '&include_24hr_change=true',
    );

    final response = await http.get(uri).timeout(const Duration(seconds: 10));

    if (response.statusCode != 200) {
      throw Exception('Failed to fetch market data: ${response.statusCode}');
    }

    final Map<String, dynamic> data = jsonDecode(response.body);
    final assets = <WalletAsset>[];

    for (final entry in _coinIds.entries) {
      final symbol = entry.key;
      final coinId = entry.value;
      final coinData = data[coinId];

      if (coinData != null) {
        final price = (coinData[currencyCode] as num?)?.toDouble() ?? 0.0;
        final change =
            (coinData['${currencyCode}_24h_change'] as num?)?.toDouble() ?? 0.0;

        assets.add(WalletAsset(
          symbol: symbol,
          name: _coinNames[symbol] ?? symbol,
          price: price,
          changePct: change,
          currency: currency.code,
        ));
      }
    }

    // Return in consistent order
    final order = ['ETH', 'BTC', 'DCR', 'EMC', 'NAV'];
    assets.sort(
        (a, b) => order.indexOf(a.symbol).compareTo(order.indexOf(b.symbol)));

    return assets;
  } catch (e) {
    // Fallback to mock data on error
    return [
      WalletAsset(
          symbol: 'ETH',
          name: 'Ethereum',
          price: 0,
          changePct: 0,
          currency: currency.code),
      WalletAsset(
          symbol: 'BTC',
          name: 'Bitcoin',
          price: 0,
          changePct: 0,
          currency: currency.code),
      WalletAsset(
          symbol: 'DCR',
          name: 'Decred',
          price: 0,
          changePct: 0,
          currency: currency.code),
      WalletAsset(
          symbol: 'EMC',
          name: 'Emercoin',
          price: 0,
          changePct: 0,
          currency: currency.code),
      WalletAsset(
          symbol: 'NAV',
          name: 'NavCoin',
          price: 0,
          changePct: 0,
          currency: currency.code),
    ];
  }
});
