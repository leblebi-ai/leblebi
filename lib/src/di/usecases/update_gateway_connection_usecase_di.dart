import 'package:get_it/get_it.dart';

import '../../domain/repositories/gateway_connection_repository.dart';
import '../../domain/usecases/gateway_connection/update_gateway_connection_usecase.dart';

void registerUpdateGatewayConnectionUseCase(GetIt getIt) {
  getIt.registerLazySingleton<UpdateGatewayConnectionUseCase>(
    () => UpdateGatewayConnectionUseCase(getIt<GatewayConnectionRepository>()),
  );
}
