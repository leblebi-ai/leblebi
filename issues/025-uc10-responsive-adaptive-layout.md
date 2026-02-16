## Acceptance Criteria
- [ ] Mobile (portrait): Bottom navigation, 2-column agent grid, simplified workflow builder
- [ ] Tablet (landscape): Side navigation rail, master-detail layout, full canvas
- [ ] Desktop: Full sidebar, multi-pane layout, keyboard shortcuts, system tray integration
- [ ] All layouts support same core functionality with appropriate adaptations
- [ ] All entities generated using ZFA (Zorphy) with JSON serialization
- [ ] All Clean Architecture layers generated using ZFA generate command
- [ ] State management using ZFA-generated State classes

## Task
Implement responsive and adaptive layouts for all screen sizes and platforms.

### Mobile (Portrait):

**Layout Structure:**
```
┌─────────────────────────────────────┐
│  Status Bar                         │
├─────────────────────────────────────┤
│  App Bar (contextual)               │
├─────────────────────────────────────┤
│                                     │
│                                     │
│         Main Content                │
│         (scrollable)                │
│                                     │
│                                     │
│                                     │
├─────────────────────────────────────┤
│  Bottom Navigation                  │
│  ┌───┬───┬───┬───┐                 │
│  │ 🏠│ 💬│ 🔄│ ⚙️│                 │
│  └───┴───┴───┴───┘                 │
└─────────────────────────────────────┘
```

**Navigation:**
- Bottom tab bar (Home, Chat, Workflows, Settings)
- Full-screen views with back navigation
- Swipe gestures for navigation
- Pull-to-refresh where applicable

**Dashboard Adaptations:**
- 2-column agent grid
- Pull-down command bar from top
- FAB for new agent/workflow
- Activity feed as bottom sheet

**Chat Adaptations:**
- Full-screen chat
- Swipe to go back
- Pull-down for older messages
- Message input anchored at bottom
- Expandable input field

**Workflow Builder Adaptations:**
- Simplified node list view (vertical drag-and-drop)
- Tap node to configure
- Canvas view optional (pinch to zoom)
- Stepper wizard for simple workflows

**Command Bar:**
- Pull-down gesture from top
- Full-width input
- Dismiss with swipe up

### Tablet (Landscape):

**Layout Structure:**
```
┌────────┬────────────────────────────────────────┐
│        │ App Bar                                │
│  Side  ├────────────────────────────────────────┤
│  Rail  │                                        │
│        │         Main Content                   │
│  ┌───┐ │                                        │
│  │ 🏠│ │         (larger area)                  │
│  │ 💬│ │                                        │
│  │ 🔄│ │                                        │
│  │ ⚙️│ │                                        │
│  └───┘ │                                        │
│        │                                        │
└────────┴────────────────────────────────────────┘
```

**Navigation:**
- Side navigation rail (icons + labels on larger tablets)
- Master-detail layouts common
- Split view for multi-agent chat

**Dashboard Adaptations:**
- 3-column agent grid
- Side panel for activity feed
- Larger agent cards with more info

**Chat Adaptations:**
- Master-detail: Agent list on left, chat on right
- Split view for War Room
- Floating input bar

**Workflow Builder Adaptations:**
- Full canvas with touch gestures
- Pinch-to-zoom
- Side panel for node configuration
- Mini-map in corner

**Command Bar:**
- Centered modal
- `Cmd+K` shortcut

### Desktop (macOS, Windows, Linux, Web):

**Layout Structure:**
```
┌────────────┬───────────────────────────────────┬──────────────┐
│            │ App Bar                           │              │
│   Full     ├───────────────────────────────────┤   Detail     │
│   Sidebar  │                                   │   Panel      │
│            │         Main Content              │   (optional) │
│   ┌──────┐ │                                   │              │
│   │ Home │ │         (resizable)               │              │
│   │ Chat │ │                                   │              │
│   │ Work │ │                                   │              │
│   │ Sett │ │                                   │              │
│   └──────┘ │                                   │              │
│            │                                   │              │
└────────────┴───────────────────────────────────┴──────────────┘
```

**Navigation:**
- Full sidebar with collapsible sections
- Keyboard shortcuts for everything
- Multi-pane layouts
- Tab bar for multiple open chats

**Dashboard Adaptations:**
- Sidebar list of agents + detail panel
- Activity feed as side panel
- Command bar as centered modal

**Chat Adaptations:**
- Multi-pane: nav + chat list + chat view + detail
- Tabs for multiple conversations
- Split view for War Room

**Workflow Builder Adaptations:**
- Full canvas with mouse + keyboard
- Resizable panels
- Context menu on right-click
- Keyboard shortcuts for all actions

**Desktop-Specific Features:**

**System Tray (Desktop):**
```
┌─────────────────────────────┐
│  🔔 Leblebi                 │
├─────────────────────────────┤
│  ● Research Agent running   │
│  ⚠️  Approval needed        │
│  ─────────────────────────  │
│  Open Leblebi               │
│  New Agent                  │
│  Settings                   │
│  ─────────────────────────  │
│  Quit                       │
└─────────────────────────────┘
```

**Menu Bar (macOS):**
```
File          Edit          View          Agent         Window        Help
─────────────────────────────────────────────────────────────────────────────
New Agent     Undo          Zoom In       New Agent     Minimize      About
New Workflow  Redo          Zoom Out      Configure     Zoom          Docs
Open...       Cut           Full Screen   Run           Float All     Support
Save          Copy          Toggle Rail   Stop          Reset Layout  Release Notes
Export        Paste         Toggle Panel  Pause All     ──────────    Report Issue
─────────     Select All    ───────────   Resume All    Chat 1        
Settings      Find          Dark/Light    ──────────    Chat 2        
Quit          ───────────   Dashboard                    Chat 3        
                             Activity Feed                             

Keyboard Shortcuts:
- Cmd+N: New Agent
- Cmd+Shift+N: New Workflow
- Cmd+K: Command Bar
- Cmd+,: Settings
- Cmd+Q: Quit
- Cmd+W: Close Window
```

**Window Management:**
- Resizable panels
- Detachable windows
- Multiple window support
- Window state persistence

### Breakpoints:

| Breakpoint | Width | Layout |
|------------|-------|--------|
| Mobile | < 600px | Single column, bottom nav |
| Tablet Portrait | 600-840px | 2-column, bottom nav |
| Tablet Landscape | 840-1200px | Side rail, master-detail |
| Desktop | > 1200px | Full sidebar, multi-pane |

### Responsive Components:

**Agent Grid:**
- Mobile: 2 columns
- Tablet: 3 columns
- Desktop: List + detail OR 4+ columns

**Chat View:**
- Mobile: Full screen
- Tablet: Master-detail (optional)
- Desktop: Multi-pane with tabs

**Workflow Builder:**
- Mobile: List view (vertical)
- Tablet: Canvas with touch
- Desktop: Full canvas with mouse/keyboard

**Settings:**
- Mobile: Full-screen sections
- Tablet: Side panel
- Desktop: Multi-pane settings

### Adaptive Behaviors:

**Touch vs Mouse:**
- Touch: Larger tap targets, swipe gestures
- Mouse: Hover states, right-click menus, tooltips

**Screen Real Estate:**
- Small: Prioritize essential info, collapsible sections
- Large: Show more info, persistent panels

**Input Methods:**
- Touch: On-screen keyboard, voice input
- Mouse/Keyboard: Keyboard shortcuts, drag-and-drop

### Platform-Specific Adaptations:

**iOS:**
- Safe area handling
- Swipe from edge to go back
- Haptic feedback
- Dynamic Type support
- Split View / Slide Over support

**Android:**
- Material Design components
- Back gesture
- Predictive back
- Edge-to-edge
- Multi-window support

**macOS:**
- Native window chrome
- Touch Bar support (if available)
- Handoff support
- iCloud sync

**Windows:**
- Fluent Design elements
- Snap layouts support
- Windows Hello integration

**Linux:**
- GTK/Qt theme integration
- System tray support
- Desktop entry

**Web:**
- Browser tab management
- URL routing
- Service worker for offline
- PWA support

### State Management:

**Layout State:**
```javascript
{
  breakpoint: enum, // mobile, tablet-portrait, tablet-landscape, desktop
  isTouch: boolean,
  sidebarExpanded: boolean,
  panelPositions: { ... },
  windowState: { width, height, isMaximized }
}
```

### Accessibility:
- All layouts support screen readers
- Keyboard navigation on all platforms
- High contrast support
- Reduced motion support

## ZFA Architecture Requirements

### Entity Definition

**LayoutPreferences Entity:**
```bash
zfa entity create -n LayoutPreferences --field "id:String,breakpoint:String,isTouch:bool,sidebarExpanded:bool,panelPositions:Map<String,dynamic>,windowWidth:int,windowHeight:int,isMaximized:bool" --json
```

### Clean Architecture Generation

```bash
zfa generate LayoutPreferences --methods=get,update --data --vpc --state
```

### Implementation Notes

1. **Responsive Builder**: Use `MediaQuery` to detect breakpoint
2. **Platform Detection**: Use `Platform.isIOS`, `Platform.isAndroid`, etc.
3. **State Persistence**: Save layout preferences for restoration

