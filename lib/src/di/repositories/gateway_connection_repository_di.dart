import 'package:get_it/get_it.dart';

import '../../data/data_sources/gateway_connection/gateway_connection_local_data_source.dart';
import '../../data/data_sources/gateway_connection/gateway_connection_remote_data_source.dart';
import '../../data/repositories/data_gateway_connection_repository.dart';
import '../../domain/repositories/gateway_connection_repository.dart';

void registerGatewayConnectionRepository(GetIt getIt) {
  getIt.registerLazySingleton<GatewayConnectionRepository>(
    () => DataGatewayConnectionRepository(
      getIt<GatewayConnectionLocalDataSource>(),
      getIt<GatewayConnectionRemoteDataSource>(),
    ),
  );
}

