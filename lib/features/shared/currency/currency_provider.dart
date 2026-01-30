import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Represents a supported fiat currency.
class Currency {
  final String code; // e.g. "USD", "MYR"
  final String symbol; // e.g. "$", "RM"
  final String name; // e.g. "United States Dollar"

  const Currency({
    required this.code,
    required this.symbol,
    required this.name,
  });
}

/// List of supported currencies.
const kSupportedCurrencies = [
  Currency(code: 'USD', symbol: r'$', name: 'US Dollar'),
  Currency(code: 'MYR', symbol: 'RM', name: 'Malaysian Ringgit'),
  Currency(code: 'SGD', symbol: r'S$', name: 'Singapore Dollar'),
  Currency(code: 'EUR', symbol: '€', name: 'Euro'),
  Currency(code: 'GBP', symbol: '£', name: 'British Pound'),
  Currency(code: 'JPY', symbol: '¥', name: 'Japanese Yen'),
  Currency(code: 'CNY', symbol: '¥', name: 'Chinese Yuan'),
  Currency(code: 'AUD', symbol: r'A$', name: 'Australian Dollar'),
  Currency(code: 'CAD', symbol: r'C$', name: 'Canadian Dollar'),
];

class CurrencyNotifier extends StateNotifier<Currency> {
  CurrencyNotifier() : super(kSupportedCurrencies.first);

  void setCurrency(Currency currency) {
    state = currency;
  }

  void setCurrencyByCode(String code) {
    state = kSupportedCurrencies.firstWhere(
      (c) => c.code.toUpperCase() == code.toUpperCase(),
      orElse: () => kSupportedCurrencies.first,
    );
  }
}

/// Provider for the currently selected currency.
///
/// For now it's in-memory; can be persisted later (e.g. shared_preferences).
final currencyProvider =
    StateNotifierProvider<CurrencyNotifier, Currency>((ref) {
  return CurrencyNotifier();
});

