import 'package:zuraffa/zuraffa.dart';

import '../../domain/entities/gateway_connection/gateway_connection.dart';
import '../../domain/repositories/gateway_connection_repository.dart';
import '../data_sources/gateway_connection/gateway_connection_data_source.dart';

class DataGatewayConnectionRepository
    with Loggable, FailureHandler
    implements GatewayConnectionRepository {
  DataGatewayConnectionRepository(this._dataSource);

  final GatewayConnectionDataSource _dataSource;

  @override
  Future<GatewayConnection> get(QueryParams<GatewayConnection> params) {
    return _dataSource.get(params);
  }

  @override
  Future<List<GatewayConnection>> getList(
    ListQueryParams<GatewayConnection> params,
  ) {
    return _dataSource.getList(params);
  }

  @override
  Future<GatewayConnection> create(GatewayConnection gatewayConnection) {
    return _dataSource.create(gatewayConnection);
  }

  @override
  Future<GatewayConnection> update(
    UpdateParams<String, Partial<GatewayConnection>> params,
  ) {
    return _dataSource.update(params);
  }

  @override
  Future<void> delete(DeleteParams<String> params) {
    return _dataSource.delete(params);
  }
}
