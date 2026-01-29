import 'dart:async';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../shared/contracts/app_contracts.dart';
import '../features/auth/data/mock_auth_repository.dart';
import '../features/account/data/mock_account_repository.dart';
import '../features/swap/data/mock_swap_repository.dart';
import '../features/wallet/data/evm_chain_repo_impl.dart';
import '../features/wallet/data/mock_evm_chain_repository.dart';
import '../features/wallet/data/wallet_engine_impl.dart';
import '../features/wallet/data/wallet_repository_impl.dart';
import '../app/app.dart';

Future<void> bootstrap() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Firebase is optional in dev until FlutterFire is configured, but Crashlytics
  // is required in production. We "best-effort" init here.
  final bool firebaseReady = await _tryInitFirebase();
  final bool crashlyticsSupported = !kIsWeb &&
      (defaultTargetPlatform == TargetPlatform.android ||
          defaultTargetPlatform == TargetPlatform.iOS ||
          defaultTargetPlatform == TargetPlatform.macOS);
  if (firebaseReady && crashlyticsSupported) {
    FlutterError.onError = FirebaseCrashlytics.instance.recordFlutterFatalError;
    PlatformDispatcher.instance.onError = (error, stack) {
      FirebaseCrashlytics.instance.recordError(error, stack, fatal: true);
      return true;
    };
  }

  runApp(
    ProviderScope(
      overrides: [
        // Keep contracts.dart providers intact; app wires implementations here.
        authRepositoryProvider.overrideWith((ref) => MockAuthRepository(ref)),
        accountRepositoryProvider
            .overrideWith((ref) => MockAccountRepository()),
        swapRepositoryProvider.overrideWith((ref) => MockSwapRepository()),
        evmChainRepositoryProvider.overrideWith((ref) {
          final network = ref.watch(selectedNetworkProvider);
          final rpcUrl = network.rpcUrl.trim();
          if (rpcUrl.isEmpty) return MockEvmChainRepository();

          if (kDebugMode) {
            final uri = Uri.tryParse(rpcUrl);
            // ignore: avoid_print
            print('EVM RPC: ${uri?.host ?? 'unknown'}');
          }

          final repo = EvmChainRepositoryImpl(rpcUrl: rpcUrl);
          ref.onDispose(repo.dispose);
          return repo;
        }),
        walletEngineProvider.overrideWith((ref) => WalletEngineImpl()),
        walletRepositoryProvider.overrideWith((ref) => WalletRepositoryImpl()),
      ],
      child: const FirstWalletApp(),
    ),
  );
}

Future<bool> _tryInitFirebase() async {
  try {
    await Firebase.initializeApp();
    return true;
  } catch (e) {
    // Ignore in dev if Firebase isn't configured yet (no firebase_options.dart).
    if (kDebugMode) {
      // ignore: avoid_print
      print('Firebase.initializeApp skipped: $e');
    }
    return false;
  }
}
