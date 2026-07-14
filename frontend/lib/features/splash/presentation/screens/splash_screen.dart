import 'package:flutter/material.dart';
import 'package:ghostos/core/constants/app_copy.dart';
import 'package:ghostos/core/theme/app_colors.dart';
import 'package:ghostos/core/widgets/glass_card.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
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
            Center(
              child: Padding(
                padding: const EdgeInsets.all(24),
                child: GlassCard(
                  padding: const EdgeInsets.all(32),
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
                          width: 108,
                          height: 108,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            gradient: const LinearGradient(
                              colors: [AppColors.primary, Color(0xFFFF7B3D)],
                            ),
                            boxShadow: [
                              BoxShadow(
                                blurRadius: 48,
                                color: theme.colorScheme.primary.withValues(alpha: 0.32),
                              ),
                            ],
                          ),
                          child: const Icon(
                            Icons.emoji_emotions_rounded,
                            size: 52,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      const SizedBox(height: 28),
                      Text(
                        AppCopy.appName,
                        style: theme.textTheme.headlineLarge,
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
                        child: LinearProgressIndicator(
                          minHeight: 7,
                          value: 0.68,
                          backgroundColor: Colors.white.withValues(alpha: 0.08),
                          valueColor: const AlwaysStoppedAnimation(AppColors.primary),
                        ),
                      ),
                    ],
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
