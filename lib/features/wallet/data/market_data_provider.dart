import 'dart:async';
import 'dart:convert';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;

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

  try {
    final ids = _coinIds.values.join(',');
    final uri = Uri.parse(
      'https://api.coingecko.com/api/v3/simple/price'
      '?ids=$ids'
      '&vs_currencies=usd'
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
        final price = (coinData['usd'] as num?)?.toDouble() ?? 0.0;
        final change = (coinData['usd_24h_change'] as num?)?.toDouble() ?? 0.0;

        assets.add(WalletAsset(
          symbol: symbol,
          name: _coinNames[symbol] ?? symbol,
          priceUsd: price,
          changePct: change,
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
    return const [
      WalletAsset(symbol: 'ETH', name: 'Ethereum', priceUsd: 0, changePct: 0),
      WalletAsset(symbol: 'BTC', name: 'Bitcoin', priceUsd: 0, changePct: 0),
      WalletAsset(symbol: 'DCR', name: 'Decred', priceUsd: 0, changePct: 0),
      WalletAsset(symbol: 'EMC', name: 'Emercoin', priceUsd: 0, changePct: 0),
      WalletAsset(symbol: 'NAV', name: 'NavCoin', priceUsd: 0, changePct: 0),
    ];
  }
});
