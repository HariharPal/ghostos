import 'package:flutter/material.dart';
import 'package:ghostos/core/theme/app_colors.dart';

class SectionHeader extends StatelessWidget {
  const SectionHeader({
    required this.title,
    required this.subtitle,
    super.key,
    this.actionLabel,
  });

  final String title;
  final String subtitle;
  final String? actionLabel;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title, style: theme.textTheme.titleLarge),
              const SizedBox(height: 4),
              Text(
                subtitle,
                style: theme.textTheme.bodySmall?.copyWith(
                  color: AppColors.textSecondary,
                ),
              ),
            ],
          ),
        ),
        if (actionLabel != null)
          Padding(
            padding: const EdgeInsets.only(top: 6),
            child: Text(
              actionLabel!,
              style: theme.textTheme.labelLarge?.copyWith(
                color: AppColors.primary,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
      ],
    );
  }
}
