import 'package:zuraffa/zuraffa.dart';

import '../../repositories/conversation_repository.dart';

class DeleteConversationUseCase
    extends CompletableUseCase<DeleteParams<String>> {
  DeleteConversationUseCase(this._repository);

  final ConversationRepository _repository;

  @override
  Future<void> execute(
    DeleteParams<String> params,
    CancelToken? cancelToken,
  ) async {
    cancelToken?.throwIfCancelled();
    return _repository.delete(params);
  }
}
