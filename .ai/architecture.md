# Architecture

## Frontend
- Feature-first structure with shared cross-cutting concerns in `app`, `bootstrap`, and `core`.
- Riverpod manages global state such as authentication and later ghost-world state.
- GoRouter owns splash gating, auth gating, and bottom-navigation shell behavior.

## Backend Target
- Spring Boot clean architecture planned with modules per feature.
- Supabase remains the system of record for auth, relational data, and asset storage.
- Backend bootstrap lives under `backend/` with Java 21 and Gradle Kotlin DSL.
- First backend slice is `features/system` for service health and operational checks.

## Decision Log
- 2026-07-14: Started with frontend scaffold because repository was empty.
- 2026-07-14: Used local auth controller to make Sprint 1 screens functional before external service integration.
