# UI

## Visual Direction
- Premium dark Material 3 with Strava-inspired performance styling
- Deep black background `#0F0F10`
- Strava orange primary `#FC4C02`
- Secondary surfaces `#181818` and elevated cards `#1F1F21`
- White foreground text with muted secondary copy `#A9A9A9`
- Glassmorphism reserved for premium hero cards and elevated content zones
- Plus Jakarta Sans typography for a polished consumer fitness-app feel

## Implemented
- Splash screen redesigned with premium glow orbs, hero branding, and loading bar
- Auth screen redesigned with premium hero entrance, segmented auth switcher, and elevated form surface
- Shared app bar redesigned with stronger hierarchy, premium badge, and elevated action icons
- Shared glass card style upgraded with deeper elevation and configurable gradients
- Floating bottom navigation shell with rounded corners and orange active state
- Home screen redesigned into a premium dashboard with a dominant ghost hero, metric cards, mission carousel, summary cards, and quick actions
- Activity screen redesigned with performance hero, stat grid, and premium timeline layout
- Record screen redesigned with premium capture hero and activity action grid
- You/Profile screen redesigned with premium profile header, collection cards, and cleaner account layout

## Planned
- Real animated ghost artwork
- Weather-state animation layers
- Reward-strip animations and mission completion motion
- Rich analytics charts and heatmaps once feature data is wired

## Design Tokens
- Primary: `#FC4C02`
- Background: `#0F0F10`
- Surface: `#181818`
- Elevated Surface: `#1F1F21`
- Divider: `#2A2A2A`
- Success: `#38D996`
- Warning: `#FFC247`
- Danger: `#FF5F5F`
- XP: `#3FA3FF`
- Coins: `#FFC94A`

## Spacing System
- Screen padding: `20`
- Section gaps: `18-24`
- Card padding: `20-32`
- Corner radius set: `22`, `24`, `28`, `30`, `34`, `36`

## Typography System
- Family: Plus Jakarta Sans
- Headline style: bold, compact tracking, high contrast
- Section titles: strong `titleLarge` emphasis
- Supporting text: muted gray for secondary hierarchy

## Component Library
- `GlassCard`: configurable premium surface with blur, border, and shadows
- `GhostAppBar`: profile, centered brand, plan badge, and elevated action icons
- `SectionHeader`: reusable section title and subtitle pairing
- `AuthTextField`: shared auth input shell with suffix support

## Implementation Notes
- UI pass intentionally preserved existing navigation, auth flow structure, providers, and business logic.
- Material icons remain in use but were normalized toward rounded symbols for design consistency.
- The redesign focuses on layout, color, hierarchy, and perceived polish rather than adding new functional behavior.
