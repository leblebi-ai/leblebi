import 'package:zuraffa/zuraffa.dart';

import '../../entities/message/message.dart';
import '../../repositories/message_repository.dart';

class GetMessageUseCase extends UseCase<Message, QueryParams<Message>> {
  GetMessageUseCase(this._repository);

  final MessageRepository _repository;

  @override
  Future<Message> execute(
    QueryParams<Message> params,
    CancelToken? cancelToken,
  ) async {
    cancelToken?.throwIfCancelled();
    return _repository.get(params);
  }
}
