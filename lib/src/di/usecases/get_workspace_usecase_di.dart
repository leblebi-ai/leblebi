import 'package:get_it/get_it.dart';

import '../../domain/repositories/workspace_repository.dart';
import '../../domain/usecases/workspace/get_workspace_usecase.dart';

void registerGetWorkspaceUseCase(GetIt getIt) {
  getIt.registerLazySingleton<GetWorkspaceUseCase>(
    () => GetWorkspaceUseCase(getIt<WorkspaceRepository>()),
  );
}
