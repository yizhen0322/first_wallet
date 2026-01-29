// ignore_for_file: avoid_print

import 'package:firstwallet/features/wallet/data/wallet_engine_impl.dart';

void main() async {
  print('--- Verifying WalletEngine ---');

  final engine = WalletEngineImpl();

  // 1. Create Mnemonic
  final mnemonic = await engine.createMnemonic();
  print('Mnemonic: $mnemonic');
  if (mnemonic.split(' ').length != 12) {
    print('FAIL: Mnemonic length is not 12 words');
    return;
  }

  // 2. Derive Address
  final address = await engine.deriveAddressFromMnemonic(mnemonic: mnemonic);
  print('Address: $address');
  if (!address.startsWith('0x') || address.length != 42) {
    print('FAIL: Invalid address format');
    return;
  }

  print('SUCCESS: Wallet generation verified.');
}
