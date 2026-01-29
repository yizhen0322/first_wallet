import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../features/wallet/state/wallet_secrets.dart';

/// Clears sensitive in-memory secrets when the app goes to background.
class AppLifecycleGuard extends ConsumerStatefulWidget {
  const AppLifecycleGuard({super.key, required this.child});

  final Widget child;

  @override
  ConsumerState<AppLifecycleGuard> createState() => _AppLifecycleGuardState();
}

class _AppLifecycleGuardState extends ConsumerState<AppLifecycleGuard>
    with WidgetsBindingObserver {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    // Phase 2 hardening: drop mnemonic from memory when app is backgrounded.
    switch (state) {
      case AppLifecycleState.resumed:
        return;
      case AppLifecycleState.inactive:
      case AppLifecycleState.paused:
      case AppLifecycleState.detached:
      case AppLifecycleState.hidden:
        ref.read(currentMnemonicProvider.notifier).state = null;
    }
  }

  @override
  Widget build(BuildContext context) => widget.child;
}
