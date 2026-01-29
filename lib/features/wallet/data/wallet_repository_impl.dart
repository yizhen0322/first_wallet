import 'dart:convert';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../../../shared/contracts/app_contracts.dart';

class WalletRepositoryImpl implements WalletRepository {
  final FlutterSecureStorage _storage;

  WalletRepositoryImpl({FlutterSecureStorage? storage})
      : _storage = storage ?? const FlutterSecureStorage();

  static const _kWalletsIndexKey = 'wallets_index';
  static const _kMnemonicPrefix = 'wallet_mnemonic_';
  static const _kWatchAddressPrefix = 'wallet_watch_address_';

  @override
  Future<void> saveWallet({
    required String id,
    required String name,
    String? mnemonic,
    required int wordCount,
    required bool usePassphrase,
    bool? backupRequired,
    String? watchAddress,
  }) async {
    // 1. Get existing list
    final wallets = await listWallets();

    // 2. Add new wallet metadata
    final isWatchOnly = mnemonic == null || mnemonic.trim().isEmpty;
    final label = isWatchOnly
        ? 'Watch'
        : (usePassphrase
            ? '$wordCount words with passphrase'
            : '$wordCount words');
    final needsBackup = backupRequired ?? !isWatchOnly;

    final newWallet = WalletSummary(
      id: id,
      name: name,
      backupLabel: label,
      backupRequired: needsBackup,
    );

    // Check if exists/update
    final index = wallets.indexWhere((w) => w.id == id);
    if (index >= 0) {
      wallets[index] = newWallet;
    } else {
      wallets.add(newWallet);
    }

    // 3. Save updated list
    await _storage.write(
      key: _kWalletsIndexKey,
      value: jsonEncode(wallets.map((e) => e.toJson()).toList()),
    );

    // 4. Save mnemonic only when provided.
    if (mnemonic != null && mnemonic.trim().isNotEmpty) {
      await _storage.write(
        key: '$_kMnemonicPrefix$id',
        value: mnemonic,
      );
    } else {
      // Ensure no stale entry remains (e.g. updating wallet type).
      await _storage.delete(key: '$_kMnemonicPrefix$id');
    }

    // 5. Save watch address if provided (for watch-only wallets)
    if (watchAddress != null && watchAddress.trim().isNotEmpty) {
      await _storage.write(
        key: '$_kWatchAddressPrefix$id',
        value: watchAddress,
      );
    } else {
      // Ensure no stale entry remains (e.g. updating wallet type).
      await _storage.delete(key: '$_kWatchAddressPrefix$id');
    }
  }

  @override
  Future<List<WalletSummary>> listWallets() async {
    final jsonStr = await _storage.read(key: _kWalletsIndexKey);
    if (jsonStr == null) return [];

    try {
      final List<dynamic> jsonList = jsonDecode(jsonStr);
      return jsonList.map((e) => WalletSummary.fromJson(e)).toList();
    } catch (e) {
      // Return empty if corrupted
      return [];
    }
  }

  @override
  Future<String?> getMnemonic(String id) async {
    return _storage.read(key: '$_kMnemonicPrefix$id');
  }

  /// Get the watch address for a watch-only wallet.
  @override
  Future<String?> getWatchAddress(String id) async {
    return _storage.read(key: '$_kWatchAddressPrefix$id');
  }

  @override
  Future<void> deleteWallet(String id) async {
    // 1. Remove from list
    final wallets = await listWallets();
    wallets.removeWhere((w) => w.id == id);

    // 2. Save list
    await _storage.write(
      key: _kWalletsIndexKey,
      value: jsonEncode(wallets.map((e) => e.toJson()).toList()),
    );

    // 3. Delete mnemonic
    await _storage.delete(key: '$_kMnemonicPrefix$id');

    // 4. Delete watch address
    await _storage.delete(key: '$_kWatchAddressPrefix$id');
  }
}
