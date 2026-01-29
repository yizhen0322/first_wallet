import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

@immutable
class SwapFormState {
  final String fromSymbol;
  final String toSymbol;
  final String amount;
  final String dex;
  final String recipient;
  final double slippage;

  const SwapFormState({
    required this.fromSymbol,
    required this.toSymbol,
    required this.amount,
    required this.dex,
    required this.recipient,
    required this.slippage,
  });

  SwapFormState copyWith({
    String? fromSymbol,
    String? toSymbol,
    String? amount,
    String? dex,
    String? recipient,
    double? slippage,
  }) {
    return SwapFormState(
      fromSymbol: fromSymbol ?? this.fromSymbol,
      toSymbol: toSymbol ?? this.toSymbol,
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
      fromSymbol: 'BTC',
      toSymbol: 'DCR',
      amount: '10',
      dex: 'PancakeSwap V3',
      recipient: '',
      slippage: 0.5,
    );
  }

  void setFrom(String symbol) => state = state.copyWith(fromSymbol: symbol);
  void setTo(String symbol) => state = state.copyWith(toSymbol: symbol);
  void setAmount(String amount) => state = state.copyWith(amount: amount);
  void setDex(String dex) => state = state.copyWith(dex: dex);
  void setRecipient(String recipient) =>
      state = state.copyWith(recipient: recipient);
  void setSlippage(double slippage) =>
      state = state.copyWith(slippage: slippage);

  void flip() {
    state = state.copyWith(
      fromSymbol: state.toSymbol,
      toSymbol: state.fromSymbol,
    );
  }
}

