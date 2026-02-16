import 'package:zuraffa/zuraffa.dart';

import '../../../domain/entities/workspace/workspace.dart';

abstract class WorkspaceDataSource with Loggable, FailureHandler {
  Future<Workspace> get(QueryParams<Workspace> params);
  Future<List<Workspace>> getList(ListQueryParams<Workspace> params);
  Future<Workspace> create(Workspace workspace);
  Future<Workspace> update(UpdateParams<String, Partial<Workspace>> params);
  Future<void> delete(DeleteParams<String> params);
}
