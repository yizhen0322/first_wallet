import 'package:flutter/material.dart';

class SupportRequestSentScreen extends StatelessWidget {
  const SupportRequestSentScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Spacer(),
              Icon(Icons.mark_email_read_outlined,
                  size: 64, color: Theme.of(context).colorScheme.primary),
              const SizedBox(height: 14),
              Text(
                'We will get back to you soon',
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.titleLarge,
              ),
              const Spacer(),
              FilledButton(
                onPressed: () => Navigator.of(context).popUntil((r) => r.isFirst),
                child: const Text('Done'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

