import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

enum LocalTxStatus { pending, success, failed }

@immutable
class LocalTxEntry {
  const LocalTxEntry({
    required this.hash,
    required this.chainId,
    required this.from,
    required this.to,
    required this.valueWei,
    required this.createdAt,
    required this.status,
  });

  final String hash;
  final int chainId;
  final String from;
  final String to;
  final String valueWei;
  final DateTime createdAt;
  final LocalTxStatus status;

  Map<String, dynamic> toJson() => <String, dynamic>{
        'hash': hash,
        'chainId': chainId,
        'from': from,
        'to': to,
        'valueWei': valueWei,
        'createdAt': createdAt.toIso8601String(),
        'status': status.name,
      };

  factory LocalTxEntry.fromJson(Map<String, dynamic> json) => LocalTxEntry(
        hash: (json['hash'] as String?) ?? '',
        chainId: (json['chainId'] as num?)?.toInt() ?? 0,
        from: (json['from'] as String?) ?? '',
        to: (json['to'] as String?) ?? '',
        valueWei: (json['valueWei'] as String?) ?? '0',
        createdAt: DateTime.tryParse((json['createdAt'] as String?) ?? '') ??
            DateTime.fromMillisecondsSinceEpoch(0),
        status: LocalTxStatus.values.firstWhere(
          (e) => e.name == (json['status'] as String?),
          orElse: () => LocalTxStatus.pending,
        ),
      );
}

/// Stores a minimal local tx list so Activity works without a chain indexer.
///
/// Uses secure storage (non-secret data, but plugin is already in the app).
/// Falls back to in-memory storage if plugin is unavailable (tests).
class LocalTxStore {
  LocalTxStore()
      : _storage = const FlutterSecureStorage(
          aOptions: AndroidOptions(encryptedSharedPreferences: true),
        );

  final FlutterSecureStorage _storage;

  static final Map<String, String> _memory = <String, String>{};

  String _key({
    required int chainId,
    required String address,
  }) =>
      'txlog:$chainId:${address.toLowerCase()}';

  Future<List<LocalTxEntry>> list({
    required int chainId,
    required String address,
  }) async {
    final k = _key(chainId: chainId, address: address);
    final raw = await _read(k);
    if (raw == null || raw.isEmpty) return <LocalTxEntry>[];
    try {
      final decoded = jsonDecode(raw);
      if (decoded is! List) return <LocalTxEntry>[];
      return decoded
          .whereType<Map>()
          .map((e) => LocalTxEntry.fromJson(Map<String, dynamic>.from(e)))
          .where((e) => e.hash.isNotEmpty)
          .toList()
        ..sort((a, b) => b.createdAt.compareTo(a.createdAt));
    } catch (_) {
      return <LocalTxEntry>[];
    }
  }

  Future<void> addOutgoing({
    required int chainId,
    required String from,
    required String to,
    required String hash,
    required String valueWei,
  }) async {
    if (hash.isEmpty) return;
    final list = await this.list(chainId: chainId, address: from);
    if (list.any((e) => e.hash.toLowerCase() == hash.toLowerCase())) return;

    final next = <LocalTxEntry>[
      LocalTxEntry(
        hash: hash,
        chainId: chainId,
        from: from,
        to: to,
        valueWei: valueWei,
        createdAt: DateTime.now(),
        status: LocalTxStatus.pending,
      ),
      ...list,
    ];

    await _write(
      _key(chainId: chainId, address: from),
      jsonEncode(next.map((e) => e.toJson()).toList()),
    );
  }

  Future<void> markStatus({
    required int chainId,
    required String address,
    required String hash,
    required LocalTxStatus status,
  }) async {
    if (hash.isEmpty) return;
    final list = await this.list(chainId: chainId, address: address);
    var changed = false;

    final next = list.map((e) {
      if (e.hash.toLowerCase() != hash.toLowerCase()) return e;
      if (e.status == status) return e;
      changed = true;
      return LocalTxEntry(
        hash: e.hash,
        chainId: e.chainId,
        from: e.from,
        to: e.to,
        valueWei: e.valueWei,
        createdAt: e.createdAt,
        status: status,
      );
    }).toList();

    if (!changed) return;

    await _write(
      _key(chainId: chainId, address: address),
      jsonEncode(next.map((e) => e.toJson()).toList()),
    );
  }

  Future<String?> _read(String key) async {
    if (kIsWeb) return _memory[key];
    try {
      return await _storage.read(key: key);
    } catch (_) {
      return _memory[key];
    }
  }

  Future<void> _write(String key, String value) async {
    if (kIsWeb) {
      _memory[key] = value;
      return;
    }
    try {
      await _storage.write(key: key, value: value);
    } catch (_) {
      _memory[key] = value;
    }
  }
}

final localTxStoreProvider = Provider<LocalTxStore>((ref) => LocalTxStore());

