import 'package:zuraffa/zuraffa.dart';

import '../../entities/conversation/conversation.dart';
import '../../repositories/conversation_repository.dart';

class WatchConversationListUseCase
    extends StreamUseCase<List<Conversation>, ListQueryParams<Conversation>> {
  WatchConversationListUseCase(this._repository);

  final ConversationRepository _repository;

  @override
  Stream<List<Conversation>> execute(
    ListQueryParams<Conversation> params,
    CancelToken? cancelToken,
  ) {
    cancelToken?.throwIfCancelled();
    return _repository.watchList(params);
  }
}
