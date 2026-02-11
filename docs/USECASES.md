# Leblebi — Use Case Master Plan

> Multi-agent AI assistant. Flutter. BYOK. Open source. Runs everywhere.

---

## UC-1: Onboarding — First Launch

### UC-1.1: Welcome & Key Setup
- User opens app for the first time → clean, minimal welcome screen with logo and one CTA
- "Bring Your Own Key" screen: user picks a provider (OpenAI, Anthropic, Google, Mistral, Ollama/local, custom OpenAI-compatible endpoint)
- Provider cards with logos, tap to expand → single text field for API key + "Test Connection" button
- Visual feedback: key validation spinner → green checkmark or red error with human-readable message
- User can add multiple providers; one is set as **default** (star badge)
- Skip option → app runs in "explore mode" (UI tour, no agent execution)

### UC-1.2: Create Your First Agent
- After key setup, guided bottom-sheet: "Create your first agent"
- Pick from starter templates (cards with illustration + 1-line description):
  - **General Assistant** — everyday tasks
  - **Research Agent** — web search, summarize, compare
  - **Email Manager** — triage, draft, reply
  - **Calendar Agent** — schedule, remind, block time
  - **Code Helper** — explain, review, generate
  - **Custom** — blank canvas
- Tap template → agent appears on home with default avatar and name, editable inline

### UC-1.3: Quick Tour
- 3-panel swipeable overlay (not blocking, dismissible):
  1. "This is your **Command Bar** — talk to any agent from anywhere"
  2. "Your **Agents** live here — tap to configure, long-press to arrange"
  3. "**Workflows** chain agents together — build once, run anytime"

---

## UC-2: Home — The Command Center

### UC-2.1: Dashboard
- Top: global search/command bar (always accessible, pull-down gesture on mobile, `Cmd+K` on desktop)
- Agent cards in a grid (mobile: 2-col, tablet: 3-col, desktop: sidebar list + main panel)
- Each agent card shows:
  - Avatar (customizable emoji, icon, or image)
  - Name
  - Status pill: `Idle` / `Working...` / `Waiting for input` / `Error`
  - Last activity timestamp
  - Unread output badge count
- Floating action button → "New Agent" or "New Workflow"
- Bottom nav (mobile) / sidebar (desktop): **Home**, **Chat**, **Workflows**, **Settings**

### UC-2.2: Agent Quick Actions
- Tap agent card → opens chat with that agent
- Long-press agent card → context menu:
  - Duplicate
  - Edit Configuration
  - Pause / Resume
  - View Logs
  - Share (export agent config as JSON/link)
  - Delete (with confirmation)
- Drag agent card onto another agent card → prompt to create a workflow linking them

### UC-2.3: Live Activity Feed
- Collapsible panel (bottom sheet on mobile, side panel on desktop)
- Real-time stream of what agents are doing:
  - `📧 Email Agent triaged 12 emails — 3 flagged`
  - `🔍 Research Agent finished "competitor analysis" — tap to view`
  - `⏰ Calendar Agent blocked focus time 2-4pm tomorrow`
- Each entry is tappable → deep-links to the relevant chat or output
- Filter chips: All, Errors, Completed, In Progress

---

## UC-3: Chat — Conversational Interface

### UC-3.1: Single Agent Chat
- Full-screen chat view with agent avatar + name in app bar
- Message bubbles: user on right, agent on left
- Agent messages support rich content blocks (rendered inline):
  - Markdown (headings, lists, bold, code)
  - Code blocks with syntax highlighting + copy button
  - Tables (horizontally scrollable on mobile)
  - Images / charts (tap to fullscreen)
  - File attachments (tap to preview/download)
  - Action buttons ("Approve", "Edit", "Retry", "Send this email")
- Typing indicator with animated dots when agent is processing
- Input bar:
  - Text field with auto-expand
  - Attachment button (files, images, clipboard)
  - Voice input button (hold to record, release to send)
  - Send button
- Pull-down to see older messages (paginated)

### UC-3.2: Multi-Agent Chat (War Room)
- User creates a "room" and adds 2+ agents
- Each agent has a distinct avatar + colored name label in the thread
- User sends a message → it's broadcast to all agents (or @mention a specific one)
- Agents can respond to each other's outputs (threaded or linear, user toggles)
- User can mute/unmute individual agents mid-conversation
- Visual indicator showing which agent is currently "thinking"
- Useful for: brainstorming, research from multiple angles, getting competing drafts

### UC-3.3: Inline Approvals & Human-in-the-Loop
- When an agent wants to perform a real action (send email, create file, make API call):
  - Chat bubble with action preview card:
    - Title: "Send email to john@example.com"
    - Expandable body showing full content
    - Two buttons: **Approve** (green) / **Reject** (red)
    - Optional: **Edit before sending** (opens editable view)
- Approval history section in chat (collapsible, shows approved/rejected actions)
- Batch approval: if multiple actions queue up, show a stacked card "3 actions pending" → expand to approve/reject individually or all at once

### UC-3.4: Chat Branching
- Long-press any message → "Branch from here"
- Creates a fork of the conversation at that point
- Branch indicator in the timeline (visual fork icon)
- User can switch between branches via a dropdown or swipe gesture
- Useful for: exploring different approaches without losing context

---

## UC-4: Agent Configuration

### UC-4.1: Agent Profile Editor
- Full-page editor accessed from agent card → "Edit"
- Sections (scrollable form, collapsible groups):
  - **Identity**: Name, Avatar (pick emoji/icon/upload image), Description
  - **Model**: Dropdown of available models from configured providers, temperature slider, max tokens
  - **System Prompt**: Large text area with placeholder examples, character count
  - **Tools/Skills**: Toggle list of available tools (web search, file access, email, calendar, code execution, etc.)
  - **Permissions**: What this agent is allowed to do autonomously vs. requiring approval
  - **Memory**: Toggle conversation memory on/off, set context window limit
- Live preview pane (desktop): shows how the agent card will look on the dashboard
- "Test" button → opens a temporary chat to test the configuration before saving

### UC-4.2: Agent Templates & Marketplace
- Browse screen with curated agent templates (cards with preview, description, author)
- Categories: Productivity, Research, Development, Creative, Communication, Finance
- Search + filter by category/tag
- Tap template → preview screen showing:
  - Description
  - System prompt (read-only)
  - Required tools
  - "Use This Template" button → pre-fills agent creation form
- Community tab: user-submitted templates (sorted by downloads/stars)
- "Share My Agent" button on any agent → exports config (JSON) or publishes to community

---

## UC-5: Workflows — Visual Agent Orchestration

### UC-5.1: Workflow Builder (Canvas)
- Full-screen canvas (pinch-to-zoom, pan)
- Left panel: palette of nodes (drag onto canvas):
  - **Agent Node**: pick an existing agent
  - **Trigger Node**: manual, scheduled (cron), webhook, file change, email received
  - **Condition Node**: if/else based on output content
  - **Transform Node**: extract, format, merge outputs
  - **Human Approval Node**: pause and wait for user input
  - **Output Node**: where result goes (chat, file, notification, clipboard)
- Connect nodes with drag-from-port-to-port (visual wires with directional arrows)
- Tap a node → side sheet with configuration for that node
- Top bar: workflow name (editable), Save, Run, Share
- Mini-map in corner for large workflows

### UC-5.2: Workflow Templates
- Pre-built workflows accessible from "New Workflow" screen:
  - **Email Triage**: Email trigger → Classifier agent → Draft replies agent → Approval → Send
  - **Daily Briefing**: Scheduled trigger → News agent + Calendar agent + Email agent → Merge → Output to notification
  - **Code Review**: File change trigger → Code agent (review) → Summary agent → Output to chat
  - **Research Pipeline**: Manual trigger → Search agent → Summarize agent → Fact-check agent → Output to file
- Each template shows a visual preview of the workflow graph
- "Use Template" → opens in builder with pre-connected nodes, user customizes

### UC-5.3: Workflow Execution View
- When a workflow runs, the canvas animates:
  - Active node pulses/glows
  - Completed nodes get a green checkmark
  - Failed nodes get a red X (tap to see error)
  - Wires animate with flowing dots showing data direction
- Right panel: live log stream (timestamped entries per node)
- If a Human Approval Node is hit → notification + the canvas highlights it with a "Waiting" badge
- Execution history: list of past runs with status, duration, and output links
- "Re-run" button on any past execution

---

## UC-6: Command Bar — Universal Launcher

### UC-6.1: Quick Command
- Accessible from anywhere in the app (global gesture or shortcut)
- Text input with auto-complete suggestions:
  - Recent commands
  - Agent names (prefix `@`)
  - Workflow names (prefix `/run`)
  - Actions: `/new agent`, `/new workflow`, `/settings`, `/keys`
- Typing a natural language request without `@` → routes to default agent
- Typing `@Research summarize this article [paste URL]` → routes directly to Research agent
- Results appear inline below the command bar (expandable)
- Dismissible with swipe down or Escape

---

## UC-7: Notifications & Outputs

### UC-7.1: Notification Center
- Bell icon in top bar with unread badge
- Dropdown (desktop) or full-page (mobile) list:
  - Agent completed a task
  - Agent encountered an error
  - Agent waiting for approval
  - Workflow finished
  - Scheduled task reminder
- Each notification is tappable → navigates to relevant context
- Swipe to dismiss, "Mark all read" button
- Notification preferences per agent (mute, critical only, all)

### UC-7.2: Output Gallery
- Dedicated tab/page collecting all agent outputs
- Grid/list toggle
- Cards showing:
  - Output type icon (document, code, email draft, summary, image)
  - Title (auto-generated or user-named)
  - Source agent + timestamp
  - Preview snippet (first 2 lines or thumbnail)
- Tap to open full output viewer (markdown renderer, code editor, etc.)
- Actions: Copy, Share, Save to file, Send to another agent, Delete
- Filter by: agent, type, date range
- Search within outputs

---

## UC-8: Settings & Key Management

### UC-8.1: API Key Manager
- List of configured providers with status indicators (green = valid, red = expired/invalid)
- Tap provider → edit key, test connection, set as default, remove
- "Add Provider" button → same flow as onboarding UC-1.1
- Usage stats per provider (if API supports it): requests today, tokens used, estimated cost
- Visual cost chart (bar chart by day/week) per provider

### UC-8.2: Tool/Skill Manager
- List of available tools/skills with toggle switches
- Each tool shows:
  - Icon + name
  - Brief description
  - Required permissions (e.g., "needs file system access")
  - Which agents currently use it
- "Add Custom Tool" → form for MCP server URL or custom function definition
- MCP server browser: discover and connect MCP servers by URL

### UC-8.3: Appearance & Behavior
- Theme: Light / Dark / System
- Accent color picker
- Font size slider
- Notification preferences (global)
- Default model selection
- Data: export all data (JSON), import data, clear all data
- Language selection

---

## UC-9: Sharing & Collaboration

### UC-9.1: Export Agent
- From agent context menu → "Share"
- Options:
  - Copy as JSON (agent config without API key, obviously)
  - Generate shareable link (if community hub is enabled)
  - Export as QR code (for mobile-to-mobile sharing)
- Import: paste JSON, scan QR, or open shared link

### UC-9.2: Export Workflow
- Same as agent export but includes the full workflow graph
- Option to include or exclude agent configurations (share structure only vs. complete setup)

### UC-9.3: Export Chat / Output
- Share button on any chat → export as:
  - Markdown file
  - PDF
  - Plain text
  - Copy to clipboard

---

## UC-10: Responsive & Adaptive Layout

### UC-10.1: Mobile (Portrait)
- Bottom navigation: Home, Chat, Workflows, Settings
- Full-screen views with back navigation
- Agent grid: 2 columns
- Workflow builder: simplified node list view (drag-and-drop vertical list instead of free canvas)
- Command bar: pull-down from top

### UC-10.2: Tablet (Landscape)
- Side navigation rail (icons + labels)
- Master-detail layout: agent list on left, chat on right
- Workflow builder: full canvas with touch gestures
- Split view for multi-agent chat

### UC-10.3: Desktop (macOS, Windows, Linux, Web)
- Full sidebar navigation with collapsible sections
- Multi-pane layout: navigation + content + detail panel
- Keyboard shortcuts for everything
- Workflow builder: full canvas with mouse + keyboard
- Resizable panels
- System tray integration (desktop): agents run in background, notifications via OS
- Menu bar quick access (macOS)

---

## UC-11: Accessibility

### UC-11.1: Screen Reader Support
- All interactive elements have semantic labels
- Agent status changes announced
- Chat messages readable in sequence
- Workflow nodes navigable via keyboard

### UC-11.2: Keyboard Navigation
- Full tab-order through all screens
- Arrow keys for lists and grids
- Enter/Space to activate
- Escape to dismiss overlays
- Shortcut cheat sheet (`?` key on desktop)

---

## Use Case Priority Matrix

| Priority | Use Case | Rationale |
|----------|----------|-----------|
| P0 | UC-1 Onboarding + BYOK | No app without keys |
| P0 | UC-3.1 Single Agent Chat | Core interaction loop |
| P0 | UC-4.1 Agent Profile Editor | Users must configure agents |
| P0 | UC-2.1 Dashboard | Home screen, entry point |
| P1 | UC-6 Command Bar | Power-user efficiency |
| P1 | UC-3.3 Inline Approvals | Safety for real actions |
| P1 | UC-8.1 Key Manager | Multi-provider management |
| P1 | UC-7.1 Notifications | Async agent awareness |
| P2 | UC-5.1 Workflow Builder | Differentiator feature |
| P2 | UC-3.2 Multi-Agent Chat | Advanced use case |
| P2 | UC-7.2 Output Gallery | Content management |
| P2 | UC-4.2 Templates | Community + discoverability |
| P3 | UC-9 Sharing | Growth + community |
| P3 | UC-3.4 Chat Branching | Power-user feature |
| P3 | UC-10 Responsive Layout | Progressive refinement |
