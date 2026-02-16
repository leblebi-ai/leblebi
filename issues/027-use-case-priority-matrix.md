## Acceptance Criteria
- [ ] Priority matrix documented for development planning
- [ ] P0 (Critical) use cases identified: Onboarding, Single Agent Chat, Agent Profile Editor, Dashboard
- [ ] P1 (High) use cases identified: Command Bar, Inline Approvals, Key Manager, Notifications
- [ ] P2 (Medium) use cases identified: Workflow Builder, Multi-Agent Chat, Output Gallery, Templates
- [ ] P3 (Low) use cases identified: Sharing, Chat Branching, Responsive Layout refinement
- [ ] ALL development must use ZFA (Zorphy) for entity and Clean Architecture generation
- [ ] No manual entity creation - use `zfa entity create` command
- [ ] No manual architecture - use `zfa generate` command

## Task
Document the use case priority matrix to guide development planning and resource allocation.

### Priority Matrix:

| Priority | Use Case | Rationale | Dependencies |
|----------|----------|-----------|--------------|
| **P0** | UC-1 Onboarding + BYOK | No app without keys; critical first-time user experience | None |
| **P0** | UC-3.1 Single Agent Chat | Core interaction loop; primary user value | UC-1, UC-4.1 |
| **P0** | UC-4.1 Agent Profile Editor | Users must configure agents to be useful | UC-1 |
| **P0** | UC-2.1 Dashboard | Home screen; entry point for all features | UC-1 |
| **P1** | UC-6 Command Bar | Power-user efficiency; quick access to features | UC-2.1, UC-3.1 |
| **P1** | UC-3.3 Inline Approvals | Safety for real actions; prevents harmful operations | UC-3.1 |
| **P1** | UC-8.1 Key Manager | Multi-provider management; essential for BYOK model | UC-1 |
| **P1** | UC-7.1 Notifications | Async agent awareness; keeps users informed | UC-2.1, UC-3.1 |
| **P2** | UC-5.1 Workflow Builder | Differentiator feature; automates complex tasks | UC-2.1, UC-3.1, UC-4.1 |
| **P2** | UC-3.2 Multi-Agent Chat | Advanced use case; collaborative agent interactions | UC-3.1, UC-4.1 |
| **P2** | UC-7.2 Output Gallery | Content management; organizes agent outputs | UC-3.1 |
| **P2** | UC-4.2 Templates | Community + discoverability; reduces setup friction | UC-4.1 |
| **P3** | UC-9 Sharing | Growth + community; nice-to-have for adoption | All core features |
| **P3** | UC-3.4 Chat Branching | Power-user feature; exploring alternatives | UC-3.1 |
| **P3** | UC-10 Responsive Layout | Progressive refinement; polish for all platforms | All features |

### Development Phases:

**Phase 1: Foundation (P0)**
Goal: Minimum viable product with core functionality

| Sprint | Use Case | Deliverable |
|--------|----------|-------------|
| 1 | UC-1.1 | Welcome & Key Setup flow |
| 2 | UC-1.2 | Create First Agent flow |
| 3 | UC-2.1 | Dashboard with agent grid |
| 4 | UC-4.1 | Agent Profile Editor (basic) |
| 5 | UC-3.1 | Single Agent Chat |
| 6 | Integration | End-to-end MVP flow |

**Exit Criteria:**
- User can add API key
- User can create an agent
- User can chat with agent
- Agent responds correctly
- Basic error handling works

**Phase 2: Essential Features (P1)**
Goal: Production-ready with safety and convenience features

| Sprint | Use Case | Deliverable |
|--------|----------|-------------|
| 7 | UC-8.1 | API Key Manager |
| 8 | UC-3.3 | Inline Approvals |
| 9 | UC-6.1 | Command Bar |
| 10 | UC-7.1 | Notifications |
| 11 | UC-1.3 | Quick Tour |
| 12 | Polish | Bug fixes, performance |

**Exit Criteria:**
- Multi-provider support
- Safe agent actions
- Quick navigation
- User awareness of agent activity
- Onboarding complete

**Phase 3: Enhanced Features (P2)**
Goal: Differentiator features and advanced capabilities

| Sprint | Use Case | Deliverable |
|--------|----------|-------------|
| 13-14 | UC-5.1 | Workflow Builder |
| 15 | UC-5.2 | Workflow Templates |
| 16 | UC-5.3 | Workflow Execution View |
| 17 | UC-3.2 | Multi-Agent Chat |
| 18 | UC-7.2 | Output Gallery |
| 19 | UC-4.2 | Agent Templates |
| 20 | Polish | Bug fixes, performance |

**Exit Criteria:**
- Visual workflow builder functional
- Pre-built templates available
- Multi-agent conversations work
- Output management complete
- Template marketplace populated

**Phase 4: Polish & Growth (P3)**
Goal: Refinement and growth features

| Sprint | Use Case | Deliverable |
|--------|----------|-------------|
| 21 | UC-9.1-9.3 | Sharing features |
| 22 | UC-3.4 | Chat Branching |
| 23-24 | UC-10 | Responsive Layout polish |
| 25 | UC-11 | Accessibility |
| 26+ | Polish | Final refinements |

**Exit Criteria:**
- All platforms polished
- Accessibility compliant
- Sharing functional
- All features complete

### Risk Assessment:

**Technical Risks:**

| Risk | Impact | Likelihood | Mitigation |
|------|--------|------------|------------|
| API provider changes | High | Medium | Abstraction layer, multiple providers |
| Performance at scale | High | Medium | Early optimization, profiling |
| Security vulnerabilities | Critical | Low | Security review, penetration testing |
| Platform-specific issues | Medium | High | Platform testing matrix |

**User Experience Risks:**

| Risk | Impact | Likelihood | Mitigation |
|------|--------|------------|------------|
| Complex onboarding | High | Medium | User testing, simplification |
| Confusing workflow builder | High | High | Templates, tutorials, wizard mode |
| Agent misbehavior | High | Medium | Guardrails, approval system |
| Feature overload | Medium | Medium | Progressive disclosure, clean UI |

### Success Metrics:

**Phase 1 Success:**
- 80% of users complete onboarding
- 90% of configured agents work correctly
- Average time to first agent chat < 5 minutes

**Phase 2 Success:**
- 60% of users configure multiple providers
- 95% of approval requests understood by users
- Command bar usage by 40% of users

**Phase 3 Success:**
- 30% of users create a workflow
- 20% of chats use multi-agent
- Output gallery accessed weekly by 50% of users

**Phase 4 Success:**
- App Store rating > 4.5
- WCAG 2.1 AA compliance
- 10% of users share content

### Resource Allocation:

**Team Requirements:**
- 2 Flutter developers (full-time)
- 1 Backend developer (part-time for API integration)
- 1 Designer (part-time for UI/UX)
- 1 QA tester (part-time)

**Technology Stack:**
- Flutter (cross-platform UI)
- Riverpod/Bloc (state management)
- Hive/SQLite (local storage)
- Supabase/Firebase (cloud sync, optional)
- Multiple LLM APIs (OpenAI, Anthropic, etc.)

### Dependencies Map:

```
UC-1.1 (Welcome/Keys)
    └── UC-1.2 (Create First Agent)
    └── UC-8.1 (Key Manager)

UC-2.1 (Dashboard)
    └── UC-3.1 (Single Agent Chat)
        └── UC-3.3 (Inline Approvals)
        └── UC-3.2 (Multi-Agent Chat)
        └── UC-3.4 (Chat Branching)

UC-4.1 (Agent Profile Editor)
    └── UC-4.2 (Templates)
    └── UC-3.1 (Single Agent Chat - agent config)

UC-5.1 (Workflow Builder)
    ├── UC-5.2 (Workflow Templates)
    └── UC-5.3 (Workflow Execution)
        └── UC-3.3 (Inline Approvals - in workflow)

UC-6.1 (Command Bar)
    └── UC-2.1 (Dashboard - agents list)
    └── UC-3.1 (Chat - agent routing)
    └── UC-5.3 (Workflow Execution - run workflows)

UC-7.1 (Notifications)
    └── All features (notification triggers)

UC-7.2 (Output Gallery)
    └── UC-3.1 (Chat - outputs)

UC-9.x (Sharing)
    └── UC-4.1 (Agent config)
    └── UC-5.1 (Workflow config)
    └── UC-3.1 (Chat history)

UC-10 (Responsive)
    └── All features (platform adaptation)

UC-11 (Accessibility)
    └── All features (a11y support)
```

### Release Planning:

**Alpha Release (End of Phase 1):**
- Core functionality only
- Internal testing
- Limited to team and select testers

**Beta Release (End of Phase 2):**
- Production-ready core features
- Public testing
- Feedback collection

**v1.0 Release (End of Phase 3):**
- Full feature set
- Public launch
- App store submission

**v1.x Updates (Phase 4+):**
- Polish and refinements
- Community features
- Platform-specific enhancements

## ZFA Architecture Requirements

### Core ZFA Commands for All Development

All entities and Clean Architecture code MUST be generated using ZFA:

**Entity Creation:**
```bash
# Create entity with Zorphy
zfa entity create -n EntityName --field "field1:Type,field2:Type?" --json

# Create enum
zfa entity enum -n EnumName --value value1,value2,value3
```

**Clean Architecture Generation:**
```bash
# Full CRUD with data layer, view, presenter, controller, state
zfa generate EntityName --methods=get,getList,create,update,delete --data --vpc --state

# Read-only with state
zfa generate EntityName --methods=get,getList --data --vpc --state

# Custom usecase
zfa generate CustomUseCase --type=usecase --returns=EntityName
```

### Master Entity List

All entities required for Leblebi:

| Entity | ZFA Command |
|--------|-------------|
| Provider | `zfa entity create -n Provider --field "id:String,name:String,type:String,apiKey:String?,baseUrl:String?,status:String,isDefault:bool,isValidated:bool,lastUsed:DateTime?,createdAt:DateTime,updatedAt:DateTime" --json` |
| Agent | `zfa entity create -n Agent --field "id:String,name:String,avatar:String?,description:String?,status:String,systemPrompt:String,temperature:double,maxTokens:int,providerId:String,model:String,tools:List<String>,permissions:Map<String,dynamic>,memory:Map<String,dynamic>,templateSource:String?,createdAt:DateTime,updatedAt:DateTime" --json` |
| Chat | `zfa entity create -n Chat --field "id:String,agentId:String,title:String?,lastMessageAt:DateTime,unreadCount:int,createdAt:DateTime" --json` |
| Message | `zfa entity create -n Message --field "id:String,chatId:String,senderType:String,senderId:String,senderName:String,content:String,contentType:String,attachments:List<Map<String,dynamic>>?,metadata:Map<String,dynamic>?,createdAt:DateTime" --json` |
| Workflow | `zfa entity create -n Workflow --field "id:String,name:String,description:String?,nodes:List<Map<String,dynamic>>,connections:List<Map<String,dynamic>>,viewportX:double,viewportY:double,viewportZoom:double,createdAt:DateTime,updatedAt:DateTime" --json` |
| Notification | `zfa entity create -n Notification --field "id:String,type:String,title:String,message:String,agentId:String?,workflowId:String?,deepLink:String?,isRead:bool,createdAt:DateTime" --json` |
| Output | `zfa entity create -n Output --field "id:String,title:String,type:String,content:String,sourceAgentId:String,sourceChatId:String?,preview:String?,wordCount:int,characterCount:int,tags:List<String>,isFavorite:bool,folderId:String?,attachments:List<Map<String,dynamic>>?,createdAt:DateTime,updatedAt:DateTime" --json` |
| Tool | `zfa entity create -n Tool --field "id:String,name:String,type:String,category:String,description:String,icon:String,enabled:bool,status:String,config:Map<String,dynamic>?,permissions:List<String>,usedByAgentIds:List<String>,createdAt:DateTime" --json` |

### Development Workflow

1. **Create Entity**: `zfa entity create -n EntityName --field "..."`
2. **Generate Architecture**: `zfa generate EntityName --methods=... --data --vpc --state`
3. **Build Generated Code**: `zfa build`
4. **Implement Data Source**: Fill in TODO methods in `*_remote_data_source.dart`
5. **Customize View**: Update `*_view.dart` with UI implementation
6. **Register DI**: Add repository to dependency injection

### ZFA Configuration (.zfa.json)

```json
{
  "zorphyByDefault": true,
  "jsonByDefault": true,
  "compareByDefault": true,
  "filterByDefault": true,
  "defaultEntityOutput": "lib/src/domain/entities",
  "gqlByDefault": false,
  "buildByDefault": true,
  "formatByDefault": true,
  "diByDefault": true
}
```

