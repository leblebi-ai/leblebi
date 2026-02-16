import 'package:zuraffa/zuraffa.dart';

import '../../entities/workspace/workspace.dart';
import '../../repositories/workspace_repository.dart';

class GetWorkspaceUseCase extends UseCase<Workspace, QueryParams<Workspace>> {
  GetWorkspaceUseCase(this._repository);

  final WorkspaceRepository _repository;

  @override
  Future<Workspace> execute(
    QueryParams<Workspace> params,
    CancelToken? cancelToken,
  ) async {
    cancelToken?.throwIfCancelled();
    return _repository.get(params);
  }
}
