import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../di/service_locator.dart';
import '../../domain/entities/workspace/workspace.dart';
import '../../domain/usecases/workspace/create_workspace_usecase.dart';
import '../../domain/usecases/workspace/get_workspace_list_usecase.dart';
import '../../domain/usecases/workspace/get_workspace_usecase.dart';
import '../../domain/usecases/workspace/update_workspace_usecase.dart';
import '../../domain/usecases/workspace/delete_workspace_usecase.dart';
import '../controllers/workspace_controller.dart';
import '../state/workspace_state.dart';
import '../chat/chat_page.dart';

/// Main view for displaying and managing workspaces
class WorkspaceListView extends StatelessWidget {
  const WorkspaceListView({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => WorkspaceController(
        getIt<GetWorkspaceListUseCase>(),
        getIt<GetWorkspaceUseCase>(),
        getIt<CreateWorkspaceUseCase>(),
        getIt<UpdateWorkspaceUseCase>(),
        getIt<DeleteWorkspaceUseCase>(),
      )..loadWorkspaces(),
      child: const _WorkspaceListContent(),
    );
  }
}

class _WorkspaceListContent extends StatelessWidget {
  const _WorkspaceListContent();

  @override
  Widget build(BuildContext context) {
    final controller = context.watch<WorkspaceController>();
    final state = controller.state;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Workspaces'),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () => controller.refresh(),
          ),
          PopupMenuButton<String>(
            onSelected: (value) async {
              if (value == 'trash') {
                _showSnackBar(context, 'Trash view coming soon');
              } else if (value == 'logout') {
                await _disconnect(context);
              }
            },
            itemBuilder: (BuildContext context) {
              return [
                const PopupMenuItem<String>(
                  value: 'trash',
                  child: Row(
                    children: [
                      Icon(Icons.delete),
                      SizedBox(width: 8),
                      Text('Trash'),
                    ],
                  ),
                ),
                const PopupMenuItem<String>(
                  value: 'logout',
                  child: Row(
                    children: [
                      Icon(Icons.logout, color: Colors.red),
                      SizedBox(width: 8),
                      Text('Disconnect', style: TextStyle(color: Colors.red)),
                    ],
                  ),
                ),
              ];
            },
          ),
        ],
      ),
      body: _buildBody(context, state),
      floatingActionButton: FloatingActionButton(
        onPressed: state.isLoading ? null : () => _showCreateDialog(context),
        tooltip: 'Create Workspace',
        child: const Icon(Icons.add),
      ),
    );
  }

  Widget _buildBody(BuildContext context, WorkspaceState state) {
    if (state.isLoading && state.workspaces.isEmpty) {
      return const Center(child: CircularProgressIndicator());
    }

    if (state.error != null && state.workspaces.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.error_outline, size: 48, color: Colors.red[300]),
            const SizedBox(height: 16),
            Text(
              state.error!,
              style: const TextStyle(color: Colors.red),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16),
            FilledButton(
              onPressed: () => context.read<WorkspaceController>().refresh(),
              child: const Text('Retry'),
            ),
          ],
        ),
      );
    }

    if (state.activeWorkspaces.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.folder_open, size: 48, color: Colors.grey[400]),
            const SizedBox(height: 16),
            Text(
              'No workspaces yet',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(height: 8),
            Text(
              'Tap + to create your first workspace',
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: Colors.grey[600],
              ),
            ),
          ],
        ),
      );
    }

    return RefreshIndicator(
      onRefresh: () => context.read<WorkspaceController>().refresh(),
      child: ListView.builder(
        padding: const EdgeInsets.all(8),
        itemCount: state.activeWorkspaces.length,
        itemBuilder: (context, index) {
          final workspace = state.activeWorkspaces[index];
          return _WorkspaceCard(
            workspace: workspace,
            isSelected: state.selectedWorkspace?.id == workspace.id,
            onTap: () => _openWorkspace(context, workspace),
            onDelete: () => _confirmDelete(context, workspace),
          );
        },
      ),
    );
  }

  void _showCreateDialog(BuildContext context) {
    final nameController = TextEditingController();
    final personaController = TextEditingController();
    final systemPromptController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Create Workspace'),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: nameController,
                decoration: const InputDecoration(
                  labelText: 'Name',
                  hintText: 'My Workspace',
                  border: OutlineInputBorder(),
                ),
                autofocus: true,
              ),
              const SizedBox(height: 16),
              TextField(
                controller: personaController,
                decoration: const InputDecoration(
                  labelText: 'Persona (optional)',
                  hintText: 'Helpful Assistant',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 16),
              TextField(
                controller: systemPromptController,
                decoration: const InputDecoration(
                  labelText: 'System Prompt (optional)',
                  hintText: 'You are a helpful assistant...',
                  border: OutlineInputBorder(),
                ),
                maxLines: 3,
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          Consumer<WorkspaceController>(
            builder: (context, controller, _) {
              return FilledButton(
                onPressed: controller.state.isCreating ? null : () async {
                  if (nameController.text.trim().isEmpty) {
                    _showSnackBar(context, 'Please enter a name');
                    return;
                  }

                  final workspace = await controller.createWorkspace(
                    name: nameController.text.trim(),
                    persona: personaController.text.trim().isEmpty
                        ? null
                        : personaController.text.trim(),
                    systemPrompt: systemPromptController.text.trim().isEmpty
                        ? null
                        : systemPromptController.text.trim(),
                    gatewayConnectionId: 'default',
                  );

                  if (workspace != null && context.mounted) {
                    Navigator.pop(context);
                    _showSnackBar(context, 'Workspace created successfully');
                  } else if (context.mounted) {
                    _showSnackBar(
                      context,
                      'Failed to create workspace',
                      isError: true,
                    );
                  }
                },
                child: controller.state.isCreating
                    ? const SizedBox(
                        width: 16,
                        height: 16,
                        child: CircularProgressIndicator(strokeWidth: 2),
                      )
                    : const Text('Create'),
              );
            },
          ),
        ],
      ),
    ).then((_) {
      nameController.dispose();
      personaController.dispose();
      systemPromptController.dispose();
    });
  }

  void _confirmDelete(BuildContext context, Workspace workspace) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Delete Workspace'),
        content: Text(
          'Are you sure you want to delete "${workspace.identity.name}"? '
          'This will move it to trash.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          FilledButton(
            style: FilledButton.styleFrom(backgroundColor: Colors.red),
            onPressed: () async {
              final controller = context.read<WorkspaceController>();
              final success = await controller.deleteWorkspace(workspace.id);
              
              if (context.mounted) {
                Navigator.pop(context);
                if (success) {
                  _showSnackBar(context, 'Workspace moved to trash');
                } else {
                  _showSnackBar(
                    context,
                    'Failed to delete workspace',
                    isError: true,
                  );
                }
              }
            },
            child: const Text('Delete'),
          ),
        ],
      ),
    );
  }

  void _openWorkspace(BuildContext context, Workspace workspace) {
    Navigator.of(context).push(
      MaterialPageRoute(builder: (_) => const ChatPage()),
    );
  }

  Future<void> _disconnect(BuildContext context) async {
    final confirm = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Disconnect'),
        content: const Text(
          'Are you sure you want to disconnect from this gateway?',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context, true),
            child: const Text('Disconnect', style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );

    if (confirm == true && context.mounted) {
      _showSnackBar(context, 'Disconnect coming soon');
    }
  }

  void _showSnackBar(BuildContext context, String message, {bool isError = false}) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: isError ? Colors.red : null,
      ),
    );
  }
}

/// Individual workspace card widget
class _WorkspaceCard extends StatelessWidget {
  const _WorkspaceCard({
    required this.workspace,
    required this.isSelected,
    required this.onTap,
    required this.onDelete,
  });

  final Workspace workspace;
  final bool isSelected;
  final VoidCallback onTap;
  final VoidCallback onDelete;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
      color: isSelected ? Theme.of(context).colorScheme.primaryContainer : null,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Row(
            children: [
              // Workspace icon
              Container(
                width: 48,
                height: 48,
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.primary.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(
                  isSelected ? Icons.folder_open : Icons.folder,
                  color: Theme.of(context).colorScheme.primary,
                ),
              ),
              const SizedBox(width: 12),
              // Workspace info
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      workspace.identity.name,
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    if (workspace.identity.persona != null &&
                        workspace.identity.persona!.isNotEmpty) ...[
                      const SizedBox(height: 4),
                      Text(
                        workspace.identity.persona!,
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: Colors.grey[600],
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                    const SizedBox(height: 4),
                    Text(
                      'Created ${_formatDate(workspace.createdAt)}',
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: Colors.grey[500],
                      ),
                    ),
                  ],
                ),
              ),
              // Actions menu
              PopupMenuButton<String>(
                onSelected: (value) {
                  if (value == 'delete') {
                    onDelete();
                  }
                },
                itemBuilder: (BuildContext context) {
                  return [
                    const PopupMenuItem<String>(
                      value: 'delete',
                      child: Row(
                        children: [
                          Icon(Icons.delete, color: Colors.red),
                          SizedBox(width: 8),
                          Text('Delete', style: TextStyle(color: Colors.red)),
                        ],
                      ),
                    ),
                  ];
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  String _formatDate(DateTime date) {
    final now = DateTime.now();
    final diff = now.difference(date);

    if (diff.inDays == 0) {
      return 'today';
    } else if (diff.inDays == 1) {
      return 'yesterday';
    } else if (diff.inDays < 7) {
      return '${diff.inDays} days ago';
    } else {
      return '${date.day}/${date.month}/${date.year}';
    }
  }
}
