# GhostOS Memory

## Project Overview
- Project: GhostOS
- Tagline: Your Habits Build Your World
- Goal: Build a production-quality Flutter app with direct Supabase integration and a premium gamified habit-tracking experience.
- Current Sprint: Sprint 1 foundation plus premium UI redesign.

## Technology Stack
- Frontend: Flutter, Material 3, Riverpod, Hooks, GoRouter, Hive, Lottie, Supabase, flutter_dotenv
- Architecture: frontend-only app in `frontend/` with direct Supabase access

## Architecture Decisions
- Frontend uses feature-first organization under `frontend/lib/features`.
- Shared app concerns live under `frontend/lib/core` and `frontend/lib/app`.
- Router uses GoRouter with splash gating, auth gating, and a four-tab shell.
- Auth is state-driven with Riverpod and direct Supabase email/password auth.
- Bottom navigation remains locked to `Home`, `Activity`, `Record`, and `You`.
- Google OAuth remains visually deferred in the UI until a mobile-safe flow is added.

## Folder Structure
- `frontend/lib/app`: app root
- `frontend/lib/bootstrap`: bootstrap entry
- `frontend/lib/core/constants`: copy and shared constants
- `frontend/lib/core/navigation`: router and floating app shell
- `frontend/lib/core/theme`: theme tokens and theme system
- `frontend/lib/core/widgets`: reusable premium UI widgets
- `frontend/lib/features/*`: feature-first presentation scaffolds
- `.ai`: persistent project memory

## Completed Screens
- Premium Splash screen
- Premium Authentication screen
- Floating app shell with four-tab bottom navigation
- Premium Home dashboard shell
- Premium Activity analytics shell
- Premium Record shell
- Premium You/Profile shell

## Pending Screens
- Rich data-backed Home dashboard behavior
- Real analytics charts and heatmaps
- Manual record forms and entry flows
- Full profile/settings/subscription experience

## Completed Features
- Material 3 premium dark theme with Strava-inspired palette
- Splash -> auth -> shell routing flow
- Direct Supabase client configured with implicit auth flow
- Google sign-in button disabled safely instead of throwing
- Reusable premium widgets: `GlassCard`, `GhostAppBar`, `SectionHeader`, `AuthTextField`
- Floating navigation shell with rounded corners and orange active state
- UI redesign across splash, auth, home, activity, record, and profile surfaces

## Pending Features
- Rich Supabase-backed data display
- Hive bootstrapping strategy
- Mission engine
- Ghost world simulation
- Fitness integrations
- Notifications
- Testing and deployment

## Navigation Flow
- `/splash` -> `/auth` when no session
- `/splash` -> `/home` when authenticated
- Authenticated shell tabs: `/home`, `/activity`, `/record`, `/you`

## Reusable Widgets
- `GlassCard`
- `GhostAppBar`
- `SectionHeader`
- `AuthTextField`

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
- Several `.ai` support files still contain older scaffold-era notes and should be normalized in a future cleanup pass.
- Feature screens are visually upgraded but still intentionally use placeholder content where full sprint functionality has not been built yet.

## Current Sprint Notes
- Date: 2026-07-14
- Prompt summary: Redesign the GhostOS Flutter UI to a premium Strava-inspired experience while preserving behavior and architecture.
- Files modified: theme system, shared widgets, auth UI, splash UI, shell navigation, and the four main tab screens.
- Important reason: raise perceived product quality and create a consistent premium design language without changing application logic.

## Next Sprint
- Sprint 2: make the premium Home dashboard data-driven with animated ghost presentation, missions, rewards, and richer activity summaries.
