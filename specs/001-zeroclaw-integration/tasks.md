# Tasks: ZeroClaw Flutter Interface

**Input**: Design documents from `/specs/001-zeroclaw-integration/`
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

- [X] T001 [P] Initialize Flutter project with Zuraffa and Zorphy dependencies (pubspec.yaml already configured)
- [X] T002 [P] Run `flutter pub get` to install dependencies
- [X] T003 [P] Create lib/src/ directory structure (domain/, data/, presentation/, di/)
- [X] T004 [P] Configure Zuraffa (.zfa.json already exists)
- [X] T005 [P] Setup Hive database initialization in lib/src/data/datasources/local/hive_datasource.dart

---

## Phase 2: Foundational (Blocking Prerequisites)

**Purpose**: Core infrastructure that MUST be complete before ANY user story can be implemented

**⚠️ CRITICAL**: No user story work can begin until this phase is complete

- [X] T006 [P] Create Workspace entity using `zuraffa_entity_create --name Workspace --json --compare`
- [X] T007 [P] Create Conversation entity using `zuraffa_entity_create --name Conversation --json --compare`
- [X] T008 [P] Create Message entity using `zuraffa_entity_create --name Message --json --compare`
- [X] T009 [P] Create GatewayConnection entity using `zuraffa_entity_create --name GatewayConnection --json --compare`
- [X] T010 [P] Create ToolConfiguration entity using `zuraffa_entity_create --name ToolConfiguration --json --compare`
- [X] T011 [P] Create SearchResult entity using `zuraffa_entity_create --name SearchResult --json --compare`
- [X] T012 Run `zuraffa_build` to generate .g.dart serialization files for all entities
- [X] T013 [P] Create WorkspaceRepository interface in lib/src/domain/repositories/workspace_repository.dart
- [X] T014 [P] Create ConversationRepository interface in lib/src/domain/repositories/conversation_repository.dart
- [X] T015 [P] Create GatewayRepository interface in lib/src/domain/repositories/gateway_repository.dart
- [X] T016 [P] Create ToolRepository interface in lib/src/domain/repositories/tool_repository.dart
- [X] T017 [P] Setup get_it dependency injection in lib/src/di/injection_container.dart
- [X] T018 [P] Create ZeroClaw API datasource in lib/src/data/datasources/remote/zeroclaw_api_datasource.dart
- [X] T019 [P] Implement Hive local storage initialization with encrypted box for credentials

**Checkpoint**: ✅ Foundation ready - user story implementation can now begin in parallel

---

## Phase 3: User Story 1 - Connect and Chat with ZeroClaw Agent (Priority: P1) 🎯 MVP

**Goal**: Users can connect to a ZeroClaw gateway and engage in conversation with message history and real-time responses

**Independent Test**: User can launch the app, configure a gateway connection, send a message, and receive an AI response. The entire conversation flow works without any other features enabled.

### Tests for User Story 1 (OPTIONAL - Test-First approach) ⚠️

> **NOTE: Write these tests FIRST, ensure they FAIL before implementation**

- [ ] T020 [P] [US1] Create unit test for SendMessageUseCase in test/domain/usecases/send_message_usecase_test.dart
- [ ] T021 [P] [US1] Create unit test for GetConversationUseCase in test/domain/usecases/get_conversation_usecase_test.dart
- [ ] T022 [P] [US1] Create widget test for ChatView in test/presentation/views/chat_view_test.dart
- [ ] T023 [P] [US1] Create integration test for gateway connection flow in test/integration/gateway_connection_test.dart

### Implementation for User Story 1

- [ ] T024 [P] [US1] Generate Workspace CRUD UseCases using `zfa generate --name Workspace --methods get,getList,create,update,delete --data --di`
- [ ] T025 [P] [US1] Generate Conversation CRUD UseCases using `zfa generate --name Conversation --methods get,getList,create,delete --data --di`
- [ ] T026 [P] [US1] Generate Message CRUD UseCases using `zfa generate --name Message --methods get,getList,create --data --di`
- [ ] T027 [P] [US1] Generate GatewayConnection CRUD UseCases using `zfa generate --name GatewayConnection --methods get,getList,create,update,delete --data --di`
- [ ] T028 [US1] Create custom SendMessageUseCase in lib/src/domain/usecases/conversation/send_message_usecase.dart
- [ ] T029 [US1] Create ConnectGatewayUseCase in lib/src/domain/usecases/gateway/connect_gateway_usecase.dart
- [ ] T030 [US1] Implement WorkspaceRepositoryImpl in lib/src/data/repositories/workspace_repository_impl.dart
- [ ] T031 [US1] Implement ConversationRepositoryImpl in lib/src/data/repositories/conversation_repository_impl.dart
- [ ] T032 [US1] Implement GatewayRepositoryImpl in lib/src/data/repositories/gateway_repository_impl.dart
- [ ] T033 [US1] Create ChatState in lib/src/presentation/state/chat_state.dart
- [ ] T034 [US1] Create ChatPresenter in lib/src/presentation/presenters/chat_presenter.dart
- [ ] T035 [US1] Create ChatController in lib/src/presentation/controllers/chat_controller.dart
- [ ] T036 [US1] Create ChatView in lib/src/presentation/views/chat_view.dart
- [ ] T037 [US1] Implement message input field with send button in lib/src/presentation/views/chat_view.dart
- [ ] T038 [US1] Implement message list display with markdown rendering in lib/src/presentation/views/chat_view.dart
- [ ] T039 [US1] Add typing indicator widget in lib/src/presentation/views/chat_view.dart
- [ ] T040 [US1] Implement connection status indicator in lib/src/presentation/views/chat_view.dart
- [ ] T041 [US1] Register all US1 services in injection_container.dart

**Checkpoint**: At this point, User Story 1 should be fully functional and testable independently. Run `flutter run -d macos` and demonstrate: connect to gateway, send message, receive AI response, view conversation history.

---

## Phase 4: User Story 2 - Multi-Agent Workspace Management (Priority: P2)

**Goal**: Users can create, configure, and switch between multiple agent workspaces with distinct identities and configurations

**Independent Test**: User can create two separate workspaces with different configurations, switch between them, and maintain independent conversation histories in each.

### Tests for User Story 2 (OPTIONAL - Test-First approach) ⚠️

- [ ] T042 [P] [US2] Create unit test for CreateWorkspaceUseCase in test/domain/usecases/create_workspace_usecase_test.dart
- [ ] T043 [P] [US2] Create unit test for SwitchWorkspaceUseCase in test/domain/usecases/switch_workspace_usecase_test.dart
- [ ] T044 [P] [US2] Create widget test for WorkspaceListView in test/presentation/views/workspace_list_view_test.dart

### Implementation for User Story 2

- [ ] T045 [P] [US2] Create custom CreateWorkspaceUseCase in lib/src/domain/usecases/workspace/create_workspace_usecase.dart
- [ ] T046 [P] [US2] Create custom UpdateWorkspaceUseCase in lib/src/domain/usecases/workspace/update_workspace_usecase.dart
- [ ] T047 [P] [US2] Create custom DeleteWorkspaceUseCase in lib/src/domain/usecases/workspace/delete_workspace_usecase.dart
- [ ] T048 [P] [US2] Create custom SwitchWorkspaceUseCase in lib/src/domain/usecases/workspace/switch_workspace_usecase.dart
- [ ] T049 [US2] Create WorkspaceState in lib/src/presentation/state/workspace_state.dart
- [ ] T050 [US2] Create WorkspacePresenter in lib/src/presentation/presenters/workspace_presenter.dart
- [ ] T051 [US2] Create WorkspaceController in lib/src/presentation/controllers/workspace_controller.dart
- [ ] T052 [US2] Create WorkspaceListView in lib/src/presentation/views/workspace_list_view.dart
- [ ] T053 [US2] Create workspace creation form with identity config in lib/src/presentation/views/workspace_form_view.dart
- [ ] T054 [US2] Implement workspace switcher UI in lib/src/presentation/views/workspace_list_view.dart
- [ ] T055 [US2] Add Trash view for soft-deleted workspaces in lib/src/presentation/views/workspace_trash_view.dart
- [ ] T056 [US2] Implement 30-day auto-purge logic for deleted workspaces
- [ ] T057 [US2] Register all US2 services in injection_container.dart

**Checkpoint**: At this point, User Stories 1 AND 2 should both work independently. Demo: Create two workspaces, switch between them, verify independent conversation histories.

---

## Phase 5: User Story 3 - Tool & Integration Management (Priority: P3)

**Goal**: Users can view, enable, and configure ZeroClaw tools and integrations with workspace-specific scopes

**Independent Test**: User can navigate to a tools settings screen, enable/disable specific tools, set workspace scopes, and observe that the AI's capabilities change accordingly.

### Tests for User Story 3 (OPTIONAL - Test-First approach) ⚠️

- [ ] T058 [P] [US3] Create unit test for UpdateToolConfigurationUseCase in test/domain/usecases/update_tool_config_usecase_test.dart
- [ ] T059 [P] [US3] Create widget test for ToolsView in test/presentation/views/tools_view_test.dart

### Implementation for User Story 3

- [ ] T060 [P] [US3] Generate ToolConfiguration CRUD UseCases using `zfa generate --name ToolConfiguration --methods get,getList,update --data --di`
- [ ] T061 [P] [US3] Create custom UpdateToolConfigurationUseCase in lib/src/domain/usecases/tool/update_tool_config_usecase.dart
- [ ] T062 [US3] Create ToolsState in lib/src/presentation/state/tools_state.dart
- [ ] T063 [US3] Create ToolsPresenter in lib/src/presentation/presenters/tools_presenter.dart
- [ ] T064 [US3] Create ToolsController in lib/src/presentation/controllers/tools_controller.dart
- [ ] T065 [US3] Create ToolsView in lib/src/presentation/views/tools_view.dart
- [ ] T066 [US3] Implement tool toggle switches in lib/src/presentation/views/tools_view.dart
- [ ] T067 [US3] Implement tool scope configuration UI (directory paths, allowed commands) in lib/src/presentation/views/tool_scope_view.dart
- [ ] T068 [US3] Implement integration management UI in lib/src/presentation/views/integrations_view.dart
- [ ] T069 [US3] Register all US3 services in injection_container.dart

**Checkpoint**: All user stories should now be independently functional. Demo: Enable file_read tool with directory scope, verify AI can access files in that scope.

---

## Phase 6: User Story 4 - Conversation Memory & Search (Priority: P4)

**Goal**: Users can search across all conversation history using natural language queries with ranked results

**Independent Test**: User can enter a search query about a past topic, see ranked results from conversation history, and tap to view the full context of any result.

### Tests for User Story 4 (OPTIONAL - Test-First approach) ⚠️

- [ ] T070 [P] [US4] Create unit test for SearchConversationsUseCase in test/domain/usecases/search_conversations_usecase_test.dart
- [ ] T071 [P] [US4] Create widget test for SearchView in test/presentation/views/search_view_test.dart

### Implementation for User Story 4

- [ ] T072 [P] [US4] Create custom SearchConversationsUseCase in lib/src/domain/usecases/conversation/search_conversations_usecase.dart
- [ ] T073 [US4] Create SearchState in lib/src/presentation/state/search_state.dart
- [ ] T074 [US4] Create SearchPresenter in lib/src/presentation/presenters/search_presenter.dart
- [ ] T075 [US4] Create SearchController in lib/src/presentation/controllers/search_controller.dart
- [ ] T076 [US4] Create SearchView in lib/src/presentation/views/search_view.dart
- [ ] T077 [US4] Implement search input field with debounce in lib/src/presentation/views/search_view.dart
- [ ] T078 [US4] Implement search results list with relevance scores in lib/src/presentation/views/search_view.dart
- [ ] T079 [US4] Implement result navigation to original conversation context in lib/src/presentation/views/search_view.dart
- [ ] T080 [US4] Implement hybrid search (keyword + semantic) in SearchConversationsUseCase
- [ ] T081 [US4] Register all US4 services in injection_container.dart

**Checkpoint**: All 4 user stories are now complete and independently testable. Full demo: Search for past conversation, tap result, view full context.

---

## Phase 7: Polish & Cross-Cutting Concerns

**Purpose**: Improvements that affect multiple user stories

- [ ] T082 [P] Run `dart format .` and fix all formatting issues
- [ ] T083 [P] Run `flutter analyze` and fix all errors/warnings (must be 0)
- [ ] T084 [P] Add documentation comments to all public APIs (UseCase methods, Repository interfaces)
- [ ] T085 [P] Implement structured logging for all agent operations (provider, model, tokens, duration)
- [ ] T086 [P] Add error handling and user-friendly error messages throughout
- [ ] T087 [P] Implement network retry with exponential backoff for all API calls
- [ ] T088 [P] Add pagination/virtual scrolling for conversations with 1000+ messages
- [ ] T089 [P] Implement "No connection" state when gateway unreachable (disable input, show indicator)
- [ ] T090 [P] Run quickstart.md validation - follow setup guide and verify all steps work
- [ ] T091 [P] Update README.md with feature overview and screenshots
- [ ] T092 [P] Create CHANGELOG.md entry for v1.0.0 release

---

## Dependencies & Execution Order

### Phase Dependencies

- **Setup (Phase 1)**: No dependencies - can start immediately
- **Foundational (Phase 2)**: Depends on Setup completion - BLOCKS all user stories
- **User Stories (Phase 3-6)**: All depend on Foundational phase completion
  - User stories can proceed in parallel (if staffed)
  - Or sequentially in priority order (P1 → P2 → P3 → P4)
- **Polish (Phase 7)**: Depends on all desired user stories being complete

### User Story Dependencies

- **User Story 1 (P1)**: Can start after Foundational (Phase 2) - No dependencies on other stories
- **User Story 2 (P2)**: Can start after Foundational (Phase 2) - Independent of US1
- **User Story 3 (P3)**: Can start after Foundational (Phase 2) - Independent of US1/US2
- **User Story 4 (P4)**: Can start after Foundational (Phase 2) - Independent of US1/US2/US3

### Within Each User Story

- Tests (if included) MUST be written and FAIL before implementation
- Entities/Models already generated in Foundational phase
- UseCases generated via Zuraffa before custom implementation
- Presenters/Controllers/Views in order (VPC pattern)
- Story complete before moving to next priority

### Parallel Opportunities

- All Setup tasks marked [P] can run in parallel
- All Foundational tasks marked [P] can run in parallel (within Phase 2)
- Once Foundational phase completes, all user stories can start in parallel (if team capacity allows)
- All tests for a user story marked [P] can run in parallel
- All entity generation tasks marked [P] can run in parallel
- Different user stories can be worked on in parallel by different team members

---

## Parallel Example: User Story 1

```bash
# Launch all entity generation for User Story 1 together:
Task: "Generate Workspace CRUD UseCases using zfa generate..."
Task: "Generate Conversation CRUD UseCases using zfa generate..."
Task: "Generate Message CRUD UseCases using zfa generate..."
Task: "Generate GatewayConnection CRUD UseCases using zfa generate..."

# Launch all tests for User Story 1 together (if tests requested):
Task: "Create unit test for SendMessageUseCase in test/domain/usecases/..."
Task: "Create unit test for GetConversationUseCase in test/domain/usecases/..."
Task: "Create widget test for ChatView in test/presentation/views/..."

# Launch all repository implementations in parallel:
Task: "Implement WorkspaceRepositoryImpl in lib/src/data/repositories/..."
Task: "Implement ConversationRepositoryImpl in lib/src/data/repositories/..."
Task: "Implement GatewayRepositoryImpl in lib/src/data/repositories/..."
```

---

## Parallel Example: User Story 2

```bash
# Launch all custom UseCase creation in parallel:
Task: "Create custom CreateWorkspaceUseCase in lib/src/domain/usecases/..."
Task: "Create custom UpdateWorkspaceUseCase in lib/src/domain/usecases/..."
Task: "Create custom DeleteWorkspaceUseCase in lib/src/domain/usecases/..."
Task: "Create custom SwitchWorkspaceUseCase in lib/src/domain/usecases/..."
```

---

## Implementation Strategy

### MVP First (User Story 1 Only)

1. Complete Phase 1: Setup
2. Complete Phase 2: Foundational (CRITICAL - blocks all stories)
3. Complete Phase 3: User Story 1
4. **STOP and VALIDATE**: Run `flutter run -d macos` and test:
   - Connect to ZeroClaw gateway
   - Send a message
   - Receive AI response within 5 seconds
   - View conversation history after app restart
5. Deploy/demo if ready (MVP complete!)

### Incremental Delivery

1. Complete Setup + Foundational → Foundation ready
2. Add User Story 1 → Test independently → Deploy/Demo (MVP: Chat with AI)
3. Add User Story 2 → Test independently → Deploy/Demo (Multi-workspace)
4. Add User Story 3 → Test independently → Deploy/Demo (Tool management)
5. Add User Story 4 → Test independently → Deploy/Demo (Search)
6. Each story adds value without breaking previous stories

### Fast Iteration Workflow (Constitution Principle VII)

- **Primary platform**: macOS (`flutter run -d macos`)
- **Hot reload**: Use for UI/presentation changes (<30s iteration)
- **Hot restart**: Use for domain/data layer changes
- **Demo after EVERY task**: Run app and show feature working
- **Commit after each task or logical group**
- **Stop at checkpoints** to validate user stories independently

### Parallel Team Strategy

With multiple developers:

1. Team completes Setup + Foundational together
2. Once Foundational is done:
   - Developer A: User Story 1 (Chat)
   - Developer B: User Story 2 (Workspaces)
   - Developer C: User Story 3 (Tools)
   - Developer D: User Story 4 (Search)
3. Stories complete and integrate independently
4. Team reconvenes for Phase 7: Polish

---

## Task Summary

**Total Tasks**: 92

**By Phase**:
- Phase 1 (Setup): 5 tasks
- Phase 2 (Foundational): 14 tasks
- Phase 3 (US1 - Chat): 22 tasks (4 tests + 18 implementation)
- Phase 4 (US2 - Workspaces): 16 tasks (3 tests + 13 implementation)
- Phase 5 (US3 - Tools): 12 tasks (2 tests + 10 implementation)
- Phase 6 (US4 - Search): 11 tasks (2 tests + 9 implementation)
- Phase 7 (Polish): 12 tasks

**Parallel Opportunities**:
- 5 parallel tasks in Setup phase
- 11 parallel tasks in Foundational phase
- 4 parallel test tasks per user story
- All user stories can proceed in parallel after Foundational phase

**MVP Scope** (User Story 1 only): 41 tasks (Phases 1-3)

---

## Notes

- [P] tasks = different files, no dependencies
- [Story] label maps task to specific user story for traceability
- Each user story should be independently completable and testable
- Verify tests fail before implementing (if using Test-First)
- Commit after each task or logical group
- **CRITICAL**: Run `flutter run -d macos` after EVERY task to demo the feature working
- Stop at any checkpoint to validate story independently
- Use Zuraffa for ALL code generation - manual creation forbidden (Constitution Principle VI)
- Run `dart analyze` after each generation - must have 0 errors/warnings
