# Data Model: ZeroClaw Flutter Interface

**Created**: 2026-02-17
**Purpose**: Define all entities, relationships, and validation rules for ZeroClaw integration

---

## Core Entities

### Workspace

**Description**: A named agent configuration context containing identity settings, tool configurations, conversation history, and gateway connection details.

**Fields**:
- `id`: String (unique identifier, UUID v4)
- `name`: String (user-defined workspace name, 1-50 chars)
- `description`: String? (optional description, max 200 chars)
- `gatewayConnectionId`: String? (reference to active gateway connection, nullable for offline workspaces)
- `identityConfig`: IdentityConfig (embedded object: name, personality, system prompt)
- `toolConfigurations`: List<ToolConfiguration> (embedded list of tool settings)
- `activeConversationId`: String? (reference to currently open conversation)
- `createdAt`: DateTime (ISO 8601 timestamp)
- `updatedAt`: DateTime (ISO 8601 timestamp, auto-updated on modification)
- `isDeleted`: bool (soft delete flag, default false)

**Validation Rules**:
- `name` MUST be non-empty and unique within user's workspaces
- `gatewayConnectionId` MUST reference a valid GatewayConnection if present
- `createdAt` MUST be set on creation, immutable
- `updatedAt` MUST auto-update on any modification

**Relationships**:
- Has one GatewayConnection (optional, via gatewayConnectionId)
- Has many Conversations (via conversation.workspaceId)
- Has many ToolConfigurations (embedded)

**State Transitions**:
```
Created → Active → (Switched | Updated | Deleted)
Active → Switched → Active (different workspace becomes active)
Active → Deleted → Archived (soft delete)
```

---

### Conversation

**Description**: A chronological sequence of messages (user and AI) within a workspace, including metadata like timestamps and message IDs.

**Fields**:
- `id`: String (unique identifier, UUID v4)
- `workspaceId`: String (foreign key to Workspace)
- `title`: String (auto-generated from first message or user-defined, max 100 chars)
- `messages`: List<Message> (embedded list of messages, ordered by timestamp)
- `createdAt`: DateTime (ISO 8601 timestamp)
- `updatedAt`: DateTime (ISO 8601 timestamp, auto-updated on new message)
- `lastMessageAt`: DateTime? (timestamp of most recent message, nullable for empty conversations)
- `messageCount`: int (denormalized count for performance)
- `isArchived`: bool (archive flag, default false)
- `metadata`: Map<String, dynamic>? (optional metadata: model used, token count, etc.)

**Validation Rules**:
- `workspaceId` MUST reference a valid, non-deleted Workspace
- `messages` list MUST be ordered chronologically (ascending by timestamp)
- `lastMessageAt` MUST equal the timestamp of the last message if messages is non-empty
- `messageCount` MUST equal messages.length (denormalized consistency)
- `title` MUST be non-empty

**Relationships**:
- Belongs to one Workspace (via workspaceId)
- Has many Messages (embedded)

**State Transitions**:
```
Created → Active → (MessageAdded | Archived | Deleted)
Active → MessageAdded → Active (conversation continues)
Active → Archived → (Active | Deleted) (restore from archive)
```

---

### Message

**Description**: A single communication unit with content, sender (user/AI), timestamp, and optional metadata (tool calls, attachments).

**Fields**:
- `id`: String (unique identifier, UUID v4)
- `conversationId`: String (foreign key to Conversation)
- `sender`: MessageSender (enum: USER, AI, SYSTEM)
- `content`: String (message content, supports markdown)
- `timestamp`: DateTime (ISO 8601 timestamp)
- `status`: MessageStatus? (enum: PENDING, SENT, DELIVERED, FAILED, default SENT for AI/SYSTEM)
- `toolCalls`: List<ToolCall>? (optional list of tool invocations triggered by this message)
- `attachments`: List<Attachment>? (optional file attachments)
- `metadata`: MessageMetadata? (optional: tokenCount, model, temperature, provider)
- `replyToMessageId`: String? (reference to parent message for threaded replies)
- `isEdited`: bool (edit flag, default false)
- `editedAt`: DateTime? (timestamp of last edit, nullable)

**Validation Rules**:
- `conversationId` MUST reference a valid Conversation
- `content` MUST be non-empty (max 50,000 chars for user, unlimited for AI)
- `timestamp` MUST be set and immutable after creation
- `status` MUST transition validly: PENDING → SENT → DELIVERED (or FAILED at any point)
- `toolCalls` MUST be present only for AI messages with tool invocations
- `replyToMessageId` MUST reference a message in the same conversation if present

**Relationships**:
- Belongs to one Conversation (via conversationId)
- May reference another Message (via replyToMessageId, self-referential)
- Has many ToolCalls (embedded, optional)
- Has many Attachments (embedded, optional)

**State Transitions**:
```
Created (PENDING) → Sent → Delivered
Created (PENDING) → Failed (retry possible)
Sent → Delivered (confirmed by gateway)
```

---

### GatewayConnection

**Description**: Configuration for connecting to a ZeroClaw gateway instance, including URL, pairing code, bearer token, and connection status.

**Fields**:
- `id`: String (unique identifier, UUID v4)
- `name`: String (user-defined connection name, e.g., "Home Mac", "Work Server")
- `url`: String (gateway URL, validated HTTP/HTTPS URI)
- `pairingCode`: String? (one-time pairing code, nullable after successful pairing)
- `bearerToken`: String? (encrypted bearer token, nullable until paired)
- `tokenExpiresAt`: DateTime? (token expiration timestamp, nullable for non-expiring tokens)
- `status`: ConnectionStatus (enum: DISCONNECTED, CONNECTING, CONNECTED, ERROR)
- `lastConnectedAt`: DateTime? (timestamp of last successful connection)
- `lastError`: String? (last error message, nullable)
- `lastErrorAt`: DateTime? (timestamp of last error)
- `createdAt`: DateTime (ISO 8601 timestamp)
- `updatedAt`: DateTime (ISO 8601 timestamp)

**Validation Rules**:
- `url` MUST be a valid HTTP or HTTPS URI
- `pairingCode` MUST be present for initial pairing, cleared after successful /pair call
- `bearerToken` MUST be encrypted at rest (using platform secure storage)
- `status` MUST accurately reflect current connection state
- `tokenExpiresAt` MUST be in the future if present

**Relationships**:
- Used by many Workspaces (via workspace.gatewayConnectionId)

**State Transitions**:
```
Created (DISCONNECTED) → Connecting → Connected → Disconnected
Connecting → Error (on failure) → Disconnected (after retry exhausted)
Connected → Error (on connection loss) → Reconnecting → Connected
```

---

### ToolConfiguration

**Description**: Settings for a specific tool including enabled state, scope/permissions, and workspace-specific overrides.

**Fields**:
- `id`: String (unique identifier, UUID v4)
- `workspaceId`: String (foreign key to Workspace)
- `toolName`: String (tool identifier: shell, file_read, file_write, memory_store, etc.)
- `isEnabled`: bool (enabled flag, default false)
- `scope`: ToolScope? (optional scope configuration: directory paths, domain allowlists)
- `permissions`: List<ToolPermission> (enum: READ, WRITE, EXECUTE, NETWORK)
- `configOverrides`: Map<String, dynamic>? (tool-specific configuration overrides)
- `lastUsedAt`: DateTime? (timestamp of last tool invocation)
- `usageCount`: int (total invocations, denormalized)

**Validation Rules**:
- `workspaceId` MUST reference a valid Workspace
- `toolName` MUST be a valid ZeroClaw tool identifier
- `permissions` MUST align with tool capabilities (e.g., file_write requires WRITE permission)
- `scope` MUST be present for tools requiring scoping (file operations, browser)

**Relationships**:
- Belongs to one Workspace (via workspaceId, embedded in Workspace entity)

---

### SearchResult

**Description**: A ranked match from conversation history containing the message, relevance score, and workspace context.

**Fields**:
- `message`: Message (the matched message entity)
- `workspaceName`: String (denormalized workspace name for display)
- `conversationTitle`: String (denormalized conversation title)
- `relevanceScore`: double (0.0-1.0, hybrid search score)
- `matchType`: SearchMatchType (enum: KEYWORD, SEMANTIC, HYBRID)
- `highlightedSnippet`: String? (message excerpt with match highlights)

**Validation Rules**:
- `relevanceScore` MUST be between 0.0 and 1.0
- `matchType` MUST align with search method used
- `message` MUST be a valid, non-deleted message

**Relationships**:
- References one Message (embedded in search results, not persisted)
- References one Workspace (denormalized name)
- References one Conversation (denormalized title)

**Note**: This is a read-only DTO (Data Transfer Object), not persisted to database.

---

## Embedded Value Objects

### IdentityConfig

**Description**: AI agent identity configuration embedded in Workspace.

**Fields**:
- `name`: String (agent name, e.g., "Coding Assistant", "Writing Coach")
- `personality`: String? (personality description, optional)
- `systemPrompt`: String? (custom system prompt, optional)
- `model`: String (default model: e.g., "anthropic/claude-sonnet-4")
- `temperature`: double (0.0-2.0, default 0.7)
- `autonomyLevel`: AutonomyLevel (enum: SUPERVISED, SEMI_AUTONOMOUS, AUTONOMOUS)

---

### ToolScope

**Description**: Scope configuration for tool permissions.

**Fields**:
- `allowedDirectories`: List<String>? (for file operations)
- `allowedDomains`: List<String>? (for browser/network tools)
- `allowedCommands`: List<String>? (for shell execution)
- `workspaceOnly`: bool (restrict to workspace directory)

---

### ToolCall

**Description**: Record of a tool invocation triggered by an AI message.

**Fields**:
- `toolName`: String (tool identifier)
- `arguments`: Map<String, dynamic> (tool invocation parameters)
- `status`: ToolCallStatus (enum: PENDING, EXECUTING, SUCCESS, ERROR)
- `result`: String? (tool execution result, truncated for display)
- `error`: String? (error message if failed)
- `executedAt`: DateTime? (execution timestamp)

---

### Attachment

**Description**: File attachment metadata.

**Fields**:
- `id`: String (unique identifier)
- `filename`: String (original filename)
- `mimeType`: String (MIME type: e.g., "image/png", "application/pdf")
- `sizeBytes`: int (file size)
- `localPath`: String? (local file path if downloaded)
- `url`: String? (remote URL if applicable)

---

### MessageMetadata

**Fields**:
- `tokenCount`: int? (tokens used for this message)
- `model`: String? (model used for generation)
- `temperature`: double? (sampling temperature)
- `provider`: String? (AI provider: openrouter, anthropic, etc.)
- `latencyMs`: int? (response latency in milliseconds)

---

## Entity Relationship Diagram

```
┌─────────────────┐
│    Workspace    │
│─────────────────│
│ id              │
│ name            │
│ gatewayConnId   │──┐
│ identityConfig  │  │
│ toolConfigs[]   │  │
└────────┬────────┘  │
         │           │
         │ 1         │ 1
         │           │
         │ N         │ N
┌────────▼────────┐  │  ┌──────────────────┐
│  Conversation   │  │  │GatewayConnection │
│─────────────────│  │  │──────────────────│
│ id              │  │  │ id               │
│ workspaceId     │──┘  │ url              │
│ title           │     │ bearerToken      │
│ messages[]      │     │ status           │
└────────┬────────┘     └──────────────────┘
         │
         │ 1
         │
         │ N
┌────────▼────────┐
│     Message     │
│─────────────────│
│ id              │
│ conversationId  │
│ sender          │
│ content         │
│ toolCalls[]     │
│ replyToMessageId│──┐ (self-reference)
└─────────────────┘  │
                     │
         ┌───────────┘
         │
         ▼
   (optional parent message)
```

---

## Validation Rules Summary

| Entity | Key Validation |
|--------|---------------|
| Workspace | Unique name, valid gateway reference |
| Conversation | Valid workspace reference, chronological messages |
| Message | Valid conversation reference, ordered timestamps |
| GatewayConnection | Valid URL, encrypted token |
| ToolConfiguration | Valid tool name, scope for restricted tools |

---

## Indexing Strategy

**Hive Box Indexes**:
- `Workspace`: name (unique), updatedAt (for sorting)
- `Conversation`: workspaceId, lastMessageAt (for sorting), isArchived (for filtering)
- `Message`: conversationId, timestamp (for ordering), sender (for filtering)
- `GatewayConnection`: status (for connection monitoring)

**Query Optimization**:
- Denormalize workspaceName and conversationTitle in search results
- Cache messageCount in Conversation to avoid list.length computation
- Use Hive's built-in indexing for O(1) lookups by ID
