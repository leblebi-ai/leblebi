import 'package:zuraffa/zuraffa.dart';

import '../../entities/gateway_connection/gateway_connection.dart';
import '../../repositories/gateway_connection_repository.dart';

class CreateGatewayConnectionUseCase
    extends UseCase<GatewayConnection, GatewayConnection> {
  CreateGatewayConnectionUseCase(this._repository);

  final GatewayConnectionRepository _repository;

  @override
  Future<GatewayConnection> execute(
    GatewayConnection params,
    CancelToken? cancelToken,
  ) async {
    cancelToken?.throwIfCancelled();
    return _repository.create(params);
  }
}
