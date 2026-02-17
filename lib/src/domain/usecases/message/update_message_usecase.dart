import 'package:zuraffa/zuraffa.dart';

import '../../entities/message/message.dart';
import '../../repositories/message_repository.dart';

class UpdateMessageUseCase
    extends UseCase<Message, UpdateParams<String, Partial<Message>>> {
  UpdateMessageUseCase(this._repository);

  final MessageRepository _repository;

  @override
  Future<Message> execute(
    UpdateParams<String, Partial<Message>> params,
    CancelToken? cancelToken,
  ) async {
    cancelToken?.throwIfCancelled();
    return _repository.update(params);
  }
}
