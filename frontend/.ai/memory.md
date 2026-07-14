# GhostOS UI Memory

## Current Direction
- Premium Strava-inspired dark fitness UI.
- Palette: `#FC4C02` accent, `#0F0F10` background, `#181818` surfaces, `#1F1F21` elevated cards, `#2A2A2A` dividers, white primary text, `#A9A9A9` secondary text.
- Success, warning, danger, XP, coins, and fog colors are standardized in `lib/core/theme/app_colors.dart`.

## Design System
- Typography uses `GoogleFonts.plusJakartaSans` through `AppTheme.dark`.
- Common corner radii: 22, 24, 28, 30, 34, 36.
- Glass cards use blur, translucent gradients, and soft borders.
- Buttons use large rounded shapes and strong orange primary actions.
- Navigation uses a floating rounded bottom bar with orange active accents.

## Shared Components
- `GhostAppBar` now shows profile avatar, centered GhostOS branding, plan badge, search, and notifications.
- `GlassCard` is the main reusable elevated surface.
- `SectionHeader` is used for premium section titles and supporting copy.

## Screen Notes
- Home is a premium dashboard with hero ghost card, weather summary, stat chips, mission carousel, and quick actions.
- Activity shows compact stats, progress rings, and timeline cards.
- Record uses category chips, quick-start panels, and record controls.
- You profile uses a polished header, stats grid, and settings-style list.
- Auth and splash screens were visually aligned with the same design language.

## Constraints
- UI-only changes. No backend, API, routing, provider, repository, model, or business logic changes.
- Keep existing app behavior and navigation flow intact.
