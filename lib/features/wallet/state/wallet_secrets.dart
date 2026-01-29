import 'package:flutter_riverpod/flutter_riverpod.dart';

/// In-memory only (dev). In production, store secrets in secure storage.
final currentMnemonicProvider = StateProvider<String?>((ref) => null);

/// Backwards-compatible alias (older code uses this name).
@Deprecated('Use currentMnemonicProvider')
final walletMnemonicProvider = currentMnemonicProvider;
