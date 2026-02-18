# Feature Specification: Multi-Agent Workspace Management

**Feature Branch**: `003-us2-multi-agent-workspace`
**Parent Epic**: `001-zeroclaw-integration`
**Created**: 2026-02-17
**Status**: Draft
**Priority**: P2

## Overview

Users can create, configure, and switch between multiple agent workspaces through the ZeroClaw gateway. Leblebi acts as a **thin UI client** that displays and manipulates workspace data stored in ZeroClaw's database. All workspace data (identities, configurations, conversation histories) is managed by ZeroClaw - Leblebi only provides the interface.

**Why this matters**: Power users need to separate different contexts (work, personal, coding, writing) with dedicated agent configurations. ZeroClaw already provides workspace management - Leblebi makes it accessible through a beautiful, intuitive UI.

**Dependency**: Requires US1 (Connect and Chat) to be completed first.

**Architecture Principle**: Leblebi is a UI-only client. All data persists in ZeroClaw's database. No duplicate local storage except optional caching for performance.

## Target User

Power users who need to maintain separate AI agent contexts for different use cases (work vs personal, different projects, different domains).

## User Scenarios & Acceptance Criteria

### Primary User Journey

**Independent Test**: User can create two separate workspaces via ZeroClaw gateway, switch between them in the UI, and see independent conversation histories loaded from ZeroClaw's database.

**Acceptance Scenarios**:

1. **Given** no existing workspaces, **When** user creates a new workspace with a custom name and identity configuration, **Then** the workspace is created in ZeroClaw's database and becomes the active conversation context.
2. **Given** multiple workspaces exist in ZeroClaw, **When** user switches from one workspace to another, **Then** the UI loads and displays the workspace's conversation history from ZeroClaw's database.
3. **Given** an active workspace, **When** user modifies the agent's identity or configuration, **Then** changes are saved to ZeroClaw's database and reflected in subsequent interactions.

## Requirements

### Functional Requirements

- **FR-005**: System MUST provide UI to create, rename, and delete workspaces via ZeroClaw gateway API. Workspace data persists in ZeroClaw's database.
- **FR-006**: System MUST allow users to switch between workspaces by loading workspace data and conversation history from ZeroClaw's database.
- **FR-007**: System MUST provide a "Trash" view that displays workspaces marked as deleted in ZeroClaw's database, with restore functionality.

### Key Entities (ZeroClaw-Managed)

- **Workspace**: Managed by ZeroClaw gateway. Contains identity settings, configuration, and conversation references. Leblebi displays and manipulates via API only.
- **Conversation**: Managed by ZeroClaw gateway. Leblebi loads conversation history via API calls.
- **Message**: Managed by ZeroClaw gateway. Leblebi sends/receives via API.

## Data Architecture

**CRITICAL**: Leblebi is a **thin UI client** - all data persists in ZeroClaw's database.

- **No local Hive storage** for workspaces, conversations, or messages (except optional read-through cache)
- **ZeroClaw REST API** is the source of truth for all data operations
- **Bearer token authentication** for all API calls (stored in flutter_secure_storage)
- **Optional caching**: Read-through cache for performance (invalidated on mutations)

### API Endpoints (ZeroClaw Gateway)

- `GET /workspaces` - List all workspaces
- `POST /workspaces` - Create new workspace
- `GET /workspaces/{id}` - Get workspace details
- `PUT /workspaces/{id}` - Update workspace
- `DELETE /workspaces/{id}` - Soft delete workspace (moves to trash)
- `POST /workspaces/{id}/restore` - Restore workspace from trash
- `GET /workspaces/{id}/conversations` - List conversations in workspace
- `POST /workspaces/{id}/conversations` - Create conversation

## Edge Cases

- **API unavailable**: Show clear error message, retry with exponential backoff
- **Workspace deletion recovery**: Workspaces marked as deleted in ZeroClaw can be restored via API within 30 days
- **Concurrent modifications**: Last-write-wins (ZeroClaw handles conflict resolution)

## Out of Scope (MVP)

- Basic chat functionality (covered in US1)
- Tool & integration management (covered in US3)
- Conversation search (covered in US4)
- Multi-device sync (handled by ZeroClaw backend)
- Local data persistence (ZeroClaw is source of truth)

## Success Criteria

### Measurable Outcomes

- **SC-003**: 90% of users successfully create and switch between multiple workspaces without assistance on first attempt.
- **SC-004**: 95% of API calls complete successfully under normal network conditions.
- **SC-005**: Workspace switch completes in <2 seconds (API round-trip time).

## Clarifications

### Session 2026-02-17

- Q: How should Leblebi store workspace and conversation data? → A: ZeroClaw database only, Leblebi is thin UI client
- Q: Should we cache data locally for offline access? → A: Optional read-through cache for performance, but not required for MVP
- Q: How long should conversation history be retained? → A: Managed by ZeroClaw (30-day trash retention)
