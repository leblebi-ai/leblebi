# Implementation Plan: Multi-Agent Workspace Management

**Branch**: `003-us2-multi-agent-workspace` | **Date**: 2026-02-18 | **Spec**: [spec.md](./spec.md)
**Input**: Feature specification from `/specs/003-us2-multi-agent-workspace/spec.md`

**Note**: This template is filled in by the `/speckit.plan` command. See `.specify/templates/commands/plan.md` for the execution workflow.

## Summary

Build a thin UI client for ZeroClaw workspace management. Leblebi provides workspace CRUD interface, workspace switching, and trash management - all data operations delegate to ZeroClaw gateway API. No local Hive storage for workspaces/conversations (ZeroClaw is source of truth). Architecture: Presentation layer (Views/Controllers/State) → ZeroClawRestApi (workspace endpoints) → ZeroClaw Gateway → ZeroClaw Database.

## Technical Context

<!--
  ACTION REQUIRED: Replace the content in this section with the technical details
  for the project. The structure here is presented in advisory capacity to guide
  the iteration process.
-->

**Language/Version**: Dart 3.10.8+ with Flutter SDK
**Primary Dependencies**: zuraffa (^2.1.0), zorphy_annotation (^1.6.1), get_it (DI), http (REST API client), flutter_secure_storage (bearer token)
**Storage**: flutter_secure_storage (bearer token only), NO Hive for workspaces/conversations (ZeroClaw is source of truth)
**Testing**: flutter_test (unit/widget tests), integration_test (workspace API flow)
**Target Platform**: macOS (primary dev), iOS, Android, Web, Linux, Windows
**Project Type**: Mobile/Desktop (Flutter single project)
**Performance Goals**: Workspace switch <2s (API round-trip), workspace creation <1s, support 100+ workspaces
**Constraints**: ZeroClaw API is source of truth, no local data duplication, bearer token authentication required
**Scale/Scope**: Unlimited workspaces via ZeroClaw API, 1 active workspace at a time, optional read-through cache for performance

## Constitution Check

*GATE: Must pass before Phase 0 research. Re-check after Phase 1 design.*

✅ **Clean Architecture**: Domain entities (Workspace, Conversation as API models), UseCases for API operations, Repository interfaces (API-only), Presentation with Views/Controllers/State.

✅ **Platform-Agnostic Core**: All business logic in domain/data layers, no platform-specific code in core. Flutter adaptive UI for presentation.

✅ **Test-First**: Tasks will include test creation before implementation. Unit tests for UseCases, widget tests for Presenters, integration tests for workspace API flow.

✅ **Agent-First Design**: Workspace entity encapsulates agent identity from ZeroClaw. Each workspace represents a distinct agent context managed by ZeroClaw.

✅ **BYOK & Privacy by Default**: Bearer token stored in platform secure storage. All data persists in ZeroClaw (user-controlled gateway). No third-party services.

✅ **Zuraffa-First**: All entities generated via `zuraffa_entity_create`, UseCases via `zfa generate`, no manual editing of generated files.

✅ **Fast Iteration & Incremental Demo**: macOS primary dev platform, hot reload workflow, vertical slices per task, demo after each task.

✅ **Continuous Integration & Atomic Commits**: Commit after every task, run `dart analyze && flutter test` before each commit, push immediately.

✅ **Issue Tracking & Pull Request Workflow**: GitHub issues with checkboxes, PR created after all tasks complete, review before merge.

## Project Structure

### Documentation (this feature)

```text
specs/003-us2-multi-agent-workspace/
├── plan.md              # This file (/speckit.plan command output)
├── research.md          # Phase 0 output (/speckit.plan command)
├── data-model.md        # Phase 1 output (/speckit.plan command)
├── quickstart.md        # Phase 1 output (/speckit.plan command)
├── contracts/           # Phase 1 output (/speckit.plan command)
└── tasks.md             # Phase 2 output (/speckit.tasks command - NOT created by /speckit.plan)
```

### Source Code (repository root)

```text
lib/src/
├── domain/
│   ├── entities/
│   │   ├── workspace.dart              # API model (no Hive serialization)
│   │   └── workspace_identity.dart     # Value object
│   ├── repositories/
│   │   └── workspace_repository.dart   # Interface for API operations
│   └── usecases/
│       ├── create_workspace.dart
│       ├── get_workspace.dart
│       ├── get_workspace_list.dart
│       ├── update_workspace.dart
│       ├── delete_workspace.dart
│       ├── restore_workspace.dart
│       └── switch_workspace.dart
├── data/
│   ├── datasources/
│   │   └── remote/
│   │       ├── zeroclaw_rest_api.dart         # Existing: /health, /pair, /webhook
│   │       └── zeroclaw_workspace_api.dart    # NEW: workspace endpoints
│   └── repositories/
│       └── workspace_repository_impl.dart     # Calls ZeroClaw API only
├── presentation/
│   ├── views/
│   │   ├── workspace_list_view.dart
│   │   ├── workspace_create_view.dart
│   │   ├── workspace_switcher_view.dart
│   │   └── trash_view.dart
│   ├── controllers/
│   │   └── workspace_controller.dart
│   └── state/
│       └── workspace_state.dart
└── di/
    └── injection_container.dart

test/
├── domain/
│   └── usecases/
│       ├── create_workspace_test.dart
│       ├── delete_workspace_test.dart
│       └── switch_workspace_test.dart
├── data/
│   └── datasources/
│       └── zeroclaw_workspace_api_test.dart
├── presentation/
│   └── views/
│       └── workspace_list_view_test.dart
└── integration/
    └── workspace_api_flow_test.dart
```

**Structure Decision**: Single Flutter project with Clean Architecture layers (domain/data/presentation). No Hive boxes for workspaces - all data via ZeroClaw REST API. macOS is primary development platform for fast iteration.
