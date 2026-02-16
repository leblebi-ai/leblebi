import 'package:get_it/get_it.dart';

import '../../domain/repositories/gateway_connection_repository.dart';
import '../../domain/usecases/gateway_connection/create_gateway_connection_usecase.dart';

void registerCreateGatewayConnectionUseCase(GetIt getIt) {
  getIt.registerLazySingleton<CreateGatewayConnectionUseCase>(
    () => CreateGatewayConnectionUseCase(getIt<GatewayConnectionRepository>()),
  );
}
