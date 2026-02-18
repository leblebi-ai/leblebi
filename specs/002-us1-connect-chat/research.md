# Research: Connect and Chat with ZeroClaw Agent

**Date**: 2026-02-17
**Branch**: `002-us1-connect-chat`

## Technical Decisions

### 1. ZeroClaw Gateway Communication Protocol

**Decision**: REST API with client-side GraphQL abstraction layer

**Rationale**: 
- ZeroClaw gateway exposes REST endpoints (`/health`, `/pair`, `/webhook`)
- GraphQL provides type-safe operations and better developer experience
- Subscriptions simulated via HTTP polling (ZeroClaw doesn't support WebSocket)
- Allows future provider swaps without UI changes

**Alternatives Considered**:
- Direct REST calls: Simpler but no type safety, harder to refactor
- WebSocket: Not supported by ZeroClaw gateway
- gRPC: Overkill for simple chat, adds complexity

---

### 2. Authentication Flow

**Decision**: 6-digit pairing code → persistent bearer token

**Rationale**:
- ZeroClaw's security model uses one-time pairing codes
- Bearer token persists indefinitely (no expiration per ZeroClaw design)
- Token stored encrypted in platform secure storage (Keychain/Keystore)
- Pairing code cleared after initial authentication

**Alternatives Considered**:
- OAuth2 flow: Not supported by ZeroClaw
- API keys: Less secure, manual management
- Session-based: Requires server infrastructure

---

### 3. Local Storage Strategy

**Decision**: Hive for conversation history + flutter_secure_storage for tokens

**Rationale**:
- Hive: Fast, lightweight NoSQL database for Flutter
- Supports complex nested objects (conversations with messages)
- flutter_secure_storage: Platform-encrypted storage for sensitive data
- Matches existing project dependencies (zuraffa supports Hive)

**Alternatives Considered**:
- SQLite: More complex, overkill for simple key-value + lists
- SharedPreferences: Not suitable for complex nested data
- Isar: Newer, less mature than Hive

---

### 4. Real-time Updates

**Decision**: HTTP polling simulation for GraphQL subscriptions

**Rationale**:
- ZeroClaw doesn't support true push/subscription mechanisms
- Polling `/webhook` or conversation state every 1-2 seconds
- Typing indicators and connection status updated via polling
- Acceptable tradeoff for MVP, can optimize later

**Alternatives Considered**:
- WebSocket: Not supported by ZeroCllaw
- Server-Sent Events: Not supported
- Long polling: More complex, marginal benefit

---

### 5. Pluggable Provider Architecture

**Decision**: AIProvider abstract class with ZeroClawProvider implementation

**Rationale**:
- Future-proofs for PicoClaw, OpenClaw support
- Clean separation of concerns
- UI layer never knows which provider is active
- Follows Clean Architecture dependency inversion

**Alternatives Considered**:
- Hardcoded ZeroClaw: Faster MVP but technical debt
- Strategy pattern: Similar complexity, less explicit
- Factory pattern: Works but harder to extend

---

### 6. Message Retry Strategy

**Decision**: 3 retries with exponential backoff (1s, 2s, 4s)

**Rationale**:
- Balances user experience with resource conservation
- Exponential backoff prevents network flooding
- 3 retries = ~7 seconds total before failure (acceptable for chat)
- Clear error messaging after failure

**Alternatives Considered**:
- Infinite retries: Poor UX, user must manually cancel
- Fixed interval: Less efficient network usage
- Time-based (30s): Arbitrary, may retry too long

---

### 7. Onboarding Flow

**Decision**: Full-screen blocking setup modal

**Rationale**:
- Forces completion before accessing empty chat
- Reduces confusion for casual users
- Clear call-to-action
- Matches "ease-of-use over advanced configuration" goal

**Alternatives Considered**:
- Toolbar button: Users might miss it
- Settings screen: Extra navigation step
- Inline form: Less prominent, easy to dismiss

---

### 8. Default Conversation

**Decision**: Auto-create "Default Conversation" on first connection

**Rationale**:
- Reduces decision paralysis for casual users
- Immediate chat access after setup
- Users can rename or create more later
- Matches "simple AI assistant access" target

**Alternatives Considered**:
- Manual creation: Extra step before first chat
- Prompt for name: Friction before value delivery
- Implicit creation: Confusing when conversation starts

---

### 9. Message Length Limit

**Decision**: 4000 characters maximum

**Rationale**:
- Aligns with common chat platform limits (Discord, Slack)
- Prevents API payload issues
- Generous for casual users
- Protects against accidental abuse

**Alternatives Considered**:
- 1000 chars: Too restrictive for detailed prompts
- 8000 chars: Unnecessarily large for chat
- No limit: Risk of API errors, poor UX

---

## ZeroClaw API Reference

### Endpoints

| Endpoint | Method | Auth | Description |
|----------|--------|------|-------------|
| `/health` | GET | None | Health check |
| `/pair` | POST | X-Pairing-Code header | Exchange pairing code for bearer token |
| `/webhook` | POST | Bearer token | Send message to AI |

### Authentication Flow

1. User starts ZeroClaw gateway locally (`zeroclaw gateway`)
2. Gateway displays 6-digit pairing code on startup
3. User enters pairing code in app
4. App calls `POST /pair` with `X-Pairing-Code: 123456`
5. Gateway returns bearer token
6. App stores token encrypted in secure storage
7. All subsequent `/webhook` calls use `Authorization: Bearer <token>`

### Message Format

```json
POST /webhook
Authorization: Bearer <token>
Content-Type: application/json

{
  "message": "Hello, ZeroClaw!"
}
```

---

## Best Practices

### Flutter Chat UI
- Use ListView.builder for efficient message rendering
- Implement virtual scrolling for 1000+ messages
- Auto-scroll to bottom on new message
- Show typing indicator as list item or footer

### Network Resilience
- Implement connection status listener
- Queue messages in Hive when offline
- Retry queue on reconnection
- Show clear "No connection" banner

### Security
- Never log bearer tokens
- Use flutter_secure_storage for tokens
- Clear pairing code from memory after use
- Validate gateway URL (https preferred)

### Performance
- Lazy load conversation history
- Paginate messages (50-100 at a time)
- Use const widgets where possible
- Profile with Flutter DevTools
