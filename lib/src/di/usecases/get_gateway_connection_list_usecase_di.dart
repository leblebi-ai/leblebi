import 'package:get_it/get_it.dart';

import '../../domain/repositories/gateway_connection_repository.dart';
import '../../domain/usecases/gateway_connection/get_gateway_connection_list_usecase.dart';

void registerGetGatewayConnectionListUseCase(GetIt getIt) {
  getIt.registerLazySingleton<GetGatewayConnectionListUseCase>(
    () => GetGatewayConnectionListUseCase(getIt<GatewayConnectionRepository>()),
  );
}
