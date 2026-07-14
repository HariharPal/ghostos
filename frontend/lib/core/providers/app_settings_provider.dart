import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ghostos/core/constants/app_storage_keys.dart';
import 'package:hive_flutter/hive_flutter.dart';

class AppSettingsState {
  const AppSettingsState({
    required this.themeMode,
    required this.notificationsEnabled,
    required this.dailyReminders,
    required this.focusReminders,
    required this.achievementNotifications,
    required this.generalNotifications,
  });

  final ThemeMode themeMode;
  final bool notificationsEnabled;
  final bool dailyReminders;
  final bool focusReminders;
  final bool achievementNotifications;
  final bool generalNotifications;

  AppSettingsState copyWith({
    ThemeMode? themeMode,
    bool? notificationsEnabled,
    bool? dailyReminders,
    bool? focusReminders,
    bool? achievementNotifications,
    bool? generalNotifications,
  }) {
    return AppSettingsState(
      themeMode: themeMode ?? this.themeMode,
      notificationsEnabled: notificationsEnabled ?? this.notificationsEnabled,
      dailyReminders: dailyReminders ?? this.dailyReminders,
      focusReminders: focusReminders ?? this.focusReminders,
      achievementNotifications:
          achievementNotifications ?? this.achievementNotifications,
      generalNotifications:
          generalNotifications ?? this.generalNotifications,
    );
  }
}

class AppSettingsController extends StateNotifier<AppSettingsState> {
  AppSettingsController(this._box)
      : super(
          AppSettingsState(
            themeMode: _themeModeFromName(
              _box.get(AppStorageKeys.themeMode, defaultValue: 'dark') as String,
            ),
            notificationsEnabled: _box.get(
              AppStorageKeys.notificationsEnabled,
              defaultValue: true,
            ) as bool,
            dailyReminders:
                _box.get(AppStorageKeys.dailyReminders, defaultValue: true)
                    as bool,
            focusReminders:
                _box.get(AppStorageKeys.focusReminders, defaultValue: true)
                    as bool,
            achievementNotifications: _box.get(
                  AppStorageKeys.achievementNotifications,
                  defaultValue: true,
                ) as bool,
            generalNotifications:
                _box.get(AppStorageKeys.generalNotifications, defaultValue: true)
                    as bool,
          ),
        );

  final Box<dynamic> _box;

  static ThemeMode _themeModeFromName(String value) {
    switch (value) {
      case 'light':
        return ThemeMode.light;
      case 'system':
        return ThemeMode.system;
      default:
        return ThemeMode.dark;
    }
  }

  Future<void> setThemeMode(ThemeMode themeMode) async {
    state = state.copyWith(themeMode: themeMode);
    await _box.put(AppStorageKeys.themeMode, themeMode.name);
  }

  Future<void> setNotificationsEnabled(bool value) async {
    state = state.copyWith(notificationsEnabled: value);
    await _box.put(AppStorageKeys.notificationsEnabled, value);
  }

  Future<void> setDailyReminders(bool value) async {
    state = state.copyWith(dailyReminders: value);
    await _box.put(AppStorageKeys.dailyReminders, value);
  }

  Future<void> setFocusReminders(bool value) async {
    state = state.copyWith(focusReminders: value);
    await _box.put(AppStorageKeys.focusReminders, value);
  }

  Future<void> setAchievementNotifications(bool value) async {
    state = state.copyWith(achievementNotifications: value);
    await _box.put(AppStorageKeys.achievementNotifications, value);
  }

  Future<void> setGeneralNotifications(bool value) async {
    state = state.copyWith(generalNotifications: value);
    await _box.put(AppStorageKeys.generalNotifications, value);
  }
}

final appSettingsBoxProvider = Provider<Box<dynamic>>(
  (ref) => Hive.box<dynamic>(AppStorageKeys.appBox),
);

final appSettingsProvider =
    StateNotifierProvider<AppSettingsController, AppSettingsState>(
  (ref) => AppSettingsController(ref.watch(appSettingsBoxProvider)),
);
