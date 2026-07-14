# GhostOS Memory

## Project Overview
- Project: GhostOS
- Tagline: Your Habits Build Your World
- Goal: Build a production-quality Flutter app with direct Supabase integration and a premium gamified habit-tracking experience.
- Current Sprint: Sprint 2 UI systems and dashboard maturation.

## Technology Stack
- Frontend: Flutter, Material 3, Riverpod, Hooks, GoRouter, Hive, Lottie, Supabase, flutter_dotenv
- Architecture: frontend-only app in `frontend/` with direct Supabase access and local persistence through Hive

## Architecture Decisions
- Frontend uses feature-first organization under `frontend/lib/features`.
- Shared concerns live under `frontend/lib/core` and `frontend/lib/app`.
- Router uses GoRouter with splash gating, auth gating, two standalone routes (`/notifications`, `/settings`), and a four-tab shell.
- Auth is state-driven with Riverpod and direct Supabase email/password auth.
- App settings are persisted in Hive through `AppSettingsController`, including theme mode and notification preferences.
- Profile data is managed by `ProfileController`, with username fallback derived from the email prefix and local validation for reserved names.
- Bottom navigation remains locked to `Home`, `Activity`, `Record`, and `You`.
- Google OAuth remains visually deferred in the UI until a mobile-safe flow is added.

## Folder Structure
- `frontend/lib/app`: app root and theme wiring
- `frontend/lib/bootstrap`: startup initialization and Hive bootstrapping
- `frontend/lib/core/constants`: copy and storage keys
- `frontend/lib/core/navigation`: router and floating shell
- `frontend/lib/core/providers`: Supabase and app settings providers
- `frontend/lib/core/theme`: color tokens and light/dark theme system
- `frontend/lib/core/widgets`: reusable premium UI building blocks
- `frontend/lib/features/auth`: direct Supabase auth presentation and state
- `frontend/lib/features/home`: premium dashboard experience
- `frontend/lib/features/activity`: activity analytics overview
- `frontend/lib/features/record`: analytics and historical record dashboard
- `frontend/lib/features/notifications`: dummy notifications state and inbox screen
- `frontend/lib/features/you`: profile, settings entry points, and editable identity
- `.ai`: persistent project memory

## Completed Screens
- Premium Splash screen
- Premium Authentication screen
- Floating app shell with four-tab bottom navigation
- Premium Home dashboard with greeting, ghost companion, goals, timer, AI recommendation, challenge, activity, progress, and quick actions
- Premium Activity analytics shell
- Premium Record analytics dashboard with filters, metrics, heatmap, streak, summaries, achievements, journals, and sessions
- Premium You/Profile screen with no AppBar, editable identity, stats, and account actions
- Notifications inbox screen with read state and swipe-to-dismiss
- Settings screen with theme controls, notification preferences, privacy actions, and about section

## Completed Features
- Material 3 premium light and dark themes with dark as the default persisted mode
- Splash -> auth -> shell routing flow
- Direct Supabase client configured with implicit auth flow
- Google sign-in button disabled safely instead of throwing
- Hive application box bootstrapped during startup
- Persistent theme switching with instant application updates
- Persistent notification preference toggles
- Profile persistence for username and email
- Username fallback from email prefix when no explicit username is stored
- Reserved username validation with inline messaging
- Notification list state with realistic dummy records, read updates, and dismiss behavior
- Reusable premium widgets: `GlassCard`, `GhostAppBar`, `SectionHeader`, `AuthTextField`
- Floating navigation shell with rounded corners and orange active state

## Pending Features
- Replace placeholder profile persistence with real Supabase profile table sync
- Secure account deletion and password reset flows through authenticated backend-safe paths
- Rich Supabase-backed home and analytics data instead of dummy data
- Mission engine and ghost world simulation
- Fitness integrations
- Automated tests and deployment

## Navigation Flow
- `/splash` -> `/auth` when no session
- `/splash` -> `/home` when authenticated
- Authenticated shell tabs: `/home`, `/activity`, `/record`, `/you`
- Standalone authenticated routes: `/notifications`, `/settings`

## Reusable Widgets
- `GlassCard`
- `GhostAppBar`
- `SectionHeader`
- `AuthTextField`

## Files Created
- `frontend/lib/core/constants/app_storage_keys.dart`
- `frontend/lib/core/providers/app_settings_provider.dart`
- `frontend/lib/features/you/presentation/providers/profile_controller.dart`
- `frontend/lib/features/notifications/presentation/providers/notifications_controller.dart`
- `frontend/lib/features/notifications/presentation/screens/notifications_screen.dart`
- `frontend/lib/features/you/presentation/screens/settings_screen.dart`

## Files Modified
- `frontend/lib/app/ghostos_app.dart`
- `frontend/lib/bootstrap/bootstrap.dart`
- `frontend/lib/core/navigation/app_router.dart`
- `frontend/lib/core/theme/app_theme.dart`
- `frontend/lib/core/widgets/ghost_app_bar.dart`
- `frontend/lib/features/activity/presentation/screens/activity_screen.dart`
- `frontend/lib/features/home/presentation/screens/home_screen.dart`
- `frontend/lib/features/record/presentation/screens/record_screen.dart`
- `frontend/lib/features/you/presentation/screens/you_screen.dart`
- `.ai/memory.md`

## Dependencies
- `flutter_riverpod`
- `flutter_hooks`
- `hooks_riverpod`
- `go_router`
- `google_fonts`
- `intl`
- `hive`
- `hive_flutter`
- `lottie`
- `supabase`
- `flutter_dotenv`

## Known Issues
- Google OAuth is not active yet in the current mobile auth flow.
- Account deletion and password reset actions are surfaced in UI, but secure production execution still needs dedicated backend-safe flows.
- Dashboard and analytics screens currently use curated dummy data until database models are connected.

## Current Sprint Notes
- Date: 2026-07-14
- Sprint focus: complete the premium navigation-connected frontend pass without regenerating the architecture.
- Added persistent app settings and profile state backed by Hive.
- Introduced settings and notifications routes and screens.
- Rebuilt Home, Record, and You around a more cohesive premium mobile dashboard system.
- Fixed theme wiring so light and dark modes both exist while dark remains the persisted first-run default.

## Changelog
- 2026-07-14: Bootstrapped `frontend/` as the direct Supabase Flutter client and removed backend dependency from the runtime architecture.
- 2026-07-14: Added Hive-backed app settings, profile persistence, and notification state foundations.
- 2026-07-14: Reworked the major app surfaces into a premium Strava-inspired design system and connected navigation flows to notifications and settings.

## Next Sprint
- Sprint 3: connect profile, notifications, and dashboard analytics to real Supabase tables and introduce secure account-management flows.
