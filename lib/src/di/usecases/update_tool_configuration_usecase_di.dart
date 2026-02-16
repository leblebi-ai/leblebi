import 'package:get_it/get_it.dart';

import '../../domain/repositories/tool_configuration_repository.dart';
import '../../domain/usecases/tool_configuration/update_tool_configuration_usecase.dart';

void registerUpdateToolConfigurationUseCase(GetIt getIt) {
  getIt.registerLazySingleton<UpdateToolConfigurationUseCase>(
    () => UpdateToolConfigurationUseCase(getIt<ToolConfigurationRepository>()),
  );
}
