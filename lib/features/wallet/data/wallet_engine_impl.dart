import 'dart:typed_data';

import 'package:wallet/wallet.dart' as w;
import 'package:web3dart/crypto.dart';
import 'package:web3dart/web3dart.dart';

import '../../../shared/contracts/app_contracts.dart';

class WalletEngineImpl implements WalletEngine {
  @override
  Future<String> createMnemonic({int words = 12}) async {
    final strength = switch (words) {
      12 => 128,
      24 => 256,
      _ => throw ArgumentError('Only 12 or 24 words are supported'),
    };

    final phrase = w.generateMnemonic(strength: strength).join(' ');
    return phrase;
  }

  @override
  Future<String> deriveAddressFromMnemonic({
    required String mnemonic,
    String derivationPath = "m/44'/60'/0'/0/0",
  }) async {
    final words = mnemonic.trim().split(RegExp(r'\s+'));
    if (!w.validateMnemonic(words)) {
      throw ArgumentError('Invalid mnemonic');
    }

    final seed = w.mnemonicToSeed(words);
    final master = w.ExtendedPrivateKey.master(seed, w.xprv);
    final derived = master.forPath(derivationPath) as w.ExtendedPrivateKey;

    // Use web3dart for address derivation (more reliable)
    // derived.key is BigInt, convert to bytes then EthPrivateKey
    final privateKey = EthPrivateKey(_bigIntTo32Bytes(derived.key));
    return privateKey.address.hex;
  }

  @override
  Future<String> signEvmTx({
    required String mnemonic,
    required int chainId,
    required EvmTxRequest tx,
    required int nonce,
  }) async {
    final words = mnemonic.trim().split(RegExp(r'\s+'));
    if (!w.validateMnemonic(words)) {
      throw ArgumentError('Invalid mnemonic');
    }

    final seed = w.mnemonicToSeed(words);
    final master = w.ExtendedPrivateKey.master(seed, w.xprv);
    final derived = master.forPath("m/44'/60'/0'/0/0") as w.ExtendedPrivateKey;

    final cred = EthPrivateKey(_bigIntTo32Bytes(derived.key));

    final to = EthereumAddress.fromHex(tx.to);
    final data = _hexToBytes(tx.data);
    final valueWei = _parseBigInt(tx.value);
    final gasLimit = int.parse(tx.gasLimit);

    final Transaction transaction;
    if (tx.type == TxType.eip1559) {
      transaction = Transaction(
        to: to,
        data: data,
        value: EtherAmount.inWei(valueWei),
        nonce: nonce,
        maxGas: gasLimit,
        maxFeePerGas: EtherAmount.inWei(_parseBigInt(tx.maxFeePerGas ?? '0')),
        maxPriorityFeePerGas:
            EtherAmount.inWei(_parseBigInt(tx.maxPriorityFeePerGas ?? '0')),
      );
    } else {
      transaction = Transaction(
        to: to,
        data: data,
        value: EtherAmount.inWei(valueWei),
        nonce: nonce,
        maxGas: gasLimit,
        gasPrice: EtherAmount.inWei(_parseBigInt(tx.gasPrice ?? '0')),
      );
    }

    final signed = signTransactionRaw(transaction, cred, chainId: chainId);
    return bytesToHex(signed, include0x: true, padToEvenLength: true);
  }

  @override
  Future<String> getPrivateKey({
    required String mnemonic,
    String derivationPath = "m/44'/60'/0'/0/0",
  }) async {
    final words = mnemonic.trim().split(RegExp(r'\s+'));
    if (!w.validateMnemonic(words)) {
      throw ArgumentError('Invalid mnemonic');
    }

    final seed = w.mnemonicToSeed(words);
    final master = w.ExtendedPrivateKey.master(seed, w.xprv);
    final derived = master.forPath(derivationPath) as w.ExtendedPrivateKey;

    // The key in ExtendedPrivateKey is the BigInt private key
    final privateKeyBytes = _bigIntTo32Bytes(derived.key);
    return bytesToHex(privateKeyBytes, include0x: true);
  }

  @override
  Future<String> getExtendedPrivateKey({required String mnemonic}) async {
    final words = mnemonic.trim().split(RegExp(r'\s+'));
    if (!w.validateMnemonic(words)) {
      throw ArgumentError('Invalid mnemonic');
    }

    final seed = w.mnemonicToSeed(words);
    final master = w.ExtendedPrivateKey.master(seed, w.xprv);
    // BIP32 Root Key (Master Extended Private Key)
    return master.toString();
  }

  @override
  Future<String> getAccountExtendedPublicKey({required String mnemonic}) async {
    final words = mnemonic.trim().split(RegExp(r'\s+'));
    if (!w.validateMnemonic(words)) {
      throw ArgumentError('Invalid mnemonic');
    }

    final seed = w.mnemonicToSeed(words);
    final master = w.ExtendedPrivateKey.master(seed, w.xprv);

    // Derivation logic for Ethereum Account 0: m/44'/60'/0'
    // This gives us the extended private key for the account
    final accountKey = master.forPath("m/44'/60'/0'") as w.ExtendedPrivateKey;

    // To get xpub, we simply return the public version
    return accountKey.publicKey.toString();
  }

  Uint8List _bigIntTo32Bytes(BigInt value) {
    final bytes = intToBytes(value);
    if (bytes.length == 32) return bytes;
    if (bytes.length > 32) {
      return bytes.sublist(bytes.length - 32);
    }
    return Uint8List(32)..setRange(32 - bytes.length, 32, bytes);
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
