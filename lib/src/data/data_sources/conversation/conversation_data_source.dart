import 'package:zuraffa/zuraffa.dart';

import '../../../domain/entities/conversation/conversation.dart';

abstract class ConversationDataSource with Loggable, FailureHandler {
  Future<Conversation> get(QueryParams<Conversation> params);
  Future<List<Conversation>> getList(ListQueryParams<Conversation> params);
  Future<Conversation> create(Conversation conversation);
  Future<Conversation> update(
    UpdateParams<String, Partial<Conversation>> params,
  );
  Future<void> delete(DeleteParams<String> params);
}
