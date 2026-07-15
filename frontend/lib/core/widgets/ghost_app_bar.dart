import 'package:flutter/material.dart';
import 'package:ghostos/core/constants/app_copy.dart';
import 'package:ghostos/core/theme/app_colors.dart';
import 'package:ghostos/core/widgets/ghost_logo.dart';

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
  Size get preferredSize => const Size.fromHeight(76);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return AppBar(
      toolbarHeight: 76,
      automaticallyImplyLeading: false,
      titleSpacing: 20,
      title: Row(
        children: [
          const GhostLogo(
            size: 42,
            padding: 0,
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  AppCopy.appName,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: theme.textTheme.titleLarge?.copyWith(
                    letterSpacing: -0.5,
                    fontSize: 24,
                  ),
                ),
                Text(
                  AppCopy.tagline,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: theme.textTheme.labelSmall?.copyWith(
                    color: AppColors.textSecondary,
                    fontSize: 11,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      actions: [
        Padding(
          padding: const EdgeInsets.only(right: 8),
          child: _PlanBadge(label: planLabel),
        ),
        _ActionIconButton(
          icon: Icons.search_rounded,
          onTap: onSearchTap,
        ),
        Padding(
          padding: const EdgeInsets.only(right: 16),
          child: _ActionIconButton(
            icon: Icons.notifications_none_rounded,
            onTap: onNotificationsTap,
          ),
        ),
      ],
    );
  }
}

class _PlanBadge extends StatelessWidget {
  const _PlanBadge({required this.label});

  final String label;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(999),
        color: AppColors.primarySoft,
        border: Border.all(
          color: AppColors.primary.withValues(alpha: 0.3),
        ),
      ),
      child: Text(
        label,
        style: Theme.of(context).textTheme.labelMedium?.copyWith(
              color: AppColors.primary,
              fontWeight: FontWeight.w800,
            ),
      ),
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
      width: 46,
      height: 46,
      margin: const EdgeInsets.symmetric(vertical: 14, horizontal: 4),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.04),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.divider),
      ),
      child: IconButton(
        onPressed: onTap,
        padding: EdgeInsets.zero,
        icon: Icon(icon, size: 20),
      ),
    );
  }
}
