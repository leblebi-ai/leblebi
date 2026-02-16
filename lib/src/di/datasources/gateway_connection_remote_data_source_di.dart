import 'package:get_it/get_it.dart';

import '../../data/data_sources/gateway_connection/gateway_connection_remote_data_source.dart';

void registerGatewayConnectionRemoteDataSource(GetIt getIt) {
  getIt.registerLazySingleton<GatewayConnectionRemoteDataSource>(
    () => GatewayConnectionRemoteDataSource(),
  );
}
