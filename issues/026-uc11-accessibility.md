## Acceptance Criteria
- [ ] All interactive elements have semantic labels
- [ ] Agent status changes announced to screen readers
- [ ] Chat messages readable in sequence
- [ ] Workflow nodes navigable via keyboard
- [ ] Full tab-order through all screens
- [ ] Arrow keys for lists and grids
- [ ] Enter/Space to activate
- [ ] Escape to dismiss overlays
- [ ] Shortcut cheat sheet (`?` key on desktop)
- [ ] All entities generated using ZFA (Zorphy) with JSON serialization
- [ ] All Clean Architecture layers generated using ZFA generate command
- [ ] State management using ZFA-generated State classes

## Task
Implement comprehensive accessibility features for screen reader support and keyboard navigation.

### Screen Reader Support:

**Semantic Labels:**
Every interactive element must have appropriate accessibility labels:

```dart
// Example: Agent Card
Semantics(
  label: 'Email Agent, status: Idle, last active 5 minutes ago',
  button: true,
  onTap: () => openChat(),
  child: AgentCard(...)
)

// Example: Message Bubble
Semantics(
  label: 'Research Agent says: ${message.content}',
  button: true,
  onTap: () => showMessageActions(),
  child: MessageBubble(...)
)

// Example: Workflow Node
Semantics(
  label: 'Email Trigger node, configured to monitor inbox. Tap to configure.',
  button: true,
  onTap: () => openNodeConfig(),
  child: WorkflowNode(...)
)
```

**Label Guidelines:**

| Element | Label Format |
|---------|--------------|
| Agent Card | "{name}, status: {status}, {activity}" |
| Message | "{sender} says: {content preview}" |
| Button | "{action}" or "{action} for {context}" |
| Toggle | "{name}, {on/off}" |
| Text Field | "{label}, {hint text}, {current value}" |
| Slider | "{name}, {current value} out of {max}" |
| Icon Button | "{tooltip or action description}" |

**Live Announcements:**

Agent status changes announced:
```dart
// When agent starts working
SemanticsService.announce(
  'Email Agent is now working on your request',
  TextDirection.ltr,
);

// When agent completes
SemanticsService.announce(
  'Research Agent has completed the analysis',
  TextDirection.ltr,
);

// When approval is needed
SemanticsService.announce(
  'Email Agent is waiting for your approval',
  TextDirection.ltr,
);
```

**Announcement Types:**
- Agent status changes
- New messages received
- Workflow progress
- Errors and warnings
- Approval requests

**Chat Message Accessibility:**

Messages should be:
1. Announced in order when scrolling
2. Distinguishable between user and agent
3. Include timestamp (optional announcement)
4. Rich content described appropriately

```dart
Semantics(
  container: true,
  child: Column(
    children: [
      Semantics(
        label: 'Sent by you at 2:45 PM',
        child: UserMessage(...),
      ),
      Semantics(
        label: 'Reply from Research Agent at 2:46 PM',
        child: AgentMessage(...),
      ),
    ],
  ),
)
```

**Rich Content Accessibility:**

Code blocks:
```dart
Semantics(
  label: 'Code block in ${language}: ${truncatedCode}',
  hint: 'Double tap to copy',
  child: CodeBlock(...),
)
```

Images:
```dart
Semantics(
  label: imageDescription ?? 'Image',
  hint: 'Double tap to view full screen',
  child: ImageWidget(...),
)
```

Tables:
```dart
Semantics(
  container: true,
  label: 'Table with ${rows.length} rows and ${columns.length} columns',
  child: DataTable(...),
)
```

### Keyboard Navigation:

**Tab Order:**
- Logical sequence through all interactive elements
- Skip links for main content
- Focus traps in modals/dialogs

**Focus Indicators:**
- Visible focus ring on all elements
- High contrast focus indicator
- Custom focus styling for brand consistency

```dart
Focus(
  decoration: FocusDecoration(
    border: OutlineInputBorder(
      borderSide: BorderSide(color: accentColor, width: 2),
    ),
  ),
  child: Widget(...),
)
```

**Navigation Shortcuts:**

**Global Shortcuts:**
| Key | Action |
|-----|--------|
| Tab | Next element |
| Shift+Tab | Previous element |
| Enter/Space | Activate |
| Escape | Dismiss overlay |
| ? | Show shortcuts |

**Dashboard:**
| Key | Action |
|-----|--------|
| Arrow keys | Navigate agent grid |
| Enter | Open selected agent |
| Delete | Delete selected agent |
| N | New agent |
| / | Open command bar |

**Chat:**
| Key | Action |
|-----|--------|
| Arrow up | Previous message |
| Arrow down | Next message |
| Enter | Send message |
| Shift+Enter | New line |
| R | Reply to message |
| E | Edit last message |

**Workflow Builder:**
| Key | Action |
|-----|--------|
| Arrow keys | Move selection |
| Tab | Next node |
| Shift+Tab | Previous node |
| Enter | Configure node |
| Delete | Delete node |
| C | Connect nodes |
| S | Save workflow |
| Cmd/Ctrl+Enter | Run workflow |

**Shortcuts Help Modal:**
```
┌─────────────────────────────────────┐
│  Keyboard Shortcuts            [×]  │
├─────────────────────────────────────┤
│                                     │
│  General                            │
│  ────────────────────────────────   │
│  Cmd/Ctrl + K    Command Bar        │
│  Cmd/Ctrl + N    New Agent          │
│  Cmd/Ctrl + S    Save               │
│  Cmd/Ctrl + ,    Settings           │
│  ?               Show this help     │
│                                     │
│  Navigation                         │
│  ────────────────────────────────   │
│  Tab             Next element       │
│  Shift + Tab     Previous element   │
│  Enter/Space     Activate           │
│  Escape          Dismiss/Close      │
│                                     │
│  Chat                               │
│  ────────────────────────────────   │
│  ↑ / ↓           Navigate messages  │
│  Enter           Send message       │
│  Shift + Enter   New line           │
│  R               Reply              │
│                                     │
│  Workflow Builder                   │
│  ────────────────────────────────   │
│  Arrow keys      Move selection     │
│  Enter           Configure node     │
│  Delete          Delete node        │
│  C               Connect mode       │
│  S               Save workflow      │
│                                     │
│  [Close] or press Escape            │
│                                     │
└─────────────────────────────────────┘
```

### Accessibility Settings:

**Settings Screen:**
```
┌─────────────────────────────────────┐
│  ←  Accessibility                   │
├─────────────────────────────────────┤
│                                     │
│  Screen Reader                      │
│  ☑ Enable enhanced announcements    │
│  ☑ Announce agent status changes    │
│  ☑ Announce new messages            │
│                                     │
│  Visual                             │
│  ☑ High contrast mode               │
│  ☑ Reduce motion                    │
│  ☐ Increase text contrast           │
│                                     │
│  Text Size                          │
│  Small ────●──────────── Large      │
│                                     │
│  Focus                              │
│  ☑ Visible focus indicators         │
│  ☑ Keyboard navigation hints        │
│  Focus indicator size:              │
│  Normal ────●────────── Large       │
│                                     │
│  Interaction                        │
│  ☑ Keyboard shortcuts               │
│  [View all shortcuts]               │
│                                     │
│  Timeout Settings                   │
│  Toast duration: [Short/Medium/Long]│
│  Animation speed: [Normal/Reduced]  │
│                                     │
└─────────────────────────────────────┘
```

### WCAG Compliance:

**Perceivable:**
- All non-text content has text alternatives
- Captions for video/audio content
- Content adaptable to different presentations
- Distinguishable (color contrast, text spacing)

**Operable:**
- All functionality available via keyboard
- No keyboard traps
- Adjustable time limits
- Provide ways to navigate
- Support for various input methods

**Understandable:**
- Readable and understandable text
- Predictable behavior
- Input assistance (labels, error identification, suggestions)

**Robust:**
- Compatible with assistive technologies
- Valid markup
- Status messages programmatically determinable

### Testing Requirements:

**Screen Reader Testing:**
- VoiceOver (iOS, macOS)
- TalkBack (Android)
- NVDA (Windows)
- JAWS (Windows)
- Narrator (Windows)
- Orca (Linux)

**Keyboard Testing:**
- All functionality accessible
- Logical tab order
- No focus traps
- Visible focus indicators
- Shortcut documentation

**Automated Testing:**
```dart
testWidgets('Agent card has correct semantics', (tester) async {
  await tester.pumpWidget(AgentCard(agent: testAgent));
  
  expect(
    find.bySemanticsLabel('Email Agent, status: Idle, last active 5 minutes ago'),
    findsOneWidget,
  );
});
```

### Color Contrast:

**Minimum Contrast Ratios:**
- Normal text: 4.5:1
- Large text: 3:1
- UI components: 3:1

**High Contrast Mode:**
- Automatic detection
- Enhanced borders
- Increased text contrast
- Alternative color schemes

### Reduced Motion:

**Animation Adjustments:**
```dart
MediaQuery.of(context).disableAnimations
  ? const Duration(milliseconds: 0)
  : const Duration(milliseconds: 300)
```

**Effects:**
- Disable parallax
- Instant transitions
- No auto-playing animations
- Reduced particle effects

### State Management:

**Accessibility State:**
```javascript
{
  screenReaderEnabled: boolean,
  highContrastMode: boolean,
  reduceMotion: boolean,
  textScale: number,
  focusIndicatorSize: enum,
  keyboardShortcutsEnabled: boolean,
  enhancedAnnouncements: boolean
}
```

## ZFA Architecture Requirements

### Entity Definition

**AccessibilitySettings Entity:**
```bash
zfa entity create -n AccessibilitySettings --field "id:String,screenReaderEnabled:bool,highContrastMode:bool,reduceMotion:bool,textScale:double,focusIndicatorSize:String,keyboardShortcutsEnabled:bool,enhancedAnnouncements:bool" --json
```

### Clean Architecture Generation

```bash
zfa generate AccessibilitySettings --methods=get,update --data --vpc --state
```

### Implementation Notes

1. **Semantic Labels**: Add to all ZFA-generated views
2. **Screen Reader**: Announce state changes from ZFA State classes
3. **Keyboard Navigation**: Add focus nodes to ZFA-generated views

