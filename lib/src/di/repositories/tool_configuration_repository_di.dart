import 'package:get_it/get_it.dart';

import '../../data/data_sources/tool_configuration/tool_configuration_remote_data_source.dart';
import '../../data/repositories/data_tool_configuration_repository.dart';
import '../../domain/repositories/tool_configuration_repository.dart';

void registerToolConfigurationRepository(GetIt getIt) {
  getIt.registerLazySingleton<ToolConfigurationRepository>(
    () => DataToolConfigurationRepository(
      getIt<ToolConfigurationRemoteDataSource>(),
    ),
  );
}
