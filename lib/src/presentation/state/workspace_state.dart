import '../../domain/entities/workspace/workspace.dart';

/// Represents the state of the workspace list view
class WorkspaceState {
  WorkspaceState({
    this.workspaces = const [],
    this.isLoading = false,
    this.isCreating = false,
    this.isUpdating = false,
    this.isDeleting = false,
    this.error,
    this.selectedWorkspace,
  });

  /// List of workspaces to display
  final List<Workspace> workspaces;

  /// Whether the workspace list is currently loading
  final bool isLoading;

  /// Whether a workspace is being created
  final bool isCreating;

  /// Whether a workspace is being updated
  final bool isUpdating;

  /// Whether a workspace is being deleted
  final bool isDeleting;

  /// Error message if any operation failed
  final String? error;

  /// Currently selected workspace (for switching)
  final Workspace? selectedWorkspace;

  /// Active workspaces (not deleted)
  List<Workspace> get activeWorkspaces =>
      workspaces.where((w) => w.deletedAt == null).toList();

  /// Deleted workspaces (in trash)
  List<Workspace> get deletedWorkspaces =>
      workspaces.where((w) => w.deletedAt != null).toList();

  /// Create a copy of this state with updated fields
  WorkspaceState copyWith({
    List<Workspace>? workspaces,
    bool? isLoading,
    bool? isCreating,
    bool? isUpdating,
    bool? isDeleting,
    String? error,
    Workspace? selectedWorkspace,
  }) {
    return WorkspaceState(
      workspaces: workspaces ?? this.workspaces,
      isLoading: isLoading ?? this.isLoading,
      isCreating: isCreating ?? this.isCreating,
      isUpdating: isUpdating ?? this.isUpdating,
      isDeleting: isDeleting ?? this.isDeleting,
      error: error ?? this.error,
      selectedWorkspace: selectedWorkspace ?? this.selectedWorkspace,
    );
  }

  @override
  String toString() {
    return 'WorkspaceState(workspaces: ${workspaces.length}, isLoading: $isLoading, error: $error)';
  }
}
