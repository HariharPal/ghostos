import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:ghostos/core/providers/app_settings_provider.dart';
import 'package:ghostos/core/theme/app_colors.dart';
import 'package:ghostos/core/widgets/glass_card.dart';
import 'package:ghostos/core/widgets/section_header.dart';
import 'package:ghostos/features/auth/presentation/providers/auth_controller.dart';

class SettingsScreen extends ConsumerWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final settings = ref.watch(appSettingsProvider);
    final controller = ref.read(appSettingsProvider.notifier);

    Future<void> confirmAction({
      required String title,
      required String message,
      required Future<void> Function() onConfirm,
      bool isDestructive = false,
    }) async {
      final shouldProceed = await showDialog<bool>(
        context: context,
        builder: (dialogContext) {
          return AlertDialog(
            title: Text(title),
            content: Text(message),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(dialogContext).pop(false),
                child: const Text('Cancel'),
              ),
              FilledButton(
                style: FilledButton.styleFrom(
                  backgroundColor:
                      isDestructive ? AppColors.danger : AppColors.primary,
                ),
                onPressed: () => Navigator.of(dialogContext).pop(true),
                child: Text(isDestructive ? 'Delete' : 'Confirm'),
              ),
            ],
          );
        },
      );

      if (shouldProceed == true) {
        await onConfirm();
      }
    }

    return Scaffold(
      appBar: AppBar(title: const Text('Settings')),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.fromLTRB(20, 8, 20, 28),
          children: [
            const SectionHeader(
              title: 'Appearance',
              subtitle:
                  'Theme changes apply instantly and persist locally, with dark mode as the first-run default.',
            ),
            const SizedBox(height: 16),
            GlassCard(
              child: Column(
                children: [
                  _ThemeModeTile(
                    title: 'Dark Mode',
                    subtitle: 'High-contrast premium dashboard experience.',
                    value: ThemeMode.dark,
                    groupValue: settings.themeMode,
                    onChanged: controller.setThemeMode,
                  ),
                  const Divider(height: 1),
                  _ThemeModeTile(
                    title: 'Light Mode',
                    subtitle: 'Warm neutral surfaces for daylight use.',
                    value: ThemeMode.light,
                    groupValue: settings.themeMode,
                    onChanged: controller.setThemeMode,
                  ),
                  const Divider(height: 1),
                  _ThemeModeTile(
                    title: 'System Theme',
                    subtitle: 'Follow the device appearance automatically.',
                    value: ThemeMode.system,
                    groupValue: settings.themeMode,
                    onChanged: controller.setThemeMode,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),
            const SectionHeader(
              title: 'Notifications',
              subtitle:
                  'Fine-tune the reminders and progress signals your ghost can send throughout the day.',
            ),
            const SizedBox(height: 16),
            GlassCard(
              child: Column(
                children: [
                  SwitchListTile.adaptive(
                    value: settings.notificationsEnabled,
                    onChanged: controller.setNotificationsEnabled,
                    title: const Text('All Notifications'),
                    subtitle: const Text('Master switch for every reminder and insight.'),
                    activeThumbColor: AppColors.primary,
                    contentPadding: EdgeInsets.zero,
                  ),
                  const Divider(height: 1),
                  SwitchListTile.adaptive(
                    value: settings.dailyReminders,
                    onChanged: settings.notificationsEnabled
                        ? controller.setDailyReminders
                        : null,
                    title: const Text('Daily Reminders'),
                    subtitle: const Text('Morning and evening habit nudges.'),
                    activeThumbColor: AppColors.primary,
                    contentPadding: EdgeInsets.zero,
                  ),
                  const Divider(height: 1),
                  SwitchListTile.adaptive(
                    value: settings.focusReminders,
                    onChanged: settings.notificationsEnabled
                        ? controller.setFocusReminders
                        : null,
                    title: const Text('Focus Reminders'),
                    subtitle: const Text('Prompts before deep work sessions and breaks.'),
                    activeThumbColor: AppColors.primary,
                    contentPadding: EdgeInsets.zero,
                  ),
                  const Divider(height: 1),
                  SwitchListTile.adaptive(
                    value: settings.achievementNotifications,
                    onChanged: settings.notificationsEnabled
                        ? controller.setAchievementNotifications
                        : null,
                    title: const Text('Achievement Notifications'),
                    subtitle: const Text('Celebrate streaks, XP milestones, and rewards.'),
                    activeThumbColor: AppColors.primary,
                    contentPadding: EdgeInsets.zero,
                  ),
                  const Divider(height: 1),
                  SwitchListTile.adaptive(
                    value: settings.generalNotifications,
                    onChanged: settings.notificationsEnabled
                        ? controller.setGeneralNotifications
                        : null,
                    title: const Text('General Notifications'),
                    subtitle: const Text('Product updates, AI suggestions, and app news.'),
                    activeThumbColor: AppColors.primary,
                    contentPadding: EdgeInsets.zero,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),
            const SectionHeader(
              title: 'Privacy & Account',
              subtitle:
                  'Sensitive actions are confirmation-protected so accidental changes do not disrupt your account.',
            ),
            const SizedBox(height: 16),
            GlassCard(
              child: Column(
                children: [
                  _ActionTile(
                    icon: Icons.lock_reset_rounded,
                    title: 'Change Password',
                    subtitle: 'Open the recovery flow using your current email.',
                    onTap: () => ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text(
                          'Password recovery will be connected to the Supabase reset flow next.',
                        ),
                      ),
                    ),
                  ),
                  const Divider(height: 1),
                  _ActionTile(
                    icon: Icons.logout_rounded,
                    title: 'Logout',
                    subtitle: 'Sign out from this device and return to the auth screen.',
                    onTap: () => confirmAction(
                      title: 'Logout',
                      message: 'Do you want to sign out of GhostOS on this device?',
                      onConfirm: () async {
                        await ref.read(authControllerProvider.notifier).signOut();
                        if (context.mounted) {
                          context.go('/auth');
                        }
                      },
                    ),
                  ),
                  const Divider(height: 1),
                  _ActionTile(
                    icon: Icons.delete_forever_rounded,
                    title: 'Delete Account',
                    subtitle:
                        'Requires secure server-side confirmation before permanent removal.',
                    iconColor: AppColors.danger,
                    titleColor: AppColors.danger,
                    onTap: () => confirmAction(
                      title: 'Delete Account',
                      message:
                          'This action is irreversible. For safety, the mobile build currently routes account deletion through a protected backend flow.',
                      isDestructive: true,
                      onConfirm: () async {
                        if (context.mounted) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text(
                                'Delete account confirmation captured. Wire the secure backend deletion endpoint next.',
                              ),
                            ),
                          );
                        }
                      },
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),
            const SectionHeader(
              title: 'About',
              subtitle:
                  'Key product references and support details stay visible in one tidy place.',
            ),
            const SizedBox(height: 16),
            GlassCard(
              child: Column(
                children: const [
                  _InfoRow(label: 'Version', value: '0.1.0+1'),
                  Divider(height: 1),
                  _InfoRow(label: 'Privacy Policy', value: 'ghostos.app/privacy'),
                  Divider(height: 1),
                  _InfoRow(label: 'Terms & Conditions', value: 'ghostos.app/terms'),
                  Divider(height: 1),
                  _InfoRow(label: 'GitHub', value: 'github.com/ghostos/app'),
                  Divider(height: 1),
                  _InfoRow(label: 'Support', value: 'support@ghostos.app'),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ThemeModeTile extends StatelessWidget {
  const _ThemeModeTile({
    required this.title,
    required this.subtitle,
    required this.value,
    required this.groupValue,
    required this.onChanged,
  });

  final String title;
  final String subtitle;
  final ThemeMode value;
  final ThemeMode groupValue;
  final ValueChanged<ThemeMode> onChanged;

  @override
  Widget build(BuildContext context) {
    return RadioListTile<ThemeMode>(
      value: value,
      groupValue: groupValue,
      activeColor: AppColors.primary,
      contentPadding: EdgeInsets.zero,
      title: Text(title),
      subtitle: Text(subtitle),
      onChanged: (selected) {
        if (selected != null) {
          onChanged(selected);
        }
      },
    );
  }
}

class _ActionTile extends StatelessWidget {
  const _ActionTile({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.onTap,
    this.iconColor = AppColors.primary,
    this.titleColor,
  });

  final IconData icon;
  final String title;
  final String subtitle;
  final VoidCallback onTap;
  final Color iconColor;
  final Color? titleColor;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      onTap: onTap,
      leading: Icon(icon, color: iconColor),
      title: Text(
        title,
        style: Theme.of(context).textTheme.titleMedium?.copyWith(
              color: titleColor,
            ),
      ),
      subtitle: Text(subtitle),
      trailing: const Icon(Icons.chevron_right_rounded),
    );
  }
}

class _InfoRow extends StatelessWidget {
  const _InfoRow({
    required this.label,
    required this.value,
  });

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 14),
      child: Row(
        children: [
          Expanded(
            child: Text(
              label,
              style: Theme.of(context).textTheme.titleMedium,
            ),
          ),
          const SizedBox(width: 16),
          Flexible(
            child: Text(
              value,
              textAlign: TextAlign.right,
              style: Theme.of(context).textTheme.bodyMedium,
            ),
          ),
        ],
      ),
    );
  }
}
