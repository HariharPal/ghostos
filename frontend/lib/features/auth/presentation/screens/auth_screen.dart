import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:ghostos/core/constants/app_copy.dart';
import 'package:ghostos/core/theme/app_colors.dart';
import 'package:ghostos/core/widgets/glass_card.dart';
import 'package:ghostos/features/auth/presentation/providers/auth_controller.dart';
import 'package:ghostos/features/auth/presentation/widgets/auth_text_field.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:supabase/supabase.dart';

class AuthScreen extends HookConsumerWidget {
  const AuthScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isSignIn = useState(true);
    final emailController = useTextEditingController();
    final passwordController = useTextEditingController();
    final obscurePassword = useState(true);
    final authState = ref.watch(authControllerProvider);
    final authController = ref.read(authControllerProvider.notifier);
    final theme = Theme.of(context);

    void showMessage(String message) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(message)),
      );
    }

    Future<void> submit() async {
      final email = emailController.text.trim();
      final password = passwordController.text;

      if (email.isEmpty || password.isEmpty) {
        showMessage('Email and password are required.');
        return;
      }

      try {
        if (isSignIn.value) {
          await authController.signInWithEmail(email: email, password: password);
        } else {
          final message = await authController.signUpWithEmail(
            email: email,
            password: password,
          );
          if (message != null && context.mounted) {
            showMessage(message);
          }
        }
      } on AuthException catch (error) {
        if (context.mounted) {
          showMessage(error.message);
        }
      } catch (error) {
        if (context.mounted) {
          showMessage(error.toString());
        }
      }
    }

    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(color: AppColors.background),
        child: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.fromLTRB(20, 20, 20, 32),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Hero(
                  tag: 'ghostos-mark',
                  child: Container(
                    width: 66,
                    height: 66,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      gradient: const LinearGradient(
                        colors: [AppColors.primary, Color(0xFFFF7B3D)],
                      ),
                      boxShadow: [
                        BoxShadow(
                          blurRadius: 34,
                          color: AppColors.primary.withValues(alpha: 0.28),
                        ),
                      ],
                    ),
                    child: const Icon(
                      Icons.emoji_emotions_rounded,
                      color: Colors.white,
                    ),
                  ),
                ),
                const SizedBox(height: 24),
                Text(
                  'Welcome back to your world.',
                  style: theme.textTheme.headlineMedium,
                ),
                const SizedBox(height: 10),
                Text(
                  'Strava-level polish, GhostOS energy. Sign in to continue your streaks, missions, and ghost upgrades.',
                  style: theme.textTheme.bodyLarge?.copyWith(
                    color: AppColors.textSecondary,
                  ),
                ),
                const SizedBox(height: 28),
                GlassCard(
                  borderRadius: 34,
                  gradient: LinearGradient(
                    colors: [
                      AppColors.surfaceElevated.withValues(alpha: 0.95),
                      AppColors.surface.withValues(alpha: 0.90),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _PillLabel(label: 'AUTHENTICATION'),
                      const SizedBox(height: 18),
                      SegmentedButton<bool>(
                        segments: const [
                          ButtonSegment<bool>(
                            value: true,
                            label: Text('Sign In'),
                          ),
                          ButtonSegment<bool>(
                            value: false,
                            label: Text('Sign Up'),
                          ),
                        ],
                        selected: {isSignIn.value},
                        onSelectionChanged: (selection) {
                          isSignIn.value = selection.first;
                        },
                      ),
                      const SizedBox(height: 24),
                      AuthTextField(
                        controller: emailController,
                        keyboardType: TextInputType.emailAddress,
                        label: 'Email',
                        hintText: 'you@ghostos.app',
                        prefixIcon: Icons.mail_outline_rounded,
                      ),
                      const SizedBox(height: 16),
                      AuthTextField(
                        controller: passwordController,
                        label: 'Password',
                        hintText: 'Enter your password',
                        prefixIcon: Icons.lock_outline_rounded,
                        obscureText: obscurePassword.value,
                        suffix: IconButton(
                          onPressed: () => obscurePassword.value = !obscurePassword.value,
                          icon: Icon(
                            obscurePassword.value
                                ? Icons.visibility_off_rounded
                                : Icons.visibility_rounded,
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: authState.isSubmitting ? null : submit,
                          child: Text(
                            authState.isSubmitting
                                ? 'Syncing...'
                                : isSignIn.value
                                    ? 'Enter GhostOS'
                                    : 'Create Account',
                          ),
                        ),
                      ),
                      const SizedBox(height: 12),
                      const OutlinedButton.icon(
                        onPressed: null,
                        icon: Icon(Icons.g_mobiledata_rounded, size: 28),
                        label: Text('Google Sign-In Soon'),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        'Email sign-in is live. Google OAuth will be added once the mobile-safe auth flow is wired.',
                        style: theme.textTheme.bodySmall?.copyWith(
                          color: Colors.white.withValues(alpha: 0.62),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 24),
                _MotivationStrip(
                  message: isSignIn.value
                      ? 'Your Ghost kept the lights warm while you were away.'
                      : 'Create your ghost. Start clearing the weather.',
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _PillLabel extends StatelessWidget {
  const _PillLabel({required this.label});

  final String label;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
      decoration: BoxDecoration(
        color: AppColors.primarySoft,
        borderRadius: BorderRadius.circular(999),
      ),
      child: Text(
        label,
        style: Theme.of(context).textTheme.labelSmall?.copyWith(
              color: AppColors.primary,
              fontWeight: FontWeight.w800,
              letterSpacing: 1.2,
            ),
      ),
    );
  }
}

class _MotivationStrip extends StatelessWidget {
  const _MotivationStrip({required this.message});

  final String message;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(24),
        color: AppColors.surface,
        border: Border.all(color: AppColors.divider),
      ),
      child: Row(
        children: [
          const Icon(Icons.auto_awesome_rounded),
          const SizedBox(width: 12),
          Expanded(child: Text(message)),
        ],
      ),
    );
  }
}
