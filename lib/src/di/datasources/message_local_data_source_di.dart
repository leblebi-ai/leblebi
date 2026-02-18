import 'package:get_it/get_it.dart';

import '../../data/data_sources/message/message_local_data_source.dart';

void registerMessageLocalDataSource(GetIt getIt) {
  getIt.registerLazySingleton<MessageLocalDataSource>(
    () => MessageLocalDataSource(),
  );
}
