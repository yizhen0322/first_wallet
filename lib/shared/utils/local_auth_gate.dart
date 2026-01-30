import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:local_auth/local_auth.dart';

/// Best-effort device authentication helper.
///
/// - Returns `true` when authentication succeeds.
/// - Returns `false` when user cancels/denies.
/// - Returns `true` when LocalAuth is unavailable (e.g. in Flutter tests or on
///   platforms without plugins) so we don't block dev/test flows.
class LocalAuthGate {
  static final _auth = LocalAuthentication();

  static bool get _isTestBinding {
    try {
      final name = WidgetsBinding.instance.runtimeType.toString();
      return name.contains('TestWidgetsFlutterBinding');
    } catch (_) {
      return false;
    }
  }

  static Future<bool> isAvailable() async {
    if (kIsWeb || _isTestBinding) return false;
    try {
      return await _auth.isDeviceSupported();
    } catch (_) {
      return false;
    }
  }

  static Future<bool> authenticate({
    required String reason,
  }) async {
    if (kIsWeb || _isTestBinding) return true;

    try {
      final supported = await _auth.isDeviceSupported();
      if (!supported) return true;

      final canCheck = await _auth.canCheckBiometrics;
      // Even if biometrics is unavailable, device PIN/passcode may still work.
      // `authenticate` will handle that depending on OS.
      if (!canCheck) {
        // Still try; if plugin throws, we fall back to allow.
      }

      return await _auth.authenticate(
        localizedReason: reason,
        options: const AuthenticationOptions(
          biometricOnly: false,
          stickyAuth: true,
        ),
      );
    } catch (_) {
      // MissingPluginException etc. (common in tests) -> don't block.
      return true;
    }
  }
}
