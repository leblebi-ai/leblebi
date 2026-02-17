import 'package:zuraffa/zuraffa.dart';

import '../../entities/conversation/conversation.dart';
import '../../repositories/conversation_repository.dart';

class UpdateConversationUseCase
    extends UseCase<Conversation, UpdateParams<String, Partial<Conversation>>> {
  UpdateConversationUseCase(this._repository);

  final ConversationRepository _repository;

  @override
  Future<Conversation> execute(
    UpdateParams<String, Partial<Conversation>> params,
    CancelToken? cancelToken,
  ) async {
    cancelToken?.throwIfCancelled();
    return _repository.update(params);
  }
}
