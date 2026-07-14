import 'package:flutter/material.dart';
import 'package:ghostos/core/theme/app_colors.dart';
import 'package:ghostos/core/widgets/ghost_app_bar.dart';
import 'package:ghostos/core/widgets/glass_card.dart';

class RecordScreen extends StatelessWidget {
  const RecordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: GhostAppBar(planLabel: 'FREE', onNotificationsTap: () {}, onSearchTap: () {}),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(18, 8, 18, 120),
        children: const [
          _Header(),
          SizedBox(height: 18),
          _Categories(),
          SizedBox(height: 18),
          _RecordPanel(),
        ],
      ),
    );
  }
}

class _Header extends StatelessWidget {
  const _Header();
  @override
  Widget build(BuildContext context) {
    return GlassCard(
      borderRadius: 34,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Record', style: Theme.of(context).textTheme.headlineMedium),
          const SizedBox(height: 8),
          Text('Capture a workout, task, or moment with a premium action layout.', style: Theme.of(context).textTheme.bodyMedium),
        ],
      ),
    );
  }
}

class _Categories extends StatelessWidget {
  const _Categories();
  @override
  Widget build(BuildContext context) {
    const items = [
      ('Workout', Icons.fitness_center_outlined),
      ('Study', Icons.school_outlined),
      ('Mindful', Icons.self_improvement_outlined),
      ('Custom', Icons.add_circle_outline),
    ];
    return Wrap(
      spacing: 12,
      runSpacing: 12,
      children: items.map((item) {
        return Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
          decoration: BoxDecoration(
            color: AppColors.surfaceElevated,
            borderRadius: BorderRadius.circular(22),
            border: Border.all(color: AppColors.divider),
          ),
          child: Row(mainAxisSize: MainAxisSize.min, children: [Icon(item.$2, color: AppColors.primary, size: 20), const SizedBox(width: 10), Text(item.$1)]),
        );
      }).toList(),
    );
  }
}

class _RecordPanel extends StatelessWidget {
  const _RecordPanel();
  @override
  Widget build(BuildContext context) {
    return GlassCard(
      borderRadius: 34,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Quick Start', style: Theme.of(context).textTheme.titleLarge),
          const SizedBox(height: 12),
          _Slider(label: 'Intensity', value: 0.78, color: AppColors.primary),
          const SizedBox(height: 14),
          _Slider(label: 'Duration', value: 0.52, color: AppColors.xp),
          const SizedBox(height: 14),
          SizedBox(width: double.infinity, child: ElevatedButton(onPressed: () {}, child: const Text('Start Recording'))),
        ],
      ),
    );
  }
}

class _Slider extends StatelessWidget {
  const _Slider({required this.label, required this.value, required this.color});
  final String label;
  final double value;
  final Color color;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label),
        const SizedBox(height: 8),
        ClipRRect(
          borderRadius: BorderRadius.circular(999),
          child: LinearProgressIndicator(minHeight: 10, value: value, backgroundColor: Colors.white12, valueColor: AlwaysStoppedAnimation(color)),
        ),
      ],
    );
  }
}
