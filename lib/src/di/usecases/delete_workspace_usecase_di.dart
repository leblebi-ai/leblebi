import 'package:get_it/get_it.dart';

import '../../domain/repositories/workspace_repository.dart';
import '../../domain/usecases/workspace/delete_workspace_usecase.dart';

void registerDeleteWorkspaceUseCase(GetIt getIt) {
  getIt.registerLazySingleton<DeleteWorkspaceUseCase>(
    () => DeleteWorkspaceUseCase(getIt<WorkspaceRepository>()),
  );
}
