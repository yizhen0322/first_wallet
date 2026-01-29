import 'package:flutter/material.dart';

import '../../../app/router.dart';

class SecurityChecklistScreen extends StatefulWidget {
  const SecurityChecklistScreen({super.key});

  @override
  State<SecurityChecklistScreen> createState() => _SecurityChecklistScreenState();
}

class _SecurityChecklistScreenState extends State<SecurityChecklistScreen> {
  bool _email = false;
  bool _mobile = false;
  bool _identity = false;

  @override
  Widget build(BuildContext context) {
    final allDone = _email && _mobile && _identity;

    return Scaffold(
      appBar: AppBar(title: const Text('Security Certifications')),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(20),
          children: [
            Text(
              'Before purchasing a card, you need to complete the following security certifications',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(height: 14),
            _CheckItem(
              title: 'Bind Email',
              value: _email,
              onChanged: (v) => setState(() => _email = v),
              onTap: () => Navigator.of(context).pushNamed(AppRoutes.changeEmail),
            ),
            _CheckItem(
              title: 'Bind Mobile',
              value: _mobile,
              onChanged: (v) => setState(() => _mobile = v),
              onTap: () =>
                  Navigator.of(context).pushNamed(AppRoutes.phoneVerification),
            ),
            _CheckItem(
              title: 'Identity Verification',
              value: _identity,
              onChanged: (v) => setState(() => _identity = v),
              onTap: () => Navigator.of(context)
                  .pushNamed(AppRoutes.identityVerification),
            ),
            const SizedBox(height: 18),
            FilledButton(
              onPressed: allDone
                  ? () => Navigator.of(context).pushNamed(AppRoutes.orderCard)
                  : null,
              child: const Text('Continue'),
            ),
          ],
        ),
      ),
    );
  }
}

class _CheckItem extends StatelessWidget {
  const _CheckItem({
    required this.title,
    required this.value,
    required this.onChanged,
    required this.onTap,
  });

  final String title;
  final bool value;
  final ValueChanged<bool> onChanged;
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
        leading: Checkbox(
          value: value,
          onChanged: (v) => onChanged(v ?? false),
        ),
        title: Text(title),
        trailing: const Icon(Icons.chevron_right),
        onTap: onTap,
      ),
    );
  }
}
