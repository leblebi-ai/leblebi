import 'package:zuraffa/zuraffa.dart';

import '../../entities/conversation/conversation.dart';
import '../../repositories/conversation_repository.dart';

class CreateConversationUseCase extends UseCase<Conversation, Conversation> {
  CreateConversationUseCase(this._repository);

  final ConversationRepository _repository;

  @override
  Future<Conversation> execute(
    Conversation params,
    CancelToken? cancelToken,
  ) async {
    cancelToken?.throwIfCancelled();
    return _repository.create(params);
  }
}
