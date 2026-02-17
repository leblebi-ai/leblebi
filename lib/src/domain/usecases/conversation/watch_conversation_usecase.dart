import 'package:zuraffa/zuraffa.dart';

import '../../entities/conversation/conversation.dart';
import '../../repositories/conversation_repository.dart';

class WatchConversationUseCase
    extends StreamUseCase<Conversation, QueryParams<Conversation>> {
  WatchConversationUseCase(this._repository);

  final ConversationRepository _repository;

  @override
  Stream<Conversation> execute(
    QueryParams<Conversation> params,
    CancelToken? cancelToken,
  ) {
    cancelToken?.throwIfCancelled();
    return _repository.watch(params);
  }
}
