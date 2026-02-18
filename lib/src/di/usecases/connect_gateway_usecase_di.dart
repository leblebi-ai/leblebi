import 'package:get_it/get_it.dart';

import '../../domain/repositories/gateway_connection_repository.dart';
import '../../domain/usecases/connect_gateway_usecase.dart';

void registerConnectGatewayUseCase(GetIt getIt) {
  getIt.registerLazySingleton<ConnectGatewayUseCase>(
    () => ConnectGatewayUseCase(getIt<GatewayConnectionRepository>()),
  );
}
