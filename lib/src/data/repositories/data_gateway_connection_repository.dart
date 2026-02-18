import 'package:zuraffa/zuraffa.dart';

import '../../domain/entities/gateway_connection/gateway_connection.dart';
import '../../domain/entities/enums/index.dart';
import '../../domain/repositories/gateway_connection_repository.dart';
import '../data_sources/gateway_connection/gateway_connection_local_data_source.dart';
import '../data_sources/gateway_connection/gateway_connection_remote_data_source.dart';

class DataGatewayConnectionRepository
    with Loggable, FailureHandler
    implements GatewayConnectionRepository {
  DataGatewayConnectionRepository(
    this._localDataSource,
    this._remoteDataSource,
  );

  final GatewayConnectionLocalDataSource _localDataSource;
  final GatewayConnectionRemoteDataSource _remoteDataSource;

  @override
  Future<GatewayConnection> get(QueryParams<GatewayConnection> params) {
    return _localDataSource.get(params);
  }

  @override
  Future<List<GatewayConnection>> getList(
    ListQueryParams<GatewayConnection> params,
  ) {
    return _localDataSource.getList(params);
  }

  @override
  Future<GatewayConnection> create(GatewayConnection gatewayConnection) {
    return _localDataSource.create(gatewayConnection);
  }

  @override
  Future<GatewayConnection> update(
    UpdateParams<String, Partial<GatewayConnection>> params,
  ) {
    return _localDataSource.update(params);
  }

  @override
  Future<void> delete(DeleteParams<String> params) {
    return _localDataSource.delete(params);
  }

  @override
  Future<GatewayConnection> pair(String url, String pairingCode) async {
    final response = await _remoteDataSource.pair(url, pairingCode);
    final token = response['token'] as String;
    
    // Create new GatewayConnection object
    final connection = GatewayConnection(
      id: DateTime.now().millisecondsSinceEpoch.toString(), // Generate ID
      name: 'ZeroClaw', // Default name? Or from input?
      url: url,
      pairingCode: pairingCode, // Should clear this?
      bearerToken: token,
      providerType: AIProviderType.zeroClaw,
      status: ConnectionStatus.connected,
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
      lastConnectedAt: DateTime.now(),
    );

    // Save to local storage
    return _localDataSource.create(connection);
  }
}

