# Research & Technical Decisions: Multi-Agent Workspace Management

**Feature**: 003-us2-multi-agent-workspace  
**Date**: 2026-02-18  
**Purpose**: Document technical decisions, patterns, and best practices for workspace management implementation

---

## Technical Decisions

### 1. Workspace Entity Design

**Decision**: Workspace as aggregate root containing identity, configuration, and conversation references

**Rationale**:
- Aligns with Domain-Driven Design principles
- Encapsulates all workspace-related data in single boundary
- Supports future multi-agent collaboration features
- Consistent with existing Conversation/Message entity patterns from US1

**Alternatives Considered**:
- Separate Workspace and WorkspaceConfiguration entities → Too fragmented for MVP
- Workspace as metadata overlay on Conversation → Doesn't capture agent identity separation

---

### 2. Soft Delete Pattern

**Decision**: Implement soft delete with `deletedAt` timestamp + background purge job

**Rationale**:
- User safety net for accidental deletions (30-day window)
- Complies with spec requirement for Trash functionality
- Simple implementation using existing Hive datasource
- Background job runs on app startup to purge expired workspaces

**Implementation Pattern**:
```dart
// Workspace entity
DateTime? deletedAt; // null = active, non-null = in trash

// Repository method
Future<void> delete(String id) async {
  final workspace = await get(id);
  workspace.deletedAt = DateTime.now();
  await update(workspace);
}

// Purge logic (runs on app startup)
Future<void> purgeExpiredTrash() async {
  final workspaces = await getList();
  final expired = workspaces.where((w) => 
    w.deletedAt != null && 
    DateTime.now().difference(w.deletedAt!).inDays > 30
  );
  for (final w in expired) {
    await permanentDelete(w.id);
  }
}
```

---

### 3. Workspace Switching Strategy

**Decision**: Active workspace state managed in presentation layer with repository-level caching

**Rationale**:
- No backend concept of "active" workspace (single-device MVP)
- Presentation layer manages which workspace is currently displayed
- Repository caches all workspaces locally for fast switching
- Conversation history loaded on-demand per workspace

**State Management**:
```dart
class WorkspaceState {
  final List<Workspace> workspaces;
  final String? activeWorkspaceId;
  final bool isLoading;
  final String? error;
}

class WorkspaceController extends StatefulController<WorkspaceState> {
  Future<void> switchWorkspace(String workspaceId) async {
    setState((s) => s.copyWith(isLoading: true));
    try {
      final workspace = await _getWorkspaceUseCase.execute(...);
      final conversations = await _getConversationsUseCase.execute(...);
      setState((s) => s.copyWith(
        activeWorkspaceId: workspaceId,
        conversations: conversations,
        isLoading: false,
      ));
    } catch (e) {
      setState((s) => s.copyWith(error: e.toString(), isLoading: false));
    }
  }
}
```

---

### 4. Data Storage Strategy

**Decision**: Hive boxes for workspaces, conversations, messages; Secure storage for credentials

**Rationale**:
- Consistent with US1 implementation
- Hive provides fast local storage with JSON serialization
- Secure storage for sensitive data (gateway tokens, API keys)
- No cloud sync in MVP (single-device only)

**Box Structure**:
```dart
// Hive boxes
const String workspacesBox = 'workspaces';
const String conversationsBox = 'conversations';
const String messagesBox = 'messages';

// Secure storage keys (per workspace)
const String gatewayTokenPrefix = 'gateway_token_'; // + workspaceId
const String gatewayUrlPrefix = 'gateway_url_'; // + workspaceId
```

---

### 5. Trash Management Pattern

**Decision**: Dedicated TrashView with restore and permanent delete actions

**Rationale**:
- Clear separation between active workspaces and deleted ones
- User control over retention (restore or purge early)
- Visual distinction (grayed out, trash icon)
- Consistent with desktop/mobile trash paradigms

**UI Flow**:
1. User navigates to "Trash" from workspace list
2. Shows all workspaces with `deletedAt != null`
3. Each item shows: name, deletion date, days remaining
4. Actions: Restore (moves back to active), Delete Permanently

---

### 6. Workspace Identity Configuration

**Decision**: Identity configuration as embedded value object in Workspace entity

**Rationale**:
- Identity is intrinsic to workspace, not separate entity
- Supports future agent personality customization
- Simple JSON serialization with Hive
- No need for separate repository

**Structure**:
```dart
class WorkspaceIdentity {
  final String name;
  final String? persona; // Agent personality description
  final String? systemPrompt; // Custom system instructions
  final Map<String, dynamic>? toolConfigs; // Future: tool configurations
}

class Workspace {
  final String id;
  final WorkspaceIdentity identity;
  final String gatewayConnectionId;
  final DateTime createdAt;
  final DateTime? deletedAt;
  // ... other fields
}
```

---

### 7. Performance Optimization

**Decision**: Lazy loading for conversation history, eager loading for workspace list

**Rationale**:
- Workspace list is small (<100 items typically)
- Conversation history can be large (1000s of messages)
- Lazy loading prevents UI blocking on workspace switch
- Pagination for conversations with 50-100 messages per page

**Implementation**:
```dart
// Eager: Load workspace list on app startup
final workspaces = await _workspaceRepository.getList();

// Lazy: Load conversation only when workspace is selected
final conversations = await _conversationRepository.getByWorkspace(workspaceId);

// Pagination: Load messages in chunks
final messages = await _messageRepository.getByConversation(
  conversationId,
  limit: 50,
  offset: 0,
);
```

---

## Best Practices

### Entity Lifecycle

1. **Create**: `CreateWorkspaceUseCase` → `WorkspaceRepository.create()` → `HiveDatasource.insert()`
2. **Read**: `GetWorkspaceUseCase` → `WorkspaceRepository.get()` → `HiveDatasource.getById()`
3. **Update**: `UpdateWorkspaceUseCase` → `WorkspaceRepository.update()` → `HiveDatasource.update()`
4. **Delete (Soft)**: Set `deletedAt`, move to trash conceptually
5. **Restore**: Clear `deletedAt`, move back to active
6. **Purge (Hard)**: `PermanentDeleteUseCase` → Remove from Hive + secure storage

### Error Handling

- **Workspace creation failed**: Show user-friendly error, retry option
- **Workspace switch failed**: Stay on current workspace, show error banner
- **Trash purge failed**: Log error, retry on next app startup
- **Secure storage failure**: Fallback to encrypted Hive box (less secure but functional)

### Testing Strategy

1. **Unit Tests**: UseCase logic, entity validation, repository methods
2. **Widget Tests**: Workspace list rendering, trash view, switcher UI
3. **Integration Tests**: Complete workspace flow (create → switch → delete → restore)

---

## Dependencies & Integration

### Extends US1 (Connect and Chat)

- Reuses `GatewayConnection` entity and repository
- Reuses `Conversation` and `Message` entities
- Adds `workspaceId` foreign key to conversations
- Workspace switch triggers conversation reload

### Future Integration Points

- **US3 (Tool Integration)**: Tool configurations per workspace
- **US4 (Conversation Search)**: Search scoped to active workspace or all
- **Multi-device Sync**: Workspace sync across devices (future enhancement)

---

## Risk Mitigation

| Risk | Impact | Mitigation |
|------|--------|------------|
| Data loss on trash purge | High | Clear UI warnings, 30-day grace period |
| Workspace switch performance | Medium | Lazy loading, caching, pagination |
| Secure storage key management | Medium | Consistent key naming, migration strategy |
| Conversation history orphaned | High | Cascade delete when workspace purged |

---

## References

- US1 Spec: `/specs/002-us1-connect-chat/spec.md`
- Constitution: `.specify/memory/constitution.md`
- Zuraffa Docs: https://pub.dev/packages/zuraffa
- Hive Docs: https://docs.hivedb.dev/
