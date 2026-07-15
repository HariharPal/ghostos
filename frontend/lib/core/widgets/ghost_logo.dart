import 'package:flutter/material.dart';
import 'package:ghostos/core/constants/app_assets.dart';

class GhostLogo extends StatelessWidget {
  const GhostLogo({
    super.key,
    this.size = 44,
    this.padding = 6,
    this.backgroundColor,
  });

  final double size;
  final double padding;
  final Color? backgroundColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      padding: EdgeInsets.all(padding),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: backgroundColor ?? Colors.white.withValues(alpha: 0.04),
      ),
      child: ClipOval(
        child: Image.asset(
          AppAssets.applicationLogo,
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
