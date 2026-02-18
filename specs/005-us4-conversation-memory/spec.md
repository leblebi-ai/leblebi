# Feature Specification: Conversation Memory & Search

**Feature Branch**: `005-us4-conversation-memory`
**Parent Epic**: `001-zeroclaw-integration`
**Created**: 2026-02-17
**Status**: Draft
**Priority**: P4

## Overview

Users can search across all conversation history using natural language queries via ZeroClaw's search API. The app displays relevant past conversations and messages with hybrid search (keyword + semantic similarity) results from ZeroClaw's database.

**Why this matters**: As conversation history grows, users need to find specific past interactions. This is a quality-of-life feature that becomes more valuable over time but isn't critical for initial use.

**Dependency**: Requires US1 (Connect and Chat) to be completed first.

**Architecture Principle**: Leblebi is a thin UI client. Search queries execute against ZeroClaw's database. No local search index.

## Target User

Users with extensive conversation history who need to retrieve past information, context, or decisions from previous AI interactions.

## User Scenarios & Acceptance Criteria

### Primary User Journey

**Independent Test**: User can enter a search query about a past topic, see ranked results from ZeroClaw's search API, and tap to view the full context of any result.

**Acceptance Scenarios**:

1. **Given** a conversation history with 50+ messages, **When** user searches for a specific topic via ZeroClaw search API, **Then** relevant messages appear ranked by relevance from ZeroClaw's database.
2. **Given** search results are displayed, **When** user taps a result, **Then** the app navigates to the original conversation context showing the message and surrounding messages loaded from ZeroClaw.
3. **Given** multiple workspaces exist, **When** user performs a search via API, **Then** results indicate which workspace each message belongs to (provided by ZeroClaw).

## Requirements

### Functional Requirements

- **FR-010**: System MUST provide a search interface for querying conversation history across all workspaces via ZeroClaw search API.
- **FR-011**: System MUST display search results ranked by relevance with navigation to original conversation context, loaded from ZeroClaw's database.

### Key Entities (ZeroClaw-Managed)

- **SearchResult**: Managed by ZeroClaw gateway. A ranked match from conversation history containing the message, relevance score, and workspace context. Leblebi displays results from API only.

## Data Architecture

**CRITICAL**: Leblebi is a **thin UI client** - all data persists in ZeroClaw's database.

- **No local search index** (ZeroClaw provides search functionality)
- **ZeroClaw REST API** is the source of truth for search operations
- **Bearer token authentication** for all API calls

### API Endpoints (ZeroClaw Gateway)

- `GET /search?q={query}` - Search conversations (keyword + semantic)
- `GET /search/{resultId}/context` - Get message context for search result

## Out of Scope (MVP)

- Basic chat functionality (covered in US1)
- Multiple workspaces (covered in US2)
- Tool & integration management (covered in US3)
- Local search index (ZeroClaw provides search)

## Success Criteria

### Measurable Outcomes

- **SC-004**: Search queries return relevant results (user clicks on a result) in 80% of search attempts.
- **SC-010**: 95% of search API calls complete within 2 seconds under normal network conditions.

## Clarifications

- Q: How should Leblebi implement search? → A: ZeroClaw search API only, no local index
- Q: Should search be per-workspace or global? → A: ZeroClaw API supports both (workspace-scoped or global)
