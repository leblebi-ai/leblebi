# Quickstart: ZeroClaw Flutter Interface

**Created**: 2026-02-17
**Purpose**: Get started with the ZeroClaw Flutter interface in under 5 minutes

---

## Prerequisites

- Flutter SDK 3.10.8 or higher
- Dart 3.10.8 or higher
- ZeroClaw gateway running locally or accessible via network
- macOS (primary), iOS/Android device (secondary), or Linux machine

---

## Installation

### 1. Clone and Setup

```bash
git clone <repository-url>
cd leblebi
flutter pub get
```

### 2. Configure ZeroClaw Gateway

Ensure your ZeroClaw gateway is running:

```bash
# On your local machine or server
zeroclaw gateway
```

Note the gateway URL (default: `http://localhost:8080`) and obtain a pairing code from your ZeroClaw configuration.

### 3. Run the App

**macOS** (Primary platform):
```bash
flutter run -d macos
```

**iOS Simulator**:
```bash
flutter run -d ios
```

**Android Emulator**:
```bash
flutter run -d android
```

**Linux**:
```bash
flutter run -d linux
```

**Web**:
```bash
flutter run -d chrome
```

**Windows**:
```bash
flutter run -d windows
```

---

## First-Time Setup

### Step 1: Add Gateway Connection

1. Launch the app
2. Navigate to **Settings** → **Gateway Connections**
3. Tap **Add Connection**
4. Enter:
   - **Name**: "My Gateway" (or any descriptive name)
   - **URL**: `http://localhost:8080` (or your gateway URL)
   - **Pairing Code**: Obtain from ZeroClaw config
5. Tap **Connect**
6. Wait for connection status to change to **Connected** ✅

### Step 2: Create Your First Workspace

1. Navigate to **Workspaces** tab
2. Tap **+ New Workspace**
3. Enter:
   - **Name**: "Personal Assistant" (or your choice)
   - **Description**: Optional description
   - **Agent Name**: "Helper" (default agent identity)
   - **Model**: Select from dropdown (e.g., `anthropic/claude-sonnet-4`)
   - **Temperature**: 0.7 (default)
4. Tap **Create**

### Step 3: Start Chatting

1. Tap on your newly created workspace
2. You'll see the chat interface with a welcome message
3. Type your first message: "Hello, ZeroClaw!"
4. Press **Send** or hit Enter
5. Wait for AI response (typically < 5 seconds)
6. Continue the conversation!

---

## Common Tasks

### Switch Between Workspaces

1. Tap the **Workspaces** icon in the bottom navigation
2. Tap on the workspace you want to switch to
3. The app automatically loads that workspace's conversation history

### Create a New Workspace

1. Go to **Workspaces** tab
2. Tap **+** (plus) button in top-right corner
3. Fill in workspace details
4. Tap **Create**

### Configure Tools

1. Open a workspace
2. Tap the **Tools** icon (wrench) in the top-right corner
3. Toggle tools on/off:
   - **File Read**: Allow AI to read files
   - **File Write**: Allow AI to modify files
   - **Shell**: Allow command execution
   - **Browser**: Allow web browsing
   - **Memory**: Enable long-term memory
4. For file tools, set directory scope:
   - Tap **Configure Scope**
   - Add allowed directories
   - Toggle **Workspace Only** for security
5. Changes are saved automatically

### Search Conversations

1. Tap the **Search** icon (magnifying glass)
2. Type your search query
3. Results appear ranked by relevance
4. Tap a result to view the full conversation context

### Archive a Conversation

1. Open the conversation
2. Tap the **Menu** (three dots) in top-right
3. Select **Archive**
4. To restore: Go to **Workspaces** → **Archived** → Tap conversation → **Restore**

### Delete a Workspace

1. Go to **Workspaces** tab
2. Long-press (or swipe left on) the workspace
3. Tap **Delete**
4. Confirm deletion

⚠️ **Warning**: This soft-deletes the workspace and all its conversations. They can be recovered from the **Trash** section within 30 days.

---

## Troubleshooting

### Connection Failed

**Symptom**: Gateway connection shows "Error" or "Disconnected"

**Solutions**:
1. Verify ZeroClaw gateway is running: `zeroclaw gateway`
2. Check the URL is correct (include `http://` or `https://`)
3. Ensure pairing code is valid (check ZeroClaw config)
4. Try **Test Connection** button for diagnostics
5. Check firewall settings if gateway is on a different machine

### No AI Response

**Symptom**: Message sent but no response after 30+ seconds

**Solutions**:
1. Check connection status (should be **Connected**)
2. Verify AI provider is configured in ZeroClaw
3. Check ZeroClaw logs for errors: `zeroclaw logs`
4. Try sending a simple test message: "Hello"
5. Restart the app and reconnect

### Messages Not Persisting

**Symptom**: Conversations disappear after app restart

**Solutions**:
1. Ensure you're not in "Guest Mode" (requires workspace selection)
2. Check app has storage permissions (mobile platforms)
3. Verify Hive database is not corrupted:
   ```bash
   # Clear app data and re-login
   flutter run --clear
   ```

### Search Returns No Results

**Symptom**: Search query returns empty results

**Solutions**:
1. Try broader search terms (fewer keywords)
2. Ensure you're searching in the correct workspace (or "All Workspaces")
3. Verify conversations exist and are not archived
4. Search is case-insensitive; try different capitalization

### App Crashes on Launch

**Symptom**: App crashes immediately after opening

**Solutions**:
1. Clear app cache/data:
   - **macOS**: `rm -rf ~/Library/Application\ Support/leblebi`
   - **iOS**: Delete and reinstall app
   - **Android**: Settings → Apps → Leblebi → Clear Data
2. Reinstall the app
3. Check Flutter logs: `flutter logs`
4. Report bug with crash logs if issue persists

---

## Keyboard Shortcuts (Desktop Platforms)

| Shortcut | Action |
|----------|--------|
| `Cmd/Ctrl + N` | New conversation |
| `Cmd/Ctrl + W` | Switch workspace |
| `Cmd/Ctrl + F` | Search conversations |
| `Cmd/Ctrl + Enter` | Send message |
| `Esc` | Cancel/Close modal |
| `Cmd/Ctrl + ,` | Open settings |

---

## Next Steps

- **Customize Agent Identity**: Configure personality, system prompt, and behavior
- **Enable Advanced Tools**: Set up Composio integrations, custom tools
- **Export Conversations**: Share or backup your conversation history
- **Multi-Device Sync**: Set up gateway sync across devices
- **Themes & Appearance**: Customize app appearance (light/dark mode)

---

## Support

- **Documentation**: `/specs/001-zeroclaw-integration/` for detailed specs
- **Issues**: Report bugs via GitHub Issues
- **Community**: Join Discord/Slack for help and discussions

---

**Happy Chatting! 🤖💬**
