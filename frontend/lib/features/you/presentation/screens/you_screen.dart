import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:ghostos/core/theme/app_colors.dart';
import 'package:ghostos/core/widgets/glass_card.dart';
import 'package:ghostos/core/widgets/section_header.dart';
import 'package:ghostos/features/auth/presentation/providers/auth_controller.dart';
import 'package:ghostos/features/you/presentation/providers/profile_controller.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class YouScreen extends HookConsumerWidget {
  const YouScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final profile = ref.watch(profileControllerProvider);
    final controller = ref.read(profileControllerProvider.notifier);
    final usernameController = useTextEditingController();
    final emailController = useTextEditingController();

    useEffect(() {
      usernameController.text = profile.username;
      emailController.text = profile.email;
      return null;
    }, [profile.username, profile.email]);

    Future<void> saveProfile() async {
      final email = emailController.text.trim();
      if (!email.contains('@') || !email.contains('.')) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Enter a valid email address before saving.'),
          ),
        );
        return;
      }

      final success = await controller.saveProfile(
        username: usernameController.text,
        email: email,
      );

      if (!context.mounted) {
        return;
      }

      final latestState = ref.read(profileControllerProvider);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            success
                ? 'Profile updated successfully.'
                : latestState.usernameError ??
                    'Choose a different username.',
          ),
        ),
      );
    }

    return Scaffold(
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.fromLTRB(20, 12, 20, 120),
          children: [
            _ProfileHeader(
              username: profile.username,
              email: profile.email,
              level: profile.level,
              xp: profile.xp,
              currentStreak: profile.currentStreak,
              focusCoins: profile.focusCoins,
              onNotificationsTap: () => context.push('/notifications'),
              onSettingsTap: () => context.push('/settings'),
            ),
            const SizedBox(height: 22),
            const SectionHeader(
              title: 'Profile Details',
              subtitle:
                  'Keep your identity, stats, and quick actions organized in one minimal premium profile surface.',
            ),
            const SizedBox(height: 14),
            GlassCard(
              borderRadius: 32,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Edit Profile',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  const SizedBox(height: 16),
                  TextField(
                    controller: usernameController,
                    onChanged: (value) {
                      controller.validateUsernameAvailability(value);
                    },
                    decoration: InputDecoration(
                      labelText: 'Username',
                      hintText: 'Choose a unique username',
                      errorText: profile.usernameError,
                      prefixIcon: const Icon(Icons.alternate_email_rounded),
                    ),
                  ),
                  const SizedBox(height: 14),
                  TextField(
                    controller: emailController,
                    keyboardType: TextInputType.emailAddress,
                    decoration: const InputDecoration(
                      labelText: 'Email',
                      hintText: 'you@ghostos.app',
                      prefixIcon: Icon(Icons.mail_outline_rounded),
                    ),
                  ),
                  const SizedBox(height: 18),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: profile.isSaving ? null : saveProfile,
                      child: Text(
                        profile.isSaving ? 'Saving...' : 'Save Changes',
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 22),
            const _StatsSection(),
            const SizedBox(height: 22),
            GlassCard(
              borderRadius: 32,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Account Actions',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  const SizedBox(height: 16),
                  _QuickActionRow(
                    icon: Icons.settings_rounded,
                    title: 'Open Settings',
                    subtitle:
                        'Appearance, notifications, privacy, and support.',
                    onTap: () => context.push('/settings'),
                  ),
                  const SizedBox(height: 12),
                  _QuickActionRow(
                    icon: Icons.notifications_rounded,
                    title: 'View Notifications',
                    subtitle:
                        'Review reminders, achievements, and AI insights.',
                    onTap: () => context.push('/notifications'),
                  ),
                  const SizedBox(height: 12),
                  _QuickActionRow(
                    icon: Icons.logout_rounded,
                    title: 'Sign Out',
                    subtitle:
                        'Return to the authentication screen on this device.',
                    onTap: () =>
                        ref.read(authControllerProvider.notifier).signOut(),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ProfileHeader extends StatelessWidget {
  const _ProfileHeader({
    required this.username,
    required this.email,
    required this.level,
    required this.xp,
    required this.currentStreak,
    required this.focusCoins,
    required this.onNotificationsTap,
    required this.onSettingsTap,
  });

  final String username;
  final String email;
  final int level;
  final int xp;
  final int currentStreak;
  final int focusCoins;
  final VoidCallback onNotificationsTap;
  final VoidCallback onSettingsTap;

  @override
  Widget build(BuildContext context) {
    final displayName = username.trim().isEmpty
        ? email.split('@').first
        : username;
    final avatarLetter = displayName.isNotEmpty
        ? displayName[0].toUpperCase()
        : 'G';

    return GlassCard(
      borderRadius: 38,
      gradient: const LinearGradient(
        colors: [Color(0xFF25140D), Color(0xFF1B1B1E), Color(0xFF12212B)],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  'Your Profile',
                  style: Theme.of(context).textTheme.headlineMedium,
                ),
              ),
              _HeaderButton(
                icon: Icons.notifications_none_rounded,
                onTap: onNotificationsTap,
              ),
              const SizedBox(width: 10),
              _HeaderButton(
                icon: Icons.tune_rounded,
                onTap: onSettingsTap,
              ),
            ],
          ),
          const SizedBox(height: 20),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 94,
                height: 94,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: LinearGradient(
                    colors: [AppColors.primary, Color(0xFFFF7B3D)],
                  ),
                ),
                alignment: Alignment.center,
                child: Text(
                  avatarLetter,
                  style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.w800,
                      ),
                ),
              ),
              const SizedBox(width: 18),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      displayName,
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    const SizedBox(height: 6),
                    Text(email, style: Theme.of(context).textTheme.bodyMedium),
                    const SizedBox(height: 14),
                    Wrap(
                      spacing: 8,
                      runSpacing: 8,
                      children: [
                        _Tag(label: 'Level $level'),
                        _Tag(label: '$xp XP'),
                        _Tag(label: '$currentStreak day streak'),
                        _Tag(label: '$focusCoins Focus Coins'),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          const Row(
            children: [
              Expanded(
                child: _HeaderStat(
                  label: 'Current Streak',
                  value: '12 days',
                ),
              ),
              SizedBox(width: 12),
              Expanded(
                child: _HeaderStat(
                  label: 'Focus Coins',
                  value: '485',
                ),
              ),
              SizedBox(width: 12),
              Expanded(
                child: _HeaderStat(
                  label: 'Ghost Mood',
                  value: 'Focused',
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _HeaderButton extends StatelessWidget {
  const _HeaderButton({
    required this.icon,
    required this.onTap,
  });

  final IconData icon;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white.withValues(alpha: 0.06),
      borderRadius: BorderRadius.circular(18),
      child: InkWell(
        borderRadius: BorderRadius.circular(18),
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Icon(icon, size: 20),
        ),
      ),
    );
  }
}

class _StatsSection extends StatelessWidget {
  const _StatsSection();

  @override
  Widget build(BuildContext context) {
    const items = [
      ('Achievements', '12 unlocked', Icons.emoji_events_rounded, AppColors.coins),
      ('Inventory', '8 items', Icons.backpack_rounded, AppColors.primary),
      ('Themes', '3 active', Icons.palette_rounded, AppColors.xp),
      ('Ghost Collection', '1 owned', Icons.auto_awesome_rounded, AppColors.success),
    ];

    return Wrap(
      spacing: 14,
      runSpacing: 14,
      children: items
          .map(
            (item) => SizedBox(
              width: 168,
              child: GlassCard(
                borderRadius: 28,
                gradient: LinearGradient(
                  colors: [
                    item.$4.withValues(alpha: 0.14),
                    AppColors.surfaceElevated,
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Icon(item.$3, color: item.$4, size: 24),
                    const SizedBox(height: 18),
                    Text(
                      item.$1,
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    const SizedBox(height: 8),
                    Text(
                      item.$2,
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                  ],
                ),
              ),
            ),
          )
          .toList(),
    );
  }
}

class _Tag extends StatelessWidget {
  const _Tag({required this.label});

  final String label;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 7),
      decoration: BoxDecoration(
        color: AppColors.primarySoft,
        borderRadius: BorderRadius.circular(999),
      ),
      child: Text(
        label,
        style: Theme.of(context).textTheme.labelSmall?.copyWith(
              color: AppColors.primary,
              fontWeight: FontWeight.w800,
            ),
      ),
    );
  }
}

class _HeaderStat extends StatelessWidget {
  const _HeaderStat({
    required this.label,
    required this.value,
  });

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(22),
        color: Colors.white.withValues(alpha: 0.05),
        border: Border.all(color: AppColors.divider),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label, style: Theme.of(context).textTheme.labelMedium),
          const SizedBox(height: 6),
          Text(value, style: Theme.of(context).textTheme.titleMedium),
        ],
      ),
    );
  }
}

class _QuickActionRow extends StatelessWidget {
  const _QuickActionRow({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.onTap,
  });

  final IconData icon;
  final String title;
  final String subtitle;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white.withValues(alpha: 0.04),
      borderRadius: BorderRadius.circular(22),
      child: InkWell(
        borderRadius: BorderRadius.circular(22),
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(14),
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(18),
                  color: AppColors.primarySoft,
                ),
                child: Icon(icon, color: AppColors.primary),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    const SizedBox(height: 4),
                    Text(
                      subtitle,
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                  ],
                ),
              ),
              const Icon(Icons.chevron_right_rounded),
            ],
          ),
        ),
      ),
    );
  }
}
