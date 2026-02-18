import 'package:zuraffa/zuraffa.dart';

import '../entities/gateway_connection/gateway_connection.dart';
import '../repositories/gateway_connection_repository.dart';

class ConnectGatewayUseCase
    extends UseCase<GatewayConnection, ConnectGatewayParams> {
  ConnectGatewayUseCase(this._repository);

  final GatewayConnectionRepository _repository;

  @override
  Future<GatewayConnection> execute(
    ConnectGatewayParams params,
    CancelToken? cancelToken,
  ) async {
    cancelToken?.throwIfCancelled();
    return _repository.pair(params.url, params.pairingCode);
  }
}

class ConnectGatewayParams {
  final String url;
  final String pairingCode;

  ConnectGatewayParams({required this.url, required this.pairingCode});
}
