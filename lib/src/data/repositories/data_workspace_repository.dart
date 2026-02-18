import 'package:zuraffa/zuraffa.dart';

import '../../domain/entities/workspace/workspace.dart';
import '../../domain/repositories/workspace_repository.dart';
import '../data_sources/workspace/workspace_remote_data_source.dart';

class DataWorkspaceRepository
    with Loggable, FailureHandler
    implements WorkspaceRepository {
  DataWorkspaceRepository(this._remoteDataSource);

  final WorkspaceRemoteDataSource _remoteDataSource;

  @override
  Future<Workspace> get(QueryParams<Workspace> params) {
    return _remoteDataSource.get(params);
  }

  @override
  Future<List<Workspace>> getList(ListQueryParams<Workspace> params) {
    return _remoteDataSource.getList(params);
  }

  @override
  Future<Workspace> create(Workspace workspace) {
    return _remoteDataSource.create(workspace);
  }

  @override
  Future<Workspace> update(UpdateParams<String, Partial<Workspace>> params) {
    return _remoteDataSource.update(params);
  }

  @override
  Future<void> delete(DeleteParams<String> params) {
    return _remoteDataSource.delete(params);
  }

  @override
  Future<Workspace> restore(DeleteParams<String> params) {
    return _remoteDataSource.restore(params);
  }

  @override
  Future<void> permanentDelete(DeleteParams<String> params) {
    return _remoteDataSource.permanentDelete(params);
  }

  @override
  Future<int> purgeExpiredTrash() {
    return _remoteDataSource.purgeExpiredTrash();
  }
}
