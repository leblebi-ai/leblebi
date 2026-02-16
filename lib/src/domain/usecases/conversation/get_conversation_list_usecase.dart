import 'package:zuraffa/zuraffa.dart';

import '../../entities/conversation/conversation.dart';
import '../../repositories/conversation_repository.dart';

class GetConversationListUseCase
    extends UseCase<List<Conversation>, ListQueryParams<Conversation>> {
  GetConversationListUseCase(this._repository);

  final ConversationRepository _repository;

  @override
  Future<List<Conversation>> execute(
    ListQueryParams<Conversation> params,
    CancelToken? cancelToken,
  ) async {
    cancelToken?.throwIfCancelled();
    return _repository.getList(params);
  }
}
