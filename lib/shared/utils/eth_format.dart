import 'dart:math';

BigInt parseEthToWei(String input) {
  final raw = input.trim();
  if (raw.isEmpty) throw const FormatException('Amount is empty');

  final normalized = raw.replaceAll(',', '');
  final parts = normalized.split('.');
  if (parts.length > 2) throw const FormatException('Invalid amount format');

  final wholePart = parts[0].isEmpty ? '0' : parts[0];
  final fracPart = parts.length == 2 ? parts[1] : '';

  if (!RegExp(r'^\d+$').hasMatch(wholePart)) {
    throw const FormatException('Invalid amount');
  }
  if (fracPart.isNotEmpty && !RegExp(r'^\d+$').hasMatch(fracPart)) {
    throw const FormatException('Invalid amount');
  }
  if (fracPart.length > 18) {
    throw const FormatException('Too many decimals (max 18)');
  }

  final wholeWei = BigInt.parse(wholePart) * BigInt.from(10).pow(18);
  final fracWei = fracPart.isEmpty
      ? BigInt.zero
      : BigInt.parse(fracPart.padRight(18, '0'));

  return wholeWei + fracWei;
}

String formatWeiToEth(
  BigInt wei, {
  int maxFractionDigits = 6,
}) {
  if (wei == BigInt.zero) return '0';

  final divisor = BigInt.from(10).pow(18);
  final whole = wei ~/ divisor;
  final fraction = (wei % divisor).abs().toString().padLeft(18, '0');

  final digits = max(0, min(18, maxFractionDigits));
  if (digits == 0) return whole.toString();

  var frac = fraction.substring(0, digits);
  frac = frac.replaceFirst(RegExp(r'0+$'), '');
  if (frac.isEmpty) return whole.toString();

  return '${whole.toString()}.$frac';
}

