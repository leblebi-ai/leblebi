import 'package:get_it/get_it.dart';

import '../../domain/repositories/gateway_connection_repository.dart';
import '../../domain/repositories/message_repository.dart';
import '../../domain/usecases/send_message_usecase.dart';

void registerSendMessageUseCase(GetIt getIt) {
  getIt.registerLazySingleton<SendMessageUseCase>(
    () => SendMessageUseCase(
      getIt<MessageRepository>(),
      getIt<GatewayConnectionRepository>(),
    ),
  );
}
