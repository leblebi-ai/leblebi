import 'package:get_it/get_it.dart';

import '../../data/data_sources/workspace/workspace_remote_data_source.dart';

void registerWorkspaceRemoteDataSource(GetIt getIt) {
  getIt.registerLazySingleton<WorkspaceRemoteDataSource>(
    () => WorkspaceRemoteDataSource(),
  );
}
