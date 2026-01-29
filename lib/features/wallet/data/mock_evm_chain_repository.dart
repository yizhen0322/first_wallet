import 'dart:math';

import '../../../shared/contracts/app_contracts.dart';

class MockEvmChainRepository implements EvmChainRepository {
  @override
  Future<String> getNativeBalanceWei(String address) async {
    await Future<void>.delayed(const Duration(milliseconds: 150));
    return '0';
  }

  @override
  Future<int> getNonce(String address) async {
    await Future<void>.delayed(const Duration(milliseconds: 150));
    return 0;
  }

  @override
  Future<FeeSuggestion> getFeeSuggestion() async {
    await Future<void>.delayed(const Duration(milliseconds: 150));
    return const FeeSuggestion(
      type: TxType.eip1559,
      maxFeePerGas: '0',
      maxPriorityFeePerGas: '0',
    );
  }

  @override
  Future<int> estimateGas(EvmUnsignedTx tx) async {
    await Future<void>.delayed(const Duration(milliseconds: 150));
    return 21000;
  }

  @override
  Future<String> sendRawTx(String rawTxHex) async {
    await Future<void>.delayed(const Duration(milliseconds: 400));
    final r = Random();
    final hex =
        List.generate(64, (_) => r.nextInt(16).toRadixString(16)).join();
    return '0x$hex';
  }

  @override
  Future<TxReceipt?> getReceipt(String txHash) async {
    await Future<void>.delayed(const Duration(milliseconds: 300));
    return TxReceipt(txHash: txHash, success: true, blockNumber: 0);
  }
}

