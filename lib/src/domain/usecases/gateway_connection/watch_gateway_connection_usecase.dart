import 'package:zuraffa/zuraffa.dart';

import '../../entities/gateway_connection/gateway_connection.dart';
import '../../repositories/gateway_connection_repository.dart';

class WatchGatewayConnectionUseCase
    extends StreamUseCase<GatewayConnection, QueryParams<GatewayConnection>> {
  WatchGatewayConnectionUseCase(this._repository);

  final GatewayConnectionRepository _repository;

  @override
  Stream<GatewayConnection> execute(
    QueryParams<GatewayConnection> params,
    CancelToken? cancelToken,
  ) {
    cancelToken?.throwIfCancelled();
    return _repository.watch(params);
  }
}
