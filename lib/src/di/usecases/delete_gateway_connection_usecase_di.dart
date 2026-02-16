import 'package:get_it/get_it.dart';

import '../../domain/repositories/gateway_connection_repository.dart';
import '../../domain/usecases/gateway_connection/delete_gateway_connection_usecase.dart';

void registerDeleteGatewayConnectionUseCase(GetIt getIt) {
  getIt.registerLazySingleton<DeleteGatewayConnectionUseCase>(
    () => DeleteGatewayConnectionUseCase(getIt<GatewayConnectionRepository>()),
  );
}
