import 'package:zuraffa/zuraffa.dart';

import '../../../domain/entities/message/message.dart';
import '../../../domain/entities/message_metadata/message_metadata.dart';
import '../../../domain/entities/gateway_connection/gateway_connection.dart';
import '../../../domain/entities/enums/index.dart';
import '../remote/zeroclaw_rest_api.dart';

class MessageRemoteDataSource with Loggable, FailureHandler {
  MessageRemoteDataSource(this._api);

  final ZeroClawRestApi _api;

  Future<Message> sendToAI(Message message, GatewayConnection connection) async {
    if (connection.bearerToken == null) {
      throw Exception('Gateway connection missing token');
    }

    final response = await _api.sendMessage(
      connection.url,
      connection.bearerToken!,
      message.content,
    );
    
    // Debugging
    print('ZeroClaw Response: $response');

    // The ZeroClaw API might return different fields. 
    // Usually it returns { "content": "..." } or { "message": "..." }
    // Let's try to extract from common fields.
    String replyContent = 'No response content';
    
    if (response.containsKey('content')) {
      replyContent = response['content'] as String;
    } else if (response.containsKey('message')) {
      replyContent = response['message'] as String;
    } else if (response.containsKey('response')) {
      replyContent = response['response'] as String;
    } else if (response.containsKey('reply')) {
      replyContent = response['reply'] as String;
    } else {
       // Try to dump the whole map if it's small
       replyContent = response.toString();
    }
    
    // Create AI response message
    return Message(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      conversationId: message.conversationId,
      content: replyContent,
      sender: MessageSender.ai,
      timestamp: DateTime.now(),
      status: MessageStatus.sent,
      metadata: MessageMetadata(provider: 'ZeroClaw'),
      retryCount: 0,
    );
  }
}

