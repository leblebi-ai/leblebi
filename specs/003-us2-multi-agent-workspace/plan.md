# Implementation Plan: Multi-Agent Workspace Management

**Branch**: `003-us2-multi-agent-workspace` | **Date**: 2026-02-18 | **Spec**: [spec.md](./spec.md)
**Input**: Feature specification from `/specs/003-us2-multi-agent-workspace/spec.md`

**Note**: This template is filled in by the `/speckit.plan` command. See `.specify/templates/commands/plan.md` for the execution workflow.

## Summary

Build a multi-agent workspace management system allowing users to create, configure, and switch between multiple agent workspaces with distinct identities, configurations, and conversation histories. Implements workspace CRUD operations, soft-delete with 30-day trash retention, and workspace switching with independent conversation contexts. Architecture extends existing US1 foundation with Workspace entity, repository, and UseCases following Clean Architecture patterns.

## Technical Context

<!--
  ACTION REQUIRED: Replace the content in this section with the technical details
  for the project. The structure here is presented in advisory capacity to guide
  the iteration process.
-->

**Language/Version**: Dart 3.10.8+ with Flutter SDK
**Primary Dependencies**: zuraffa (^2.1.0), zorphy_annotation (^1.6.1), get_it (DI), hive (local storage), flutter_secure_storage (token storage)
**Storage**: Hive (workspace configurations, conversation histories, identity settings), flutter_secure_storage (gateway credentials per workspace)
**Testing**: flutter_test (unit/widget tests), integration_test (workspace switching flow)
**Target Platform**: macOS (primary dev), iOS, Android, Web, Linux, Windows
**Project Type**: Mobile/Desktop (Flutter single project)
**Performance Goals**: Workspace switch <500ms, workspace creation <1s, support 100+ workspaces
**Constraints**: Single-device storage (no multi-device sync in MVP), 30-day trash retention with auto-purge, offline-capable
**Scale/Scope**: Unlimited workspaces per user, unlimited conversation history per workspace, 1 active workspace at a time

## Constitution Check

*GATE: Must pass before Phase 0 research. Re-check after Phase 1 design.*

✅ **Clean Architecture**: Domain entities (Workspace, Conversation, Message), UseCases for workspace operations, Repository interfaces, Data layer with Hive storage, Presentation with Views/Controllers/State.

✅ **Platform-Agnostic Core**: All business logic in domain/data layers, no platform-specific code in core. Flutter adaptive UI for presentation.

✅ **Test-First**: Tasks will include test creation before implementation. Unit tests for UseCases, widget tests for Presenters, integration tests for workspace switching flow.

✅ **Agent-First Design**: Workspace entity encapsulates agent identity, configuration, and conversation history. Each workspace represents a distinct agent context.

✅ **BYOK & Privacy by Default**: All workspace data stored locally on device, no third-party services. Gateway credentials per workspace stored in platform secure storage.

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
│   │   ├── workspace.dart
│   │   ├── conversation.dart
│   │   └── message.dart
│   ├── repositories/
│   │   ├── workspace_repository.dart
│   │   ├── conversation_repository.dart
│   │   └── gateway_connection_repository.dart
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
│   │   ├── local/
│   │   │   ├── hive_datasource.dart
│   │   │   └── secure_storage_datasource.dart
│   │   └── remote/
│   │       └── zeroclaw_rest_api.dart
│   ├── repositories/
│   │   ├── workspace_repository_impl.dart
│   │   ├── conversation_repository_impl.dart
│   │   └── gateway_connection_repository_impl.dart
│   └── models/
│       ├── workspace_model.dart
│       ├── conversation_model.dart
│       └── message_model.dart
├── presentation/
│   ├── views/
│   │   ├── workspace_list_view.dart
│   │   ├── workspace_create_view.dart
│   │   ├── workspace_switcher_view.dart
│   │   └── trash_view.dart
│   ├── controllers/
│   │   ├── workspace_controller.dart
│   │   └── trash_controller.dart
│   └── state/
│       ├── workspace_state.dart
│       └── trash_state.dart
└── di/
    └── injection_container.dart

test/
├── domain/
│   ├── usecases/
│   │   ├── create_workspace_test.dart
│   │   ├── delete_workspace_test.dart
│   │   └── switch_workspace_test.dart
│   └── entities/
├── data/
│   ├── repositories/
│   └── datasources/
├── presentation/
│   ├── controllers/
│   └── views/
└── integration/
    └── workspace_flow_test.dart
```

**Structure Decision**: Single Flutter project with Clean Architecture layers (domain/data/presentation). Extends existing US1 structure with Workspace entity and related UseCases. macOS is primary development platform for fast iteration.
