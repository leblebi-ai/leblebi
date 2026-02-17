import 'package:zuraffa/zuraffa.dart';

import '../../entities/message/message.dart';
import '../../repositories/message_repository.dart';

class WatchMessageUseCase extends StreamUseCase<Message, QueryParams<Message>> {
  WatchMessageUseCase(this._repository);

  final MessageRepository _repository;

  @override
  Stream<Message> execute(
    QueryParams<Message> params,
    CancelToken? cancelToken,
  ) {
    cancelToken?.throwIfCancelled();
    return _repository.watch(params);
  }
}
