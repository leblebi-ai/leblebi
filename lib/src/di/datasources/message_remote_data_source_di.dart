import 'package:get_it/get_it.dart';

import '../../data/data_sources/message/message_remote_data_source.dart';
import '../../data/data_sources/remote/zeroclaw_rest_api.dart';

void registerMessageRemoteDataSource(GetIt getIt) {
  getIt.registerLazySingleton<MessageRemoteDataSource>(
    () => MessageRemoteDataSource(getIt<ZeroClawRestApi>()),
  );
}
