import 'package:zuraffa/zuraffa.dart';

import '../../entities/message/message.dart';
import '../../repositories/message_repository.dart';

class WatchMessageListUseCase
    extends StreamUseCase<List<Message>, ListQueryParams<Message>> {
  WatchMessageListUseCase(this._repository);

  final MessageRepository _repository;

  @override
  Stream<List<Message>> execute(
    ListQueryParams<Message> params,
    CancelToken? cancelToken,
  ) {
    cancelToken?.throwIfCancelled();
    return _repository.watchList(params);
  }
}
