import 'package:zuraffa/zuraffa.dart';

import '../../entities/message/message.dart';
import '../../repositories/message_repository.dart';

class CreateMessageUseCase extends UseCase<Message, Message> {
  CreateMessageUseCase(this._repository);

  final MessageRepository _repository;

  @override
  Future<Message> execute(Message params, CancelToken? cancelToken) async {
    cancelToken?.throwIfCancelled();
    return _repository.create(params);
  }
}
