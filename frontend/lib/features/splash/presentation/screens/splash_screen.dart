import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:ghostos/core/constants/app_assets.dart';
import 'package:ghostos/core/constants/app_copy.dart';
import 'package:ghostos/core/theme/app_colors.dart';
import 'package:ghostos/core/widgets/glass_card.dart';
import 'package:ghostos/features/auth/presentation/providers/auth_controller.dart';

class SplashScreen extends ConsumerStatefulWidget {
  const SplashScreen({super.key});

  @override
  ConsumerState<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends ConsumerState<SplashScreen> {
  Timer? _timer;
  bool _delayComplete = false;
  bool _navigated = false;

  @override
  void initState() {
    super.initState();
    _timer = Timer(const Duration(milliseconds: 1200), () {
      _delayComplete = true;
      _navigateIfReady();
    });
  }

  void _navigateIfReady() {
    if (!mounted || _navigated || !_delayComplete) {
      return;
    }

    final authState = ref.read(authControllerProvider);
    if (!authState.isInitialized) {
      return;
    }

    _navigated = true;
    context.go(
      authState.status == AuthStatus.authenticated ? '/home' : '/auth',
    );
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    ref.listen<AuthViewState>(authControllerProvider, (previous, next) {
      if (next.isInitialized) {
        _navigateIfReady();
      }
    });

    final theme = Theme.of(context);

    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(color: AppColors.background),
        child: Stack(
          children: [
            const Positioned(
              top: -80,
              left: -40,
              child: _GlowOrb(
                size: 220,
                colors: AppColors.weatherGlow,
              ),
            ),
            const Positioned(
              bottom: -50,
              right: -50,
              child: _GlowOrb(
                size: 260,
                colors: [Color(0xFF252527), Color(0xFFFC4C02)],
              ),
            ),
            SafeArea(
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.all(24),
                  child: ConstrainedBox(
                    constraints: const BoxConstraints(maxWidth: 360),
                    child: GlassCard(
                      padding: const EdgeInsets.all(28),
                      borderRadius: 36,
                      gradient: LinearGradient(
                        colors: [
                          AppColors.surfaceElevated.withValues(alpha: 0.92),
                          AppColors.surface.withValues(alpha: 0.88),
                        ],
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Hero(
                            tag: 'ghostos-mark',
                            child: Container(
                              width: 96,
                              height: 96,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                boxShadow: [
                                  BoxShadow(
                                    blurRadius: 48,
                                    color: theme.colorScheme.primary
                                        .withValues(alpha: 0.26),
                                  ),
                                ],
                              ),
                              child: ClipOval(
                                child: Image.asset(
                                  AppAssets.applicationLogo,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(height: 24),
                          Text(
                            AppCopy.appName,
                            style: theme.textTheme.headlineMedium,
                          ),
                          const SizedBox(height: 10),
                          Text(
                            AppCopy.tagline,
                            textAlign: TextAlign.center,
                            style: theme.textTheme.bodyLarge,
                          ),
                          const SizedBox(height: 10),
                          Text(
                            'A premium world for your streaks, focus, and fitness.',
                            textAlign: TextAlign.center,
                            style: theme.textTheme.bodySmall,
                          ),
                          const SizedBox(height: 28),
                          ClipRRect(
                            borderRadius: BorderRadius.circular(999),
                            child: const LinearProgressIndicator(
                              minHeight: 7,
                              value: null,
                              backgroundColor: Color(0x22FFFFFF),
                              valueColor:
                                  AlwaysStoppedAnimation(AppColors.primary),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _GlowOrb extends StatelessWidget {
  const _GlowOrb({
    required this.size,
    required this.colors,
  });

  final double size;
  final List<Color> colors;

  @override
  Widget build(BuildContext context) {
    return IgnorePointer(
      child: Container(
        width: size,
        height: size,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          gradient: RadialGradient(
            colors: [
              colors.first.withValues(alpha: 0.30),
              colors.last.withValues(alpha: 0.04),
              Colors.transparent,
            ],
          ),
        ),
      ),
    );
  }
}
