import 'package:get_it/get_it.dart';

import '../../domain/repositories/message_repository.dart';
import '../../domain/usecases/message/get_message_list_usecase.dart';

void registerGetMessageListUseCase(GetIt getIt) {
  getIt.registerLazySingleton<GetMessageListUseCase>(
    () => GetMessageListUseCase(getIt<MessageRepository>()),
  );
}
