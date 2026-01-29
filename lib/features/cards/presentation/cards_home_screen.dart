import 'package:flutter/material.dart';

import '../../../app/router.dart';

class CardsHomeScreen extends StatelessWidget {
  const CardsHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Cards')),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(20),
          children: [
            _Item(
              title: 'Order a Card',
              onTap: () => Navigator.of(context).pushNamed(AppRoutes.securityChecklist),
            ),
            _Item(title: 'Card Control', onTap: () {}),
            _Item(title: 'Card label', onTap: () {}),
            _Item(title: 'Spending limit', onTap: () {}),
            _Item(title: 'Replace Card', onTap: () {}),
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

