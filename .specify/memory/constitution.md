<!--
Sync Impact Report
==================
Version change: 1.1.0 → 1.2.0 (Minor: Added Fast Iteration principle)

Modified principles:
- Added VII. Fast Iteration & Incremental Demo (new core principle)
- Technical Standards updated with hot reload workflow

Added sections:
- VII. Fast Iteration & Incremental Demo (new core principle)
- Hot reload requirement in Technical Standards

Removed sections: None

Templates requiring updates:
- ✅ .specify/templates/plan-template.md - Constitution Check section present
- ✅ .specify/templates/spec-template.md - Testable requirements align with Test-First principle
- ✅ .specify/templates/tasks-template.md - Task categorization reflects incremental delivery
- ⚠ N/A (no command files to update beyond templates already checked)

Follow-up TODOs: None
-->

# Leblebi Constitution

## Core Principles

### I. Clean Architecture (NON-NEGOTIABLE)

All code MUST follow Clean Architecture principles with clear separation of concerns
across Domain, Data, and Presentation layers. Use Zuraffa-generated structure as the
canonical pattern: Entities define business rules, UseCases encapsulate application
logic, Repositories abstract data access, and Presenters/Controllers orchestrate UI
state. Dependencies MUST point inward toward the Domain layer; outer layers (UI, Data)
MUST NOT leak into core business logic.

### II. Platform-Agnostic Core

Core business logic, entities, and use cases MUST be platform-independent and reusable
across all supported platforms (mobile, tablet, desktop, web). Platform-specific code
(file I/O, native APIs, device sensors) MUST be isolated in the Data layer with clear
abstraction boundaries. UI MUST adapt responsively using Flutter's adaptive layouts;
no platform branching in core business logic.

### III. Test-First (NON-NEGOTIABLE)

Tests MUST be written before implementation for all new functionality. Follow
Red-Green-Refactor cycle: write failing tests, get approval, then implement to pass
tests. Test coverage MUST include: unit tests for UseCases and Entities, widget tests
for Presenters/Controllers, and integration tests for critical user journeys. No code
committed without passing tests.

### IV. Agent-First Design

All features MUST be designed around the agent orchestration model. Agents are
first-class entities with clear identity, configuration, and lifecycle. Agent
interactions (single-agent chat, multi-agent collaboration, workflow chaining) MUST be
the primary abstraction; direct UI manipulation of underlying AI APIs is forbidden
without agent abstraction layer.

### V. BYOK & Privacy by Default

API keys and provider credentials MUST be user-controlled and stored locally on device;
no third-party key management services. User data MUST remain private unless explicitly
shared. All external AI provider interactions MUST go through abstracted provider
interfaces; no direct OpenAI/Anthropic/etc. API calls in business logic. Transparency
logs MUST show which provider, model, and parameters are used for each agent operation.

### VI. Zuraffa-First (NON-NEGOTIABLE)

All Dart code generation MUST use Zuraffa tooling exclusively. Workflow:
1. Entities first: Create entities using `zuraffa_entity_create` or `zorphy_create_entity`
2. Run `zuraffa_build` to generate serialization code (.g.dart files)
3. Generate UseCases: Use `zfa generate` for entity CRUD operations and custom UseCases
4. NEVER manually edit generated files (marked with // GENERATED CODE)
5. ALWAYS run `dart analyze` after generation - must have 0 errors/warnings before
   implementing new features

Manual Dart file creation is FORBIDDEN when Zuraffa can generate the structure. This
ensures consistency, reduces boilerplate errors, and enforces Clean Architecture
patterns automatically.

### VII. Fast Iteration & Incremental Demo (NON-NEGOTIABLE)

Development MUST prioritize rapid iteration on macOS as the primary platform. Each task
MUST produce immediately testable, visible results. Users MUST be able to run the app
and see a working feature slice after EACH task completion, not wait for all tasks to
finish.

**Workflow Requirements**:
- macOS is the default development and testing platform (fastest iteration)
- Use `flutter run -d macos` for hot reload during development
- Each task MUST be vertically sliced: UI → Presenter → UseCase → Repository → Data
- After completing a task, run the app and demonstrate the feature working end-to-end
- NO task should require waiting for multiple tasks to complete before testing
- Hot reload MUST be used for UI changes; hot restart for logic changes
- If a task cannot be tested independently, it MUST be broken into smaller tasks

**Rationale**: Fast feedback loops reduce cognitive load, catch issues early, and
provide confidence that the system works incrementally. Waiting until "everything is
done" creates integration nightmares and demotivates developers.

## Technical Standards

**Language & Framework**: Dart 3.10.8+ with Flutter SDK. Use Zuraffa (v2.0.0+) for code
generation and project structure enforcement.

**Project Structure**: lib/src/ with three-layer Clean Architecture:
- domain/: Entities, UseCases, Repository interfaces
- data/: Repository implementations, DataSources (remote/local), models
- presentation/: Views, Presenters, Controllers, State

**State Management**: Use StatefulController mixin for controllers with State objects;
avoid global state. State updates MUST be explicit via setState methods.

**Code Generation**: Use build_runner for Zorphy entities and Zuraffa-generated code;
NEVER manually edit generated files (marked with // GENERATED CODE).

**Hot Reload Workflow**:
- Use `flutter run -d macos` as primary development loop
- Hot reload for UI/presentation changes (preserves state)
- Hot restart for domain/data layer changes (full reload)
- Target iteration time: <30 seconds from code change to visible result

**Linting & Formatting**: Run `dart format .` and `flutter analyze` before commits. Fix
all errors; warnings MUST be justified or resolved.

**Dependency Injection**: Use get_it service locator; register services in
di/injection_container.dart following single responsibility.

**Logging**: Structured logging required for all agent operations (provider used,
model, tokens, duration, errors). Logs MUST be readable and searchable.

## Development Workflow

**Code Review**: All PRs require peer review. Reviews MUST verify: Clean Architecture
compliance, test coverage, no hardcoded keys/values, accessibility, and platform
independence.

**Testing Gates**: Unit tests MUST pass locally before PR. Widget and integration tests
MUST pass in CI. New features require at least one integration test covering the
primary user journey.

**Feature Development**: Follow spec → plan → tasks → implement → test → review →
merge flow. Specs MUST include measurable success criteria and edge cases.

**Incremental Delivery**:
- Tasks MUST be ordered by user story priority (P1 first)
- Each task MUST deliver a vertically testable slice
- Demo after EVERY task: run the app and show the feature working
- Stop at checkpoints to validate user stories independently
- Deploy/demo MVP after P1 (User Story 1) before continuing to P2, P3, P4

**Documentation**: Complex business logic MUST have inline comments. Public APIs
(UseCase methods, Repository interfaces) MUST have dartdoc comments explaining purpose,
parameters, and return types.

**Breaking Changes**: MAJOR version bump for breaking changes to Entities or UseCase
interfaces. MINOR for new features. PATCH for bug fixes and internal improvements.
Document all breaking changes in CHANGELOG.md.

## Governance

This constitution supersedes all conflicting practices or conventions. Amendments
require: documented rationale, team approval, migration plan for existing code, and
version bump according to semantic versioning rules.

All developers MUST verify compliance with these principles during:
- Code reviews (check all principles apply)
- Architecture design (Clean Architecture, Platform-Agnostic, Agent-First)
- Testing (Test-First enforcement)
- Privacy reviews (BYOK, Privacy by Default)
- Code generation (Zuraffa-First enforcement)
- Task planning (Fast Iteration validation)

Complexity MUST be justified in implementation plans (Complexity Tracking section). If
a principle conflict is unavoidable, document the exception, rationale, and proposed
alternative principle that would have applied. Use this constitution as the ultimate
authority when questions arise about code organization, patterns, or practices.

**Version**: 1.2.0 | **Ratified**: 2026-02-14 | **Last Amended**: 2026-02-17
