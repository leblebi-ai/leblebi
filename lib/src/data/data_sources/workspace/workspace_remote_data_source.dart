import 'dart:convert';

import 'package:zuraffa/zuraffa.dart';

import '../../../domain/entities/workspace/workspace.dart';
import '../../../domain/entities/workspace_identity/workspace_identity.dart';
import '../remote/zeroclaw_rest_api.dart';

abstract class WorkspaceDataSource {
  Future<Workspace> get(QueryParams<Workspace> params);
  Future<List<Workspace>> getList(ListQueryParams<Workspace> params);
  Future<Workspace> create(Workspace workspace);
  Future<Workspace> update(UpdateParams<String, Partial<Workspace>> params);
  Future<void> delete(DeleteParams<String> params);
  Future<Workspace> restore(DeleteParams<String> params);
  Future<void> permanentDelete(DeleteParams<String> params);
  Future<int> purgeExpiredTrash();
}

class WorkspaceRemoteDataSource implements WorkspaceDataSource {
  WorkspaceRemoteDataSource({
    required ZeroClawRestApi api,
    required String baseUrl,
    required String token,
  })  : _api = api,
        _baseUrl = baseUrl,
        _token = token;

  final ZeroClawRestApi _api;
  final String _baseUrl;
  final String _token;

  @override
  Future<Workspace> get(QueryParams<Workspace> params) async {
    final workspaceId = params.id;
    final data = await _api.getWorkspace(_baseUrl, _token, workspaceId);
    return _mapToWorkspace(data);
  }

  @override
  Future<List<Workspace>> getList(ListQueryParams<Workspace> params) async {
    final includeDeleted = params.params?['include_deleted'] as bool? ?? false;
    final data = await _api.getWorkspaces(
      _baseUrl,
      _token,
      includeDeleted: includeDeleted,
    );
    return data.map(_mapToWorkspace).toList();
  }

  @override
  Future<Workspace> create(Workspace workspace) async {
    final data = await _api.createWorkspace(
      _baseUrl,
      _token,
      _mapToWorkspaceData(workspace),
    );
    return _mapToWorkspace(data);
  }

  @override
  Future<Workspace> update(
    UpdateParams<String, Partial<Workspace>> params,
  ) async {
    final workspaceId = params.id;
    final data = await _api.updateWorkspace(
      _baseUrl,
      _token,
      workspaceId,
      params.data as Map<String, dynamic>,
    );
    return _mapToWorkspace(data);
  }

  @override
  Future<void> delete(DeleteParams<String> params) async {
    await _api.deleteWorkspace(_baseUrl, _token, params.id);
  }

  @override
  Future<Workspace> restore(DeleteParams<String> params) async {
    final data = await _api.restoreWorkspace(_baseUrl, _token, params.id);
    return _mapToWorkspace(data);
  }

  @override
  Future<void> permanentDelete(DeleteParams<String> params) async {
    await _api.permanentDeleteWorkspace(_baseUrl, _token, params.id);
  }

  @override
  Future<int> purgeExpiredTrash() async {
    return await _api.purgeExpiredTrash(_baseUrl, _token);
  }

  /// Get conversations by workspace
  Future<List<Map<String, dynamic>>> getConversationsByWorkspace(
    String workspaceId,
  ) async {
    return await _api.getConversationsByWorkspace(
      _baseUrl,
      _token,
      workspaceId,
    );
  }

  Workspace _mapToWorkspace(Map<String, dynamic> data) {
    final identityData = data['identity'] as Map<String, dynamic>;
    return Workspace(
      id: data['id'] as String,
      identity: WorkspaceIdentity(
        name: identityData['name'] as String,
        persona: identityData['persona'] as String?,
        systemPrompt: identityData['systemPrompt'] as String?,
        toolConfigs: identityData['toolConfigs'] as Map<String, dynamic>?,
      ),
      gatewayConnectionId: data['gatewayConnectionId'] as String,
      createdAt: DateTime.parse(data['createdAt'] as String),
      updatedAt: data['updatedAt'] != null
          ? DateTime.parse(data['updatedAt'] as String)
          : null,
      deletedAt: data['deletedAt'] != null
          ? DateTime.parse(data['deletedAt'] as String)
          : null,
    );
  }

  Map<String, dynamic> _mapToWorkspaceData(Workspace workspace) {
    return {
      'identity': {
        'name': workspace.identity.name,
        if (workspace.identity.persona != null)
          'persona': workspace.identity.persona,
        if (workspace.identity.systemPrompt != null)
          'systemPrompt': workspace.identity.systemPrompt,
        if (workspace.identity.toolConfigs != null)
          'toolConfigs': workspace.identity.toolConfigs,
      },
      'gatewayConnectionId': workspace.gatewayConnectionId,
    };
  }
}
