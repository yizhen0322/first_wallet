import 'package:flutter/material.dart';

import '../theme/app_theme.dart';

class PavilionOutlinedCard extends StatelessWidget {
  const PavilionOutlinedCard({
    super.key,
    required this.child,
    this.padding = const EdgeInsets.all(16),
    this.backgroundColor = AppColors.background,
    this.borderRadius = 12,
    this.borderWidth = 1,
    this.borderColor = AppColors.primary,
    this.clipBehavior = Clip.none,
  });

  final Widget child;
  final EdgeInsetsGeometry padding;
  final Color backgroundColor;
  final double borderRadius;
  final double borderWidth;
  final Color borderColor;
  final Clip clipBehavior;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: padding,
      clipBehavior: clipBehavior,
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(borderRadius),
        border: Border.all(color: borderColor, width: borderWidth),
      ),
      child: child,
    );
  }
}

