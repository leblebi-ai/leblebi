import 'package:get_it/get_it.dart';

import '../../domain/repositories/conversation_repository.dart';
import '../../domain/usecases/conversation/create_conversation_usecase.dart';

void registerCreateConversationUseCase(GetIt getIt) {
  getIt.registerLazySingleton<CreateConversationUseCase>(
    () => CreateConversationUseCase(getIt<ConversationRepository>()),
  );
}
