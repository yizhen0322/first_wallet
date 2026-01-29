import 'package:flutter/material.dart';

import '../../../app/router.dart';

class SupportCenterScreen extends StatelessWidget {
  const SupportCenterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Support Center')),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(20),
          children: [
            _Item(
              title: 'Crypto Wallet',
              onTap: () {},
            ),
            _Item(
              title: 'Card Settings',
              onTap: () {},
            ),
            _Item(
              title: 'Contact Us',
              onTap: () => Navigator.of(context).pushNamed(AppRoutes.contactUs),
            ),
            _Item(
              title: 'Wallet Connect',
              onTap: () => Navigator.of(context).pushNamed(AppRoutes.walletConnect),
            ),
            _Item(
              title: 'My Contacts',
              onTap: () => Navigator.of(context).pushNamed(AppRoutes.contacts),
            ),
          ],
        ),
      ),
    );
  }
}

class _Item extends StatelessWidget {
  const _Item({required this.title, required this.onTap});

  final String title;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      shape: RoundedRectangleBorder(
        side: BorderSide(color: Theme.of(context).dividerColor),
        borderRadius: BorderRadius.circular(16),
      ),
      child: ListTile(
        title: Text(title),
        trailing: const Icon(Icons.chevron_right),
        onTap: onTap,
      ),
    );
  }
}

