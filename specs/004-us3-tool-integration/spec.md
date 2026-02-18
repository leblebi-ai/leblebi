# Feature Specification: Tool & Integration Management

**Feature Branch**: `004-us3-tool-integration`
**Parent Epic**: `001-zeroclaw-integration`
**Created**: 2026-02-17
**Status**: Draft
**Priority**: P3

## Overview

Users can view, enable, and configure ZeroClaw's built-in tools (file operations, shell commands, browser, memory) and external integrations via the ZeroClaw gateway API. Leblebi provides the UI for tool configuration - all tool management persists in ZeroClaw's database.

**Why this matters**: Tools extend the AI's capabilities beyond conversation, enabling real-world actions. This is an advanced feature that enhances utility but isn't required for basic chat functionality.

**Dependency**: Requires US1 (Connect and Chat) to be completed first.

**Architecture Principle**: Leblebi is a thin UI client. Tool configurations persist in ZeroClaw's database. No local storage except bearer token.

## Target User

Advanced users who want to extend the AI's capabilities with tool integrations for file operations, shell commands, and external services.

## User Scenarios & Acceptance Criteria

### Primary User Journey

**Independent Test**: User can navigate to a tools settings screen, enable/disable specific tools via ZeroClaw API, set workspace scopes, and observe that the AI's capabilities change accordingly.

**Acceptance Scenarios**:

1. **Given** a connected workspace, **When** user navigates to the tools management screen, **Then** all available tools are listed with their current enabled/disabled state loaded from ZeroClaw.
2. **Given** tools are disabled by default, **When** user enables the file_read tool with a specific directory scope via API, **Then** the AI can access files within that scope in subsequent conversations.
3. **Given** an active integration (e.g., Composio), **When** user disconnects the integration via API, **Then** related tool capabilities are removed from the agent's available actions.

## Requirements

### Functional Requirements

- **FR-008**: System MUST display available tools and integrations with enable/disable toggles per workspace, loaded from ZeroClaw API.
- **FR-009**: System MUST allow users to configure tool scopes (e.g., directory paths for file operations) via ZeroClaw API with clear permission indicators.

### Key Entities (ZeroClaw-Managed)

- **ToolConfiguration**: Managed by ZeroClaw gateway. Settings for a specific tool including enabled state, scope/permissions, and workspace-specific overrides. Leblebi displays and modifies via API only.

## Data Architecture

**CRITICAL**: Leblebi is a **thin UI client** - all data persists in ZeroClaw's database.

- **No local Hive storage** for tool configurations
- **ZeroClaw REST API** is the source of truth for tool management
- **Bearer token authentication** for all API calls

### API Endpoints (ZeroClaw Gateway)

- `GET /tools` - List all available tools
- `PUT /tools/{id}` - Enable/disable tool
- `PUT /tools/{id}/scope` - Configure tool scope
- `GET /integrations` - List available integrations
- `POST /integrations/{id}/connect` - Connect integration
- `DELETE /integrations/{id}/connect` - Disconnect integration

## Edge Cases

- **Tool execution failures**: How are errors from tool operations (file not found, permission denied) communicated to users? The app MUST display tool errors in-context within the conversation (ZeroClaw provides error details via API).
- **API unavailable for tool config**: Show clear error message, retry with exponential backoff, disable tool config UI until connection restored.

## Out of Scope (MVP)

- Basic chat functionality (covered in US1)
- Multiple workspaces (covered in US2)
- Conversation search (covered in US4)
- Local tool configuration storage (ZeroClaw is source of truth)

## Success Criteria

### Measurable Outcomes

- **SC-008**: Users complete tool configuration tasks (enable tool, set scope) in under 1 minute on average.
- **SC-009**: 95% of tool configuration API calls complete successfully under normal network conditions.

## Clarifications

- Q: How should Leblebi store tool configurations? → A: ZeroClaw database only, Leblebi is thin UI client
- Q: Should tool configs be per-workspace or global? → A: Managed by ZeroClaw (workspace-specific overrides supported)
