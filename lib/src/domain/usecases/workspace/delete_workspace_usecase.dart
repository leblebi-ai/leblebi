import 'package:zuraffa/zuraffa.dart';

import '../../repositories/workspace_repository.dart';

class DeleteWorkspaceUseCase extends CompletableUseCase<DeleteParams<String>> {
  DeleteWorkspaceUseCase(this._repository);

  final WorkspaceRepository _repository;

  @override
  Future<void> execute(
    DeleteParams<String> params,
    CancelToken? cancelToken,
  ) async {
    cancelToken?.throwIfCancelled();
    return _repository.delete(params);
  }
}
