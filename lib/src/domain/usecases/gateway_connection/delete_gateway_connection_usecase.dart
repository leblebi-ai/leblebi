import 'package:zuraffa/zuraffa.dart';

import '../../repositories/gateway_connection_repository.dart';

class DeleteGatewayConnectionUseCase
    extends CompletableUseCase<DeleteParams<String>> {
  DeleteGatewayConnectionUseCase(this._repository);

  final GatewayConnectionRepository _repository;

  @override
  Future<void> execute(
    DeleteParams<String> params,
    CancelToken? cancelToken,
  ) async {
    cancelToken?.throwIfCancelled();
    return _repository.delete(params);
  }
}
