import 'package:get_it/get_it.dart';

import '../../domain/repositories/workspace_repository.dart';
import '../../domain/usecases/workspace/update_workspace_usecase.dart';

void registerUpdateWorkspaceUseCase(GetIt getIt) {
  getIt.registerLazySingleton<UpdateWorkspaceUseCase>(
    () => UpdateWorkspaceUseCase(getIt<WorkspaceRepository>()),
  );
}
