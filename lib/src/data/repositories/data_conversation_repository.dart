import 'package:zuraffa/zuraffa.dart';

import '../../domain/entities/conversation/conversation.dart';
import '../../domain/repositories/conversation_repository.dart';
import '../data_sources/conversation/conversation_data_source.dart';

class DataConversationRepository
    with Loggable, FailureHandler
    implements ConversationRepository {
  DataConversationRepository(this._dataSource);

  final ConversationDataSource _dataSource;

  @override
  Future<Conversation> get(QueryParams<Conversation> params) {
    return _dataSource.get(params);
  }

  @override
  Future<List<Conversation>> getList(ListQueryParams<Conversation> params) {
    return _dataSource.getList(params);
  }

  @override
  Future<Conversation> create(Conversation conversation) {
    return _dataSource.create(conversation);
  }

  @override
  Future<Conversation> update(
    UpdateParams<String, Partial<Conversation>> params,
  ) {
    return _dataSource.update(params);
  }

  @override
  Future<void> delete(DeleteParams<String> params) {
    return _dataSource.delete(params);
  }
}
