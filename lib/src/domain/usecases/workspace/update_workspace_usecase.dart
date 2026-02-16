import 'package:zuraffa/zuraffa.dart';

import '../../entities/workspace/workspace.dart';
import '../../repositories/workspace_repository.dart';

class UpdateWorkspaceUseCase
    extends UseCase<Workspace, UpdateParams<String, Partial<Workspace>>> {
  UpdateWorkspaceUseCase(this._repository);

  final WorkspaceRepository _repository;

  @override
  Future<Workspace> execute(
    UpdateParams<String, Partial<Workspace>> params,
    CancelToken? cancelToken,
  ) async {
    cancelToken?.throwIfCancelled();
    return _repository.update(params);
  }
}
