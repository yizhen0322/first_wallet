import 'package:flutter/material.dart';

import '../../../app/router.dart';

class OrderCardScreen extends StatefulWidget {
  const OrderCardScreen({super.key});

  @override
  State<OrderCardScreen> createState() => _OrderCardScreenState();
}

class _OrderCardScreenState extends State<OrderCardScreen> {
  String _type = 'Virtual';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Order a card')),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(20),
          children: [
            Text(
              '\$5.0',
              style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                    fontWeight: FontWeight.w800,
                  ),
            ),
            const SizedBox(height: 12),
            SegmentedButton<String>(
              segments: const [
                ButtonSegment(value: 'Virtual', label: Text('Virtual')),
                ButtonSegment(value: 'Physical', label: Text('Physical')),
              ],
              selected: {_type},
              onSelectionChanged: (v) =>
                  setState(() => _type = v.first),
            ),
            const SizedBox(height: 18),
            _InfoCard(
              title: 'Usage scenarios',
              body:
                  'Use your card for online payments and subscriptions. Physical cards may be used in-store.',
            ),
            const SizedBox(height: 12),
            _InfoCard(
              title: 'Payment for card issuance',
              body: 'Card issuance fee is charged once during ordering.',
            ),
            const SizedBox(height: 18),
            FilledButton(
              onPressed: () =>
                  Navigator.of(context).pushNamed(AppRoutes.supportRequestSent),
              child: Text('Order $_type Card'),
            ),
          ],
        ),
      ),
    );
  }
}

class _InfoCard extends StatelessWidget {
  const _InfoCard({required this.title, required this.body});

  final String title;
  final String body;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      shape: RoundedRectangleBorder(
        side: BorderSide(color: Theme.of(context).dividerColor),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title, style: Theme.of(context).textTheme.titleMedium),
            const SizedBox(height: 8),
            Text(body),
          ],
        ),
      ),
    );
  }
}
