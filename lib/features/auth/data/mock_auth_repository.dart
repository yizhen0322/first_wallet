import 'dart:math';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../shared/contracts/app_contracts.dart';

class MockAuthRepository implements AuthRepository {
  MockAuthRepository(this._ref);

  final Ref _ref;

  @override
  Future<AuthResponse> register({
    required String email,
    required String password,
    required String deviceId,
  }) async {
    await Future<void>.delayed(const Duration(milliseconds: 600));
    return AuthResponse(
      accessToken: _token('access'),
      refreshToken: _token('refresh'),
      user: UserSummary(id: _id(), email: email),
    );
  }

  @override
  Future<AuthResponse> login({
    required String email,
    required String password,
    required String deviceId,
  }) async {
    await Future<void>.delayed(const Duration(milliseconds: 500));

    // Minimal fake validation for demo purposes.
    if (password.length < 6) {
      throw Exception('Invalid credentials');
    }

    return AuthResponse(
      accessToken: _token('access'),
      refreshToken: _token('refresh'),
      user: UserSummary(id: _id(), email: email),
    );
  }

  @override
  Future<AuthTokens> refresh({
    required String refreshToken,
    required String deviceId,
  }) async {
    await Future<void>.delayed(const Duration(milliseconds: 300));
    return AuthTokens(
      accessToken: _token('access'),
      refreshToken: refreshToken,
    );
  }

  @override
  Future<void> logout({
    required String refreshToken,
    required String deviceId,
  }) async {
    await Future<void>.delayed(const Duration(milliseconds: 250));
    // no-op
  }

  String _id() => Random().nextInt(999999).toString();

  String _token(String prefix) {
    final env = _ref.read(envProvider);
    return '$prefix.${env.deviceId}.${DateTime.now().millisecondsSinceEpoch}';
  }
}

