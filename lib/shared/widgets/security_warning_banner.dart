import 'package:flutter/material.dart';

import '../theme/app_theme.dart';

class SecurityWarningBanner extends StatelessWidget {
  const SecurityWarningBanner({
    super.key,
    required this.text,
  });

  final String text;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      decoration: BoxDecoration(
        color: AppColors.primary,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Text(
        text,
        style: const TextStyle(
          color: Color(0xFFD32F2F),
          fontSize: 14,
          fontWeight: FontWeight.w600,
          height: 1.4,
        ),
        textAlign: TextAlign.center,
      ),
    );
  }
}

