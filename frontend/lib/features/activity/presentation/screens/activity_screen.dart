import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:ghostos/core/constants/app_copy.dart';
import 'package:ghostos/core/theme/app_colors.dart';
import 'package:ghostos/core/widgets/ghost_app_bar.dart';
import 'package:ghostos/core/widgets/glass_card.dart';
import 'package:ghostos/core/widgets/section_header.dart';

class ActivityScreen extends StatelessWidget {
  const ActivityScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: GhostAppBar(
        planLabel: AppCopy.freePlan,
        onNotificationsTap: () => context.push('/notifications'),
        onSearchTap: () {},
      ),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(20, 6, 20, 120),
        children: const [
          SectionHeader(
            title: 'Performance Overview',
            subtitle:
                'A premium activity snapshot inspired by modern fitness dashboards.',
          ),
          SizedBox(height: 14),
          _ActivityHero(),
          SizedBox(height: 18),
          _StatGrid(),
          SizedBox(height: 18),
          _TimelineCard(),
        ],
      ),
    );
  }
}

class _ActivityHero extends StatelessWidget {
  const _ActivityHero();

  @override
  Widget build(BuildContext context) {
    return GlassCard(
      borderRadius: 34,
      gradient: const LinearGradient(
        colors: [Color(0xFF1E1310), Color(0xFF1B1B1D), Color(0xFF101A22)],
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Today', style: Theme.of(context).textTheme.labelLarge),
                const SizedBox(height: 8),
                Text('76%', style: Theme.of(context).textTheme.headlineLarge),
                const SizedBox(height: 8),
                Text(
                  'Consistency score trending upward with better focus and lower fog impact.',
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
              ],
            ),
          ),
          SizedBox(
            width: 92,
            height: 92,
            child: Stack(
              alignment: Alignment.center,
              children: [
                CircularProgressIndicator(
                  value: 0.76,
                  strokeWidth: 9,
                  backgroundColor: Colors.white.withValues(alpha: 0.08),
                  valueColor: const AlwaysStoppedAnimation(AppColors.primary),
                ),
                const Icon(Icons.insights_rounded, color: AppColors.primary),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _StatGrid extends StatelessWidget {
  const _StatGrid();

  @override
  Widget build(BuildContext context) {
    const stats = [
      ('Daily Progress', '84%', AppColors.primary),
      ('Focus Time', '2h 14m', AppColors.xp),
      ('Screen Time', '1h 26m', AppColors.warning),
      ('XP Earned', '+40', AppColors.xp),
    ];

    return Wrap(
      spacing: 14,
      runSpacing: 14,
      children: stats.map((stat) {
        return SizedBox(
          width: 168,
          child: GlassCard(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  stat.$1,
                  style: Theme.of(context).textTheme.labelLarge?.copyWith(
                        color: AppColors.textSecondary,
                      ),
                ),
                const SizedBox(height: 20),
                Text(stat.$2, style: Theme.of(context).textTheme.titleLarge),
                const SizedBox(height: 12),
                Container(
                  height: 6,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(999),
                    color: Colors.white.withValues(alpha: 0.07),
                  ),
                  child: FractionallySizedBox(
                    widthFactor: 0.35 + (stats.indexOf(stat) * 0.15),
                    alignment: Alignment.centerLeft,
                    child: DecoratedBox(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(999),
                        color: stat.$3,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      }).toList(),
    );
  }
}

class _TimelineCard extends StatelessWidget {
  const _TimelineCard();

  @override
  Widget build(BuildContext context) {
    return GlassCard(
      borderRadius: 32,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: const [
          Text(
            'Activity Timeline',
            style: TextStyle(fontSize: 22, fontWeight: FontWeight.w800),
          ),
          SizedBox(height: 18),
          _TimelineRow(
            time: '07:30',
            title: 'Morning Walk',
            detail: '1,840 steps - weather improved',
          ),
          SizedBox(height: 16),
          _TimelineRow(
            time: '10:15',
            title: 'Deep Work',
            detail: '52 min focus - +18 XP',
          ),
          SizedBox(height: 16),
          _TimelineRow(
            time: '18:45',
            title: 'Workout',
            detail: '34 min strength - +24 Coins',
          ),
        ],
      ),
    );
  }
}

class _TimelineRow extends StatelessWidget {
  const _TimelineRow({
    required this.time,
    required this.title,
    required this.detail,
  });

  final String time;
  final String title;
  final String detail;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SizedBox(
          width: 58,
          child: Text(
            time,
            style: Theme.of(context).textTheme.labelLarge?.copyWith(
                  color: AppColors.textSecondary,
                ),
          ),
        ),
        Container(
          width: 12,
          height: 12,
          decoration: const BoxDecoration(
            color: AppColors.primary,
            shape: BoxShape.circle,
          ),
        ),
        const SizedBox(width: 14),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title, style: Theme.of(context).textTheme.titleMedium),
              const SizedBox(height: 4),
              Text(detail, style: Theme.of(context).textTheme.bodySmall),
            ],
          ),
        ),
      ],
    );
  }
}
