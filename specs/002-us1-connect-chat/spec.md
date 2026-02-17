# Feature Specification: Connect and Chat with ZeroClaw Agent

**Feature Branch**: `002-us1-connect-chat`
**Parent Epic**: `001-zeroclaw-integration`
**Created**: 2026-02-17
**Status**: Draft
**Priority**: P1 (MVP)

## Overview

Users can connect to a ZeroClaw gateway instance and engage in natural conversation with the AI assistant. The interface provides a clean, responsive chat experience with message history, typing indicators, and real-time responses.

**Why this matters**: This is the core value proposition - without the ability to chat with the AI, the app has no primary functionality. It's the minimum viable product that delivers immediate user value.

**Input Reference**: Build a Flutter app that works on all platforms and FULLY INTEGRATE WITH zeroclaw. ZeroClaw is AI personal assistant that will be the core engine we will be consuming. This will be ONLY a BEAUTIFUL, UX-driven interface. https://github.com/zeroclaw-labs/zeroclaw

**Future Provider Support**: The app architecture MUST support future integration with alternative AI gateway providers (PicoClaw, OpenClaw) through a pluggable provider abstraction layer. MVP launches with ZeroClaw only.

## Target User

Casual users seeking simple AI assistant access. Interface prioritizes ease-of-use over advanced configuration. Basic accessibility support (screen reader compatibility, sufficient color contrast) without formal WCAG compliance.

## User Scenarios & Acceptance Criteria

### Primary User Journey

**Independent Test**: User can launch the app, configure a gateway connection, send a message, and receive an AI response. The entire conversation flow works without any other features enabled.

**Acceptance Scenarios**:

1. **Given** the app is launched for the first time, **When** user enters a valid gateway URL and pairing code, **Then** the app successfully connects and displays a welcome message from the AI assistant.
2. **Given** a connected session, **When** user types and sends a message, **Then** the message appears in the chat, a typing indicator shows, and the AI response appears within 5 seconds.
3. **Given** an active conversation, **When** the user closes and reopens the app, **Then** the conversation history is preserved and visible.

## Requirements

### Functional Requirements

- **FR-001**: System MUST allow users to configure and save a ZeroClaw gateway connection (URL, pairing code, bearer token). Pairing code is used once for initial authentication, then cleared. Bearer token persists indefinitely (no expiration) and is stored encrypted in platform secure storage (Keychain/Keystore).
- **FR-002**: System MUST provide a real-time chat interface for sending messages to and receiving responses from the ZeroClaw agent.
- **FR-003**: System MUST display conversation history chronologically with clear visual distinction between user and AI messages.
- **FR-004**: System MUST preserve conversation history locally on device across app sessions.
- **FR-012**: System MUST show real-time connection status (connected, disconnected, reconnecting) with visual indicators.
- **FR-013**: System MUST handle network interruptions by queuing outbound messages and retrying automatically.
- **FR-014**: System MUST display typing indicators while awaiting AI responses.
- **FR-015**: System MUST support markdown rendering in AI responses (code blocks, lists, tables, links).

### Key Entities

- **Conversation**: A chronological sequence of messages (user and AI) within a workspace, including metadata like timestamps and message IDs. Conversations are retained indefinitely until explicitly deleted.
- **Message**: A single communication unit with content, sender (user/AI), timestamp, and optional metadata (tool calls, attachments).
- **GatewayConnection**: Configuration for connecting to a ZeroClaw gateway instance, including URL, pairing code, bearer token, and connection status. Bearer token is persistent (no expiration) and stored encrypted in platform secure storage. Pairing code used once for initial authentication, then cleared.

## Edge Cases

- **Network connectivity loss**: When the gateway connection drops mid-conversation, the app MUST show a clear "No connection" indicator and disable the message input field. Messages cannot be sent while offline. The app MUST attempt to reconnect automatically and notify the user when connection is restored.
- **Invalid gateway configuration**: How does the system handle incorrect URLs, expired tokens, or unreachable servers? The app MUST provide clear error messages with actionable recovery steps.
- **Large conversation history**: How does the UI handle conversations with 1000+ messages? The app MUST implement pagination or virtual scrolling to maintain performance.

## Out of Scope (MVP)

- Multi-device sync (all data stored locally on single device)
- Multiple workspaces (covered in US2)
- Tool & integration management (covered in US3)
- Conversation search (covered in US4)

## Success Criteria

### Measurable Outcomes

- **SC-001**: Users can complete initial gateway setup and send their first message within 2 minutes of launching the app for the first time.
- **SC-002**: 95% of messages receive an AI response within 5 seconds under normal network conditions.
- **SC-005**: App maintains 60 FPS UI performance during conversation scrolling with 500+ messages loaded.
- **SC-006**: 85% of users rate the interface as "beautiful" or "very beautiful" in post-use surveys (4+ out of 5 stars).
- **SC-007**: App successfully reconnects after network interruption within 10 seconds in 95% of cases.

## Clarifications

### Session 2026-02-17

- Q: How should the app handle the ZeroClaw pairing authentication flow and token lifecycle? → A: Persistent token only
- Q: Who is the primary user and what accessibility standards must the app meet? → A: Casual users, basic accessibility
- Q: What can users do when the app has no network connectivity to the ZeroClaw gateway? → A: No offline support
- Q: Should the app support syncing conversations/workspaces across multiple devices from day one? → A: Single device only (MVP)
- Q: What API protocol and contracts does the Flutter app use to communicate with ZeroClaw? → A: REST with client-side GraphQL abstraction (simulated subscriptions via polling)
- Q: When the network connection drops and messages are queued for retry, what is the maximum retry behavior? → A: 3 retries with exponential backoff
- Q: What should first-time users see when launching the app with no gateway configured? → A: Full-screen blocking setup modal
- Q: Should the app architecture support future AI gateway providers beyond ZeroClaw? → A: Yes, pluggable provider layer (PicoClaw, OpenClaw)
- Q: For the default/initial conversation when a user first connects to a gateway, how should it be created? → A: Auto-create "Default Conversation" on first successful connection
- Q: What is the maximum message length (character count) that users can send in a single message? → A: 4000 characters

### Edge Cases

- **Message retry failure**: After 3 failed retries with exponential backoff (1s, 2s, 4s), the app MUST show a "Message failed to send" error and discard the queued message.

### Integration & External Dependencies

- **ZeroClaw Gateway REST API**: The app communicates with a locally-running ZeroClaw gateway process via HTTP REST endpoints:
  - `GET /health` — Health check (no auth)
  - `POST /pair` — Exchange 6-digit pairing code for bearer token
  - `POST /webhook` — Send message `{"message": "your prompt"}` (requires Bearer token)
- **Authentication Flow**: User obtains 6-digit pairing code from ZeroClaw startup → App exchanges via `/pair` → Receives persistent bearer token → Token stored encrypted in platform secure storage.
- **GraphQL Abstraction Layer**: Client-side GraphQL schema (queries, mutations, subscriptions) provides type-safe operations translated to ZeroClaw REST calls via a GraphQL-to-REST adapter. Subscriptions are simulated via HTTP polling for real-time updates.
- **Gateway Deployment**: ZeroClaw runs as a local process on localhost (default `127.0.0.1:8080`). No cloud service dependency.

### Functional Requirements

- **FR-017**: System MUST implement HTTP client for ZeroClaw REST API (`/health`, `/pair`, `/webhook`) with bearer token authentication.
- **FR-018**: System MUST implement a GraphQL-to-REST adapter that translates client-side GraphQL operations to ZeroClaw REST calls.
- **FR-019**: System MUST guide users through the 6-digit pairing code flow on first connection and persist the resulting bearer token.
- **FR-020**: System MUST simulate GraphQL subscriptions via HTTP polling for real-time message updates and connection status changes.
- **FR-021**: System MUST display a full-screen blocking setup modal on first launch, requiring users to complete gateway configuration before accessing the chat interface.
- **FR-022**: System MUST implement a pluggable provider abstraction layer to support future AI gateway providers (PicoClaw, OpenClaw) without major refactoring.
- **FR-023**: System MUST auto-create a "Default Conversation" upon first successful gateway connection and display it to the user.
- **FR-024**: System MUST enforce a maximum message length of 4000 characters for user-sent messages, with client-side validation and clear error messaging.

### Key Entities

- **GatewayConnection**: Configuration for connecting to an AI gateway provider instance, including provider type (ZeroClaw/PicoClaw/OpenClaw), URL, pairing code, bearer token, and connection status. Bearer token is persistent (no expiration) and stored encrypted in platform secure storage. Pairing code used once for initial authentication, then cleared.
- **AIProvider**: Abstract definition of an AI gateway provider including provider type identifier, supported protocols, authentication mechanism, and API endpoints. MVP supports ZeroClaw only.
- **Conversation**: A chronological sequence of messages (user and AI) within a workspace, including metadata like timestamps and message IDs. A "Default Conversation" is auto-created on first successful gateway connection. Conversations are retained indefinitely until explicitly deleted.
- **Message**: A single communication unit with content (max 4000 characters for user messages), sender (user/AI), timestamp, and optional metadata (tool calls, attachments).
