import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../activity/data/token_balance_provider.dart';

@immutable
class SwapToken {
  final String address;
  final String symbol;
  final int decimals;
  final bool isNative;

  const SwapToken({
    required this.address,
    required this.symbol,
    required this.decimals,
    required this.isNative,
  });
}

const String kNativeTokenAddress = '0x0000000000000000000000000000000000000000';

const SwapToken kNativeEth = SwapToken(
  address: kNativeTokenAddress,
  symbol: 'ETH',
  decimals: 18,
  isNative: true,
);

final swapTokensProvider = FutureProvider.autoDispose<List<SwapToken>>((ref) async {
  final balances = await ref.watch(tokenBalanceProvider.future);
  final tokens = <SwapToken>[kNativeEth];

  final seen = <String>{kNativeTokenAddress.toLowerCase()};
  for (final t in balances) {
    final addr = t.contractAddress.trim();
    if (addr.isEmpty) continue;
    final key = addr.toLowerCase();
    if (seen.contains(key)) continue;
    seen.add(key);
    tokens.add(
      SwapToken(
        address: addr,
        symbol: t.symbol,
        decimals: t.decimals,
        isNative: false,
      ),
    );
  }

  return tokens;
});

