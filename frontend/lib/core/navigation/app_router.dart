import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:ghostos/core/theme/app_colors.dart';
import 'package:ghostos/features/activity/presentation/screens/activity_screen.dart';
import 'package:ghostos/features/auth/presentation/providers/auth_controller.dart';
import 'package:ghostos/features/auth/presentation/screens/auth_screen.dart';
import 'package:ghostos/features/home/presentation/screens/home_screen.dart';
import 'package:ghostos/features/record/presentation/screens/record_screen.dart';
import 'package:ghostos/features/splash/presentation/screens/splash_screen.dart';
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
        minimum: const EdgeInsets.fromLTRB(16, 0, 16, 14),
        child: Container(
          decoration: BoxDecoration(
            color: AppColors.surfaceElevated.withValues(alpha: 0.98),
            borderRadius: BorderRadius.circular(32),
            border: Border.all(color: AppColors.divider),
            boxShadow: [
              BoxShadow(
                blurRadius: 32,
                offset: const Offset(0, 18),
                color: Colors.black.withValues(alpha: 0.42),
              ),
            ],
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(32),
            child: NavigationBar(
              height: 76,
              backgroundColor: Colors.transparent,
              indicatorColor: AppColors.primarySoft,
              selectedIndex: navigationShell.currentIndex,
              labelBehavior: NavigationDestinationLabelBehavior.alwaysShow,
              destinations: const [
                NavigationDestination(
                  icon: Icon(Icons.home_outlined),
                  selectedIcon: Icon(Icons.home),
                  label: 'Home',
                ),
                NavigationDestination(
                  icon: Icon(Icons.query_stats_outlined),
                  selectedIcon: Icon(Icons.query_stats),
                  label: 'Activity',
                ),
                NavigationDestination(
                  icon: Icon(Icons.add_circle_outline),
                  selectedIcon: Icon(Icons.add_circle),
                  label: 'Record',
                ),
                NavigationDestination(
                  icon: Icon(Icons.person_outline),
                  selectedIcon: Icon(Icons.person),
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
      ),
    );
  }
}
