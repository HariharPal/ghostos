import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ghostos/core/constants/app_storage_keys.dart';
import 'package:ghostos/core/providers/app_settings_provider.dart';
import 'package:ghostos/core/providers/supabase_provider.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:supabase/supabase.dart';

class ProfileState {
  const ProfileState({
    required this.email,
    required this.username,
    required this.level,
    required this.xp,
    required this.currentStreak,
    required this.focusCoins,
    required this.isSaving,
    required this.usernameError,
  });

  final String email;
  final String username;
  final int level;
  final int xp;
  final int currentStreak;
  final int focusCoins;
  final bool isSaving;
  final String? usernameError;

  ProfileState copyWith({
    String? email,
    String? username,
    int? level,
    int? xp,
    int? currentStreak,
    int? focusCoins,
    bool? isSaving,
    String? usernameError,
    bool clearUsernameError = false,
  }) {
    return ProfileState(
      email: email ?? this.email,
      username: username ?? this.username,
      level: level ?? this.level,
      xp: xp ?? this.xp,
      currentStreak: currentStreak ?? this.currentStreak,
      focusCoins: focusCoins ?? this.focusCoins,
      isSaving: isSaving ?? this.isSaving,
      usernameError:
          clearUsernameError ? null : usernameError ?? this.usernameError,
    );
  }
}

class ProfileController extends StateNotifier<ProfileState> {
  ProfileController(this._box, this._client)
      : super(
          ProfileState(
            email: _resolveEmail(_box, _client),
            username: _resolveUsername(_box, _client),
            level: 7,
            xp: 1840,
            currentStreak: 12,
            focusCoins: 485,
            isSaving: false,
            usernameError: null,
          ),
        );

  final Box<dynamic> _box;
  final SupabaseClient _client;
  static const _reservedUsernames = {
    'admin',
    'ghost',
    'ghostos',
    'support',
    'hari',
  };

  static String _resolveEmail(Box<dynamic> box, SupabaseClient client) {
    final stored = box.get(AppStorageKeys.profileEmail) as String?;
    final sessionEmail = client.auth.currentUser?.email;
    return (stored?.trim().isNotEmpty ?? false)
        ? stored!.trim()
        : (sessionEmail?.trim().isNotEmpty ?? false)
            ? sessionEmail!.trim()
            : 'ghost@ghostos.app';
  }

  static String _resolveUsername(Box<dynamic> box, SupabaseClient client) {
    final stored = box.get(AppStorageKeys.profileUsername) as String?;
    if (stored?.trim().isNotEmpty ?? false) {
      return stored!.trim();
    }

    final email = _resolveEmail(box, client);
    final prefix = email.split('@').first.trim();
    return prefix.isEmpty ? 'ghostuser' : prefix;
  }

  Future<bool> validateUsernameAvailability(String username) async {
    final normalized = username.trim().toLowerCase();
    await Future<void>.delayed(const Duration(milliseconds: 250));

    if (normalized.isEmpty) {
      state = state.copyWith(
        usernameError: 'Username cannot be empty.',
      );
      return false;
    }

    if (normalized == state.username.toLowerCase()) {
      state = state.copyWith(clearUsernameError: true);
      return true;
    }

    if (_reservedUsernames.contains(normalized)) {
      state = state.copyWith(
        usernameError: 'That username is already taken. Try another one.',
      );
      return false;
    }

    state = state.copyWith(clearUsernameError: true);
    return true;
  }

  Future<bool> saveProfile({
    required String username,
    required String email,
  }) async {
    final normalizedEmail = email.trim();
    final normalizedUsername = username.trim().isEmpty
        ? normalizedEmail.split('@').first.trim()
        : username.trim();

    final isAvailable = await validateUsernameAvailability(normalizedUsername);
    if (!isAvailable) {
      return false;
    }

    state = state.copyWith(isSaving: true, clearUsernameError: true);
    await _box.put(AppStorageKeys.profileEmail, normalizedEmail);
    await _box.put(AppStorageKeys.profileUsername, normalizedUsername);
    state = state.copyWith(
      email: normalizedEmail,
      username: normalizedUsername,
      isSaving: false,
      clearUsernameError: true,
    );
    return true;
  }
}

final profileControllerProvider =
    StateNotifierProvider<ProfileController, ProfileState>(
  (ref) => ProfileController(
    ref.watch(appSettingsBoxProvider),
    ref.watch(supabaseClientProvider),
  ),
);
