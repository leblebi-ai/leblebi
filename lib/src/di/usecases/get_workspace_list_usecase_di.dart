import 'package:get_it/get_it.dart';

import '../../domain/repositories/workspace_repository.dart';
import '../../domain/usecases/workspace/get_workspace_list_usecase.dart';

void registerGetWorkspaceListUseCase(GetIt getIt) {
  getIt.registerLazySingleton<GetWorkspaceListUseCase>(
    () => GetWorkspaceListUseCase(getIt<WorkspaceRepository>()),
  );
}
