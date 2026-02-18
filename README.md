# Leblebi (ZeroClaw Client)

[![WIP](https://img.shields.io/badge/status-WIP-orange.svg)](https://github.com/leblebi-ai/leblebi)

**Leblebi** is a high-performance, native Flutter-based client for **ZeroClaw**, designed to be the definitive **Multi-Agent Orchestration Platform**.

Unlike Electron-based alternatives (e.g., Eigent), Leblebi focuses on:
*   **🚀 Native Performance**: Built with Flutter/Dart for blazing fast UI, minimal memory footprint, and instant startup.
*   **🔋 Efficiency**: Optimized for battery life and system resources, leaving more power for your local LLMs.
*   **🛠️ Professional Tooling**: A clean, type-safe architecture for managing complex agent workflows and tools.

> **Note:** This project is currently a **Work In Progress (WIP)**. Features are actively being developed to surpass existing open-source agent desktops.

## 🎥 Demo

Check out the current state of the chat interface:

<video src="https://github.com/user-attachments/assets/46863fd7-c031-434d-95de-ce5f17aa835d" controls="controls" style="max-width: 100%;">
  Your browser does not support the video tag.
</video>

*(If the video above doesn't play, you can view the file locally: `lebleli_zero_claw.mp4`)*

---

## ✨ Features

### ✅ Implemented
- **Gateway Connection**:
  - Securely connect to a ZeroClaw gateway.
  - Persist connection details with secure token storage.
  - **Re-pairing**: Disconnect and pair with a new gateway via the UI.
- **Chat Interface**:
  - Real-time messaging with optimistic UI updates.
  - "Enter to Send" functionality (Shift+Enter for new lines).
  - Message status indicators (Pending, Sent, Failed).
  - Clean and responsive message bubbles.
- **Architecture**:
  - Clean Architecture (Domain, Data, Presentation layers).
  - Dependency Injection using `get_it`.
  - Local data persistence with **Hive**.
  - State management with **Provider**.
- **CI/CD**:
  - Automated macOS binary builds and releases via GitHub Actions.

### 🚀 Roadmap & Upcoming Features

#### 🏢 Multi-Agent Workspace Management (US2)
Power users can maintain separate AI agent contexts for different use cases.
- [ ] **Workspace CRUD**: Create, rename, and delete multiple agent workspaces.
- [ ] **Context Switching**: Seamlessly switch between workspaces, preserving conversation history and state.
- [ ] **Identity Customization**: Configure distinct agent identities and personalities per workspace.
- [ ] **Trash Management**: Recover deleted workspaces within 30 days (soft delete).

#### 🛠️ Tool & Integration Management (US3)
Extend the AI's capabilities with tools and external integrations.
- [ ] **Tool Discovery**: View all available built-in tools (File Ops, Shell, Browser) and integrations.
- [ ] **Workspace Scoping**: Enable/disable tools per workspace.
- [ ] **Permission Control**: Configure granular scopes (e.g., allowed directory paths) for file operations.
- [ ] **Integration Status**: Manage connection status for external services (e.g., Composio).

#### 🧠 Conversation Memory & Search (US4)
Retrieve past information and context efficiently.
- [ ] **Global Search**: Natural language search across all conversation history.
- [ ] **Hybrid Search**: Combine keyword matching with semantic similarity for better results.
- [ ] **Context Navigation**: Jump directly to the message context from search results.
- [ ] **Workspace Filtering**: Identify which workspace a search result belongs to.

#### 🎨 UI/UX Improvements
- [ ] **Message History**: Enhanced loading and pagination (infinite scroll).
- [ ] **Auto-Scroll**: Smart scrolling to the latest message.
- [ ] **Rich Text Support**: Markdown rendering for AI responses and code syntax highlighting.
- [ ] **Settings**: User preferences for theme, notifications, and more.

## 🛠️ Getting Started

### Prerequisites
- Flutter SDK 3.x
- Dart 3.10.8+

### Installation

1. **Clone the repository:**
   ```bash
   git clone https://github.com/your-username/leblebi.git
   cd leblebi
   ```

2. **Install dependencies:**
   ```bash
   flutter pub get
   ```

3. **Run the app:**
   ```bash
   flutter run
   ```

## 🏗️ Project Structure

The project follows a **Clean Architecture** pattern:

```text
lib/src/
├── data/           # Data layer (Repositories, Data Sources, APIs)
├── domain/         # Domain layer (Entities, UseCases, Repository Interfaces)
├── presentation/   # UI layer (Pages, Widgets, ViewModels)
└── di/             # Dependency Injection setup
```

## 🤝 Contributing

Contributions are welcome! Please feel free to submit a Pull Request.

---

*Generated for Leblebi Project*
