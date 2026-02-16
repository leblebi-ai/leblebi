# Implementation Plan: ZeroClaw Flutter Interface

**Branch**: `001-zeroclaw-integration` | **Date**: 2026-02-17 | **Spec**: [spec.md](./spec.md)
**Input**: Feature specification for ZeroClaw integration - a beautiful, UX-driven Flutter interface for the ZeroClaw AI personal assistant

## Summary

Build a cross-platform Flutter application that serves as a beautiful, UX-driven interface for ZeroClaw AI personal assistant. The app will integrate with ZeroClaw gateway via REST API, providing chat functionality, workspace management, tool configuration, and conversation search. Core business logic will be platform-independent, following Clean Architecture with Zuraffa-generated code structure.

## Technical Context

**Language/Version**: Dart 3.10.8+ with Flutter SDK
**Primary Dependencies**: Flutter SDK, zuraffa (^2.1.0), zorphy_annotation (^1.6.1), get_it (DI), http/http2 (network), web_socket_channel (real-time)
**Storage**: Hive (local NoSQL database for offline-first conversation history and settings)
**Testing**: flutter_test (unit/widget tests), integration_test (E2E user journeys)
**Target Platform**: macOS (primary), iOS/Android (secondary), Linux/Web (tertiary), Windows (last)
**Project Type**: Single Flutter project with Clean Architecture layers
**Performance Goals**: 60 FPS UI, <5s AI response time, <10ms local storage operations, app startup <2s
**Constraints**: Offline-capable (local conversation cache), <100MB memory footprint, network retry with exponential backoff
**Scale/Scope**: 50+ screens (chat, workspaces, settings, tools, search), 10+ entities, 20+ UseCases

## Constitution Check

*GATE: Must pass before Phase 0 research. Re-check after Phase 1 design.*

| Principle | Compliance | Justification |
|-----------|------------|---------------|
| **I. Clean Architecture** | ✅ PASS | Three-layer structure (domain/data/presentation) with Zuraffa generation |
| **II. Platform-Agnostic Core** | ✅ PASS | Core logic in domain layer, platform code isolated in Data layer |
| **III. Test-First** | ✅ PASS | All tasks will include test creation before implementation |
| **IV. Agent-First Design** | ✅ PASS | Workspace entity encapsulates agent identity, configuration, lifecycle |
| **V. BYOK & Privacy by Default** | ✅ PASS | Gateway credentials stored locally in Hive, no third-party services |
| **VI. Zuraffa-First** | ✅ PASS | All Dart code generated via Zuraffa CLI, manual creation forbidden |

**Gate Result**: ✅ ALL PASS - Proceed to Phase 0 research

### Post-Design Constitution Check (Phase 1 Complete)

| Principle | Re-Check Status | Design Validation |
|-----------|-----------------|-------------------|
| **I. Clean Architecture** | ✅ PASS | Data model confirms 3-layer structure; entities in domain, repositories in data, VPC in presentation |
| **II. Platform-Agnostic Core** | ✅ PASS | All entities platform-independent; Hive storage abstracts platform-specific secure storage |
| **III. Test-First** | ✅ PASS | Test structure defined; all UseCases and Presenters have corresponding test files |
| **IV. Agent-First Design** | ✅ PASS | Workspace entity encapsulates agent identity, config, lifecycle; AgentStatus queries present |
| **V. BYOK & Privacy by Default** | ✅ PASS | GatewayConnection stores encrypted tokens; credentials never leave device |
| **VI. Zuraffa-First** | ✅ PASS | All 6 entities will be generated via Zuraffa; 20+ UseCases via `zfa generate` |

**Final Gate Result**: ✅ ALL PASS - Ready for task breakdown

## Project Structure

### Documentation (this feature)

```text
specs/001-zeroclaw-integration/
├── plan.md              # This file
├── research.md          # Phase 0 output
├── data-model.md        # Phase 1 output
├── quickstart.md        # Phase 1 output
├── contracts/           # Phase 1 output (GraphQL schemas)
└── tasks.md             # Phase 2 output
```

### Source Code (repository root)

```text
lib/src/
├── domain/
│   ├── entities/
│   │   ├── workspace/
│   │   │   ├── workspace.dart
│   │   │   └── workspace.g.dart
│   │   ├── conversation/
│   │   │   ├── conversation.dart
│   │   │   └── conversation.g.dart
│   │   ├── message/
│   │   │   ├── message.dart
│   │   │   └── message.g.dart
│   │   ├── gateway_connection/
│   │   │   ├── gateway_connection.dart
│   │   │   └── gateway_connection.g.dart
│   │   ├── tool_configuration/
│   │   │   ├── tool_configuration.dart
│   │   │   └── tool_configuration.g.dart
│   │   └── search_result/
│   │       ├── search_result.dart
│   │       └── search_result.g.dart
│   ├── usecases/
│   │   ├── workspace/
│   │   │   ├── get_workspace.dart
│   │   │   ├── get_workspace_list.dart
│   │   │   ├── create_workspace.dart
│   │   │   ├── update_workspace.dart
│   │   │   └── delete_workspace.dart
│   │   ├── conversation/
│   │   │   ├── get_conversation.dart
│   │   │   ├── get_conversation_list.dart
│   │   │   ├── create_conversation.dart
│   │   │   └── send_message.dart
│   │   ├── gateway/
│   │   │   ├── connect_gateway.dart
│   │   │   ├── disconnect_gateway.dart
│   │   │   └── test_connection.dart
│   │   ├── tool/
│   │   │   ├── get_tools.dart
│   │   │   ├── update_tool_config.dart
│   │   │   └── search_conversations.dart
│   │   └── agent/
│   │       ├── get_agent_status.dart
│   │       └── configure_agent.dart
│   └── repositories/
│       ├── workspace_repository.dart
│       ├── conversation_repository.dart
│       ├── gateway_repository.dart
│       └── tool_repository.dart
├── data/
│   ├── repositories/
│   │   ├── workspace_repository_impl.dart
│   │   ├── conversation_repository_impl.dart
│   │   ├── gateway_repository_impl.dart
│   │   └── tool_repository_impl.dart
│   ├── datasources/
│   │   ├── local/
│   │   │   ├── hive_datasource.dart
│   │   │   └── hive_models/
│   │   └── remote/
│   │       ├── zeroclaw_api_datasource.dart
│   │       └── zeroclaw_models/
│   └── models/
│       ├── workspace_model.dart
│       ├── conversation_model.dart
│       └── message_model.dart
├── presentation/
│   ├── views/
│   │   ├── chat_view.dart
│   │   ├── workspace_list_view.dart
│   │   ├── settings_view.dart
│   │   ├── tools_view.dart
│   │   └── search_view.dart
│   ├── presenters/
│   │   ├── chat_presenter.dart
│   │   ├── workspace_presenter.dart
│   │   ├── settings_presenter.dart
│   │   ├── tools_presenter.dart
│   │   └── search_presenter.dart
│   ├── controllers/
│   │   ├── chat_controller.dart
│   │   ├── workspace_controller.dart
│   │   ├── settings_controller.dart
│   │   ├── tools_controller.dart
│   │   └── search_controller.dart
│   └── state/
│       ├── chat_state.dart
│       ├── workspace_state.dart
│       ├── settings_state.dart
│       ├── tools_state.dart
│       └── search_state.dart
└── di/
    └── injection_container.dart

test/
├── domain/
│   ├── usecases/
│   │   ├── workspace_usecase_test.dart
│   │   ├── conversation_usecase_test.dart
│   │   └── gateway_usecase_test.dart
│   └── entities/
│       ├── workspace_test.dart
│       └── message_test.dart
├── data/
│   ├── repositories/
│   │   └── workspace_repository_test.dart
│   └── datasources/
│       ├── hive_datasource_test.dart
│       └── zeroclaw_api_datasource_test.dart
└── presentation/
    ├── presenters/
    │   └── chat_presenter_test.dart
    └── widgets/
        └── chat_view_test.dart
```

**Structure Decision**: Single Flutter project with Clean Architecture three-layer structure (domain/data/presentation). Platform-specific code isolated in Data layer datasources. Zuraffa will generate all entities, use cases, repositories, and presentation layer (VPC pattern).

## Complexity Tracking

> **Fill ONLY if Constitution Check has violations that must be justified**

No violations - all constitution principles pass. No complexity justification needed.
