import 'package:flutter/material.dart';
import 'package:ghostos/core/theme/app_colors.dart';
import 'package:ghostos/core/widgets/ghost_app_bar.dart';
import 'package:ghostos/core/widgets/glass_card.dart';

class ActivityScreen extends StatelessWidget {
  const ActivityScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: GhostAppBar(
        planLabel: 'PRO',
        onNotificationsTap: () {},
        onSearchTap: () {},
      ),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(18, 8, 18, 120),
        children: const [
          _Overview(),
          SizedBox(height: 20),
          _RingRow(),
          SizedBox(height: 20),
          _Timeline(),
        ],
      ),
    );
  }
}

class _Overview extends StatelessWidget {
  const _Overview();
  @override
  Widget build(BuildContext context) {
    return GlassCard(
      borderRadius: 34,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Activity', style: Theme.of(context).textTheme.headlineMedium),
          const SizedBox(height: 8),
          Text('A polished readout of movement, focus, and ghost momentum.', style: Theme.of(context).textTheme.bodyMedium),
        ],
      ),
    );
  }
}

class _RingRow extends StatelessWidget {
  const _RingRow();
  @override
  Widget build(BuildContext context) {
    return const Wrap(
      spacing: 14,
      runSpacing: 14,
      children: [
        _RingCard(label: 'Steps', value: '8.4k', color: AppColors.primary, progress: 0.78),
        _RingCard(label: 'Focus', value: '2h', color: AppColors.xp, progress: 0.62),
        _RingCard(label: 'Hydration', value: '80%', color: AppColors.success, progress: 0.8),
        _RingCard(label: 'Fog', value: '8%', color: AppColors.coins, progress: 0.92),
      ],
    );
  }
}

class _RingCard extends StatelessWidget {
  const _RingCard({required this.label, required this.value, required this.color, required this.progress});
  final String label;
  final String value;
  final Color color;
  final double progress;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 168,
      child: GlassCard(
        borderRadius: 28,
        child: Column(
          children: [
            SizedBox(
              height: 96,
              width: 96,
              child: Stack(
                alignment: Alignment.center,
                children: [
                  CircularProgressIndicator(value: progress, strokeWidth: 10, backgroundColor: Colors.white12, valueColor: AlwaysStoppedAnimation(color)),
                  Text(value, style: Theme.of(context).textTheme.titleLarge),
                ],
              ),
            ),
            const SizedBox(height: 12),
            Text(label, style: Theme.of(context).textTheme.labelLarge),
          ],
        ),
      ),
    );
  }
}

class _Timeline extends StatelessWidget {
  const _Timeline();
  @override
  Widget build(BuildContext context) {
    return Column(
      children: List.generate(4, (i) {
        return Padding(
          padding: const EdgeInsets.only(bottom: 12),
          child: GlassCard(
            borderRadius: 24,
            child: Row(
              children: [
                Container(width: 12, height: 12, decoration: BoxDecoration(color: [AppColors.primary, AppColors.xp, AppColors.success, AppColors.coins][i], shape: BoxShape.circle)),
                const SizedBox(width: 14),
                Expanded(child: Text('Session ${i + 1} completed', style: Theme.of(context).textTheme.titleMedium)),
                Text('+${12 + i * 8}', style: Theme.of(context).textTheme.labelLarge?.copyWith(color: AppColors.primary)),
              ],
            ),
          ),
        );
      }),
    );
  }
}
