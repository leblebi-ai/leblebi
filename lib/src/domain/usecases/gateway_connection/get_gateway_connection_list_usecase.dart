import 'package:zuraffa/zuraffa.dart';

import '../../entities/gateway_connection/gateway_connection.dart';
import '../../repositories/gateway_connection_repository.dart';

class GetGatewayConnectionListUseCase
    extends
        UseCase<List<GatewayConnection>, ListQueryParams<GatewayConnection>> {
  GetGatewayConnectionListUseCase(this._repository);

  final GatewayConnectionRepository _repository;

  @override
  Future<List<GatewayConnection>> execute(
    ListQueryParams<GatewayConnection> params,
    CancelToken? cancelToken,
  ) async {
    cancelToken?.throwIfCancelled();
    return _repository.getList(params);
  }
}
