# Quickstart: Multi-Agent Workspace Management

**Feature**: 003-us2-multi-agent-workspace  
**Date**: 2026-02-18  
**Audience**: Developers implementing the feature

---

## Overview

This guide provides step-by-step instructions for implementing multi-agent workspace management. Follow the phases in order for incremental delivery.

---

## Prerequisites

- ✅ US1 (Connect and Chat) completed
- ✅ Flutter SDK 3.24.0+ installed
- ✅ Zuraffa CLI installed (`dart pub global activate zuraffa`)
- ✅ macOS for development (primary platform)

---

## Phase 1: Entity & Repository Setup

### Step 1: Create Workspace Entity

```bash
# Create Workspace entity with Zuraffa
zuraffa_entity_create \
  --name Workspace \
  --json \
  --compare \
  --fields "identity:WorkspaceIdentity" \
  --fields "gatewayConnectionId:String" \
  --fields "createdAt:DateTime" \
  --fields "updatedAt:DateTime?" \
  --fields "deletedAt:DateTime?"

# Create WorkspaceIdentity value object
zuraffa_entity_create \
  --name WorkspaceIdentity \
  --json \
  --fields "name:String" \
  --fields "persona:String?" \
  --fields "systemPrompt:String?" \
  --fields "toolConfigs:Map<String,dynamic>?"
```

### Step 2: Update Conversation Entity

```bash
# Add workspaceId field to existing Conversation entity
zuraffa_entity_add_field \
  --name Conversation \
  --fields "workspaceId:String"
```

### Step 3: Generate Serialization Code

```bash
# Run build_runner to generate .g.dart files
flutter pub run build_runner build --delete-conflicting-outputs
```

### Step 4: Create Repository Interface

```bash
# Create WorkspaceRepository interface
zuraffa_repository_create \
  --name Workspace \
  --methods "get" "list" "create" "update" "delete"
```

### Step 5: Create UseCases

```bash
# Generate CRUD UseCases
zfa generate \
  --name Workspace \
  --methods "get" "list" "create" "update" "delete" \
  --di \
  --test
```

---

## Phase 2: Data Layer Implementation

### Step 1: Implement Hive Datasource

```dart
// lib/src/data/datasources/local/hive_datasource.dart
class HiveDatasource {
  static const String workspacesBox = 'workspaces';
  
  Future<void> init() async {
    await Hive.openBox<Workspace>(workspacesBox);
    // Register type adapters
    Hive.registerAdapter(WorkspaceAdapter());
    Hive.registerAdapter(WorkspaceIdentityAdapter());
  }
  
  // Workspace CRUD operations
  Future<List<Workspace>> getWorkspaces() async {
    final box = Hive.box<Workspace>(workspacesBox);
    return box.values.toList();
  }
  
  Future<Workspace?> getWorkspace(String id) async {
    final box = Hive.box<Workspace>(workspacesBox);
    return box.get(id);
  }
  
  Future<void> saveWorkspace(Workspace workspace) async {
    final box = Hive.box<Workspace>(workspacesBox);
    await box.put(workspace.id, workspace);
  }
  
  Future<void> deleteWorkspace(String id) async {
    final box = Hive.box<Workspace>(workspacesBox);
    await box.delete(id);
  }
}
```

### Step 2: Implement Repository

```dart
// lib/src/data/repositories/workspace_repository_impl.dart
class WorkspaceRepositoryImpl implements WorkspaceRepository {
  final HiveDatasource _hiveDatasource;
  final SecureStorageDatasource _secureStorage;
  
  WorkspaceRepositoryImpl(this._hiveDatasource, this._secureStorage);
  
  @override
  Future<Workspace> create(Workspace workspace) async {
    await _hiveDatasource.saveWorkspace(workspace);
    return workspace;
  }
  
  @override
  Future<Workspace?> get(String id) async {
    return await _hiveDatasource.getWorkspace(id);
  }
  
  @override
  Future<List<Workspace>> getList() async {
    final workspaces = await _hiveDatasource.getWorkspaces();
    // Return only active workspaces
    return workspaces.where((w) => w.isActive).toList();
  }
  
  @override
  Future<List<Workspace>> getAllWithDeleted() async {
    return await _hiveDatasource.getWorkspaces();
  }
  
  @override
  Future<void> delete(String id) async {
    final workspace = await get(id);
    if (workspace == null) throw Exception('Workspace not found');
    
    // Soft delete: set deletedAt
    final updated = workspace.copyWith(deletedAt: DateTime.now());
    await _hiveDatasource.saveWorkspace(updated);
  }
  
  @override
  Future<Workspace> restore(String id) async {
    final workspace = await get(id);
    if (workspace == null) throw Exception('Workspace not found');
    
    // Restore: clear deletedAt
    final updated = workspace.copyWith(deletedAt: null);
    await _hiveDatasource.saveWorkspace(updated);
    return updated;
  }
  
  @override
  Future<void> permanentDelete(String id) async {
    // Delete workspace
    await _hiveDatasource.deleteWorkspace(id);
    
    // Delete associated secure storage credentials
    await _secureStorage.deleteValue('gateway_token_$id');
    await _secureStorage.deleteValue('gateway_url_$id');
    
    // Cascade delete: conversations and messages handled by their repositories
  }
  
  @override
  Future<int> purgeExpiredTrash() async {
    final workspaces = await getAllWithDeleted();
    final expired = workspaces.where((w) => 
      w.deletedAt != null && 
      DateTime.now().difference(w.deletedAt!).inDays > 30
    );
    
    int count = 0;
    for (final workspace in expired) {
      await permanentDelete(workspace.id);
      count++;
    }
    
    return count;
  }
  
  // ... implement update method
}
```

---

## Phase 3: Presentation Layer

### Step 1: Create Workspace State

```dart
// lib/src/presentation/state/workspace_state.dart
class WorkspaceState {
  final List<Workspace> workspaces;
  final List<Workspace> trashWorkspaces;
  final String? activeWorkspaceId;
  final bool isLoading;
  final String? error;
  
  WorkspaceState({
    this.workspaces = const [],
    this.trashWorkspaces = const [],
    this.activeWorkspaceId,
    this.isLoading = false,
    this.error,
  });
  
  WorkspaceState copyWith({
    List<Workspace>? workspaces,
    List<Workspace>? trashWorkspaces,
    String? activeWorkspaceId,
    bool? isLoading,
    String? error,
  }) {
    return WorkspaceState(
      workspaces: workspaces ?? this.workspaces,
      trashWorkspaces: trashWorkspaces ?? this.trashWorkspaces,
      activeWorkspaceId: activeWorkspaceId ?? this.activeWorkspaceId,
      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error,
    );
  }
}
```

### Step 2: Create Workspace Controller

```dart
// lib/src/presentation/controllers/workspace_controller.dart
class WorkspaceController extends StatefulController<WorkspaceState> {
  final GetWorkspaceListUseCase _getWorkspaceListUseCase;
  final GetWorkspaceUseCase _getWorkspaceUseCase;
  final CreateWorkspaceUseCase _createWorkspaceUseCase;
  final DeleteWorkspaceUseCase _deleteWorkspaceUseCase;
  final RestoreWorkspaceUseCase _restoreWorkspaceUseCase;
  
  WorkspaceController({
    required GetWorkspaceListUseCase getWorkspaceListUseCase,
    required GetWorkspaceUseCase getWorkspaceUseCase,
    required CreateWorkspaceUseCase createWorkspaceUseCase,
    required DeleteWorkspaceUseCase deleteWorkspaceUseCase,
    required RestoreWorkspaceUseCase restoreWorkspaceUseCase,
  })  : _getWorkspaceListUseCase = getWorkspaceListUseCase,
        _getWorkspaceUseCase = getWorkspaceUseCase,
        _createWorkspaceUseCase = createWorkspaceUseCase,
        _deleteWorkspaceUseCase = deleteWorkspaceUseCase,
        _restoreWorkspaceUseCase = restoreWorkspaceUseCase;
  
  @override
  void onInit() {
    super.onInit();
    loadWorkspaces();
  }
  
  Future<void> loadWorkspaces() async {
    setState((s) => s.copyWith(isLoading: true, error: null));
    try {
      final workspaces = await _getWorkspaceListUseCase.execute(NoParams(), null);
      final trashWorkspaces = await _getTrashUseCase.execute(NoParams(), null);
      setState((s) => s.copyWith(
        workspaces: workspaces,
        trashWorkspaces: trashWorkspaces,
        isLoading: false,
      ));
    } catch (e) {
      setState((s) => s.copyWith(error: e.toString(), isLoading: false));
    }
  }
  
  Future<void> createWorkspace(String name, String gatewayConnectionId) async {
    setState((s) => s.copyWith(isLoading: true, error: null));
    try {
      final workspace = await _createWorkspaceUseCase.execute(
        CreateWorkspaceParams(name: name, gatewayConnectionId: gatewayConnectionId),
        null,
      );
      await loadWorkspaces();
      // Navigate to new workspace
    } catch (e) {
      setState((s) => s.copyWith(error: e.toString(), isLoading: false));
    }
  }
  
  Future<void> switchWorkspace(String workspaceId) async {
    setState((s) => s.copyWith(activeWorkspaceId: workspaceId, isLoading: true));
    // Load conversations for selected workspace
    // ... conversation loading logic
    setState((s) => s.copyWith(isLoading: false));
  }
  
  Future<void> deleteWorkspace(String id) async {
    setState((s) => s.copyWith(isLoading: true, error: null));
    try {
      await _deleteWorkspaceUseCase.execute(DeleteParams(id: id), null);
      await loadWorkspaces();
    } catch (e) {
      setState((s) => s.copyWith(error: e.toString(), isLoading: false));
    }
  }
  
  Future<void> restoreWorkspace(String id) async {
    setState((s) => s.copyWith(isLoading: true, error: null));
    try {
      await _restoreWorkspaceUseCase.execute(RestoreParams(id: id), null);
      await loadWorkspaces();
    } catch (e) {
      setState((s) => s.copyWith(error: e.toString(), isLoading: false));
    }
  }
}
```

### Step 3: Create Workspace List View

```dart
// lib/src/presentation/views/workspace_list_view.dart
class WorkspaceListView extends StatelessWidget {
  const WorkspaceListView({super.key});
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Workspaces'),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () => _showCreateDialog(context),
          ),
          IconButton(
            icon: const Icon(Icons.delete),
            onPressed: () => Navigator.pushNamed(context, '/trash'),
          ),
        ],
      ),
      body: Consumer<WorkspaceController>(
        builder: (context, controller, _) {
          final state = controller.state;
          
          if (state.isLoading && state.workspaces.isEmpty) {
            return const Center(child: CircularProgressIndicator());
          }
          
          if (state.error != null) {
            return Center(child: Text('Error: ${state.error}'));
          }
          
          if (state.workspaces.isEmpty) {
            return const Center(
              child: Text('No workspaces yet. Create one!'),
            );
          }
          
          return ListView.builder(
            itemCount: state.workspaces.length,
            itemBuilder: (context, index) {
              final workspace = state.workspaces[index];
              final isActive = workspace.id == state.activeWorkspaceId;
              
              return ListTile(
                leading: Icon(
                  isActive ? Icons.folder_open : Icons.folder,
                  color: isActive ? Theme.of(context).primaryColor : null,
                ),
                title: Text(workspace.identity.name),
                subtitle: Text('${workspace.identity.persona ?? 'No persona'}'),
                trailing: PopupMenuButton<String>(
                  onSelected: (value) {
                    switch (value) {
                      case 'switch':
                        controller.switchWorkspace(workspace.id);
                        break;
                      case 'delete':
                        _confirmDelete(context, workspace.id);
                        break;
                    }
                  },
                  itemBuilder: (context) => [
                    const PopupMenuItem(
                      value: 'switch',
                      child: Text('Switch to Workspace'),
                    ),
                    const PopupMenuItem(
                      value: 'delete',
                      child: Text('Delete', style: TextStyle(color: Colors.red)),
                    ),
                  ],
                ),
                onTap: () => controller.switchWorkspace(workspace.id),
              );
            },
          );
        },
      ),
    );
  }
  
  void _showCreateDialog(BuildContext context) {
    // Show dialog to create new workspace
    // ...
  }
  
  void _confirmDelete(BuildContext context, String workspaceId) {
    // Show confirmation dialog
    // ...
  }
}
```

---

## Phase 4: Dependency Injection

### Step 1: Register Repository

```dart
// lib/src/di/repositories/workspace_repository_di.dart
import 'package:get_it/get_it.dart';
import '../../domain/repositories/workspace_repository.dart';
import '../../data/repositories/workspace_repository_impl.dart';

void registerWorkspaceRepository(GetIt getIt) {
  getIt.registerLazySingleton<WorkspaceRepository>(
    () => WorkspaceRepositoryImpl(
      getIt<HiveDatasource>(),
      getIt<SecureStorageDatasource>(),
    ),
  );
}
```

### Step 2: Register UseCases

```dart
// lib/src/di/usecases/workspace_usecases_di.dart
import 'package:get_it/get_it.dart';
import '../../domain/usecases/create_workspace_usecase.dart';
import '../../domain/usecases/get_workspace_usecase.dart';
import '../../domain/usecases/get_workspace_list_usecase.dart';
import '../../domain/usecases/delete_workspace_usecase.dart';
import '../../domain/usecases/restore_workspace_usecase.dart';

void registerWorkspaceUseCases(GetIt getIt) {
  getIt.registerLazySingleton(() => CreateWorkspaceUseCase(
    getIt<WorkspaceRepository>(),
  ));
  
  getIt.registerLazySingleton(() => GetWorkspaceUseCase(
    getIt<WorkspaceRepository>(),
  ));
  
  getIt.registerLazySingleton(() => GetWorkspaceListUseCase(
    getIt<WorkspaceRepository>(),
  ));
  
  getIt.registerLazySingleton(() => DeleteWorkspaceUseCase(
    getIt<WorkspaceRepository>(),
  ));
  
  getIt.registerLazySingleton(() => RestoreWorkspaceUseCase(
    getIt<WorkspaceRepository>(),
  ));
}
```

### Step 3: Register Controller

```dart
// lib/src/di/controllers/workspace_controller_di.dart
import 'package:get_it/get_it.dart';
import '../../presentation/controllers/workspace_controller.dart';

void registerWorkspaceController(GetIt getIt) {
  getIt.registerFactory(
    () => WorkspaceController(
      getWorkspaceListUseCase: getIt<GetWorkspaceListUseCase>(),
      getWorkspaceUseCase: getIt<GetWorkspaceUseCase>(),
      createWorkspaceUseCase: getIt<CreateWorkspaceUseCase>(),
      deleteWorkspaceUseCase: getIt<DeleteWorkspaceUseCase>(),
      restoreWorkspaceUseCase: getIt<RestoreWorkspaceUseCase>(),
    ),
  );
}
```

---

## Phase 5: Background Job (Trash Purge)

### Step 1: Create Purge Job

```dart
// lib/src/jobs/purge_trash_job.dart
class PurgeTrashJob {
  final WorkspaceRepository _workspaceRepository;
  
  PurgeTrashJob(this._workspaceRepository);
  
  Future<void> execute() async {
    try {
      final count = await _workspaceRepository.purgeExpiredTrash();
      if (count > 0) {
        debugPrint('Purged $count expired workspaces from trash');
      }
    } catch (e) {
      debugPrint('Error purging trash: $e');
      // Don't rethrow - job should fail silently
    }
  }
}
```

### Step 2: Run on App Startup

```dart
// lib/main.dart
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  // Initialize dependencies
  await setupDependencies();
  
  // Run background jobs
  final purgeTrashJob = getIt<PurgeTrashJob>();
  await purgeTrashJob.execute();
  
  runApp(const MyApp());
}
```

---

## Testing

### Run Tests

```bash
# Unit tests
flutter test test/domain/usecases/

# Widget tests
flutter test test/presentation/views/

# Integration tests
flutter test test/integration/workspace_flow_test.dart
```

### Manual Testing on macOS

```bash
# Run app
flutter run -d macos

# Test scenarios:
# 1. Create workspace
# 2. Switch between workspaces
# 3. Delete workspace
# 4. Restore from trash
# 5. Verify 30-day purge (mock system date)
```

---

## Next Steps

After completing this feature:

1. ✅ Run `dart analyze && flutter test`
2. ✅ Commit after each task
3. ✅ Create GitHub issue with checkboxes
4. ✅ Create PR when all tasks complete
5. ✅ Proceed to US3 (Tool Integration)

---

## References

- Spec: `/specs/003-us2-multi-agent-workspace/spec.md`
- Data Model: `/specs/003-us2-multi-agent-workspace/data-model.md`
- Research: `/specs/003-us2-multi-agent-workspace/research.md`
- Constitution: `.specify/memory/constitution.md`
