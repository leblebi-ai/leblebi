import 'package:get_it/get_it.dart';

import '../../domain/repositories/conversation_repository.dart';
import '../../domain/usecases/conversation/get_conversation_list_usecase.dart';

void registerGetConversationListUseCase(GetIt getIt) {
  getIt.registerLazySingleton<GetConversationListUseCase>(
    () => GetConversationListUseCase(getIt<ConversationRepository>()),
  );
}
