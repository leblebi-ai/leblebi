import 'package:zuraffa/zuraffa.dart';

import '../../../domain/entities/gateway_connection/gateway_connection.dart';
import 'gateway_connection_data_source.dart';

class GatewayConnectionRemoteDataSource
    with Loggable, FailureHandler
    implements GatewayConnectionDataSource {
  @override
  Future<GatewayConnection> get(QueryParams<GatewayConnection> params) async {
    throw UnimplementedError('Implement remote get');
  }

  @override
  Future<List<GatewayConnection>> getList(
    ListQueryParams<GatewayConnection> params,
  ) async {
    throw UnimplementedError('Implement remote getList');
  }

  @override
  Future<GatewayConnection> create(GatewayConnection gatewayConnection) async {
    throw UnimplementedError('Implement remote create');
  }

  @override
  Future<GatewayConnection> update(
    UpdateParams<String, Partial<GatewayConnection>> params,
  ) async {
    throw UnimplementedError('Implement remote update');
  }

  @override
  Future<void> delete(DeleteParams<String> params) async {
    throw UnimplementedError('Implement remote delete');
  }
}
