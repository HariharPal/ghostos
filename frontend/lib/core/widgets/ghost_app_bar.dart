import 'package:flutter/material.dart';
import 'package:ghostos/core/constants/app_copy.dart';
import 'package:ghostos/core/theme/app_colors.dart';

class GhostAppBar extends StatelessWidget implements PreferredSizeWidget {
  const GhostAppBar({
    required this.planLabel,
    required this.onNotificationsTap,
    required this.onSearchTap,
    super.key,
  });

  final String planLabel;
  final VoidCallback onSearchTap;
  final VoidCallback onNotificationsTap;

  @override
  Size get preferredSize => const Size.fromHeight(88);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return AppBar(
      toolbarHeight: 88,
      leadingWidth: 82,
      leading: Padding(
        padding: const EdgeInsets.only(left: 18, top: 14, bottom: 14),
        child: Container(
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            gradient: const LinearGradient(
              colors: [AppColors.primary, Color(0xFFFF7B3D)],
            ),
            border: Border.all(color: Colors.white.withValues(alpha: 0.16)),
          ),
          child: const Icon(
            Icons.person_rounded,
            size: 20,
            color: Colors.white,
          ),
        ),
      ),
      title: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            AppCopy.appName,
            style: theme.textTheme.titleLarge?.copyWith(letterSpacing: -0.4),
          ),
          Text(
            AppCopy.tagline,
            style: theme.textTheme.labelSmall?.copyWith(
              color: AppColors.textSecondary,
              letterSpacing: 0.3,
            ),
          ),
        ],
      ),
      actions: [
        Container(
          margin: const EdgeInsets.symmetric(vertical: 18),
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 7),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(999),
            color: AppColors.primarySoft,
            border: Border.all(
              color: AppColors.primary.withValues(alpha: 0.35),
            ),
          ),
          child: Text(
            planLabel,
            style: theme.textTheme.labelMedium?.copyWith(
              fontWeight: FontWeight.w800,
              color: AppColors.primary,
            ),
          ),
        ),
        _ActionIconButton(
          icon: Icons.search_rounded,
          onTap: onSearchTap,
        ),
        Padding(
          padding: const EdgeInsets.only(right: 12),
          child: _ActionIconButton(
            icon: Icons.notifications_none_rounded,
            onTap: onNotificationsTap,
          ),
        ),
      ],
    );
  }
}

class _ActionIconButton extends StatelessWidget {
  const _ActionIconButton({
    required this.icon,
    required this.onTap,
  });

  final IconData icon;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 16, horizontal: 4),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.04),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.divider),
      ),
      child: IconButton(
        onPressed: onTap,
        icon: Icon(icon, size: 20),
      ),
    );
  }
}
