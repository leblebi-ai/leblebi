import 'package:get_it/get_it.dart';

import '../../data/data_sources/conversation/conversation_remote_data_source.dart';

void registerConversationRemoteDataSource(GetIt getIt) {
  getIt.registerLazySingleton<ConversationRemoteDataSource>(
    () => ConversationRemoteDataSource(),
  );
}
