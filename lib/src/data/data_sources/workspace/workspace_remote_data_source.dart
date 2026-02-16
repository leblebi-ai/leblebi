import 'package:zuraffa/zuraffa.dart';

import '../../../domain/entities/workspace/workspace.dart';
import 'workspace_data_source.dart';

class WorkspaceRemoteDataSource
    with Loggable, FailureHandler
    implements WorkspaceDataSource {
  @override
  Future<Workspace> get(QueryParams<Workspace> params) async {
    throw UnimplementedError('Implement remote get');
  }

  @override
  Future<List<Workspace>> getList(ListQueryParams<Workspace> params) async {
    throw UnimplementedError('Implement remote getList');
  }

  @override
  Future<Workspace> create(Workspace workspace) async {
    throw UnimplementedError('Implement remote create');
  }

  @override
  Future<Workspace> update(
    UpdateParams<String, Partial<Workspace>> params,
  ) async {
    throw UnimplementedError('Implement remote update');
  }

  @override
  Future<void> delete(DeleteParams<String> params) async {
    throw UnimplementedError('Implement remote delete');
  }
}
