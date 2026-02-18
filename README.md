# Leblebi (ZeroClaw Client)

[![WIP](https://img.shields.io/badge/status-WIP-orange.svg)](https://github.com/leblebi-ai/leblebi)

**Leblebi** is a Flutter-based client application for **ZeroClaw**, designed to provide a seamless chat interface and gateway connection management.

> **Note:** This project is currently a **Work In Progress (WIP)**. Features are actively being developed and improved.

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

### 🚀 Upcoming Features
- [ ] **Message History**: Enhanced loading and pagination of past conversations.
- [ ] **Auto-Scroll**: Smart scrolling to the latest message.
- [ ] **Rich Text Support**: Markdown rendering for AI responses and code syntax highlighting.
- [ ] **Multiple Conversations**: Create, switch, and manage multiple chat sessions.
- [ ] **Settings**: User preferences for theme, notifications, and more.
- [ ] **Tool Integration**: Support for executing and viewing tool calls/outputs.
- [ ] **Workspace Management**: Switch between different workspaces.

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
