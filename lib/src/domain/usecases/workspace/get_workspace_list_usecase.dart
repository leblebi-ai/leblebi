import 'package:zuraffa/zuraffa.dart';

import '../../entities/workspace/workspace.dart';
import '../../repositories/workspace_repository.dart';

class GetWorkspaceListUseCase
    extends UseCase<List<Workspace>, ListQueryParams<Workspace>> {
  GetWorkspaceListUseCase(this._repository);

  final WorkspaceRepository _repository;

  @override
  Future<List<Workspace>> execute(
    ListQueryParams<Workspace> params,
    CancelToken? cancelToken,
  ) async {
    cancelToken?.throwIfCancelled();
    return _repository.getList(params);
  }
}
