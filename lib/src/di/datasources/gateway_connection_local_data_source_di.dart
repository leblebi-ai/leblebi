import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get_it/get_it.dart';
import '../../data/data_sources/gateway_connection/gateway_connection_local_data_source.dart';

void registerGatewayConnectionLocalDataSource(GetIt getIt) {
  getIt.registerLazySingleton<GatewayConnectionLocalDataSource>(
    () => GatewayConnectionLocalDataSource(getIt<FlutterSecureStorage>()),
  );
}

