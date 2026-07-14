import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:ghostos/core/theme/app_colors.dart';
import 'package:ghostos/features/activity/presentation/screens/activity_screen.dart';
import 'package:ghostos/features/auth/presentation/providers/auth_controller.dart';
import 'package:ghostos/features/auth/presentation/screens/auth_screen.dart';
import 'package:ghostos/features/home/presentation/screens/home_screen.dart';
import 'package:ghostos/features/notifications/presentation/screens/notifications_screen.dart';
import 'package:ghostos/features/record/presentation/screens/record_screen.dart';
import 'package:ghostos/features/splash/presentation/screens/splash_screen.dart';
import 'package:ghostos/features/you/presentation/screens/settings_screen.dart';
import 'package:ghostos/features/you/presentation/screens/you_screen.dart';

final _rootNavigatorKey = GlobalKey<NavigatorState>();

final appRouterProvider = Provider<GoRouter>((ref) {
  final authState = ref.watch(authControllerProvider);

  return GoRouter(
    navigatorKey: _rootNavigatorKey,
    initialLocation: '/splash',
    routes: [
      GoRoute(
        path: '/splash',
        builder: (context, state) => const SplashScreen(),
      ),
      GoRoute(
        path: '/auth',
        builder: (context, state) => const AuthScreen(),
      ),
      GoRoute(
        path: '/notifications',
        builder: (context, state) => const NotificationsScreen(),
      ),
      GoRoute(
        path: '/settings',
        builder: (context, state) => const SettingsScreen(),
      ),
      StatefulShellRoute.indexedStack(
        builder: (context, state, navigationShell) {
          return AppShell(navigationShell: navigationShell);
        },
        branches: [
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: '/home',
                builder: (context, state) => const HomeScreen(),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: '/activity',
                builder: (context, state) => const ActivityScreen(),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: '/record',
                builder: (context, state) => const RecordScreen(),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: '/you',
                builder: (context, state) => const YouScreen(),
              ),
            ],
          ),
        ],
      ),
    ],
    redirect: (context, state) {
      final location = state.matchedLocation;
      final isAuthenticated = authState.status == AuthStatus.authenticated;
      final isBooting = !authState.isInitialized;
      final isAtSplash = location == '/splash';
      final isAtAuth = location == '/auth';

      if (isBooting && !isAtSplash) {
        return '/splash';
      }

      if (!isBooting && isAtSplash) {
        return isAuthenticated ? '/home' : '/auth';
      }

      if (!isAuthenticated && !isAtAuth) {
        return '/auth';
      }

      if (isAuthenticated && isAtAuth) {
        return '/home';
      }

      return null;
    },
  );
});

class AppShell extends StatelessWidget {
  const AppShell({
    required this.navigationShell,
    super.key,
  });

  final StatefulNavigationShell navigationShell;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: navigationShell,
      extendBody: true,
      bottomNavigationBar: SafeArea(
        minimum: const EdgeInsets.fromLTRB(18, 0, 18, 16),
        child: DecoratedBox(
          decoration: BoxDecoration(
            color: AppColors.surfaceElevated.withValues(alpha: 0.96),
            borderRadius: BorderRadius.circular(30),
            border: Border.all(color: AppColors.divider),
            boxShadow: [
              BoxShadow(
                blurRadius: 28,
                offset: const Offset(0, 16),
                color: Colors.black.withValues(alpha: 0.35),
              ),
            ],
          ),
          child: NavigationBar(
            height: 74,
            selectedIndex: navigationShell.currentIndex,
            destinations:  [
              NavigationDestination(
                icon: Icon(Icons.home_rounded),
                label: 'Home',
              ),
              NavigationDestination(
                icon: Icon(Icons.insights_rounded),
                label: 'Activity',
              ),
              NavigationDestination(
                icon: Icon(Icons.radio_button_checked_rounded),
                label: 'Record',
              ),
              NavigationDestination(
                icon: Icon(Icons.person_rounded),
                label: 'You',
              ),
            ],
            onDestinationSelected: (index) {
              navigationShell.goBranch(
                index,
                initialLocation: index == navigationShell.currentIndex,
              );
            },
          ),
        ),
      ),
    );
  }
}
