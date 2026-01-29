import 'package:flutter/material.dart';

class BaseCurrencyScreen extends StatefulWidget {
  const BaseCurrencyScreen({super.key});

  @override
  State<BaseCurrencyScreen> createState() => _BaseCurrencyScreenState();
}

class _BaseCurrencyScreenState extends State<BaseCurrencyScreen> {
  String _selected = 'USD';

  @override
  Widget build(BuildContext context) {
    final currencies = const ['USD', 'MYR', 'SGD', 'EUR', 'GBP'];

    return Scaffold(
      appBar: AppBar(title: const Text('Base Currency')),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(20),
          children: [
            ...currencies.map(
              (c) => Card(
                elevation: 0,
                shape: RoundedRectangleBorder(
                  side: BorderSide(color: Theme.of(context).dividerColor),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: RadioListTile<String>(
                  value: c,
                  groupValue: _selected,
                  onChanged: (v) => setState(() => _selected = v ?? _selected),
                  title: Text(c),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

