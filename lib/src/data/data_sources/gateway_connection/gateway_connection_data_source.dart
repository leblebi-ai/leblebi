import 'package:zuraffa/zuraffa.dart';

import '../../../domain/entities/gateway_connection/gateway_connection.dart';

abstract class GatewayConnectionDataSource with Loggable, FailureHandler {
  Future<GatewayConnection> get(QueryParams<GatewayConnection> params);
  Future<List<GatewayConnection>> getList(
    ListQueryParams<GatewayConnection> params,
  );
  Future<GatewayConnection> create(GatewayConnection gatewayConnection);
  Future<GatewayConnection> update(
    UpdateParams<String, Partial<GatewayConnection>> params,
  );
  Future<void> delete(DeleteParams<String> params);
}
