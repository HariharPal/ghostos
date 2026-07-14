import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class GhostNotification {
  const GhostNotification({
    required this.id,
    required this.title,
    required this.message,
    required this.timestamp,
    required this.icon,
    required this.color,
    this.isRead = false,
  });

  final String id;
  final String title;
  final String message;
  final String timestamp;
  final IconData icon;
  final Color color;
  final bool isRead;

  GhostNotification copyWith({bool? isRead}) {
    return GhostNotification(
      id: id,
      title: title,
      message: message,
      timestamp: timestamp,
      icon: icon,
      color: color,
      isRead: isRead ?? this.isRead,
    );
  }
}

class NotificationsController extends StateNotifier<List<GhostNotification>> {
  NotificationsController()
      : super(
          const [
            GhostNotification(
              id: 'focus-1',
              title: 'Focus Session Complete',
              message: 'Your 52-minute focus sprint earned 18 XP and calmed the fog.',
              timestamp: '5 min ago',
              icon: Icons.timer_rounded,
              color: Color(0xFF3FA3FF),
            ),
            GhostNotification(
              id: 'ghost-1',
              title: 'Ghost Evolution Near',
              message: 'Two more healthy sessions will unlock your ghost’s next aura.',
              timestamp: '32 min ago',
              icon: Icons.auto_awesome_rounded,
              color: Color(0xFFFC4C02),
            ),
            GhostNotification(
              id: 'achievement-1',
              title: 'Achievement Unlocked',
              message: 'You reached a 12-day study streak. The library looks brighter already.',
              timestamp: '1 hr ago',
              icon: Icons.emoji_events_rounded,
              color: Color(0xFFFFC94A),
            ),
            GhostNotification(
              id: 'water-1',
              title: 'Hydration Reminder',
              message: 'Your ghost would like one glass of water before the next focus block.',
              timestamp: '2 hr ago',
              icon: Icons.water_drop_rounded,
              color: Color(0xFF38D996),
              isRead: true,
            ),
            GhostNotification(
              id: 'workout-1',
              title: 'Workout Reminder',
              message: 'A short movement break can boost energy and clear cloud cover.',
              timestamp: '3 hr ago',
              icon: Icons.fitness_center_rounded,
              color: Color(0xFFFFC247),
              isRead: true,
            ),
            GhostNotification(
              id: 'sleep-1',
              title: 'Sleep Insight',
              message: 'You slept 7h 24m last night. Keep that rhythm for bonus recovery XP.',
              timestamp: 'Yesterday',
              icon: Icons.bedtime_rounded,
              color: Color(0xFF8E95A9),
              isRead: true,
            ),
          ],
        );

  void markRead(String id) {
    state = [
      for (final item in state)
        if (item.id == id) item.copyWith(isRead: true) else item,
    ];
  }

  void dismiss(String id) {
    state = state.where((item) => item.id != id).toList();
  }
}

final notificationsControllerProvider =
    StateNotifierProvider<NotificationsController, List<GhostNotification>>(
  (ref) => NotificationsController(),
);
