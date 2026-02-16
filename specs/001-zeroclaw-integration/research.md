# Research: ZeroClaw Flutter Integration

**Created**: 2026-02-17
**Purpose**: Resolve all technical unknowns and establish best practices for ZeroClaw Flutter interface implementation

---

## Decision: ZeroClaw Gateway API Integration Pattern

**What was chosen**: RESTful HTTP API with Bearer token authentication, following ZeroClaw's gateway endpoints (`/pair`, `/webhook`, `/health`)

**Rationale**: 
- ZeroClaw gateway exposes REST endpoints as primary interface
- Bearer token authentication aligns with BYOK principle (user-controlled credentials)
- Webhook-based messaging supports real-time bidirectional communication
- Health endpoint enables connection status monitoring

**Alternatives considered**:
- WebSocket-only: Rejected because ZeroClaw gateway uses HTTP REST as primary interface
- GraphQL layer: Rejected - adds unnecessary complexity; ZeroClaw API is already well-structured REST

---

## Decision: Local Storage with Hive

**What was chosen**: Hive NoSQL database for local conversation history, workspace configurations, and cached credentials

**Rationale**:
- Flutter-native, pure Dart implementation (no platform channels)
- 10x faster than SQLite for read/write operations
- Built-in encryption support for sensitive data (gateway tokens)
- Offline-first architecture requires robust local persistence
- Cross-platform consistency (macOS, iOS, Android, Linux, Web, Windows)

**Alternatives considered**:
- SQLite (via sqflite): Rejected - slower, requires platform-specific native bindings
- SharedPreferences: Rejected - limited to simple key-value, not suitable for complex queries
- Isar Database: Considered - similar performance, but Hive has larger community adoption

---

## Decision: Clean Architecture with Zuraffa Generation

**What was chosen**: Three-layer Clean Architecture (Domain/Data/Presentation) with Zuraffa CLI generating all boilerplate

**Rationale**:
- Constitution Principle I (Clean Architecture) and VI (Zuraffa-First) mandate this approach
- Zuraffa ensures consistent structure across all entities, use cases, and presentation layers
- Generated code includes JSON serialization, equality operators, and copyWith methods
- VPC (View-Presenter-Controller) pattern separates UI logic from business logic

**Alternatives considered**:
- Manual implementation: Rejected - violates Zuraffa-First principle, error-prone
- BLoC pattern: Considered - but Zuraffa's StatefulController mixin provides simpler state management
- Riverpod: Rejected - adds dependency injection complexity; get_it is sufficient

---

## Decision: Platform Priority - macOS First

**What was chosen**: macOS as primary development and testing platform, followed by iOS/Android, then Linux/Web, finally Windows

**Rationale**:
- User requirement specifies macOS as highest priority
- macOS development enables fastest iteration (native Xcode tooling, easy debugging)
- ZeroClaw gateway likely runs locally on macOS during development
- iOS/Android share similar mobile patterns, can be tested secondarily
- Linux/Web/Windows are secondary platforms for broader distribution

**Alternatives considered**:
- Web-first: Rejected - ZeroClaw is desktop-centric tool, macOS aligns better with target users
- Equal priority all platforms: Rejected - slows development; better to perfect one platform then expand

---

## Decision: Real-time Communication Pattern

**What was chosen**: HTTP long-polling with exponential backoff retry, simulating real-time messaging via `/webhook` endpoint

**Rationale**:
- ZeroClaw gateway `/webhook` endpoint supports asynchronous message delivery
- Long-polling simpler than WebSocket for initial implementation
- Exponential backoff handles network interruptions gracefully
- Connection status indicators (connected/disconnected/reconnecting) required by FR-011

**Alternatives considered**:
- WebSocket: Rejected - ZeroClaw gateway uses HTTP webhook pattern
- Server-Sent Events (SSE): Considered - but less supported on mobile platforms
- Polling (fixed interval): Rejected - inefficient, higher latency than long-polling

---

## Decision: State Management with StatefulController

**What was chosen**: Zuraffa's StatefulController mixin with explicit State objects and setState methods

**Rationale**:
- Constitution Technical Standards mandate this pattern
- Explicit state updates improve debuggability and testability
- Avoids global state complexity (no Provider, no Riverpod globals)
- Type-safe state transitions with sealed classes

**Alternatives considered**:
- Provider + Riverpod: Rejected - violates constitution standards, adds global state
- BLoC: Considered - but more boilerplate than Zuraffa's generated controllers
- ValueNotifier: Rejected - less structured, harder to test

---

## Best Practice: ZeroClaw Gateway Connection Lifecycle

**Pattern**: Connection manager singleton with automatic reconnection

```
1. User configures gateway (URL + pairing code)
2. App calls /pair endpoint → receives bearer token
3. Token stored encrypted in Hive
4. All subsequent requests use Authorization: Bearer <token>
5. On 401/403: attempt token refresh via /pair
6. On network error: exponential backoff retry (1s, 2s, 4s, 8s, 16s, max 5 attempts)
7. Connection status broadcast via stream to all listeners
```

**Rationale**: 
- Aligns with ZeroClaw pairing authentication flow
- Automatic retry handles transient network failures
- Status streaming enables UI indicators (FR-011, FR-012)

---

## Best Practice: Conversation History Pagination

**Pattern**: Cursor-based pagination with infinite scroll

```
- Load 50 messages initially
- On scroll to top: load previous 50 messages (cursor: before_message_id)
- On scroll to bottom: load next 50 messages (cursor: after_message_id)
- Virtual scrolling for 1000+ messages (only render visible messages)
```

**Rationale**:
- Meets SC-005 (60 FPS with 500+ messages)
- Prevents memory bloat from loading entire history
- Cursor-based more efficient than offset pagination for large datasets

---

## Best Practice: Hybrid Search Implementation

**Pattern**: Client-side search with cached embeddings (future enhancement)

**Phase 1 (MVP)**: 
- Keyword search using Hive filters (contains, equals)
- Filter by workspace, date range, sender

**Phase 2 (Enhancement)**:
- Cache ZeroClaw embeddings locally
- Cosine similarity search for semantic matching
- Hybrid merge: 70% semantic + 30% keyword (configurable)

**Rationale**:
- Phase 1 sufficient for initial search (FR-009, FR-010)
- Phase 2 requires embedding caching strategy, deferred to later sprint
- Aligns with ZeroClaw's own hybrid search architecture

---

## Best Practice: Markdown Rendering

**Pattern**: flutter_markdown package with custom style sheet

```
- Code blocks: syntax highlighting with highlight package
- Tables: custom table renderer with horizontal scroll
- Links: launch_url for platform-specific URL handling
- Math: katex_flutter for LaTeX rendering (optional)
```

**Rationale**:
- FR-014 requires markdown rendering
- flutter_markdown is Flutter standard, well-maintained
- Custom styling aligns with "beautiful UX" requirement

---

## Integration Pattern: ZeroClaw Tool Configuration

**Pattern**: Tool configuration synced with gateway, cached locally

```
1. On workspace switch: fetch tool configs from gateway
2. Cache in Hive with workspace_id key
3. UI displays toggles bound to cached config
4. On toggle change: optimistic UI update + background sync to gateway
5. On sync failure: revert UI, show error toast
```

**Rationale**:
- Optimistic UI provides responsive UX (SC-008: <1 min tool config)
- Local cache enables offline viewing of tool states
- Background sync ensures gateway is source of truth

---

## Security Pattern: Credential Storage

**Pattern**: Encrypted Hive boxes with platform-specific key management

```
macOS/iOS: Keychain for encryption key
Android: EncryptedSharedPreferences for encryption key
Linux: libsecret (GNOME Keyring/KWallet)
Windows: Windows Credential Manager
Web: IndexedDB with user-provided passphrase (limited security)
```

**Rationale**:
- Constitution Principle V (BYOK & Privacy by Default)
- Credentials never leave device unencrypted
- Platform-specific secure storage for encryption keys

---

## Testing Strategy

**Unit Tests**: 
- All UseCases (domain layer) with mock repositories
- All Presenters with mock UseCases
- Repository implementations with mock datasources

**Widget Tests**:
- All Views with mocked Presenters
- Chat message rendering (markdown, code blocks)
- Workspace switcher UI

**Integration Tests**:
- Full chat flow: connect → send message → receive response
- Workspace CRUD operations
- Search functionality with mock data
- Network failure and recovery

**Test Coverage Goal**: 80%+ line coverage, 100% of UseCases and Presenters

---

## Dependencies Summary

| Package | Purpose | Version |
|---------|---------|---------|
| flutter | UI framework | SDK |
| zuraffa | Code generation | ^2.1.0 |
| zorphy_annotation | Entity annotations | ^1.6.1 |
| get_it | Dependency injection | ^7.6.0 |
| hive | Local database | ^2.2.3 |
| hive_flutter | Flutter Hive integration | ^1.1.0 |
| http | HTTP client | ^1.2.0 |
| http2 | HTTP/2 support | ^2.3.0 |
| web_socket_channel | WebSocket (optional) | ^2.4.0 |
| flutter_markdown | Markdown rendering | ^0.6.18 |
| highlight | Code syntax highlighting | ^0.7.0 |
| url_launcher | Launch URLs | ^6.2.0 |
| encrypt | Encryption for credentials | ^5.0.3 |
| flutter_secure_storage | Platform secure storage | ^9.0.0 |

---

## Unresolved Questions

None - all NEEDS CLARIFICATION items from Technical Context resolved.
