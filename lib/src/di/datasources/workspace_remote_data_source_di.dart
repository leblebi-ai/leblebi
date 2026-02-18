import 'package:get_it/get_it.dart';

import '../../data/data_sources/remote/zeroclaw_rest_api.dart';
import '../../data/data_sources/workspace/workspace_remote_data_source.dart';

void registerWorkspaceRemoteDataSource(GetIt getIt) {
  getIt.registerLazySingleton<WorkspaceRemoteDataSource>(
    () => WorkspaceRemoteDataSource(
      api: getIt<ZeroClawRestApi>(),
      baseUrl: getIt<String>(instanceName: 'gatewayUrl'),
      token: getIt<String>(instanceName: 'bearerToken'),
    ),
  );
}
