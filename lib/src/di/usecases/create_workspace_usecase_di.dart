import 'package:get_it/get_it.dart';

import '../../domain/repositories/workspace_repository.dart';
import '../../domain/usecases/workspace/create_workspace_usecase.dart';

void registerCreateWorkspaceUseCase(GetIt getIt) {
  getIt.registerLazySingleton<CreateWorkspaceUseCase>(
    () => CreateWorkspaceUseCase(getIt<WorkspaceRepository>()),
  );
}
