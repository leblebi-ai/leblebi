import 'package:get_it/get_it.dart';

import '../../data/data_sources/conversation/conversation_remote_data_source.dart';
import '../../data/repositories/data_conversation_repository.dart';
import '../../domain/repositories/conversation_repository.dart';

void registerConversationRepository(GetIt getIt) {
  getIt.registerLazySingleton<ConversationRepository>(
    () => DataConversationRepository(getIt<ConversationRemoteDataSource>()),
  );
}
