import 'package:zuraffa/zuraffa.dart';

import '../../domain/entities/workspace/workspace.dart';
import '../../domain/repositories/workspace_repository.dart';
import '../data_sources/workspace/workspace_data_source.dart';

class DataWorkspaceRepository
    with Loggable, FailureHandler
    implements WorkspaceRepository {
  DataWorkspaceRepository(this._dataSource);

  final WorkspaceDataSource _dataSource;

  @override
  Future<Workspace> get(QueryParams<Workspace> params) {
    return _dataSource.get(params);
  }

  @override
  Future<List<Workspace>> getList(ListQueryParams<Workspace> params) {
    return _dataSource.getList(params);
  }

  @override
  Future<Workspace> create(Workspace workspace) {
    return _dataSource.create(workspace);
  }

  @override
  Future<Workspace> update(UpdateParams<String, Partial<Workspace>> params) {
    return _dataSource.update(params);
  }

  @override
  Future<void> delete(DeleteParams<String> params) {
    return _dataSource.delete(params);
  }
}
