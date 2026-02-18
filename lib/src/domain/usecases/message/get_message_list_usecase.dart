import 'package:zuraffa/zuraffa.dart';

import '../../entities/message/message.dart';
import '../../repositories/message_repository.dart';

class GetMessageListUseCase
    extends UseCase<List<Message>, ListQueryParams<Message>> {
  GetMessageListUseCase(this._repository);

  final MessageRepository _repository;

  @override
  Future<List<Message>> execute(
    ListQueryParams<Message> params,
    CancelToken? cancelToken,
  ) async {
    cancelToken?.throwIfCancelled();
    return _repository.getList(params);
  }
}
