import 'dart:convert';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;

import '../../../shared/contracts/app_contracts.dart';

const String _etherscanApiKey = String.fromEnvironment(
  'ETHERSCAN_API_KEY',
  defaultValue: '',
);

/// Token balance model.
class TokenBalance {
  const TokenBalance({
    required this.contractAddress,
    required this.symbol,
    required this.name,
    required this.balance,
    required this.decimals,
  });

  final String contractAddress;
  final String symbol;
  final String name;
  final String balance; // Raw balance
  final int decimals;

  /// Format balance with decimals.
  String get formattedBalance {
    final raw = BigInt.tryParse(balance) ?? BigInt.zero;
    if (raw == BigInt.zero) return '0';

    final divisor = BigInt.from(10).pow(decimals);
    final whole = raw ~/ divisor;
    final remainder = raw % divisor;

    if (remainder == BigInt.zero) {
      return whole.toString();
    }

    // Format with up to 4 decimal places
    final remainderStr = remainder.toString().padLeft(decimals, '0');
    final decimalPart = remainderStr.substring(0, decimals.clamp(0, 4));
    return '$whole.$decimalPart'.replaceAll(RegExp(r'\.?0+$'), '');
  }
}

/// Fetches ERC-20 token balances from Etherscan API.
final tokenBalanceProvider =
    FutureProvider.autoDispose<List<TokenBalance>>((ref) async {
  final session = ref.watch(walletSessionProvider);
  final address = session.activeAddress;
  if (address == null || address.isEmpty) return [];

  final network = ref.watch(selectedNetworkProvider);

  // Use Sepolia API for testnet, mainnet API for mainnet
  final baseUrl = network.chainId == 11155111
      ? 'https://api-sepolia.etherscan.io/api'
      : 'https://api.etherscan.io/api';

  // Fetch token transfer events to discover tokens
  final apiKey = _etherscanApiKey.trim();
  final apiKeyParam = apiKey.isEmpty ? '' : '&apikey=$apiKey';
  final uri = Uri.parse(
    '$baseUrl'
    '?module=account'
    '&action=tokentx'
    '&address=$address'
    '&page=1'
    '&offset=100'
    '&sort=desc'
    '$apiKeyParam',
  );

  try {
    final response = await http.get(uri).timeout(const Duration(seconds: 15));

    if (response.statusCode != 200) {
      throw Exception('Failed to fetch tokens: ${response.statusCode}');
    }

    final Map<String, dynamic> data = jsonDecode(response.body);

    if (data['status'] != '1') {
      return [];
    }

    final List<dynamic> result = data['result'] ?? [];

    // Extract unique tokens
    final Map<String, TokenBalance> tokenMap = {};
    for (final tx in result) {
      final contractAddress = tx['contractAddress'] ?? '';
      if (contractAddress.isNotEmpty &&
          !tokenMap.containsKey(contractAddress)) {
        tokenMap[contractAddress] = TokenBalance(
          contractAddress: contractAddress,
          symbol: tx['tokenSymbol'] ?? 'UNKNOWN',
          name: tx['tokenName'] ?? 'Unknown Token',
          balance: '0', // Will need separate balance call
          decimals: int.tryParse(tx['tokenDecimal'] ?? '18') ?? 18,
        );
      }
    }

    // For each token, fetch current balance
    final List<TokenBalance> balances = [];
    for (final token in tokenMap.values) {
      final balanceUri = Uri.parse(
        '$baseUrl'
        '?module=account'
        '&action=tokenbalance'
        '&contractaddress=${token.contractAddress}'
        '&address=$address'
        '&tag=latest'
        '$apiKeyParam',
      );

      try {
        final balanceResponse =
            await http.get(balanceUri).timeout(const Duration(seconds: 10));

        if (balanceResponse.statusCode == 200) {
          final balanceData = jsonDecode(balanceResponse.body);
          if (balanceData['status'] == '1') {
            final balance = balanceData['result'] ?? '0';
            if (balance != '0') {
              balances.add(TokenBalance(
                contractAddress: token.contractAddress,
                symbol: token.symbol,
                name: token.name,
                balance: balance,
                decimals: token.decimals,
              ));
            }
          }
        }
      } catch (_) {
        // Skip this token on error
      }
    }

    return balances;
  } catch (e) {
    return [];
  }
});
