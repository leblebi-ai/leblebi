import 'package:get_it/get_it.dart';

import '../../domain/repositories/message_repository.dart';
import '../../domain/usecases/message/create_message_usecase.dart';

void registerCreateMessageUseCase(GetIt getIt) {
  getIt.registerLazySingleton<CreateMessageUseCase>(
    () => CreateMessageUseCase(getIt<MessageRepository>()),
  );
}
