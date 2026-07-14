# Changelog

## 2026-07-14
- Initialized GhostOS repository scaffold from an empty workspace.
- Added Flutter Sprint 1 source structure, theme, router, splash, auth, and shell tabs.
- Added Spring Boot backend bootstrap with health endpoint and Gradle build files.
- Added persistent `.ai` project documentation files.
- Changed the auth screen so Google sign-in is disabled safely instead of throwing an unsupported operation.
- Set the direct Supabase client to implicit auth flow so email auth no longer triggers the PKCE async-storage assertion.
