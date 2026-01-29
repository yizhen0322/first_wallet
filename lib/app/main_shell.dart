import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../features/account/presentation/account_home_screen.dart';
import '../features/activity/presentation/activity_home_screen.dart';
import '../features/cards/presentation/cards_home_screen.dart';
import '../features/wallet/presentation/wallet_home_screen.dart';

final _tabIndexProvider = StateProvider<int>((ref) => 0); // default: Wallet

class MainShell extends ConsumerWidget {
  const MainShell({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final index = ref.watch(_tabIndexProvider);

    return Scaffold(
      body: IndexedStack(
        index: index,
        children: const [
          WalletHomeScreen(),
          ActivityHomeScreen(),
          CardsHomeScreen(),
          AccountHomeScreen(),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: index,
        onTap: (value) => ref.read(_tabIndexProvider.notifier).state = value,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.account_balance_wallet_outlined),
            label: 'Wallet',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.history),
            label: 'Activity',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.credit_card_outlined),
            label: 'Cards',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_outline),
            label: 'Account',
          ),
        ],
      ),
    );
  }
}
