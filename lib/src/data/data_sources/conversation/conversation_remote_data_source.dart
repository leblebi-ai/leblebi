import 'package:zuraffa/zuraffa.dart';

import '../../../domain/entities/conversation/conversation.dart';
import 'conversation_data_source.dart';

class ConversationRemoteDataSource
    with Loggable, FailureHandler
    implements ConversationDataSource {
  @override
  Future<Conversation> get(QueryParams<Conversation> params) async {
    throw UnimplementedError('Implement remote get');
  }

  @override
  Future<List<Conversation>> getList(
    ListQueryParams<Conversation> params,
  ) async {
    throw UnimplementedError('Implement remote getList');
  }

  @override
  Future<Conversation> create(Conversation conversation) async {
    throw UnimplementedError('Implement remote create');
  }

  @override
  Future<Conversation> update(
    UpdateParams<String, Partial<Conversation>> params,
  ) async {
    throw UnimplementedError('Implement remote update');
  }

  @override
  Future<void> delete(DeleteParams<String> params) async {
    throw UnimplementedError('Implement remote delete');
  }
}
