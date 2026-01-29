import 'package:flutter/material.dart';

class WalletConnectScreen extends StatelessWidget {
  const WalletConnectScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Wallet Connect')),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              FilledButton(
                onPressed: () {},
                child: const Text('New Connection'),
              ),
              const SizedBox(height: 18),
              Expanded(
                child: Center(
                  child: Text(
                    'You don’t have any connected dapps',
                    style: Theme.of(context).textTheme.bodyMedium,
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

