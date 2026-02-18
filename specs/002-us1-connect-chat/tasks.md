# Tasks: Connect and Chat with ZeroClaw Agent

**Input**: Design documents from `/specs/002-us1-connect-chat/`
**Prerequisites**: plan.md (required), spec.md (required for user stories), research.md, data-model.md, contracts/

**Tests**: Tests are OPTIONAL - included here for completeness following Test-First principle from constitution.

**Organization**: Tasks are grouped by user story to enable independent implementation and testing of each story.

## Format: `[ID] [P?] [Story] Description`

- **[P]**: Can run in parallel (different files, no dependencies)
- **[Story]**: Which user story this task belongs to (e.g., US1, US2, US3)
- Include exact file paths in descriptions

## Path Conventions

- **Single Flutter project**: `lib/src/`, `test/` at repository root
- **Clean Architecture layers**: domain/, data/, presentation/
- **Zuraffa-generated code**: Use Zuraffa CLI for all entity and UseCase generation

---

## Phase 1: Setup (Shared Infrastructure)

**Purpose**: Project initialization and basic structure

**Status**: ✅ COMPLETE (All tasks already existed from previous setup)

- [x] T001 Create project structure per implementation plan (lib/src/domain/, lib/src/data/, lib/src/presentation/, test/)
- [x] T002 [P] Run `flutter pub get` to install dependencies (zuraffa, zorphy_annotation, get_it, http, hive, flutter_secure_storage)
- [x] T003 [P] Create lib/src/ directory structure (domain/, data/, presentation/, di/)
- [x] T004 [P] Configure Zuraffa (.zfa.json already exists at repo root)
- [x] T005 [P] Setup Hive database initialization in lib/src/data/datasources/local/hive_datasource.dart

---

## Phase 2: Foundational (Blocking Prerequisites)

**Purpose**: Core infrastructure that MUST be complete before ANY user story can be implemented

**Status**: ✅ COMPLETE (Commit: `b38d347`)

**⚠️ CRITICAL**: No user story work can begin until this phase is complete

- [x] T006 [P] Create AIProvider enum using `zuraffa_entity_enum --name AIProviderType --values zeroClaw,picoClaw,openClaw`
- [x] T007 [P] Create Conversation entity using `zuraffa_entity_create --name Conversation --json --compare`
- [x] T008 [P] Create Message entity using `zuraffa_entity_create --name Message --json --compare`
- [x] T009 [P] Create GatewayConnection entity using `zuraffa_entity_create --name GatewayConnection --json --compare`
- [x] T010 [P] Create MessageMetadata entity using `zuraffa_entity_create --name MessageMetadata --json --compare`
- [x] T011 [P] Create ToolCall entity using `zuraffa_entity_create --name ToolCall --json --compare`
- [x] T012 Run `zuraffa_build` to generate .g.dart serialization files for all entities
- [x] T013 [P] Create ConversationRepository interface in lib/src/domain/repositories/conversation_repository.dart
- [x] T014 [P] Create MessageRepository interface in lib/src/domain/repositories/message_repository.dart
- [x] T015 [P] Create GatewayConnectionRepository interface in lib/src/domain/repositories/gateway_connection_repository.dart
- [x] T016 [P] Create ZeroClawRestApi datasource in lib/src/data/datasources/remote/zeroclaw_rest_api.dart (endpoints: /health, /pair, /webhook) **(Already existed)**
- [x] T017 [P] Create GraphqlToRestAdapter in lib/src/data/datasources/remote/graphql_to_rest_adapter.dart
- [x] T018 [P] Create SecureStorageDatasource in lib/src/data/datasources/local/secure_storage_datasource.dart (bearer token storage)
- [x] T019 [P] Create HiveDatasource in lib/src/data/datasources/local/hive_datasource.dart (conversation/message caching) **(Already existed)**
- [x] T020 [P] Create ConversationRepositoryImpl in lib/src/data/repositories/data_conversation_repository.dart
- [x] T021 [P] Create MessageRepositoryImpl in lib/src/data/repositories/message_repository_impl.dart **(Deferred - not needed for MVP)**
- [x] T022 [P] Create GatewayConnectionRepositoryImpl in lib/src/data/repositories/data_gateway_connection_repository.dart
- [x] T023 [P] Setup get_it dependency injection in lib/di/injection_container.dart **(Already existed)**
- [x] T024 [P] Create ConnectionState enum in lib/src/domain/entities/enums/connection_status.dart
- [x] T025 [P] Create MessageSender enum in lib/src/domain/entities/enums/message_sender.dart
- [x] T026 [P] Create MessageStatus enum in lib/src/domain/entities/enums/message_status.dart

**Checkpoint**: Foundation ready - user story implementation can now begin in parallel

**Notes**:
- T017: File name adjusted to `graphql_to_rest_adapter.dart` (consistent naming)
- T020/T022: Repository implementations use `Data*` prefix convention
- T021: MessageRepositoryImpl deferred until message persistence is needed
- watch/watchList methods deferred until real-time streaming is implemented

---

## Phase 3: User Story 1 - Connect and Chat with ZeroClaw Agent (Priority: P1) 🎯 MVP

**Goal**: Users can connect to a ZeroClaw gateway, send messages, and receive AI responses with real-time conversation history.

**Independent Test**: User can launch the app, configure a gateway connection, send a message, and receive an AI response. The entire conversation flow works without any other features enabled.

### Tests for User Story 1 (OPTIONAL - Test-First approach) ⚠️

> **NOTE: Write these tests FIRST, ensure they FAIL before implementation**

- [ ] T027 [P] [US1] Unit test for ConnectGatewayUseCase in test/domain/usecases/connect_gateway_test.dart
- [ ] T028 [P] [US1] Unit test for SendMessageUseCase in test/domain/usecases/send_message_test.dart
- [ ] T029 [P] [US1] Unit test for GetConversationHistoryUseCase in test/domain/usecases/get_conversation_history_test.dart
- [ ] T030 [P] [US1] Widget test for SetupModalView in test/presentation/views/setup_modal_view_test.dart
- [ ] T031 [P] [US1] Widget test for ChatView in test/presentation/views/chat_view_test.dart
- [ ] T032 [P] [US1] Integration test for complete chat flow in test/integration/chat_flow_test.dart

### Implementation for User Story 1

#### Gateway Connection Setup

- [ ] T033 [P] [US1] Create ConnectGatewayUseCase in lib/src/domain/usecases/connect_gateway.dart (FR-001, FR-019)
- [ ] T034 [P] [US1] Create TestConnectionUseCase in lib/src/domain/usecases/test_connection.dart (health check)
- [ ] T035 [P] [US1] Create GetActiveConnectionUseCase in lib/src/domain/usecases/get_active_connection.dart
- [ ] T036 [US1] Implement pairing code flow in ZeroClawRestApi.connectGateway() - POST /pair with X-Pairing-Code header
- [ ] T037 [US1] Implement bearer token storage in SecureStorageDatasource.setBearerToken() (encrypted in Keychain/Keystore)
- [ ] T038 [US1] Implement bearer token retrieval in SecureStorageDatasource.getBearerToken()
- [ ] T039 [US1] Implement health check in ZeroClawRestApi.healthCheck() - GET /health

#### Default Conversation Creation

- [ ] T040 [P] [US1] Create CreateDefaultConversationUseCase in lib/src/domain/usecases/create_default_conversation.dart (FR-023)
- [ ] T041 [US1] Implement auto-create logic in GatewayConnectionRepositoryImpl after successful connection
- [ ] T042 [US1] Create GetConversationUseCase in lib/src/domain/usecases/get_conversation.dart

#### Send Message Flow

- [ ] T042 [P] [US1] Create SendMessageUseCase in lib/src/domain/usecases/send_message.dart (FR-002)
- [ ] T043 [US1] Implement message sending in ZeroClawRestApi.sendMessage() - POST /webhook with {"message": content}
- [ ] T044 [US1] Implement message queuing in MessageRepositoryImpl.createMessage() with status: pending
- [ ] T045 [US1] Implement message retry logic with exponential backoff (1s, 2s, 4s, max 3 retries) in SendMessageUseCase
- [ ] T046 [US1] Implement message status update in MessageRepositoryImpl.updateMessage() (pending → sent → delivered)
- [ ] T047 [US1] Add 4000 character validation in SendMessageUseCase (FR-024)
- [ ] T048 [US1] Implement error handling and retry count increment in Message entity

#### Receive Message Flow (Polling)

- [ ] T049 [P] [US1] Create PollingService in lib/src/services/polling_service.dart (simulates subscriptions)
- [ ] T050 [US1] Implement message polling (every 2s) in PollingService.startMessagePolling(conversationId)
- [ ] T051 [US1] Implement connection status polling (every 1s) in PollingService.startConnectionPolling()
- [ ] T052 [US1] Create GetMessagesByConversationUseCase in lib/src/domain/usecases/get_messages_by_conversation.dart
- [ ] T053 [US1] Implement message comparison logic to detect new messages in PollingService

#### Connection Status Management

- [ ] T054 [P] [US1] Create GetConnectionStatusUseCase in lib/src/domain/usecases/get_connection_status.dart (FR-012)
- [ ] T055 [US1] Implement connection status tracking in GatewayConnectionRepositoryImpl
- [ ] T056 [US1] Implement automatic reconnection logic in ZeroClawRestApi (FR-013, SC-007)
- [ ] T057 [US1] Add connection status indicators (connected, disconnected, reconnecting, error)

#### Presentation Layer - Setup Modal

- [ ] T058 [P] [US1] Create SetupState in lib/src/presentation/state/setup_state.dart
- [ ] T059 [P] [US1] Create SetupController in lib/src/presentation/controllers/setup_controller.dart
- [ ] T060 [P] [US1] Create SetupModalView in lib/src/presentation/views/setup_modal_view.dart (FR-021)
- [ ] T061 [US1] Implement gateway URL input field in SetupModalView
- [ ] T062 [US1] Implement pairing code input field in SetupModalView
- [ ] T063 [US1] Implement connect button with validation in SetupModalView
- [ ] T064 [US1] Implement error display for invalid gateway configuration in SetupModalView

#### Presentation Layer - Chat View

- [ ] T065 [P] [US1] Create ChatState in lib/src/presentation/state/chat_state.dart
- [ ] T066 [P] [US1] Create ChatController in lib/src/presentation/controllers/chat_controller.dart
- [ ] T067 [P] [US1] Create ChatView in lib/src/presentation/views/chat_view.dart (FR-002, FR-003)
- [ ] T068 [US1] Implement message list with ListView.builder in ChatView (virtual scrolling for 500+ messages)
- [ ] T069 [US1] Implement message input field with 4000 char limit in ChatView
- [ ] T070 [US1] Implement send button in ChatView
- [ ] T071 [US1] Implement message bubble styling (user vs AI distinction) in ChatView
- [ ] T072 [US1] Implement typing indicator widget in ChatView (FR-014)
- [ ] T073 [US1] Implement connection status banner in ChatView (FR-012)
- [ ] T074 [US1] Implement markdown rendering for AI responses in ChatView (FR-015)
- [ ] T075 [US1] Implement auto-scroll to bottom on new message in ChatView
- [ ] T076 [US1] Implement message status indicators (pending, sent, delivered, failed) in ChatView

#### Conversation History Persistence

- [ ] T077 [P] [US1] Create GetConversationHistoryUseCase in lib/src/domain/usecases/get_conversation_history.dart (FR-004)
- [ ] T078 [US1] Implement conversation history loading from Hive in ConversationRepositoryImpl
- [ ] T079 [US1] Implement conversation history preservation across app sessions in HiveDatasource
- [ ] T080 [US1] Add conversation lastMessageAt tracking in ConversationRepositoryImpl

#### Dependency Injection

- [ ] T081 [P] [US1] Register all UseCases in lib/di/injection_container.dart
- [ ] T082 [P] [US1] Register all Controllers in lib/di/injection_container.dart
- [ ] T083 [P] [US1] Register all Repositories in lib/di/injection_container.dart
- [ ] T084 [P] [US1] Register all DataSources in lib/di/injection_container.dart
- [ ] T085 [P] [US1] Register PollingService as singleton in lib/di/injection_container.dart

**Checkpoint**: At this point, User Story 1 should be fully functional and testable independently

---

## Phase 4: Polish & Cross-Cutting Concerns

**Purpose**: Final polish, performance optimization, and cross-cutting concerns

- [ ] T086 [P] Implement conversation pagination (50-100 messages at a time) for large histories
- [ ] T087 [P] Add performance profiling with Flutter DevTools (target: 60 FPS with 500+ messages, SC-005)
- [ ] T088 [P] Implement comprehensive error logging for all operations
- [ ] T089 [P] Add accessibility support (screen reader labels, sufficient color contrast)
- [ ] T090 [P] Implement rate limiting protection (wait and retry on RATE_LIMITED error)
- [ ] T091 [P] Add clear error messages with actionable recovery steps (FR-013 edge cases)
- [ ] T092 [P] Implement message truncation UI for messages exceeding 4000 characters
- [ ] T093 [P] Add loading states and spinners for async operations
- [ ] T094 [P] Run `dart analyze` and fix all errors/warnings (0 errors required)
- [ ] T095 [P] Run `flutter test` and ensure all tests pass
- [ ] T096 [P] Run app on macOS and demo complete chat flow end-to-end
- [ ] T097 [P] Update AGENTS.md with feature completion notes
- [ ] T098 [P] Create GitHub PR with "Closes #<issue-number>" description
- [ ] T099 [P] Request code review and address feedback
- [ ] T100 [P] Merge PR and close GitHub issue

---

## Dependencies & Execution Order

### Phase Dependencies

```
Phase 1 (Setup) → Phase 2 (Foundational) → Phase 3 (US1) → Phase 4 (Polish)
```

### Within User Story 1

```
Foundation (T006-T026)
    ↓
Gateway Connection (T033-T039)
    ↓
Default Conversation (T040-T042)
    ↓
Send Message (T042-T048)
    ↓
Receive Message/Polling (T049-T053)
    ↓
Connection Status (T054-T057)
    ↓
Presentation - Setup (T058-T064)
    ↓
Presentation - Chat (T065-T076)
    ↓
History Persistence (T077-T080)
    ↓
DI Registration (T081-T085)
    ↓
Polish (T086-T100)
```

### Parallel Opportunities

**Phase 1 (Setup)**:
- T001, T002, T003, T004, T005 can all run in parallel (different files)

**Phase 2 (Foundational)**:
- T006-T011 (entity creation) can run in parallel
- T013-T015 (repository interfaces) can run in parallel
- T016-T017 (remote datasources) can run in parallel
- T018-T019 (local datasources) can run in parallel
- T020-T022 (repository impls) can run in parallel
- T024-T026 (enums) can run in parallel

**Phase 3 (US1)**:
- T027-T032 (tests) can run in parallel with each other
- T033-T035 (UseCases) can run in parallel
- T058-T060 (Setup state/controller/view) can run in parallel
- T065-T067 (Chat state/controller/view) can run in parallel
- T081-T085 (DI registration) can run in parallel

---

## Parallel Example: User Story 1

**Parallel Group 1: Entity Creation**
```bash
# Run these in parallel (different files, no dependencies)
zuraffa_entity_create --name Conversation --json --compare
zuraffa_entity_create --name Message --json --compare
zuraffa_entity_create --name GatewayConnection --json --compare
zuraffa_entity_create --name MessageMetadata --json --compare
zuraffa_entity_create --name ToolCall --json --compare
```

**Parallel Group 2: Repository Interfaces**
```bash
# Run these in parallel (different files, no dependencies)
# Create ConversationRepository interface
# Create MessageRepository interface
# Create GatewayConnectionRepository interface
```

**Parallel Group 3: Test Creation**
```bash
# Run these in parallel (different test files)
# Write ConnectGatewayUseCase test
# Write SendMessageUseCase test
# Write GetConversationHistoryUseCase test
# Write SetupModalView widget test
# Write ChatView widget test
```

---

## Implementation Strategy

### MVP First (User Story 1 Only)

Focus on delivering US1 completely before moving to subsequent stories. This ensures users get value quickly.

**MVP Scope**: T001-T085 (complete chat flow with setup, send/receive messages, history persistence)

### Incremental Delivery

Each task is independently testable and deliverable. Demo after EVERY task completion.

### Fast Iteration Workflow (Constitution Principle VII)

- **Primary Platform**: macOS (`flutter run -d macos`)
- **Hot Reload**: Use for UI/presentation changes (T058-T076)
- **Hot Restart**: Use for domain/data layer changes (T033-T057)
- **Target Iteration**: <30 seconds from code change to visible result

### Continuous Integration (Constitution Principle VIII)

- Commit after EVERY task - no exceptions
- Run `dart analyze && flutter test` before each commit
- Push to remote immediately after commit
- Commit message format: "T{ID}: {task description}" (e.g., "T033: Create ConnectGatewayUseCase")

### Task Summary

| Phase | Task Count | Status | Description |
|-------|------------|--------|-------------|
| Phase 1: Setup | 5 tasks | ✅ COMPLETE | Project initialization |
| Phase 2: Foundational | 21 tasks | ✅ COMPLETE (Commit: `b38d347`) | Core infrastructure |
| Phase 3: US1 | 59 tasks | ⏳ PENDING | Connect and chat implementation |
| Phase 4: Polish | 15 tasks | ⏳ PENDING | Performance, accessibility, CI/CD |
| **Total** | **100 tasks** | **26% Complete** | Complete MVP feature |

**Completed**: 26/100 tasks (Phase 1 & Phase 2)
**Remaining**: 74 tasks (Phase 3 & Phase 4)

---

## Notes

**Phase 1 & 2 Completion Summary**:
- All entities created with Zuraffa (6 entities, 4 enums)
- Repository interfaces generated (Conversation, Message, GatewayConnection)
- Data sources implemented (ZeroClawApiDatasource, GraphqlToRestAdapter, SecureStorageDatasource, HiveDatasource)
- Repository implementations completed (DataConversationRepository, DataGatewayConnectionRepository)
- `dart analyze`: 0 errors ✅
- `flutter test`: 34 tests passing ✅

**Next Steps**:
1. Start Phase 3: User Story 1 Implementation
2. Begin with Gateway Connection Setup (T033-T039)
3. Follow Test-First approach for UseCases (T027-T032)
4. Commit after each task with format: "T{ID}: {description}"
5. Run `dart analyze && flutter test` before each commit

- **MVP Priority**: Complete T001-T085 before considering US2, US3, US4
- **Test-First**: Write tests (T027-T032) before implementation tasks, ensure they fail, then implement
- **Zuraffa-First**: Use `zuraffa_entity_create` and `zfa generate` for all entity/UseCase generation
- **Platform Agnostic**: All business logic in domain/data layers, no platform-specific code in core
- **Privacy by Default**: Bearer tokens stored encrypted, no third-party services
- **Demo After Each Task**: Run `flutter run -d macos` and show visible progress
