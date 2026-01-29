import 'dart:math';

import '../../../shared/contracts/app_contracts.dart';

class MockSwapRepository implements SwapRepository {
  @override
  Future<SwapQuoteResponse> quote(SwapQuoteRequest req) async {
    await Future<void>.delayed(const Duration(milliseconds: 500));

    return SwapQuoteResponse(
      quoteId: 'q_${Random().nextInt(999999)}',
      chainId: req.chainId,
      amountIn: req.amountIn,
      amountOut: req.amountIn,
      minOut: req.amountIn,
      route: SwapRoute(
        aggregator: 'mock',
        dex: req.preferredDex,
        estimatedGas: '21000',
      ),
      approval: const SwapApproval(
        isRequired: false,
        spender: '0x0000000000000000000000000000000000000000',
        amount: '0',
      ),
      expiresAt: DateTime.now().add(const Duration(minutes: 5)),
      warnings: const ['Mock quote - replace with backend'],
    );
  }

  @override
  Future<SwapBuildResponse> build(SwapBuildRequest req) async {
    await Future<void>.delayed(const Duration(milliseconds: 600));

    return SwapBuildResponse(
      tx: const EvmTxRequest(
        to: '0x0000000000000000000000000000000000000000',
        data: '0x',
        value: '0',
        gasLimit: '21000',
        type: TxType.eip1559,
        maxFeePerGas: '0',
        maxPriorityFeePerGas: '0',
      ),
      fee: const SwapFee(estimatedNetworkFeeWei: '0'),
    );
  }
}

