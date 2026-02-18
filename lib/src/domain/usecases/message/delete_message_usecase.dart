import 'package:zuraffa/zuraffa.dart';

import '../../repositories/message_repository.dart';

class DeleteMessageUseCase extends CompletableUseCase<DeleteParams<String>> {
  DeleteMessageUseCase(this._repository);

  final MessageRepository _repository;

  @override
  Future<void> execute(
    DeleteParams<String> params,
    CancelToken? cancelToken,
  ) async {
    cancelToken?.throwIfCancelled();
    return _repository.delete(params);
  }
}
