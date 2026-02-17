import 'package:zuraffa/zuraffa.dart';

import '../../entities/gateway_connection/gateway_connection.dart';
import '../../repositories/gateway_connection_repository.dart';

class WatchGatewayConnectionListUseCase
    extends
        StreamUseCase<
          List<GatewayConnection>,
          ListQueryParams<GatewayConnection>
        > {
  WatchGatewayConnectionListUseCase(this._repository);

  final GatewayConnectionRepository _repository;

  @override
  Stream<List<GatewayConnection>> execute(
    ListQueryParams<GatewayConnection> params,
    CancelToken? cancelToken,
  ) {
    cancelToken?.throwIfCancelled();
    return _repository.watchList(params);
  }
}
