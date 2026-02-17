# Data Model: Connect and Chat with ZeroClaw Agent

**Date**: 2026-02-17
**Branch**: `002-us1-connect-chat`

## Entities

### AIProvider

Abstract definition of an AI gateway provider.

```dart
enum AIProviderType {
  zeroClaw,
  picoClaw,  // Future
  openClaw,  // Future
}

class AIProvider {
  final AIProviderType type;
  final String name;
  final String version;
  final List<String> supportedProtocols;  // ['REST', 'GraphQL']
  final String authMechanism;  // 'pairing-code'
  final ApiEndpoints endpoints;
}

class ApiEndpoints {
  final String health;    // '/health'
  final String pair;      // '/pair'
  final String webhook;   // '/webhook'
}
```

**Validation Rules**:
- `type` MUST be one of defined enum values
- `endpoints` MUST contain valid HTTP paths (start with `/`)
- `supportedProtocols` MUST include 'REST' for MVP

---

### GatewayConnection

Configuration for connecting to an AI gateway provider instance.

```dart
class GatewayConnection {
  final String id;
  final AIProviderType providerType;
  final String name;
  final String url;  // e.g., 'http://127.0.0.1:8080'
  final String? pairingCode;  // Cleared after use
  final String? bearerToken;  // Encrypted in secure storage
  final ConnectionStatus status;
  final DateTime? lastConnectedAt;
  final DateTime? lastErrorAt;
  final String? lastError;
  final DateTime createdAt;
  final DateTime updatedAt;
}

enum ConnectionStatus {
  disconnected,
  connecting,
  connected,
  error,
  reconnecting,
}
```

**Validation Rules**:
- `url` MUST be valid HTTP/HTTPS URL
- `url` MUST NOT be empty
- `bearerToken` MUST be stored encrypted (never in plaintext)
- `pairingCode` MUST be cleared after successful authentication
- `status` transitions: `disconnected` → `connecting` → `connected` | `error`

**State Transitions**:
```
disconnected ──[connect()]──> connecting ──[success]──> connected
                                │
                                └──[error]──> error ──[retry]──> reconnecting
```

---

### Message

A single communication unit in a conversation.

```dart
enum MessageSender {
  user,
  ai,
  system,
}

enum MessageStatus {
  pending,
  sent,
  delivered,
  failed,
}

class Message {
  final String id;
  final String conversationId;
  final MessageSender sender;
  final String content;  // Max 4000 chars for user messages
  final MessageStatus status;
  final DateTime timestamp;
  final int? retryCount;
  final String? errorMessage;
  final MessageMetadata? metadata;
}

class MessageMetadata {
  final int? tokenCount;
  final String? model;
  final String? provider;
  final int? latencyMs;
  final List<ToolCall>? toolCalls;
}

class ToolCall {
  final String toolName;
  final Map<String, dynamic> arguments;
  final ToolCallStatus status;
  final String? result;
  final String? error;
  final DateTime? executedAt;
}

enum ToolCallStatus {
  pending,
  executing,
  success,
  error,
}
```

**Validation Rules**:
- `content` MUST NOT exceed 4000 characters for `MessageSender.user`
- `content` MUST NOT be empty
- `conversationId` MUST reference existing conversation
- `timestamp` MUST be set on creation
- `status` MUST be `pending` initially for user messages

**Relationships**:
- Many-to-One: `Message` → `Conversation` (via `conversationId`)

---

### Conversation

A chronological sequence of messages within a workspace.

```dart
class Conversation {
  final String id;
  final String? workspaceId;  // Null for MVP (default conversation)
  final String title;  // Auto: "Default Conversation" or user-defined
  final List<String> messageIds;  // Ordered chronologically
  final DateTime createdAt;
  final DateTime updatedAt;
  final DateTime? lastMessageAt;
  final int messageCount;
  final bool isArchived;
}
```

**Validation Rules**:
- `title` MUST NOT be empty
- `messageIds` preserves chronological order (oldest first)
- `lastMessageAt` MUST be updated on new message
- `messageCount` MUST equal `messageIds.length`
- `isArchived` defaults to `false`

**Lifecycle**:
1. **Created**: Auto-created on first successful gateway connection (MVP)
2. **Active**: User sends/receives messages
3. **Archived**: User explicitly archives (future feature)
4. **Deleted**: User deletes → moves to Trash (30-day retention, US2)

**Relationships**:
- One-to-Many: `Conversation` → `Message` (via `messageIds`)
- Many-to-One: `Conversation` → `Workspace` (future, US2)

---

## Local Storage Schema

### Hive Boxes

```dart
// Box: 'conversations'
@HiveType(typeId: 0)
class ConversationAdapter extends TypeAdapter<Conversation> { ... }

// Box: 'messages'
@HiveType(typeId: 1)
class MessageAdapter extends TypeAdapter<Message> { ... }

// Box: 'gateway_connections'
@HiveType(typeId: 2)
class GatewayConnectionAdapter extends TypeAdapter<GatewayConnection> { ... }
```

### Secure Storage Keys

```dart
// flutter_secure_storage
const String KEY_BEARER_TOKEN = 'bearer_token';
const String KEY_GATEWAY_URL = 'gateway_url';
const String KEY_PROVIDER_TYPE = 'provider_type';
```

---

## Repository Interfaces

### ConversationRepository

```dart
abstract class ConversationRepository {
  Future<Conversation> createDefaultConversation();
  Future<Conversation> getConversation(String id);
  Future<List<Conversation>> getAllConversations();
  Future<void> updateConversation(Conversation conversation);
  Future<void> deleteConversation(String id);
  Future<void> archiveConversation(String id);
  Stream<Conversation> watchConversation(String id);
}
```

### MessageRepository

```dart
abstract class MessageRepository {
  Future<Message> createMessage(Message message);
  Future<Message> getMessage(String id);
  Future<List<Message>> getMessagesByConversation(String conversationId, {int limit = 50, String? cursor});
  Future<void> updateMessage(Message message);
  Future<void> deleteMessage(String id);
  Stream<List<Message>> watchMessages(String conversationId);
}
```

### GatewayConnectionRepository

```dart
abstract class GatewayConnectionRepository {
  Future<GatewayConnection> createConnection(GatewayConnection connection);
  Future<GatewayConnection> getConnection(String id);
  Future<List<GatewayConnection>> getAllConnections();
  Future<void> updateConnection(GatewayConnection connection);
  Future<void> deleteConnection(String id);
  Future<void> setBearerToken(String connectionId, String token);
  Future<String?> getBearerToken(String connectionId);
  Stream<GatewayConnection> watchConnection(String id);
}
```

---

## Data Flow

### Send Message Flow

```
User sends message
    ↓
ChatController.sendMessage(content)
    ↓
SendMessageUseCase(params)
    ↓
MessageRepository.createMessage(Message(status: pending))
    ↓
Message queued in Hive
    ↓
GatewayConnectionRepository.getConnection()
    ↓
ZeroClawRestApi.sendMessage(message, bearerToken)
    ↓
POST /webhook { "message": content }
    ↓
[Success] MessageRepository.updateMessage(status: sent)
[Error] MessageRepository.updateMessage(status: failed, retryCount++)
    ↓
Retry with exponential backoff (max 3 retries)
```

### Receive Message Flow (Polling)

```
Polling timer (every 2s)
    ↓
GetConversationUseCase(conversationId)
    ↓
MessageRepository.getMessagesByConversation()
    ↓
Compare with cached messages
    ↓
[New messages] Update local cache via Hive
    ↓
ChatState.messages = updated list
    ↓
UI rebuilds ListView
```

### Connection Status Flow

```
ConnectionStatusPolling (every 1s)
    ↓
TestConnectionUseCase()
    ↓
ZeroClawRestApi.healthCheck()
    ↓
GET /health
    ↓
[200 OK] ConnectionStatus.connected
[Error] ConnectionStatus.error → trigger retry logic
```
