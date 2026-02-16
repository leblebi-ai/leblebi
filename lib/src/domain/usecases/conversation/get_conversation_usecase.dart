import 'package:zuraffa/zuraffa.dart';

import '../../entities/conversation/conversation.dart';
import '../../repositories/conversation_repository.dart';

class GetConversationUseCase
    extends UseCase<Conversation, QueryParams<Conversation>> {
  GetConversationUseCase(this._repository);

  final ConversationRepository _repository;

  @override
  Future<Conversation> execute(
    QueryParams<Conversation> params,
    CancelToken? cancelToken,
  ) async {
    cancelToken?.throwIfCancelled();
    return _repository.get(params);
  }
}
