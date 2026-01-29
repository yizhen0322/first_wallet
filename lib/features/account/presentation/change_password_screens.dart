import 'package:flutter/material.dart';

import '../../../app/router.dart';

class ChangePasswordScreen extends StatefulWidget {
  const ChangePasswordScreen({super.key});

  @override
  State<ChangePasswordScreen> createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {
  final _currentCtrl = TextEditingController();

  @override
  void dispose() {
    _currentCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Change Password')),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(20),
          children: [
            const Text('Current Password'),
            const SizedBox(height: 12),
            TextField(
              controller: _currentCtrl,
              obscureText: true,
              decoration: const InputDecoration(),
            ),
            const SizedBox(height: 18),
            FilledButton(
              onPressed: () =>
                  Navigator.of(context).pushNamed(AppRoutes.changePasswordNew),
              child: const Text('Next'),
            ),
          ],
        ),
      ),
    );
  }
}

class NewPasswordScreen extends StatefulWidget {
  const NewPasswordScreen({super.key});

  @override
  State<NewPasswordScreen> createState() => _NewPasswordScreenState();
}

class _NewPasswordScreenState extends State<NewPasswordScreen> {
  final _newCtrl = TextEditingController();
  final _confirmCtrl = TextEditingController();

  @override
  void dispose() {
    _newCtrl.dispose();
    _confirmCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Change Password')),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(20),
          children: [
            const Text('New Password'),
            const SizedBox(height: 12),
            TextField(
              controller: _newCtrl,
              obscureText: true,
              decoration: const InputDecoration(),
            ),
            const SizedBox(height: 12),
            const Text('Confirm New Password'),
            const SizedBox(height: 12),
            TextField(
              controller: _confirmCtrl,
              obscureText: true,
              decoration: const InputDecoration(),
            ),
            const SizedBox(height: 18),
            FilledButton(
              onPressed: () =>
                  Navigator.of(context).pushNamed(AppRoutes.changePasswordDone),
              child: const Text('Next'),
            ),
          ],
        ),
      ),
    );
  }
}

class PasswordChangedScreen extends StatelessWidget {
  const PasswordChangedScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Change Password')),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Spacer(),
              Icon(Icons.check_circle, size: 64, color: Theme.of(context).colorScheme.primary),
              const SizedBox(height: 12),
              Text(
                'Password changed',
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

