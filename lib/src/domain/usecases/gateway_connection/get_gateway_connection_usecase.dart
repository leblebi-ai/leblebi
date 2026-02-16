import 'package:zuraffa/zuraffa.dart';

import '../../entities/gateway_connection/gateway_connection.dart';
import '../../repositories/gateway_connection_repository.dart';

class GetGatewayConnectionUseCase
    extends UseCase<GatewayConnection, QueryParams<GatewayConnection>> {
  GetGatewayConnectionUseCase(this._repository);

  final GatewayConnectionRepository _repository;

  @override
  Future<GatewayConnection> execute(
    QueryParams<GatewayConnection> params,
    CancelToken? cancelToken,
  ) async {
    cancelToken?.throwIfCancelled();
    return _repository.get(params);
  }
}
