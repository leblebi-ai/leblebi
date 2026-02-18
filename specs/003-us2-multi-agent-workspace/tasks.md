# Tasks: Multi-Agent Workspace Management

**Input**: Design documents from `/specs/003-us2-multi-agent-workspace/`
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
- **ZeroClaw API**: All data operations via REST API (no Hive storage for workspaces)

---

## Phase 1: Setup (Shared Infrastructure)

**Purpose**: Project initialization and basic structure

**Status**: ✅ COMPLETE (inherited from US1)

- [x] T001 Create project structure per implementation plan
- [x] T002 [P] Run `flutter pub get` to install dependencies (zuraffa, zorphy_annotation, get_it, http, flutter_secure_storage)
- [x] T003 [P] Configure Zuraffa (.zfa.json already exists at repo root)

**Note**: US1 already established the basic project structure and ZeroClaw REST API foundation.

---

## Phase 2: Foundational (Blocking Prerequisites)

**Purpose**: Core infrastructure that MUST be complete before ANY user story can be implemented

**⚠️ CRITICAL**: No user story work can begin until this phase is complete

- [ ] T004 [P] Create Workspace entity using `zuraffa_entity_create --name Workspace --json --compare --fields "identity:WorkspaceIdentity" --fields "gatewayConnectionId:String" --fields "createdAt:DateTime" --fields "updatedAt:DateTime?" --fields "deletedAt:DateTime?"` in lib/src/domain/entities/workspace.dart
- [ ] T005 [P] Create WorkspaceIdentity value object using `zuraffa_entity_create --name WorkspaceIdentity --json --fields "name:String" --fields "persona:String?" --fields "systemPrompt:String?" --fields "toolConfigs:Map<String,dynamic>?"` in lib/src/domain/entities/workspace_identity.dart
- [ ] T006 Run `zuraffa_build` to generate .g.dart serialization files for Workspace and WorkspaceIdentity
- [ ] T007 [P] Create WorkspaceRepository interface in lib/src/domain/repositories/workspace_repository.dart
- [ ] T008 [P] Extend ZeroClawRestApi with workspace endpoints in lib/src/data/datasources/remote/zeroclaw_workspace_api.dart (endpoints: GET/POST/PUT/DELETE /workspaces)
- [ ] T009 [P] Create WorkspaceRepositoryImpl in lib/src/data/repositories/workspace_repository_impl.dart (calls ZeroClaw API only, no Hive)
- [ ] T010 [P] Update Conversation entity to add workspaceId field using `zuraffa_entity_add_field --name Conversation --fields "workspaceId:String"` in lib/src/domain/entities/conversation.dart
- [ ] T011 [P] Update existing ZeroClawRestApi to include workspaceId in conversation API calls

**Checkpoint**: Foundation ready - user story implementation can now begin in parallel

**Notes**:
- T009: WorkspaceRepositoryImpl delegates ALL operations to ZeroClaw API (no local storage)
- T010: workspaceId links conversations to workspaces (managed by ZeroClaw)

---

## Phase 3: User Story 1 - Create and Manage Workspaces (Priority: P1) 🎯 MVP

**Goal**: Users can create, view, update, and delete workspaces via ZeroClaw gateway API.

**Independent Test**: User can create a workspace with custom name and identity, see it in the workspace list, update its configuration, and delete it (soft delete to trash).

### Tests for User Story 1 (OPTIONAL - Test-First approach) ⚠️

> **NOTE: Write these tests FIRST, ensure they FAIL before implementation**

- [ ] T012 [P] [US1] Unit test for CreateWorkspaceUseCase in test/domain/usecases/create_workspace_test.dart
- [ ] T013 [P] [US1] Unit test for GetWorkspaceListUseCase in test/domain/usecases/get_workspace_list_test.dart
- [ ] T014 [P] [US1] Unit test for DeleteWorkspaceUseCase in test/domain/usecases/delete_workspace_test.dart
- [ ] T015 [P] [US1] Widget test for WorkspaceListView in test/presentation/views/workspace_list_view_test.dart
- [ ] T016 [P] [US1] Integration test for workspace API flow in test/integration/workspace_api_flow_test.dart

### Implementation for User Story 1

#### Workspace CRUD UseCases

- [ ] T017 [P] [US1] Create CreateWorkspaceUseCase in lib/src/domain/usecases/create_workspace.dart (FR-005)
- [ ] T018 [P] [US1] Create GetWorkspaceListUseCase in lib/src/domain/usecases/get_workspace_list.dart
- [ ] T019 [P] [US1] Create GetWorkspaceUseCase in lib/src/domain/usecases/get_workspace.dart
- [ ] T020 [P] [US1] Create UpdateWorkspaceUseCase in lib/src/domain/usecases/update_workspace.dart
- [ ] T021 [P] [US1] Create DeleteWorkspaceUseCase in lib/src/domain/usecases/delete_workspace.dart (soft delete via API)

#### API Implementation

- [ ] T022 [US1] Implement workspace creation in ZeroClawWorkspaceApi.createWorkspace() - POST /workspaces
- [ ] T023 [US1] Implement workspace list in ZeroClawWorkspaceApi.getWorkspaces() - GET /workspaces
- [ ] T024 [US1] Implement workspace details in ZeroClawWorkspaceApi.getWorkspace(id) - GET /workspaces/{id}
- [ ] T025 [US1] Implement workspace update in ZeroClawWorkspaceApi.updateWorkspace(id, data) - PUT /workspaces/{id}
- [ ] T026 [US1] Implement workspace delete in ZeroClawWorkspaceApi.deleteWorkspace(id) - DELETE /workspaces/{id} (soft delete)

#### Presentation Layer - Workspace List

- [ ] T027 [P] [US1] Create WorkspaceState in lib/src/presentation/state/workspace_state.dart
- [ ] T028 [P] [US1] Create WorkspaceController in lib/src/presentation/controllers/workspace_controller.dart
- [ ] T029 [P] [US1] Create WorkspaceListView in lib/src/presentation/views/workspace_list_view.dart (FR-005)
- [ ] T030 [US1] Implement workspace list loading from API in WorkspaceController.loadWorkspaces()
- [ ] T031 [US1] Implement workspace list UI with ListView.builder in WorkspaceListView
- [ ] T032 [US1] Implement workspace item with name, persona, and actions menu in WorkspaceListView
- [ ] T033 [US1] Implement create workspace button and dialog in WorkspaceListView
- [ ] T034 [US1] Implement delete workspace confirmation dialog in WorkspaceListView
- [ ] T035 [US1] Implement error handling and loading states in WorkspaceListView

#### Dependency Injection

- [ ] T036 [P] [US1] Register Workspace UseCases in lib/src/di/injection_container.dart
- [ ] T037 [P] [US1] Register WorkspaceController in lib/src/di/injection_container.dart
- [ ] T038 [P] [US1] Register WorkspaceRepository in lib/src/di/injection_container.dart

**Checkpoint**: At this point, User Story 1 should be fully functional and testable independently

---

## Phase 4: User Story 2 - Switch Between Workspaces (Priority: P1)

**Goal**: Users can switch between workspaces, loading the appropriate conversation history from ZeroClaw.

**Independent Test**: User with multiple workspaces can switch from one to another and see the workspace's conversation history loaded from ZeroClaw API.

### Tests for User Story 2 (OPTIONAL - Test-First approach) ⚠️

- [ ] T039 [P] [US2] Unit test for SwitchWorkspaceUseCase in test/domain/usecases/switch_workspace_test.dart
- [ ] T040 [P] [US2] Integration test for workspace switching flow in test/integration/workspace_switch_flow_test.dart

### Implementation for User Story 2

#### Switch Workspace UseCase

- [ ] T041 [P] [US2] Create SwitchWorkspaceUseCase in lib/src/domain/usecases/switch_workspace.dart (FR-006)

#### API Integration

- [ ] T042 [US2] Implement conversation loading by workspace in ZeroClawWorkspaceApi.getConversationsByWorkspace(workspaceId) - GET /workspaces/{id}/conversations
- [ ] T043 [US2] Update WorkspaceController.switchWorkspace() to load conversations from API

#### UI Implementation

- [ ] T044 [US2] Implement workspace switcher UI in WorkspaceListView (dropdown or separate view)
- [ ] T045 [US2] Show active workspace indicator in WorkspaceListView
- [ ] T046 [US2] Implement conversation list loading when workspace switches
- [ ] T047 [US2] Add loading state during workspace switch (API call in progress)
- [ ] T048 [US2] Implement error handling for failed workspace switch

**Checkpoint**: At this point, User Stories 1 AND 2 should both work independently

---

## Phase 5: User Story 3 - Trash Management (Priority: P2)

**Goal**: Users can view deleted workspaces in Trash, restore them, or see auto-purge status (managed by ZeroClaw).

**Independent Test**: User can delete a workspace, see it in Trash view, restore it, and see it return to active workspace list.

### Tests for User Story 3 (OPTIONAL - Test-First approach) ⚠️

- [ ] T049 [P] [US3] Unit test for RestoreWorkspaceUseCase in test/domain/usecases/restore_workspace_test.dart
- [ ] T050 [P] [US3] Widget test for TrashView in test/presentation/views/trash_view_test.dart

### Implementation for User Story 3

#### Restore UseCase

- [ ] T051 [P] [US3] Create RestoreWorkspaceUseCase in lib/src/domain/usecases/restore_workspace.dart (FR-007)

#### API Implementation

- [ ] T052 [US3] Implement restore workspace in ZeroClawWorkspaceApi.restoreWorkspace(id) - POST /workspaces/{id}/restore
- [ ] T053 [US3] Implement get trash workspaces in ZeroClawWorkspaceApi.getTrashWorkspaces() - GET /workspaces?status=deleted

#### Presentation Layer - Trash View

- [ ] T054 [P] [US3] Create TrashState in lib/src/presentation/state/trash_state.dart
- [ ] T055 [P] [US3] Create TrashController in lib/src/presentation/controllers/trash_controller.dart
- [ ] T056 [P] [US3] Create TrashView in lib/src/presentation/views/trash_view.dart (FR-007)
- [ ] T057 [US3] Implement trash list loading from API in TrashController.loadTrash()
- [ ] T058 [US3] Implement trash list UI with deleted workspaces in TrashView
- [ ] T059 [US3] Implement restore button for each workspace in TrashView
- [ ] T060 [US3] Implement days remaining before auto-purge display in TrashView
- [ ] T061 [US3] Implement navigation to Trash from WorkspaceListView

#### Dependency Injection

- [ ] T062 [P] [US3] Register RestoreWorkspaceUseCase in lib/src/di/injection_container.dart
- [ ] T063 [P] [US3] Register TrashController in lib/src/di/injection_container.dart

**Checkpoint**: All user stories should now be independently functional

---

## Phase 6: Polish & Cross-Cutting Concerns

**Purpose**: Final polish, performance optimization, and cross-cutting concerns

- [ ] T064 [P] Add API response caching for workspace list (optional read-through cache for performance)
- [ ] T065 [P] Implement optimistic UI updates for workspace operations
- [ ] T066 [P] Add comprehensive error logging for API calls
- [ ] T067 [P] Add retry logic with exponential backoff for failed API calls
- [ ] T068 [P] Implement pull-to-refresh for workspace list
- [ ] T069 [P] Add accessibility support (screen reader labels, sufficient color contrast)
- [ ] T070 [P] Add loading skeletons for workspace list and conversation list
- [ ] T071 [P] Run `dart analyze` and fix all errors/warnings (0 errors required)
- [ ] T072 [P] Run `flutter test` and ensure all tests pass
- [ ] T073 [P] Run app on macOS and demo complete workspace flow end-to-end
- [ ] T074 [P] Update AGENTS.md with feature completion notes
- [ ] T075 [P] Create GitHub PR with "Closes #<issue-number>" description
- [ ] T076 [P] Request code review and address feedback
- [ ] T077 [P] Merge PR and close GitHub issue

---

## Dependencies & Execution Order

### Phase Dependencies

```
Phase 1 (Setup) → Phase 2 (Foundational) → Phase 3 (US1) → Phase 4 (US2) → Phase 5 (US3) → Phase 6 (Polish)
```

### User Story Dependencies

- **User Story 1 (P1)**: Can start after Foundational (Phase 2) - No dependencies on other stories
- **User Story 2 (P1)**: Can start after Foundational (Phase 2) - Independent but integrates with US1
- **User Story 3 (P2)**: Can start after Foundational (Phase 2) - Independent but integrates with US1

### Within Each User Story

```
Foundation (T004-T011)
    ↓
Tests (T012-T016, optional but Test-First)
    ↓
UseCases (T017-T021)
    ↓
API Implementation (T022-T026)
    ↓
Presentation (T027-T035)
    ↓
DI Registration (T036-T038)
```

### Parallel Opportunities

**Phase 2 (Foundational)**:
- T004-T005 (entity creation) can run in parallel
- T007-T009 (repository interface, API, repository impl) can run in parallel after entities
- T010-T011 (Conversation update) can run in parallel

**Phase 3 (US1)**:
- T012-T016 (tests) can run in parallel
- T017-T021 (UseCases) can run in parallel
- T027-T029 (State, Controller, View) can run in parallel
- T036-T038 (DI registration) can run in parallel

**Phase 4 (US2)**:
- T039-T040 (tests) can run in parallel
- T041 (UseCase) independent
- T044-T048 (UI tasks) can run in parallel after UseCase

**Phase 5 (US3)**:
- T049-T050 (tests) can run in parallel
- T054-T056 (State, Controller, View) can run in parallel

---

## Parallel Example: User Story 1

**Parallel Group 1: Entity Creation**
```bash
# Run these in parallel (different files, no dependencies)
zuraffa_entity_create --name Workspace --json --compare ...
zuraffa_entity_create --name WorkspaceIdentity --json ...
```

**Parallel Group 2: Test Creation (if tests requested)**
```bash
# Run these in parallel (different test files)
# Write CreateWorkspaceUseCase test
# Write GetWorkspaceListUseCase test
# Write DeleteWorkspaceUseCase test
# Write WorkspaceListView widget test
# Write workspace API integration test
```

**Parallel Group 3: UseCase Creation**
```bash
# Run these in parallel (different files, no dependencies)
# Create CreateWorkspaceUseCase
# Create GetWorkspaceListUseCase
# Create GetWorkspaceUseCase
# Create UpdateWorkspaceUseCase
# Create DeleteWorkspaceUseCase
```

**Parallel Group 4: Presentation Layer**
```bash
# Run these in parallel (different files)
# Create WorkspaceState
# Create WorkspaceController
# Create WorkspaceListView
```

---

## Implementation Strategy

### MVP First (User Story 1 Only)

Focus on delivering US1 completely before moving to subsequent stories. This ensures users get value quickly.

**MVP Scope**: T004-T038 (complete workspace CRUD with API integration and UI)

### Incremental Delivery

1. Complete Phase 1 & 2 → Foundation ready
2. Complete Phase 3 (US1) → Users can create/manage workspaces → **DEMO**
3. Complete Phase 4 (US2) → Users can switch workspaces → **DEMO**
4. Complete Phase 5 (US3) → Users can restore from trash → **DEMO**
5. Complete Phase 6 → Polish and production-ready

### Fast Iteration Workflow (Constitution Principle VII)

- **Primary Platform**: macOS (`flutter run -d macos`)
- **Hot Reload**: Use for UI/presentation changes (T027-T035, T044-T048, T054-T061)
- **Hot Restart**: Use for domain/data layer changes (T004-T026)
- **Target Iteration**: <30 seconds from code change to visible result

### Continuous Integration (Constitution Principle VIII)

- Commit after EVERY task - no exceptions
- Run `dart analyze && flutter test` before each commit
- Push to remote immediately after commit
- Commit message format: "T{ID}: {task description}" (e.g., "T017: Create CreateWorkspaceUseCase")

### ZeroClaw-First Architecture

**IMPORTANT**: All data operations MUST go through ZeroClaw API:
- NO Hive boxes for workspaces/conversations
- NO local data persistence (except bearer token in secure storage)
- ZeroClaw gateway is the source of truth
- Optional: Read-through cache for performance (invalidated on mutations)

---

## Task Summary

| Phase | Task Count | Status | Description |
|-------|------------|--------|-------------|
| Phase 1: Setup | 3 tasks | ✅ COMPLETE | Project initialization (inherited from US1) |
| Phase 2: Foundational | 8 tasks | ⏳ PENDING | Core infrastructure (entities, repository, API) |
| Phase 3: US1 | 22 tasks | ⏳ PENDING | Create and manage workspaces |
| Phase 4: US2 | 10 tasks | ⏳ PENDING | Switch between workspaces |
| Phase 5: US3 | 13 tasks | ⏳ PENDING | Trash management |
| Phase 6: Polish | 14 tasks | ⏳ PENDING | Performance, accessibility, CI/CD |
| **Total** | **70 tasks** | **4% Complete** | Complete MVP feature |

**Completed**: 3/70 tasks (Phase 1)
**Remaining**: 67 tasks (Phase 2-6)

---

## Notes

- **ZeroClaw API is source of truth**: No local Hive storage for workspaces/conversations
- **Bearer token authentication**: Stored in flutter_secure_storage (from US1)
- **Soft delete**: Workspaces marked as deleted in ZeroClaw, restored via API
- **Test-First**: Write tests (T012-T016, etc.) before implementation tasks, ensure they fail, then implement
- **Zuraffa-First**: Use `zuraffa_entity_create` and `zfa generate` for all entity/UseCase generation
- **Platform Agnostic**: All business logic in domain/data layers, no platform-specific code in core
- **Privacy by Default**: Bearer tokens stored encrypted, all data in user-controlled ZeroClaw gateway
- **Demo After Each Task**: Run `flutter run -d macos` and show visible progress

**Next Steps**:
1. Start Phase 2: Foundational Infrastructure
2. Begin with entity creation (T004-T005)
3. Follow Test-First approach for UseCases (T012-T016)
4. Commit after each task with format: "T{ID}: {description}"
5. Run `dart analyze && flutter test` before each commit
