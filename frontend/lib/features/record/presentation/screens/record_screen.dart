import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:ghostos/core/constants/app_copy.dart';
import 'package:ghostos/core/theme/app_colors.dart';
import 'package:ghostos/core/widgets/ghost_app_bar.dart';
import 'package:ghostos/core/widgets/glass_card.dart';
import 'package:ghostos/core/widgets/section_header.dart';

class RecordScreen extends HookWidget {
  const RecordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final selectedRange = useState('Week');
    final filters = ['Today', 'Week', 'Month', 'Year'];

    return Scaffold(
      appBar: GhostAppBar(
        planLabel: AppCopy.freePlan,
        onNotificationsTap: () => context.push('/notifications'),
        onSearchTap: () {},
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          final isWide = constraints.maxWidth >= 760;

          return ListView(
            padding: const EdgeInsets.fromLTRB(20, 6, 20, 120),
            children: [
              const SectionHeader(
                title: 'Analytics Dashboard',
                subtitle:
                    'Every habit, health signal, and performance trend is organized into a polished record center.',
              ),
              const SizedBox(height: 16),
              Wrap(
                spacing: 10,
                runSpacing: 10,
                children: filters
                    .map(
                      (filter) => ChoiceChip(
                        label: Text(filter),
                        selected: selectedRange.value == filter,
                        onSelected: (_) => selectedRange.value = filter,
                      ),
                    )
                    .toList(),
              ),
              const SizedBox(height: 18),
              _TodaySummaryCard(range: selectedRange.value),
              const SizedBox(height: 18),
              const _CoreMetricsGrid(),
              const SizedBox(height: 18),
              if (isWide)
                const Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(flex: 6, child: _WeeklyAnalyticsCard()),
                    SizedBox(width: 16),
                    Expanded(flex: 5, child: _HabitHeatmapCard()),
                  ],
                )
              else ...const [
                _WeeklyAnalyticsCard(),
                SizedBox(height: 16),
                _HabitHeatmapCard(),
              ],
              const SizedBox(height: 18),
              if (isWide)
                const Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(child: _StreakCalendarCard()),
                    SizedBox(width: 16),
                    Expanded(child: _ProgressRingsCard()),
                  ],
                )
              else ...const [
                _StreakCalendarCard(),
                SizedBox(height: 16),
                _ProgressRingsCard(),
              ],
              const SizedBox(height: 18),
              if (isWide)
                const Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(child: _AiSummaryCard()),
                    SizedBox(width: 16),
                    Expanded(child: _AchievementHistoryCard()),
                  ],
                )
              else ...const [
                _AiSummaryCard(),
                SizedBox(height: 16),
                _AchievementHistoryCard(),
              ],
              const SizedBox(height: 18),
              if (isWide)
                const Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(child: _JournalHistoryCard()),
                    SizedBox(width: 16),
                    Expanded(child: _PreviousSessionsCard()),
                  ],
                )
              else ...const [
                _JournalHistoryCard(),
                SizedBox(height: 16),
                _PreviousSessionsCard(),
              ],
            ],
          );
        },
      ),
    );
  }
}

class _TodaySummaryCard extends StatelessWidget {
  const _TodaySummaryCard({required this.range});

  final String range;

  @override
  Widget build(BuildContext context) {
    return GlassCard(
      borderRadius: 34,
      gradient: const LinearGradient(
        colors: [Color(0xFF22140D), Color(0xFF1B1D21), Color(0xFF11222B)],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: AppColors.primarySoft,
                ),
                child: const Icon(
                  Icons.analytics_rounded,
                  color: AppColors.primary,
                ),
              ),
              const SizedBox(width: 14),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Today\'s Summary',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    '$range overview synced with your recent effort patterns.',
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                ],
              ),
              const Spacer(),
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(999),
                  color: Colors.white.withValues(alpha: 0.06),
                ),
                child: Text(
                  'Score 84',
                  style: Theme.of(context).textTheme.labelLarge?.copyWith(
                        color: AppColors.coins,
                      ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          const Wrap(
            spacing: 12,
            runSpacing: 12,
            children: [
              _SummaryPill(label: 'Focus Hours', value: '3.4h', color: AppColors.xp),
              _SummaryPill(label: 'Study Time', value: '1.7h', color: AppColors.primary),
              _SummaryPill(label: 'Workout', value: '42m', color: AppColors.warning),
              _SummaryPill(label: 'Walking', value: '4.2km', color: AppColors.success),
              _SummaryPill(label: 'Reading', value: '26m', color: AppColors.coins),
              _SummaryPill(label: 'Mood', value: 'Focused', color: AppColors.primary),
            ],
          ),
        ],
      ),
    );
  }
}

class _SummaryPill extends StatelessWidget {
  const _SummaryPill({
    required this.label,
    required this.value,
    required this.color,
  });

  final String label;
  final String value;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(22),
        color: color.withValues(alpha: 0.12),
        border: Border.all(color: color.withValues(alpha: 0.22)),
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

class _CoreMetricsGrid extends StatelessWidget {
  const _CoreMetricsGrid();

  @override
  Widget build(BuildContext context) {
    const items = [
      ('Coding Time', '2h 05m', Icons.code_rounded, AppColors.xp),
      ('Meditation', '18m', Icons.self_improvement_rounded, AppColors.success),
      ('Sleep', '7h 24m', Icons.bedtime_rounded, AppColors.fog),
      ('Screen Time', '4h 12m', Icons.phone_iphone_rounded, AppColors.warning),
      ('Water Intake', '2.2L', Icons.water_drop_rounded, AppColors.success),
      ('Mood Tracking', 'Calm / Focused', Icons.mood_rounded, AppColors.primary),
      ('Workout Duration', '42m', Icons.fitness_center_rounded, AppColors.coins),
      ('Reading Time', '26m', Icons.menu_book_rounded, AppColors.primary),
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
                    const SizedBox(height: 20),
                    Text(
                      item.$1,
                      style: Theme.of(context).textTheme.labelLarge,
                    ),
                    const SizedBox(height: 8),
                    Text(
                      item.$2,
                      style: Theme.of(context).textTheme.titleMedium,
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

class _WeeklyAnalyticsCard extends StatelessWidget {
  const _WeeklyAnalyticsCard();

  @override
  Widget build(BuildContext context) {
    const bars = [
      ('Mon', 2.4),
      ('Tue', 3.1),
      ('Wed', 2.7),
      ('Thu', 4.2),
      ('Fri', 3.6),
      ('Sat', 4.8),
      ('Sun', 2.9),
    ];

    return GlassCard(
      borderRadius: 32,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SectionHeader(
            title: 'Weekly Analytics',
            subtitle:
                'Focus output and effort volume across the last seven days.',
          ),
          const SizedBox(height: 18),
          SizedBox(
            height: 190,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: bars
                  .map(
                    (bar) => Expanded(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 5),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Text(
                              '${bar.$2.toStringAsFixed(1)}h',
                              style: Theme.of(context).textTheme.labelMedium,
                            ),
                            const SizedBox(height: 8),
                            TweenAnimationBuilder<double>(
                              tween: Tween(begin: 0, end: bar.$2 / 5),
                              duration: const Duration(milliseconds: 950),
                              builder: (context, value, child) {
                                return Container(
                                  height: 120 * value + 20,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(18),
                                    gradient: const LinearGradient(
                                      begin: Alignment.bottomCenter,
                                      end: Alignment.topCenter,
                                      colors: [
                                        AppColors.xp,
                                        Color(0xFF8ED6FF),
                                      ],
                                    ),
                                  ),
                                );
                              },
                            ),
                            const SizedBox(height: 10),
                            Text(
                              bar.$1,
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

class _HabitHeatmapCard extends StatelessWidget {
  const _HabitHeatmapCard();

  @override
  Widget build(BuildContext context) {
    const values = [
      [0.2, 0.4, 0.8, 0.6, 0.4, 0.7, 0.3],
      [0.6, 0.5, 0.3, 0.9, 0.7, 0.8, 0.4],
      [0.4, 0.8, 0.7, 0.5, 0.6, 0.9, 0.2],
      [0.7, 0.9, 0.4, 0.8, 0.5, 0.6, 0.5],
    ];

    return GlassCard(
      borderRadius: 32,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SectionHeader(
            title: 'Habit Heatmap',
            subtitle:
                'Dense activity blocks reveal where your routines are strongest.',
          ),
          const SizedBox(height: 18),
          ...values.map(
            (row) => Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: Row(
                children: row
                    .map(
                      (value) => Expanded(
                        child: Container(
                          height: 34,
                          margin: const EdgeInsets.symmetric(horizontal: 4),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: AppColors.primary.withValues(
                              alpha: 0.15 + value * 0.55,
                            ),
                            border: Border.all(color: AppColors.divider),
                          ),
                        ),
                      ),
                    )
                    .toList(),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _StreakCalendarCard extends StatelessWidget {
  const _StreakCalendarCard();

  @override
  Widget build(BuildContext context) {
    final now = DateTime.now();
    const activeDays = {2, 3, 4, 6, 7, 9, 10, 12, 13, 14};

    return GlassCard(
      borderRadius: 32,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SectionHeader(
            title: 'Streak Calendar',
            subtitle:
                'A compact monthly view of your strongest routine days.',
          ),
          const SizedBox(height: 18),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: List.generate(14, (index) {
              final day = index + 1;
              final isToday = day == now.day;
              final isActive = activeDays.contains(day);

              return Container(
                width: 42,
                height: 42,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: isToday
                      ? AppColors.coins
                      : isActive
                          ? AppColors.primary
                          : Colors.white.withValues(alpha: 0.05),
                ),
                child: Text(
                  '$day',
                  style: Theme.of(context).textTheme.labelLarge?.copyWith(
                        color: isToday || isActive
                            ? Colors.black
                            : AppColors.textPrimary,
                      ),
                ),
              );
            }),
          ),
        ],
      ),
    );
  }
}

class _ProgressRingsCard extends StatelessWidget {
  const _ProgressRingsCard();

  @override
  Widget build(BuildContext context) {
    const rings = [
      ('Sleep', 0.82, AppColors.fog),
      ('Hydration', 0.74, AppColors.success),
      ('Recovery', 0.68, AppColors.coins),
    ];

    return GlassCard(
      borderRadius: 32,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SectionHeader(
            title: 'Recovery Signals',
            subtitle:
                'Progress indicators for the habits that protect long-term consistency.',
          ),
          const SizedBox(height: 18),
          ...rings.map(
            (ring) => Padding(
              padding: const EdgeInsets.only(bottom: 16),
              child: Row(
                children: [
                  SizedBox(
                    width: 54,
                    height: 54,
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        CircularProgressIndicator(
                          value: ring.$2,
                          strokeWidth: 7,
                          backgroundColor: Colors.white.withValues(alpha: 0.08),
                          valueColor: AlwaysStoppedAnimation<Color>(ring.$3),
                        ),
                        Text(
                          '${(ring.$2 * 100).round()}',
                          style: Theme.of(context).textTheme.labelMedium,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 14),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          ring.$1,
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                        const SizedBox(height: 4),
                        Text(
                          'Trending upward and supporting better focus quality.',
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

class _AiSummaryCard extends StatelessWidget {
  const _AiSummaryCard();

  @override
  Widget build(BuildContext context) {
    return GlassCard(
      borderRadius: 32,
      gradient: const LinearGradient(
        colors: [Color(0xFF181F2A), Color(0xFF1E1F22)],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('AI Summary', style: Theme.of(context).textTheme.titleLarge),
          const SizedBox(height: 12),
          Text(
            'You are most productive on days when water intake crosses 2 liters before noon. Coding quality also improves when movement happens within 90 minutes of your first focus block.',
            style: Theme.of(context).textTheme.bodyMedium,
          ),
          const SizedBox(height: 14),
          Text(
            'Recommended experiment: start tomorrow with a 15-minute walk, then begin the first coding session by 9:30 AM.',
            style: Theme.of(context).textTheme.labelLarge?.copyWith(
                  color: AppColors.xp,
                ),
          ),
        ],
      ),
    );
  }
}

class _AchievementHistoryCard extends StatelessWidget {
  const _AchievementHistoryCard();

  @override
  Widget build(BuildContext context) {
    const achievements = [
      ('12-day study streak', 'Unlocked today'),
      ('Focus Marathon', 'Completed 5 sessions this week'),
      ('Hydration Hero', 'Reached water goal 4 days in a row'),
    ];

    return GlassCard(
      borderRadius: 32,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Achievement History',
            style: Theme.of(context).textTheme.titleLarge,
          ),
          const SizedBox(height: 14),
          ...achievements.map(
            (item) => ListTile(
              contentPadding: EdgeInsets.zero,
              leading: const Icon(
                Icons.emoji_events_rounded,
                color: AppColors.coins,
              ),
              title: Text(item.$1),
              subtitle: Text(item.$2),
            ),
          ),
        ],
      ),
    );
  }
}

class _JournalHistoryCard extends StatelessWidget {
  const _JournalHistoryCard();

  @override
  Widget build(BuildContext context) {
    const journals = [
      (
        'Today',
        'Energy improved after the afternoon walk and deep focus felt easier.',
      ),
      (
        'Yesterday',
        'Sleep quality was decent, but screen time pushed too late into the night.',
      ),
      (
        'Jul 12',
        'Workout consistency is improving and reading has become easier to maintain.',
      ),
    ];

    return GlassCard(
      borderRadius: 32,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Journal History', style: Theme.of(context).textTheme.titleLarge),
          const SizedBox(height: 14),
          ...journals.map(
            (entry) => Padding(
              padding: const EdgeInsets.only(bottom: 14),
              child: Container(
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(22),
                  color: Colors.white.withValues(alpha: 0.04),
                  border: Border.all(color: AppColors.divider),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      entry.$1,
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    const SizedBox(height: 6),
                    Text(
                      entry.$2,
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _PreviousSessionsCard extends StatelessWidget {
  const _PreviousSessionsCard();

  @override
  Widget build(BuildContext context) {
    const sessions = [
      ('Focus Session', '52 min', '10:20 AM'),
      ('Coding Sprint', '1h 12m', '1:00 PM'),
      ('Reading Block', '26 min', '4:40 PM'),
      ('Workout', '42 min', '6:35 PM'),
    ];

    return GlassCard(
      borderRadius: 32,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Previous Sessions',
            style: Theme.of(context).textTheme.titleLarge,
          ),
          const SizedBox(height: 14),
          ...sessions.map(
            (session) => Padding(
              padding: const EdgeInsets.only(bottom: 12),
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          session.$1,
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                        const SizedBox(height: 4),
                        Text(
                          session.$3,
                          style: Theme.of(context).textTheme.bodySmall,
                        ),
                      ],
                    ),
                  ),
                  Text(
                    session.$2,
                    style: Theme.of(context).textTheme.labelLarge?.copyWith(
                          color: AppColors.primary,
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
