import 'dart:typed_data';

import 'package:http/http.dart' as http;
import 'package:web3dart/crypto.dart';
import 'package:web3dart/web3dart.dart';

import '../../../shared/contracts/app_contracts.dart';

/// Real EVM RPC implementation (Sepolia-first).
///
/// Wired in `bootstrap.dart` whenever an RPC URL is configured.
class EvmChainRepositoryImpl implements EvmChainRepository {
  EvmChainRepositoryImpl({
    required String rpcUrl,
    http.Client? httpClient,
  }) {
    _http = httpClient ?? http.Client();
    _client = Web3Client(rpcUrl, _http);
  }

  late final http.Client _http;
  late final Web3Client _client;

  void dispose() {
    _http.close();
    _client.dispose();
  }

  @override
  Future<String> getNativeBalanceWei(String address) async {
    final etherAmount =
        await _client.getBalance(EthereumAddress.fromHex(address));
    return etherAmount.getInWei.toString();
  }

  @override
  Future<int> getNonce(String address) async {
    return _client.getTransactionCount(
      EthereumAddress.fromHex(address),
      atBlock: const BlockNum.pending(),
    );
  }

  @override
  Future<FeeSuggestion> getFeeSuggestion() async {
    // If the node supports EIP-1559, suggest maxFee/maxPriorityFee using a
    // simple formula: maxFee = 2 * baseFee + priorityFee.
    try {
      final block = await _client.getBlockInformation();
      if (block.baseFeePerGas != null) {
        final base = block.baseFeePerGas!.getInWei;
        final priority = BigInt.from(1_000_000_000); // 1 gwei
        final maxFee = base * BigInt.from(2) + priority;
        return FeeSuggestion(
          type: TxType.eip1559,
          maxFeePerGas: maxFee.toString(),
          maxPriorityFeePerGas: priority.toString(),
        );
      }
    } catch (_) {
      // Fall back to legacy gasPrice.
    }

    final gasPrice = await _client.getGasPrice();
    return FeeSuggestion(
      type: TxType.legacy,
      gasPrice: gasPrice.getInWei.toString(),
    );
  }

  @override
  Future<int> estimateGas(EvmUnsignedTx tx) async {
    final from =
        tx.from == null || tx.from!.trim().isEmpty ? null : tx.from!.trim();
    final to = EthereumAddress.fromHex(tx.to);
    final data = _hexToBytes(tx.data);
    final value = EtherAmount.inWei(_parseBigInt(tx.valueWei));

    final estimate = await _client.estimateGas(
      sender: from == null ? null : EthereumAddress.fromHex(from),
      to: to,
      value: value,
      data: data,
    );

    return estimate.toInt();
  }

  @override
  Future<String> sendRawTx(String rawTxHex) async {
    final bytes = _hexToBytes(rawTxHex);
    return _client.sendRawTransaction(bytes);
  }

  @override
  Future<TxReceipt?> getReceipt(String txHash) async {
    final receipt = await _client.getTransactionReceipt(txHash);
    if (receipt == null) return null;

    final hashHex = bytesToHex(
      receipt.transactionHash,
      include0x: true,
      padToEvenLength: true,
    );

    return TxReceipt(
      txHash: hashHex,
      success: receipt.status ?? false,
      blockNumber: receipt.blockNumber.blockNum,
    );
  }

  Uint8List _hexToBytes(String hexString) {
    final normalized =
        hexString.startsWith('0x') ? hexString.substring(2) : hexString;
    if (normalized.isEmpty) return Uint8List(0);
    return hexToBytes(normalized);
  }

  BigInt _parseBigInt(String value) {
    final v = value.trim();
    if (v.isEmpty) return BigInt.zero;
    if (v.startsWith('0x') || v.startsWith('0X')) {
      return BigInt.parse(v.substring(2), radix: 16);
    }
    return BigInt.parse(v);
  }
}
