import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

@immutable
class SwapFormState {
  final String fromToken;
  final String fromSymbol;
  final int fromDecimals;
  final String toToken;
  final String toSymbol;
  final int toDecimals;
  final String amount;
  final String dex;
  final String recipient;
  final double slippage;

  const SwapFormState({
    required this.fromToken,
    required this.fromSymbol,
    required this.fromDecimals,
    required this.toToken,
    required this.toSymbol,
    required this.toDecimals,
    required this.amount,
    required this.dex,
    required this.recipient,
    required this.slippage,
  });

  SwapFormState copyWith({
    String? fromToken,
    String? fromSymbol,
    int? fromDecimals,
    String? toToken,
    String? toSymbol,
    int? toDecimals,
    String? amount,
    String? dex,
    String? recipient,
    double? slippage,
  }) {
    return SwapFormState(
      fromToken: fromToken ?? this.fromToken,
      fromSymbol: fromSymbol ?? this.fromSymbol,
      fromDecimals: fromDecimals ?? this.fromDecimals,
      toToken: toToken ?? this.toToken,
      toSymbol: toSymbol ?? this.toSymbol,
      toDecimals: toDecimals ?? this.toDecimals,
      amount: amount ?? this.amount,
      dex: dex ?? this.dex,
      recipient: recipient ?? this.recipient,
      slippage: slippage ?? this.slippage,
    );
  }
}

final swapFormProvider =
    NotifierProvider<SwapFormController, SwapFormState>(SwapFormController.new);

class SwapFormController extends Notifier<SwapFormState> {
  @override
  SwapFormState build() {
    return const SwapFormState(
      fromToken: '0x0000000000000000000000000000000000000000',
      fromSymbol: 'ETH',
      fromDecimals: 18,
      toToken: '0x0000000000000000000000000000000000000000',
      toSymbol: 'ETH',
      toDecimals: 18,
      amount: '',
      dex: 'PancakeSwap V3',
      recipient: '',
      slippage: 0.5,
    );
  }

  void setFromToken({
    required String address,
    required String symbol,
    required int decimals,
  }) =>
      state = state.copyWith(
        fromToken: address,
        fromSymbol: symbol,
        fromDecimals: decimals,
      );

  void setToToken({
    required String address,
    required String symbol,
    required int decimals,
  }) =>
      state = state.copyWith(
        toToken: address,
        toSymbol: symbol,
        toDecimals: decimals,
      );

  void setAmount(String amount) => state = state.copyWith(amount: amount);
  void setDex(String dex) => state = state.copyWith(dex: dex);
  void setRecipient(String recipient) =>
      state = state.copyWith(recipient: recipient);
  void setSlippage(double slippage) =>
      state = state.copyWith(slippage: slippage);

  void flip() {
    state = state.copyWith(
      fromToken: state.toToken,
      fromSymbol: state.toSymbol,
      fromDecimals: state.toDecimals,
      toToken: state.fromToken,
      toSymbol: state.fromSymbol,
      toDecimals: state.fromDecimals,
    );
  }
}
