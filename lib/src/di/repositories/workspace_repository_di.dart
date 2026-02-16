import 'package:get_it/get_it.dart';

import '../../data/data_sources/workspace/workspace_remote_data_source.dart';
import '../../data/repositories/data_workspace_repository.dart';
import '../../domain/repositories/workspace_repository.dart';

void registerWorkspaceRepository(GetIt getIt) {
  getIt.registerLazySingleton<WorkspaceRepository>(
    () => DataWorkspaceRepository(getIt<WorkspaceRemoteDataSource>()),
  );
}
