import 'package:get_it/get_it.dart';

import '../../domain/repositories/tool_configuration_repository.dart';
import '../../domain/usecases/tool_configuration/get_tool_configuration_usecase.dart';

void registerGetToolConfigurationUseCase(GetIt getIt) {
  getIt.registerLazySingleton<GetToolConfigurationUseCase>(
    () => GetToolConfigurationUseCase(getIt<ToolConfigurationRepository>()),
  );
}
