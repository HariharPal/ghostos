import 'package:flutter/material.dart';
import 'package:ghostos/core/theme/app_colors.dart';
import 'package:ghostos/core/widgets/ghost_app_bar.dart';
import 'package:ghostos/core/widgets/glass_card.dart';

class YouScreen extends StatelessWidget {
  const YouScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: GhostAppBar(planLabel: 'PRO', onNotificationsTap: () {}, onSearchTap: () {}),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(18, 8, 18, 120),
        children: const [
          _ProfileHeader(),
          SizedBox(height: 18),
          _StatsGrid(),
          SizedBox(height: 18),
          _SettingsList(),
        ],
      ),
    );
  }
}

class _ProfileHeader extends StatelessWidget {
  const _ProfileHeader();
  @override
  Widget build(BuildContext context) {
    return GlassCard(
      borderRadius: 34,
      child: Row(
        children: [
          Container(
            width: 72,
            height: 72,
            decoration: const BoxDecoration(shape: BoxShape.circle, gradient: LinearGradient(colors: [AppColors.primary, Color(0xFFFF7B3D)])),
            child: const Icon(Icons.person, color: Colors.white),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text('Vinayak', style: Theme.of(context).textTheme.headlineSmall),
              const SizedBox(height: 6),
              Text('Ghost runner · 3 day streak · 120 coins', style: Theme.of(context).textTheme.bodyMedium),
            ]),
          ),
        ],
      ),
    );
  }
}

class _StatsGrid extends StatelessWidget {
  const _StatsGrid();
  @override
  Widget build(BuildContext context) {
    return const Wrap(
      spacing: 14,
      runSpacing: 14,
      children: [
        _MiniStat(title: 'Achievements', value: '12', color: AppColors.primary),
        _MiniStat(title: 'Inventory', value: '24', color: AppColors.coins),
        _MiniStat(title: 'Rank', value: 'A2', color: AppColors.xp),
        _MiniStat(title: 'Mood', value: 'Great', color: AppColors.success),
      ],
    );
  }
}

class _MiniStat extends StatelessWidget {
  const _MiniStat({required this.title, required this.value, required this.color});
  final String title;
  final String value;
  final Color color;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 168,
      child: GlassCard(
        borderRadius: 26,
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Container(width: 12, height: 12, decoration: BoxDecoration(color: color, shape: BoxShape.circle)),
          const SizedBox(height: 18),
          Text(title, style: Theme.of(context).textTheme.labelLarge),
          const SizedBox(height: 6),
          Text(value, style: Theme.of(context).textTheme.titleLarge),
        ]),
      ),
    );
  }
}

class _SettingsList extends StatelessWidget {
  const _SettingsList();
  @override
  Widget build(BuildContext context) {
    const rows = ['Subscription', 'Notifications', 'Privacy', 'Appearance'];
    return Column(
      children: rows
          .map((row) => Padding(
                padding: const EdgeInsets.only(bottom: 12),
                child: GlassCard(
                  borderRadius: 24,
                  child: Row(
                    children: [
                      Text(row, style: Theme.of(context).textTheme.titleMedium),
                      const Spacer(),
                      const Icon(Icons.chevron_right_rounded),
                    ],
                  ),
                ),
              ))
          .toList(),
    );
  }
}
