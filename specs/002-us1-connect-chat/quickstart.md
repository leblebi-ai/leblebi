# Quickstart: Connect and Chat with ZeroClaw Agent

**Branch**: `002-us1-connect-chat`
**Date**: 2026-02-17

## Prerequisites

- Flutter SDK 3.x installed
- ZeroClaw gateway installed (`zeroclaw` CLI)
- macOS (primary dev platform)

## Setup ZeroClaw Gateway

1. **Install ZeroClaw** (if not already installed):
   ```bash
   # Follow https://github.com/zeroclaw-labs/zeroclaw installation instructions
   ```

2. **Start the gateway**:
   ```bash
   zeroclaw gateway
   ```
   
   Expected output:
   ```
   Gateway started on http://127.0.0.1:8080
   Pairing code: 123456
   ```

3. **Note the 6-digit pairing code** - you'll need this for the Flutter app.

## Run Flutter App

1. **Navigate to project root**:
   ```bash
   cd /Users/arrrrny/Developer/leblebi
   ```

2. **Install dependencies**:
   ```bash
   flutter pub get
   ```

3. **Run on macOS** (primary dev platform):
   ```bash
   flutter run -d macos
   ```

## First-Time Setup Flow

1. **App launches** → Full-screen setup modal appears
2. **Enter gateway URL**: `http://127.0.0.1:8080`
3. **Enter pairing code**: `123456` (from ZeroClaw output)
4. **Tap "Connect"**
5. **Default conversation auto-created** → Chat interface appears
6. **Send your first message!**

## Testing the Chat Flow

1. **Type a message** in the input field (max 4000 characters)
2. **Press Send** (or Enter key)
3. **Observe**:
   - Message appears in chat with "pending" status
   - Status changes to "sent" when delivered
   - Typing indicator appears
   - AI response appears within ~5 seconds
4. **Close and reopen app** → Conversation history preserved

## Testing Network Resilience

1. **Start a conversation** (send a few messages)
2. **Stop ZeroClaw gateway**:
   ```bash
   # Press Ctrl+C in terminal running zeroclaw
   ```
3. **Observe in app**:
   - "No connection" banner appears
   - Message input disabled
   - Retry indicator shows
4. **Restart ZeroClaw gateway**:
   ```bash
   zeroclaw gateway
   ```
5. **Observe**:
   - App reconnects automatically within 10 seconds
   - Connection status updates to "connected"
   - Can send messages again

## Testing Message Retry

1. **Start sending a message**
2. **Immediately stop ZeroClaw** (while message is "pending")
3. **Observe**:
   - Message retries 3 times with exponential backoff (1s, 2s, 4s)
   - After 3 failed retries, status changes to "failed"
   - Error message shown: "Message failed to send"

## Development Workflow

### Hot Reload (UI changes)
```bash
# While app is running, press 'r' in terminal
# Or save a Dart file in presentation/ layer
```

### Hot Restart (logic changes)
```bash
# While app is running, press 'R' in terminal
# Required for domain/ or data/ layer changes
```

### Run Tests
```bash
flutter test
```

### Analyze Code
```bash
dart analyze
```

## Troubleshooting

### "Connection refused" error
- **Cause**: ZeroClaw gateway not running
- **Fix**: Run `zeroclaw gateway` in a separate terminal

### "Invalid pairing code" error
- **Cause**: Pairing code expired or already used
- **Fix**: Restart ZeroClaw gateway to get new code

### Messages stuck in "pending" status
- **Cause**: Network issue or gateway crashed
- **Fix**: Check ZeroClaw is running, wait for retry or restart app

### Bearer token lost
- **Cause**: App reinstalled or secure storage cleared
- **Fix**: Re-enter pairing code in setup modal

## Next Steps

After verifying basic chat works:
1. Test with longer conversations (100+ messages)
2. Test scroll performance with 500+ messages
3. Test markdown rendering in AI responses
4. Test connection status indicators
5. Proceed to US2 (Multi-Agent Workspace) implementation

## Resources

- **ZeroClaw Docs**: https://github.com/zeroclaw-labs/zeroclaw
- **Feature Spec**: `specs/002-us1-connect-chat/spec.md`
- **Data Model**: `specs/002-us1-connect-chat/data-model.md`
- **API Contracts**: `specs/002-us1-connect-chat/contracts/chat-contracts.graphql`
