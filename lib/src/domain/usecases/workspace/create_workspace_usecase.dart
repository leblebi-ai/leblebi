import 'package:zuraffa/zuraffa.dart';

import '../../entities/workspace/workspace.dart';
import '../../repositories/workspace_repository.dart';

class CreateWorkspaceUseCase extends UseCase<Workspace, Workspace> {
  CreateWorkspaceUseCase(this._repository);

  final WorkspaceRepository _repository;

  @override
  Future<Workspace> execute(Workspace params, CancelToken? cancelToken) async {
    cancelToken?.throwIfCancelled();
    return _repository.create(params);
  }
}
