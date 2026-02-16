import 'package:zuraffa/zuraffa.dart';

import '../../entities/gateway_connection/gateway_connection.dart';
import '../../repositories/gateway_connection_repository.dart';

class UpdateGatewayConnectionUseCase
    extends
        UseCase<
          GatewayConnection,
          UpdateParams<String, Partial<GatewayConnection>>
        > {
  UpdateGatewayConnectionUseCase(this._repository);

  final GatewayConnectionRepository _repository;

  @override
  Future<GatewayConnection> execute(
    UpdateParams<String, Partial<GatewayConnection>> params,
    CancelToken? cancelToken,
  ) async {
    cancelToken?.throwIfCancelled();
    return _repository.update(params);
  }
}
