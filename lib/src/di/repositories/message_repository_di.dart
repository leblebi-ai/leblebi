import 'package:get_it/get_it.dart';

import '../../data/data_sources/message/message_local_data_source.dart';
import '../../data/data_sources/message/message_remote_data_source.dart';
import '../../data/repositories/data_message_repository.dart';
import '../../domain/repositories/message_repository.dart';

void registerMessageRepository(GetIt getIt) {
  getIt.registerLazySingleton<MessageRepository>(
    () => DataMessageRepository(
      getIt<MessageLocalDataSource>(),
      getIt<MessageRemoteDataSource>(),
    ),
  );
}
