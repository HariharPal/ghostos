import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ghostos/core/providers/supabase_provider.dart';
import 'package:supabase/supabase.dart';

enum AuthStatus { unknown, unauthenticated, authenticated }

class AuthViewState {
  const AuthViewState({
    required this.status,
    required this.isInitialized,
    required this.isSubmitting,
  });

  final AuthStatus status;
  final bool isInitialized;
  final bool isSubmitting;

  AuthViewState copyWith({
    AuthStatus? status,
    bool? isInitialized,
    bool? isSubmitting,
  }) {
    return AuthViewState(
      status: status ?? this.status,
      isInitialized: isInitialized ?? this.isInitialized,
      isSubmitting: isSubmitting ?? this.isSubmitting,
    );
  }
}

class AuthController extends StateNotifier<AuthViewState> {
  AuthController(this._client)
      : super(
          const AuthViewState(
            status: AuthStatus.unknown,
            isInitialized: false,
            isSubmitting: false,
          ),
        ) {
    _initialize();
  }

  final SupabaseClient _client;
  StreamSubscription<AuthState>? _authStateSubscription;

  void _initialize() {
    final currentSession = _client.auth.currentSession;
    state = state.copyWith(
      status: currentSession == null
          ? AuthStatus.unauthenticated
          : AuthStatus.authenticated,
      isInitialized: true,
      isSubmitting: false,
    );

    _authStateSubscription = _client.auth.onAuthStateChange.listen((event) {
      state = state.copyWith(
        status: event.session == null
            ? AuthStatus.unauthenticated
            : AuthStatus.authenticated,
        isInitialized: true,
        isSubmitting: false,
      );
    });
  }

  Future<void> signInWithEmail({
    required String email,
    required String password,
  }) async {
    state = state.copyWith(isSubmitting: true);
    try {
      await _client.auth.signInWithPassword(
        email: email,
        password: password,
      );
    } catch (_) {
      state = state.copyWith(isSubmitting: false);
      rethrow;
    }
  }

  Future<String?> signUpWithEmail({
    required String email,
    required String password,
  }) async {
    state = state.copyWith(isSubmitting: true);
    try {
      final response = await _client.auth.signUp(
        email: email,
        password: password,
      );
      state = state.copyWith(isSubmitting: false);
      if (response.session == null) {
        return 'Account created. Confirm your email to finish signing in.';
      }
      return null;
    } catch (_) {
      state = state.copyWith(isSubmitting: false);
      rethrow;
    }
  }

  Future<void> signInWithGoogle() async {
    state = state.copyWith(isSubmitting: false);
  }

  Future<void> signOut() async {
    await _client.auth.signOut();
  }

  @override
  void dispose() {
    _authStateSubscription?.cancel();
    super.dispose();
  }
}

final authControllerProvider =
    StateNotifierProvider<AuthController, AuthViewState>(
  (ref) => AuthController(ref.watch(supabaseClientProvider)),
);
