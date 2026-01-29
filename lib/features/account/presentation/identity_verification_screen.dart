import 'package:flutter/material.dart';

class IdentityVerificationScreen extends StatefulWidget {
  const IdentityVerificationScreen({super.key});

  @override
  State<IdentityVerificationScreen> createState() =>
      _IdentityVerificationScreenState();
}

class _IdentityVerificationScreenState extends State<IdentityVerificationScreen> {
  final _firstCtrl = TextEditingController();
  final _lastCtrl = TextEditingController();
  final _countryCtrl = TextEditingController();
  DateTime? _dob;
  String _gender = 'Male';

  @override
  void dispose() {
    _firstCtrl.dispose();
    _lastCtrl.dispose();
    _countryCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Identity Verification')),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(20),
          children: [
            TextField(
              controller: _firstCtrl,
              decoration: const InputDecoration(labelText: 'Firstname'),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: _lastCtrl,
              decoration: const InputDecoration(labelText: 'Lastname'),
            ),
            const SizedBox(height: 12),
            DropdownButtonFormField<String>(
              value: _gender,
              items: const [
                DropdownMenuItem(value: 'Male', child: Text('Male')),
                DropdownMenuItem(value: 'Female', child: Text('Female')),
                DropdownMenuItem(value: 'Other', child: Text('Other')),
              ],
              onChanged: (v) => setState(() => _gender = v ?? _gender),
              decoration: const InputDecoration(labelText: 'Gender'),
            ),
            const SizedBox(height: 12),
            ListTile(
              contentPadding: EdgeInsets.zero,
              title: const Text('Date of Birth'),
              subtitle: Text(_dob == null
                  ? 'Select'
                  : '${_dob!.year}-${_dob!.month.toString().padLeft(2, '0')}-${_dob!.day.toString().padLeft(2, '0')}'),
              trailing: const Icon(Icons.calendar_month_outlined),
              onTap: () async {
                final now = DateTime.now();
                final picked = await showDatePicker(
                  context: context,
                  firstDate: DateTime(now.year - 100),
                  lastDate: now,
                  initialDate: DateTime(now.year - 18, now.month, now.day),
                );
                if (picked != null) {
                  setState(() => _dob = picked);
                }
              },
            ),
            const SizedBox(height: 12),
            TextField(
              controller: _countryCtrl,
              decoration: const InputDecoration(labelText: 'Country'),
            ),
            const SizedBox(height: 18),
            FilledButton(
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Submitted (mock)')),
                );
                Navigator.of(context).pop();
              },
              child: const Text('Submit'),
            ),
          ],
        ),
      ),
    );
  }
}

