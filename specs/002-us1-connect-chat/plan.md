# Implementation Plan: Connect and Chat with ZeroClaw Agent

**Branch**: `002-us1-connect-chat` | **Date**: 2026-02-17 | **Spec**: [spec.md](./spec.md)
**Input**: Feature specification from `/specs/002-us1-connect-chat/spec.md`

**Note**: This template is filled in by the `/speckit.plan` command. See `.specify/templates/commands/plan.md` for the execution workflow.

## Summary

Build a Flutter chat interface for ZeroClaw AI gateway with real-time messaging, conversation history, and connection management. The app uses a client-side GraphQL abstraction layer over ZeroClaw's REST API (`/health`, `/pair`, `/webhook`), with bearer token authentication via 6-digit pairing code. Architecture includes a pluggable provider layer for future PicoClaw/OpenClaw support. MVP delivers a full-screen blocking setup modal, auto-created default conversation, message retry with exponential backoff, and 4000-character message limits.

## Technical Context

<!--
  ACTION REQUIRED: Replace the content in this section with the technical details
  for this project. The structure here is presented in advisory capacity to guide
  the iteration process.
-->

**Language/Version**: Dart 3.10.8+ with Flutter SDK
**Primary Dependencies**: zuraffa (^2.1.0), zorphy_annotation (^1.6.1), get_it (DI), http/http2 (network), web_socket_channel (polling simulation), hive (local storage), flutter_secure_storage (token storage)
**Storage**: Hive (conversation history, messages, gateway config), flutter_secure_storage (bearer tokens)
**Testing**: flutter_test (unit/widget tests), integration_test (E2E chat flow)
**Target Platform**: macOS (primary dev), iOS, Android, Web, Linux, Windows
**Project Type**: Mobile/Desktop (Flutter single project)
**Performance Goals**: 60 FPS UI with 500+ messages, 95% messages receive AI response within 5 seconds, reconnection within 10 seconds (95% of cases)
**Constraints**: <200ms UI response time, offline-capable with message queuing, max 4000 chars/message, 3 retries with exponential backoff
**Scale/Scope**: Single device storage, unlimited conversation history, 1 gateway connection (MVP), pluggable provider architecture

## Constitution Check

*GATE: Must pass before Phase 0 research. Re-check after Phase 1 design.*

✅ **Clean Architecture**: Domain entities (Conversation, Message, GatewayConnection, AIProvider), UseCases for chat operations, Repository interfaces, Data layer with REST adapter and Hive storage, Presentation with Views/Controllers/State.

✅ **Platform-Agnostic Core**: All business logic in domain/data layers, no platform-specific code in core. Flutter adaptive UI for presentation.

✅ **Test-First**: Tasks will include test creation before implementation. Unit tests for UseCases, widget tests for Presenters, integration tests for chat flow.

✅ **Agent-First Design**: AIProvider abstraction layer encapsulates ZeroClaw gateway, supports future PicoClaw/OpenClaw without UI changes.

✅ **BYOK & Privacy by Default**: Bearer tokens stored in platform secure storage (Keychain/Keystore), no third-party services, all data local to device.

✅ **Zuraffa-First**: All entities generated via `zuraffa_entity_create`, UseCases via `zfa generate`, no manual editing of generated files.

✅ **Fast Iteration & Incremental Demo**: macOS primary dev platform, hot reload workflow, vertical slices per task, demo after each task.

✅ **Continuous Integration & Atomic Commits**: Commit after every task, run `dart analyze && flutter test` before each commit, push immediately.

✅ **Issue Tracking & Pull Request Workflow**: GitHub issues with checkboxes, PR created after all tasks complete, review before merge.

## Project Structure

### Documentation (this feature)

```text
specs/002-us1-connect-chat/
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
│   │   ├── conversation.dart
│   │   ├── message.dart
│   │   ├── gateway_connection.dart
│   │   └── ai_provider.dart
│   ├── repositories/
│   │   ├── conversation_repository.dart
│   │   ├── message_repository.dart
│   │   └── gateway_connection_repository.dart
│   └── usecases/
│       ├── connect_gateway.dart
│       ├── send_message.dart
│       ├── get_conversation_history.dart
│       └── ...
├── data/
│   ├── datasources/
│   │   ├── remote/
│   │   │   ├── zeroclaw_rest_api.dart
│   │   │   └── graphql_adapter.dart
│   │   └── local/
│   │       ├── hive_datasource.dart
│   │       └── secure_storage_datasource.dart
│   ├── repositories/
│   │   ├── conversation_repository_impl.dart
│   │   ├── message_repository_impl.dart
│   │   └── gateway_connection_repository_impl.dart
│   └── models/
│       ├── conversation_model.dart
│       ├── message_model.dart
│       └── gateway_connection_model.dart
├── presentation/
│   ├── views/
│   │   ├── setup_modal_view.dart
│   │   ├── chat_view.dart
│   │   └── conversation_list_view.dart
│   ├── controllers/
│   │   ├── chat_controller.dart
│   │   ├── setup_controller.dart
│   │   └── conversation_controller.dart
│   └── state/
│       ├── chat_state.dart
│       ├── setup_state.dart
│       └── conversation_state.dart
└── di/
    └── injection_container.dart

test/
├── domain/
│   ├── usecases/
│   └── entities/
├── data/
│   ├── repositories/
│   └── datasources/
├── presentation/
│   ├── controllers/
│   └── views/
└── integration/
    └── chat_flow_test.dart
```

**Structure Decision**: Single Flutter project with Clean Architecture layers (domain/data/presentation). macOS is primary development platform for fast iteration.
