import 'package:get_it/get_it.dart';

import '../../domain/repositories/conversation_repository.dart';
import '../../domain/usecases/conversation/delete_conversation_usecase.dart';

void registerDeleteConversationUseCase(GetIt getIt) {
  getIt.registerLazySingleton<DeleteConversationUseCase>(
    () => DeleteConversationUseCase(getIt<ConversationRepository>()),
  );
}
