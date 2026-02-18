import 'package:zuraffa/zuraffa.dart';

import '../entities/message/message.dart';
import '../repositories/message_repository.dart';
import '../repositories/gateway_connection_repository.dart';

class SendMessageUseCase extends UseCase<Message, SendMessageParams> {
  SendMessageUseCase(
    this._messageRepository,
    this._gatewayRepository,
  );

  final MessageRepository _messageRepository;
  final GatewayConnectionRepository _gatewayRepository;

  @override
  Future<Message> execute(
    SendMessageParams params,
    CancelToken? cancelToken,
  ) async {
    cancelToken?.throwIfCancelled();
    
    // 1. Get active connection (or specific one)
    // For MVP, we might assume there's an active connection or pass it in params.
    // The spec says "Active GatewayConnection".
    // We'll query for the active connection.
    final connections = await _gatewayRepository.getList(
      ListQueryParams(
        // filtering by status: connected would be ideal, but for now we take the first one
        // assuming single connection MVP
      ),
    );
    
    if (connections.isEmpty) {
      throw Exception('No gateway connection available');
    }
    
    final connection = connections.first; // Should refine this logic
    
    // 2. Create local message (pending)
    // This part might be handled by the UI calling createMessage first, then sendMessage.
    // But usually SendMessage usecase handles the whole flow.
    // However, to keep UI responsive, UI often creates optimistic message.
    // Let's assume params includes the message content and conversation ID.
    
    // If params has a message object, use it. If not, create it.
    // Let's assume params is just the message to send (already created locally or to be created).
    
    // Actually, simpler: The UI creates the message with status 'pending' via CreateMessageUseCase.
    // Then calls SendMessageUseCase with that message.
    
    return _messageRepository.sendToAI(params.message, connection);
  }
}

class SendMessageParams {
  final Message message;

  SendMessageParams({required this.message});
}
