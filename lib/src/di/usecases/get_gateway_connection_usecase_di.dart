import 'package:get_it/get_it.dart';

import '../../domain/repositories/gateway_connection_repository.dart';
import '../../domain/usecases/gateway_connection/get_gateway_connection_usecase.dart';

void registerGetGatewayConnectionUseCase(GetIt getIt) {
  getIt.registerLazySingleton<GetGatewayConnectionUseCase>(
    () => GetGatewayConnectionUseCase(getIt<GatewayConnectionRepository>()),
  );
}
