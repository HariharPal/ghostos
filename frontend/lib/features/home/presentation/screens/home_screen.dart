import 'package:flutter/material.dart';
import 'package:ghostos/core/constants/app_copy.dart';
import 'package:ghostos/core/theme/app_colors.dart';
import 'package:ghostos/core/widgets/glass_card.dart';
import 'package:ghostos/core/widgets/ghost_app_bar.dart';
import 'package:ghostos/core/widgets/section_header.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: GhostAppBar(
        planLabel: AppCopy.freePlan,
        onNotificationsTap: () {},
        onSearchTap: () {},
      ),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(18, 8, 18, 120),
        children: const [
          _HeroCard(),
          SizedBox(height: 22),
          SectionHeader(
            title: 'Daily Missions',
            subtitle: 'Swipe through the goals that keep GhostOS feeling alive.',
            actionLabel: 'Today',
          ),
          SizedBox(height: 14),
          _MissionCarousel(),
          SizedBox(height: 22),
          SectionHeader(
            title: 'Momentum Dashboard',
            subtitle: 'High-signal stats arranged like a premium fitness home screen.',
          ),
          SizedBox(height: 14),
          _ActivitySummary(),
          SizedBox(height: 22),
          SectionHeader(
            title: 'Quick Actions',
            subtitle: 'Fast entry points for the actions you use most often.',
          ),
          SizedBox(height: 14),
          _QuickActions(),
        ],
      ),
    );
  }
}

class _HeroCard extends StatelessWidget {
  const _HeroCard();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return GlassCard(
      borderRadius: 36,
      gradient: const LinearGradient(
        colors: [Color(0xFF311409), Color(0xFF17171A), Color(0xFF101D26)],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 96,
                height: 96,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: const LinearGradient(
                    colors: [AppColors.primary, Color(0xFFFF7B3D)],
                  ),
                  boxShadow: [
                    BoxShadow(
                      blurRadius: 30,
                      color: AppColors.primary.withValues(alpha: 0.24),
                    ),
                  ],
                ),
                child: const Hero(
                  tag: 'ghostos-mark',
                  child: Icon(Icons.auto_awesome, size: 42, color: Colors.white),
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Ghost Lv. 1', style: theme.textTheme.titleLarge),
                    const SizedBox(height: 6),
                    Text(
                      'A premium morning dashboard for coins, XP, weather, and world depth.',
                      style: theme.textTheme.bodyMedium?.copyWith(
                        color: AppColors.textSecondary,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 22),
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(26),
              color: Colors.white.withValues(alpha: 0.05),
              border: Border.all(color: Colors.white.withValues(alpha: 0.08)),
            ),
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'World Weather',
                        style: theme.textTheme.labelLarge?.copyWith(
                          color: AppColors.textSecondary,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text('Sunny / 8% Fog', style: theme.textTheme.titleLarge),
                    ],
                  ),
                ),
                SizedBox(
                  width: 72,
                  height: 72,
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      CircularProgressIndicator(
                        value: 0.72,
                        strokeWidth: 7,
                        backgroundColor: Colors.white.withValues(alpha: 0.08),
                        valueColor: const AlwaysStoppedAnimation(AppColors.primary),
                      ),
                      const Icon(Icons.wb_sunny_rounded, color: AppColors.coins),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 22),
          const Wrap(
            spacing: 12,
            runSpacing: 12,
            children: [
              _MetricChip(label: 'Coins', value: '120', color: AppColors.coins, icon: Icons.payments_outlined),
              _MetricChip(label: 'XP', value: '40/100', color: AppColors.xp, icon: Icons.auto_graph_outlined),
              _MetricChip(label: 'Health', value: '92', color: AppColors.success, icon: Icons.favorite_outline),
              _MetricChip(label: 'Energy', value: '84', color: AppColors.warning, icon: Icons.bolt_outlined),
              _MetricChip(label: 'Mood', value: 'Happy', color: AppColors.primary, icon: Icons.sentiment_satisfied_alt_outlined),
              _MetricChip(label: 'Weather', value: 'Sunny', color: AppColors.coins, icon: Icons.sunny),
              _MetricChip(label: 'Fog', value: '8%', color: AppColors.fog, icon: Icons.cloud_outlined),
              _MetricChip(label: 'Streak', value: '3 days', color: AppColors.primary, icon: Icons.local_fire_department_outlined),
            ],
          ),
        ],
      ),
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
    return Container(
      width: 154,
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(24),
        color: AppColors.surfaceElevated.withValues(alpha: 0.88),
        border: Border.all(color: AppColors.divider),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: color, size: 20),
          const SizedBox(height: 14),
          Text(label, style: Theme.of(context).textTheme.labelMedium?.copyWith(color: AppColors.textSecondary)),
          const SizedBox(height: 4),
          Text(value, style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w800)),
        ],
      ),
    );
  }
}

class _MissionCarousel extends StatelessWidget {
  const _MissionCarousel();

  @override
  Widget build(BuildContext context) {
    const missions = [
      ('5,000 steps', 'Forest Growth +45', Icons.directions_walk_outlined),
      ('Read 20 pages', 'Library Upgrade +20', Icons.menu_book_outlined),
      ('90 min focus', 'Fog Reduction -12%', Icons.psychology_alt_outlined),
    ];

    return SizedBox(
      height: 190,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: missions.length,
        separatorBuilder: (_, _) => const SizedBox(width: 14),
        itemBuilder: (context, index) {
          final mission = missions[index];
          return SizedBox(
            width: 250,
            child: GlassCard(
              borderRadius: 30,
              gradient: LinearGradient(
                colors: [
                  AppColors.surfaceElevated,
                  index.isEven ? const Color(0xFF28160F) : const Color(0xFF13202A),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Icon(mission.$3, color: AppColors.primary, size: 24),
                  const Spacer(),
                  Text(mission.$1, style: Theme.of(context).textTheme.titleLarge),
                  const SizedBox(height: 8),
                  Text(mission.$2, style: Theme.of(context).textTheme.bodyMedium),
                  const SizedBox(height: 16),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(999),
                    child: LinearProgressIndicator(
                      minHeight: 8,
                      value: 0.34 + (index * 0.2),
                      backgroundColor: Colors.white.withValues(alpha: 0.08),
                      valueColor: const AlwaysStoppedAnimation(AppColors.primary),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

class _ActivitySummary extends StatelessWidget {
  const _ActivitySummary();

  @override
  Widget build(BuildContext context) {
    return const Wrap(
      spacing: 14,
      runSpacing: 14,
      children: [
        _SummaryCard(title: 'Focus Time', value: '2h 14m', detail: '+18% vs yesterday', color: AppColors.xp),
        _SummaryCard(title: 'Hydration', value: '1.6L', detail: '80% of daily goal', color: AppColors.success),
        _SummaryCard(title: 'Coins Earned', value: '+54', detail: 'Reward pace is strong', color: AppColors.coins),
        _SummaryCard(title: 'Streak Power', value: '3 days', detail: 'Keep the world sunny', color: AppColors.primary),
      ],
    );
  }
}

class _SummaryCard extends StatelessWidget {
  const _SummaryCard({
    required this.title,
    required this.value,
    required this.detail,
    required this.color,
  });

  final String title;
  final String value;
  final String detail;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 168,
      child: GlassCard(
        borderRadius: 28,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(width: 12, height: 12, decoration: BoxDecoration(color: color, shape: BoxShape.circle)),
            const SizedBox(height: 22),
            Text(title, style: Theme.of(context).textTheme.labelLarge),
            const SizedBox(height: 6),
            Text(value, style: Theme.of(context).textTheme.titleLarge),
            const SizedBox(height: 8),
            Text(detail, style: Theme.of(context).textTheme.bodySmall),
          ],
        ),
      ),
    );
  }
}

class _QuickActions extends StatelessWidget {
  const _QuickActions();

  @override
  Widget build(BuildContext context) {
    const actions = [
      ('Workout', Icons.fitness_center_outlined),
      ('Study', Icons.school_outlined),
      ('Code', Icons.code_outlined),
      ('Read', Icons.auto_stories_outlined),
      ('Meditate', Icons.self_improvement_outlined),
    ];

    return Wrap(
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
    );
  }
}
