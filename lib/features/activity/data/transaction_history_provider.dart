import 'dart:convert';
import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;

import '../../../shared/contracts/app_contracts.dart';
import '../../../shared/data/local_tx_store.dart';

const String _etherscanApiKey = String.fromEnvironment(
  'ETHERSCAN_API_KEY',
  defaultValue: '',
);

/// Transaction model for history display.
class TransactionRecord {
  const TransactionRecord({
    required this.hash,
    required this.from,
    required this.to,
    required this.value,
    required this.timeStamp,
    required this.isError,
    required this.isIncoming,
    this.isPending = false,
  });

  final String hash;
  final String from;
  final String to;
  final String value; // in Wei
  final DateTime timeStamp;
  final bool isError;
  final bool isIncoming;
  final bool isPending;

  /// Format value from Wei to ETH.
  String get valueInEth {
    final wei = BigInt.tryParse(value) ?? BigInt.zero;
    final eth = wei / BigInt.from(10).pow(18);
    return eth.toStringAsFixed(6);
  }

  /// Short address for display.
  String get shortFrom => from.length > 10
      ? '${from.substring(0, 6)}...${from.substring(from.length - 4)}'
      : from;

  String get shortTo => to.length > 10
      ? '${to.substring(0, 6)}...${to.substring(to.length - 4)}'
      : to;
}

/// Fetches transaction history from Etherscan API.
final transactionHistoryProvider =
    FutureProvider.autoDispose<List<TransactionRecord>>((ref) async {
  final timer = Timer.periodic(
    const Duration(seconds: 20),
    (_) => ref.invalidateSelf(),
  );
  ref.onDispose(timer.cancel);

  final session = ref.watch(walletSessionProvider);
  final address = session.activeAddress;
  if (address == null || address.isEmpty) return [];

  final network = ref.watch(selectedNetworkProvider);

  final local = await ref
      .read(localTxStoreProvider)
      .list(chainId: network.chainId, address: address);

  // Use Sepolia API for testnet, mainnet API for mainnet
  final baseUrl = network.chainId == 11155111
      ? 'https://api-sepolia.etherscan.io/api'
      : 'https://api.etherscan.io/api';

  // Note: For production, you'd want an API key from Etherscan
  final apiKey = _etherscanApiKey.trim();
  final apiKeyParam = apiKey.isEmpty ? '' : '&apikey=$apiKey';
  final uri = Uri.parse(
    '$baseUrl'
    '?module=account'
    '&action=txlist'
    '&address=$address'
    '&startblock=0'
    '&endblock=99999999'
    '&page=1'
    '&offset=50'
    '&sort=desc'
    '$apiKeyParam',
  );

  List<TransactionRecord> remote = <TransactionRecord>[];
  try {
    final response = await http.get(uri).timeout(const Duration(seconds: 15));

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = jsonDecode(response.body);
      if (data['status'] == '1') {
        final List<dynamic> result = data['result'] ?? [];
        final lowerAddress = address.toLowerCase();

        remote = result.map((tx) {
          final from = (tx['from'] as String?) ?? '';
          final to = (tx['to'] as String?) ?? '';
          final timestamp = int.tryParse(tx['timeStamp'] ?? '0') ?? 0;

          return TransactionRecord(
            hash: tx['hash'] ?? '',
            from: from,
            to: to,
            value: tx['value'] ?? '0',
            timeStamp: DateTime.fromMillisecondsSinceEpoch(timestamp * 1000),
            isError: tx['isError'] == '1',
            isIncoming: to.toLowerCase() == lowerAddress,
          );
        }).toList();
      }
    }
  } catch (_) {
    // Ignore and fall back to local history.
  }

  final localRecords = local.map((e) {
    return TransactionRecord(
      hash: e.hash,
      from: e.from,
      to: e.to,
      value: e.valueWei,
      timeStamp: e.createdAt,
      isError: e.status == LocalTxStatus.failed,
      isIncoming: false,
      isPending: e.status == LocalTxStatus.pending,
    );
  }).toList();

  if (remote.isEmpty) return localRecords;

  final seen = <String>{};
  final merged = <TransactionRecord>[];
  for (final r in [...localRecords, ...remote]) {
    final key = r.hash.toLowerCase();
    if (key.isEmpty) continue;
    if (seen.contains(key)) continue;
    seen.add(key);
    merged.add(r);
  }

  merged.sort((a, b) => b.timeStamp.compareTo(a.timeStamp));
  return merged;
});
