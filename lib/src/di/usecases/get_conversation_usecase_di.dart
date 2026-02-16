import 'package:get_it/get_it.dart';

import '../../domain/repositories/conversation_repository.dart';
import '../../domain/usecases/conversation/get_conversation_usecase.dart';

void registerGetConversationUseCase(GetIt getIt) {
  getIt.registerLazySingleton<GetConversationUseCase>(
    () => GetConversationUseCase(getIt<ConversationRepository>()),
  );
}
