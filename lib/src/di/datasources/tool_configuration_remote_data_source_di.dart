import 'package:get_it/get_it.dart';

import '../../data/data_sources/tool_configuration/tool_configuration_remote_data_source.dart';

void registerToolConfigurationRemoteDataSource(GetIt getIt) {
  getIt.registerLazySingleton<ToolConfigurationRemoteDataSource>(
    () => ToolConfigurationRemoteDataSource(),
  );
}
