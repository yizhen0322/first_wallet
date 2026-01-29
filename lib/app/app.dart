import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../app/app_lifecycle_guard.dart';
import '../app/main_shell.dart';
import '../app/router.dart';
import '../features/auth/presentation/auth_landing_screen.dart';
import '../shared/contracts/app_contracts.dart';
import '../shared/theme/app_theme.dart';

class FirstWalletApp extends ConsumerWidget {
  const FirstWalletApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return MaterialApp(
      title: 'PAVILION',
      theme: AppTheme.dark(),
      debugShowCheckedModeBanner: false,
      onGenerateRoute: AppRouter.onGenerateRoute,
      builder: (context, child) {
        // On web/desktop, constrain to a phone-like width so the UI matches the
        // mobile Figma designs more closely.
        return ColoredBox(
          color: AppColors.background,
          child: Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 420),
              child: child ?? const SizedBox.shrink(),
            ),
          ),
        );
      },
      home: const AppLifecycleGuard(child: _AuthGate()),
    );
  }
}

class _AuthGate extends ConsumerWidget {
  const _AuthGate();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final session = ref.watch(authSessionProvider);
    if (session.isLoggedIn) {
      return const MainShell();
    }
    return const AuthLandingScreen();
  }
}
