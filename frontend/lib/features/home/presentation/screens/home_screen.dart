import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:ghostos/core/constants/app_copy.dart';
import 'package:ghostos/core/theme/app_colors.dart';
import 'package:ghostos/core/widgets/ghost_app_bar.dart';
import 'package:ghostos/core/widgets/glass_card.dart';
import 'package:ghostos/core/widgets/section_header.dart';
import 'package:ghostos/features/you/presentation/providers/profile_controller.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final profile = ref.watch(profileControllerProvider);
    final displayName = profile.username.trim().isEmpty
        ? profile.email.split('@').first
        : profile.username;

    return Scaffold(
      appBar: GhostAppBar(
        planLabel: AppCopy.freePlan,
        onNotificationsTap: () => context.push('/notifications'),
        onSearchTap: () {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Global search is queued for the next sprint.'),
            ),
          );
        },
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          final isWide = constraints.maxWidth >= 760;

          return ListView(
            padding: const EdgeInsets.fromLTRB(20, 8, 20, 120),
            children: [
              _GreetingBlock(displayName: displayName),
              const SizedBox(height: 18),
              _GhostCompanionCard(displayName: displayName),
              const SizedBox(height: 22),
              const SectionHeader(
                title: 'Quick Statistics',
                subtitle:
                    'Your strongest signals for focus, movement, recovery, and consistency are grouped cleanly for mobile.',
              ),
              const SizedBox(height: 14),
              const _QuickStatsGrid(),
              const SizedBox(height: 22),
              if (isWide)
                const Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(flex: 6, child: _GoalsSection()),
                    SizedBox(width: 16),
                    Expanded(flex: 5, child: _FocusTimerCard()),
                  ],
                )
              else ...const [
                _GoalsSection(),
                SizedBox(height: 16),
                _FocusTimerCard(),
              ],
              const SizedBox(height: 22),
              if (isWide)
                const Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(child: _AiRecommendationCard()),
                    SizedBox(width: 16),
                    Expanded(child: _DailyChallengeCard()),
                  ],
                )
              else ...const [
                _AiRecommendationCard(),
                SizedBox(height: 16),
                _DailyChallengeCard(),
              ],
              const SizedBox(height: 22),
              if (isWide)
                const Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(flex: 6, child: _RecentActivityCard()),
                    SizedBox(width: 16),
                    Expanded(flex: 5, child: _WeeklyProgressCard()),
                  ],
                )
              else ...const [
                _RecentActivityCard(),
                SizedBox(height: 16),
                _WeeklyProgressCard(),
              ],
              const SizedBox(height: 22),
              const _QuickActions(),
            ],
          );
        },
      ),
    );
  }
}

class _GreetingBlock extends StatelessWidget {
  const _GreetingBlock({required this.displayName});

  final String displayName;

  @override
  Widget build(BuildContext context) {
    final hour = DateTime.now().hour;
    final greeting = hour < 12
        ? 'Good morning'
        : hour < 18
            ? 'Good afternoon'
            : 'Good evening';

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '$greeting, $displayName',
          style: Theme.of(context).textTheme.headlineSmall,
        ),
        const SizedBox(height: 8),
        Text(
          'Your world looks steady today. Here is the clearest view of momentum, goals, and ghost energy.',
          style: Theme.of(context).textTheme.bodyLarge,
        ),
      ],
    );
  }
}

class _GhostCompanionCard extends StatelessWidget {
  const _GhostCompanionCard({required this.displayName});

  final String displayName;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final compact = constraints.maxWidth < 380;

        return GlassCard(
          borderRadius: 34,
          gradient: const LinearGradient(
            colors: [Color(0xFF29150E), Color(0xFF1C1D20), Color(0xFF12212A)],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (compact)
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _GhostAvatar(size: 78),
                    const SizedBox(height: 16),
                    _GhostCopy(displayName: displayName),
                  ],
                )
              else
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const _GhostAvatar(size: 84),
                    const SizedBox(width: 16),
                    Expanded(child: _GhostCopy(displayName: displayName)),
                  ],
                ),
              const SizedBox(height: 18),
              const Wrap(
                spacing: 12,
                runSpacing: 12,
                children: [
                  _MetricChip(
                    label: 'Coins',
                    value: '485',
                    color: AppColors.coins,
                    icon: Icons.toll_rounded,
                  ),
                  _MetricChip(
                    label: 'XP',
                    value: '1,840',
                    color: AppColors.xp,
                    icon: Icons.auto_graph_rounded,
                  ),
                  _MetricChip(
                    label: 'Health',
                    value: '92',
                    color: AppColors.success,
                    icon: Icons.favorite_rounded,
                  ),
                  _MetricChip(
                    label: 'Energy',
                    value: '84',
                    color: AppColors.warning,
                    icon: Icons.bolt_rounded,
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}

class _GhostAvatar extends StatelessWidget {
  const _GhostAvatar({required this.size});

  final double size;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: const BoxDecoration(
        shape: BoxShape.circle,
        gradient: LinearGradient(
          colors: [AppColors.primary, Color(0xFFFF7B3D)],
        ),
      ),
      child: const Hero(
        tag: 'ghostos-mark',
        child: Icon(
          Icons.emoji_emotions_rounded,
          size: 40,
          color: Colors.white,
        ),
      ),
    );
  }
}

class _GhostCopy extends StatelessWidget {
  const _GhostCopy({required this.displayName});

  final String displayName;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Today\'s Ghost Companion',
          style: theme.textTheme.labelLarge,
        ),
        const SizedBox(height: 6),
        Text(
          '$displayName\'s Ember Ghost',
          style: theme.textTheme.titleLarge,
        ),
        const SizedBox(height: 8),
        Text(
          'Low fog, strong rhythm, and enough energy for deep work plus movement. Your companion is ready to evolve.',
          style: theme.textTheme.bodyMedium?.copyWith(
            color: AppColors.textSecondary,
          ),
        ),
      ],
    );
  }
}

class _MetricChip extends StatelessWidget {
  const _MetricChip({
    required this.label,
    required this.value,
    required this.color,
    required this.icon,
  });

  final String label;
  final String value;
  final Color color;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    final width = (MediaQuery.of(context).size.width - 64) / 2;

    return SizedBox(
      width: width.clamp(132.0, 170.0).toDouble(),
      child: GlassCard(
        padding: const EdgeInsets.all(14),
        borderRadius: 22,
        gradient: LinearGradient(
          colors: [
            color.withValues(alpha: 0.14),
            AppColors.surfaceElevated.withValues(alpha: 0.82),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(icon, color: color, size: 20),
            const SizedBox(height: 12),
            Text(
              label,
              style: Theme.of(context).textTheme.labelMedium?.copyWith(
                    color: AppColors.textSecondary,
                  ),
            ),
            const SizedBox(height: 4),
            Text(
              value,
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w700,
                  ),
            ),
          ],
        ),
      ),
    );
  }
}

class _QuickStatsGrid extends StatelessWidget {
  const _QuickStatsGrid();

  @override
  Widget build(BuildContext context) {
    const stats = [
      ('Focus Time', '3h 24m', '+38 min', Icons.timer_rounded, AppColors.xp),
      ('Study Time', '1h 40m', '2 chapters', Icons.school_rounded, AppColors.primary),
      ('Water Intake', '2.2L', '8 / 10 cups', Icons.water_drop_rounded, AppColors.success),
      ('Workout', '42 min', 'Upper body', Icons.fitness_center_rounded, AppColors.warning),
    ];
    final width = (MediaQuery.of(context).size.width - 64) / 2;

    return Wrap(
      spacing: 14,
      runSpacing: 14,
      children: stats
          .map(
            (stat) => SizedBox(
              width: width.clamp(148.0, 180.0).toDouble(),
              child: GlassCard(
                borderRadius: 26,
                gradient: LinearGradient(
                  colors: [
                    stat.$5.withValues(alpha: 0.14),
                    AppColors.surfaceElevated,
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Icon(stat.$4, color: stat.$5, size: 22),
                    const SizedBox(height: 16),
                    Text(stat.$1, style: Theme.of(context).textTheme.labelLarge),
                    const SizedBox(height: 8),
                    Text(stat.$2, style: Theme.of(context).textTheme.titleMedium),
                    const SizedBox(height: 6),
                    Text(stat.$3, style: Theme.of(context).textTheme.bodySmall),
                  ],
                ),
              ),
            ),
          )
          .toList(),
    );
  }
}

class _GoalsSection extends StatelessWidget {
  const _GoalsSection();

  @override
  Widget build(BuildContext context) {
    const goals = [
      (
        'Deep work block',
        'Complete 90 minutes of focused coding.',
        0.72,
        AppColors.xp,
      ),
      (
        'Movement goal',
        'Reach 7,000 steps before dinner.',
        0.64,
        AppColors.success,
      ),
      (
        'Reading goal',
        'Finish 24 pages of your current book.',
        0.48,
        AppColors.coins,
      ),
    ];

    return GlassCard(
      borderRadius: 30,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SectionHeader(
            title: 'Today\'s Goals',
            subtitle:
                'Clear, mission-driven objectives keep the dashboard grounded in action.',
            actionLabel: '3 Active',
          ),
          const SizedBox(height: 18),
          ...goals.map(
            (goal) => Padding(
              padding: const EdgeInsets.only(bottom: 14),
              child: _GoalTile(
                title: goal.$1,
                detail: goal.$2,
                progress: goal.$3,
                color: goal.$4,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _GoalTile extends StatelessWidget {
  const _GoalTile({
    required this.title,
    required this.detail,
    required this.progress,
    required this.color,
  });

  final String title;
  final String detail;
  final double progress;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(22),
        color: Colors.white.withValues(alpha: 0.04),
        border: Border.all(color: AppColors.divider),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  title,
                  style: Theme.of(context).textTheme.titleMedium,
                ),
              ),
              Text(
                '${(progress * 100).round()}%',
                style: Theme.of(context).textTheme.labelLarge,
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(detail, style: Theme.of(context).textTheme.bodyMedium),
          const SizedBox(height: 12),
          ClipRRect(
            borderRadius: BorderRadius.circular(999),
            child: TweenAnimationBuilder<double>(
              tween: Tween(begin: 0, end: progress),
              duration: const Duration(milliseconds: 900),
              builder: (context, value, child) {
                return LinearProgressIndicator(
                  minHeight: 8,
                  value: value,
                  backgroundColor: Colors.white.withValues(alpha: 0.08),
                  valueColor: AlwaysStoppedAnimation<Color>(color),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class _FocusTimerCard extends StatelessWidget {
  const _FocusTimerCard();

  @override
  Widget build(BuildContext context) {
    return GlassCard(
      borderRadius: 30,
      gradient: const LinearGradient(
        colors: [Color(0xFF141B24), Color(0xFF1E2025)],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SectionHeader(
            title: 'Focus Timer',
            subtitle:
                'A single glance at your current pacing and recovery cadence.',
          ),
          const SizedBox(height: 20),
          Center(
            child: SizedBox(
              width: 160,
              height: 160,
              child: Stack(
                alignment: Alignment.center,
                children: [
                  TweenAnimationBuilder<double>(
                    tween: Tween(begin: 0, end: 0.78),
                    duration: const Duration(milliseconds: 1100),
                    builder: (context, value, child) {
                      return CircularProgressIndicator(
                        value: value,
                        strokeWidth: 12,
                        backgroundColor: Colors.white.withValues(alpha: 0.08),
                        valueColor:
                            const AlwaysStoppedAnimation(AppColors.primary),
                      );
                    },
                  ),
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        '39:12',
                        style: Theme.of(context).textTheme.headlineSmall,
                      ),
                      const SizedBox(height: 6),
                      Text(
                        'Deep focus in progress',
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 18),
          const Row(
            children: [
              Expanded(child: _MiniStat(label: 'Next break', value: '10:00')),
              SizedBox(width: 12),
              Expanded(child: _MiniStat(label: 'Session goal', value: '50 min')),
            ],
          ),
        ],
      ),
    );
  }
}

class _MiniStat extends StatelessWidget {
  const _MiniStat({
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
        borderRadius: BorderRadius.circular(20),
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

class _AiRecommendationCard extends StatelessWidget {
  const _AiRecommendationCard();

  @override
  Widget build(BuildContext context) {
    return GlassCard(
      borderRadius: 30,
      gradient: const LinearGradient(
        colors: [Color(0xFF29150E), Color(0xFF1A1A1D)],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: AppColors.primarySoft,
                  borderRadius: BorderRadius.circular(18),
                ),
                child: const Icon(
                  Icons.auto_awesome_rounded,
                  color: AppColors.primary,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  'AI Recommendation',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Text(
            'Your strongest focus window has shifted later today. Delay the hardest coding task by 20 minutes, drink water first, then start with a 50-minute sprint.',
            style: Theme.of(context).textTheme.bodyMedium,
          ),
          const SizedBox(height: 14),
          Text(
            'Predicted outcome: +14 XP and better completion odds on your deep work goal.',
            style: Theme.of(context).textTheme.labelLarge?.copyWith(
                  color: AppColors.coins,
                ),
          ),
        ],
      ),
    );
  }
}

class _DailyChallengeCard extends StatelessWidget {
  const _DailyChallengeCard();

  @override
  Widget build(BuildContext context) {
    return GlassCard(
      borderRadius: 30,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Daily Challenge',
            style: Theme.of(context).textTheme.titleLarge,
          ),
          const SizedBox(height: 10),
          Text(
            'Complete one focus block, one workout, and one reading session to unlock the Solar Aura reward.',
            style: Theme.of(context).textTheme.bodyMedium,
          ),
          const SizedBox(height: 18),
          const Wrap(
            spacing: 10,
            runSpacing: 10,
            children: [
              _ChallengeBadge(label: 'Focus', done: true),
              _ChallengeBadge(label: 'Workout', done: true),
              _ChallengeBadge(label: 'Reading', done: false),
            ],
          ),
        ],
      ),
    );
  }
}

class _ChallengeBadge extends StatelessWidget {
  const _ChallengeBadge({
    required this.label,
    required this.done,
  });

  final String label;
  final bool done;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(999),
        color: done
            ? AppColors.primarySoft
            : Colors.white.withValues(alpha: 0.05),
        border: Border.all(
          color: done
              ? AppColors.primary.withValues(alpha: 0.35)
              : AppColors.divider,
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            done
                ? Icons.check_circle_rounded
                : Icons.radio_button_unchecked_rounded,
            color: done ? AppColors.primary : AppColors.textSecondary,
            size: 18,
          ),
          const SizedBox(width: 8),
          Text(label),
        ],
      ),
    );
  }
}

class _RecentActivityCard extends StatelessWidget {
  const _RecentActivityCard();

  @override
  Widget build(BuildContext context) {
    const items = [
      ('07:10', 'Morning walk', '2.1 km and 2,980 steps opened up the world weather.'),
      ('10:20', 'Deep coding', '52-minute session closed two tasks and earned 18 XP.'),
      ('14:00', 'Reading sprint', '16 pages completed during recovery mode.'),
      ('18:35', 'Strength workout', '42 minutes boosted health and energy ratings.'),
    ];

    return GlassCard(
      borderRadius: 30,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SectionHeader(
            title: 'Recent Activity',
            subtitle: 'A compact feed of the moves that shaped today.',
          ),
          const SizedBox(height: 18),
          ...items.map(
            (item) => Padding(
              padding: const EdgeInsets.only(bottom: 16),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    width: 58,
                    child: Text(
                      item.$1,
                      style: Theme.of(context).textTheme.labelLarge?.copyWith(
                            color: AppColors.textSecondary,
                          ),
                    ),
                  ),
                  Container(
                    width: 12,
                    height: 12,
                    margin: const EdgeInsets.only(top: 4),
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: AppColors.primary,
                    ),
                  ),
                  const SizedBox(width: 14),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          item.$2,
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                        const SizedBox(height: 4),
                        Text(
                          item.$3,
                          style: Theme.of(context).textTheme.bodySmall,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _WeeklyProgressCard extends StatelessWidget {
  const _WeeklyProgressCard();

  @override
  Widget build(BuildContext context) {
    const week = [
      ('Mon', 0.52),
      ('Tue', 0.74),
      ('Wed', 0.68),
      ('Thu', 0.81),
      ('Fri', 0.64),
      ('Sat', 0.91),
      ('Sun', 0.58),
    ];

    return GlassCard(
      borderRadius: 30,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SectionHeader(
            title: 'Weekly Progress',
            subtitle: 'Your consistency curve across the last seven days.',
          ),
          const SizedBox(height: 18),
          SizedBox(
            height: 170,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: week
                  .map(
                    (day) => Expanded(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 5),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            TweenAnimationBuilder<double>(
                              tween: Tween(begin: 0, end: day.$2),
                              duration: const Duration(milliseconds: 1000),
                              builder: (context, value, child) {
                                return Container(
                                  height: 120 * value + 16,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(18),
                                    gradient: const LinearGradient(
                                      begin: Alignment.bottomCenter,
                                      end: Alignment.topCenter,
                                      colors: [
                                        AppColors.primary,
                                        Color(0xFFFFA06A),
                                      ],
                                    ),
                                  ),
                                );
                              },
                            ),
                            const SizedBox(height: 10),
                            Text(
                              day.$1,
                              style: Theme.of(context).textTheme.labelMedium,
                            ),
                          ],
                        ),
                      ),
                    ),
                  )
                  .toList(),
            ),
          ),
        ],
      ),
    );
  }
}

class _QuickActions extends StatelessWidget {
  const _QuickActions();

  @override
  Widget build(BuildContext context) {
    const actions = [
      ('Start Focus', Icons.play_circle_fill_rounded),
      ('Log Workout', Icons.fitness_center_rounded),
      ('Track Water', Icons.water_drop_rounded),
      ('Write Journal', Icons.edit_note_rounded),
      ('Review Goals', Icons.task_alt_rounded),
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SectionHeader(
          title: 'Quick Actions',
          subtitle:
              'Fast entry points for the most common routines in your day.',
        ),
        const SizedBox(height: 14),
        Wrap(
          spacing: 12,
          runSpacing: 12,
          children: actions.map((action) {
            return Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
              decoration: BoxDecoration(
                color: AppColors.surface,
                borderRadius: BorderRadius.circular(22),
                border: Border.all(color: AppColors.divider),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(action.$2, color: AppColors.primary, size: 20),
                  const SizedBox(width: 10),
                  Text(action.$1),
                ],
              ),
            );
          }).toList(),
        ),
      ],
    );
  }
}
