import 'package:flutter/material.dart';

import '../../../app/router.dart';

class ChangeEmailScreen extends StatefulWidget {
  const ChangeEmailScreen({super.key});

  @override
  State<ChangeEmailScreen> createState() => _ChangeEmailScreenState();
}

class _ChangeEmailScreenState extends State<ChangeEmailScreen> {
  final _currentCtrl = TextEditingController();

  @override
  void dispose() {
    _currentCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Change Email')),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(20),
          children: [
            const Text('Confirm Current Email'),
            const SizedBox(height: 12),
            TextField(
              controller: _currentCtrl,
              keyboardType: TextInputType.emailAddress,
              decoration: const InputDecoration(
                hintText: 'muhammad.syamil@fpgberhad.com',
              ),
            ),
            const SizedBox(height: 18),
            FilledButton(
              onPressed: () =>
                  Navigator.of(context).pushNamed(AppRoutes.changeEmailVerify),
              child: const Text('Next'),
            ),
          ],
        ),
      ),
    );
  }
}

class VerifyNewEmailScreen extends StatefulWidget {
  const VerifyNewEmailScreen({super.key});

  @override
  State<VerifyNewEmailScreen> createState() => _VerifyNewEmailScreenState();
}

class _VerifyNewEmailScreenState extends State<VerifyNewEmailScreen> {
  final _newCtrl = TextEditingController();
  final _confirmCtrl = TextEditingController();
  final _codeCtrl = TextEditingController();

  @override
  void dispose() {
    _newCtrl.dispose();
    _confirmCtrl.dispose();
    _codeCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Change Email')),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(20),
          children: [
            const Text('New Email'),
            const SizedBox(height: 12),
            TextField(
              controller: _newCtrl,
              keyboardType: TextInputType.emailAddress,
              decoration: const InputDecoration(),
            ),
            const SizedBox(height: 12),
            const Text('Confirm New Email'),
            const SizedBox(height: 12),
            TextField(
              controller: _confirmCtrl,
              keyboardType: TextInputType.emailAddress,
              decoration: const InputDecoration(),
            ),
            const SizedBox(height: 12),
            Text(
              'Enter the 6-digit code sent to mu********@fpgberhad.com',
              style: Theme.of(context).textTheme.bodySmall,
            ),
            const SizedBox(height: 12),
            TextField(
              controller: _codeCtrl,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(hintText: '123456'),
            ),
            const SizedBox(height: 18),
            FilledButton(
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Email updated (mock)')),
                );
                Navigator.of(context).popUntil((r) => r.isFirst);
              },
              child: const Text('Next'),
            ),
          ],
        ),
      ),
    );
  }
}

