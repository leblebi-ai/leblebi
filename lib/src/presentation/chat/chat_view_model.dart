import 'package:flutter/material.dart';
import 'package:zuraffa/zuraffa.dart';

import '../../domain/entities/message/message.dart';
import '../../domain/entities/gateway_connection/gateway_connection.dart';
import '../../domain/entities/enums/index.dart';
import '../../domain/usecases/message/get_message_list_usecase.dart';
import '../../domain/usecases/send_message_usecase.dart';
import '../../domain/usecases/gateway_connection/get_gateway_connection_list_usecase.dart';
import '../../domain/usecases/gateway_connection/delete_gateway_connection_usecase.dart';

class ChatViewModel extends ChangeNotifier {
  ChatViewModel(
    this._getMessageListUseCase,
    this._sendMessageUseCase,
    this._getGatewayConnectionListUseCase,
    this._deleteGatewayConnectionUseCase,
  );

  final GetMessageListUseCase _getMessageListUseCase;
  final SendMessageUseCase _sendMessageUseCase;
  final GetGatewayConnectionListUseCase _getGatewayConnectionListUseCase;
  final DeleteGatewayConnectionUseCase _deleteGatewayConnectionUseCase;

  List<Message> _messages = [];
  List<Message> get messages => _messages;

  bool _isLoading = false;
  bool get isLoading => _isLoading;
  
  bool _isSending = false;
  bool get isSending => _isSending;

  String? _error;
  String? get error => _error;

  Future<void> loadMessages(String conversationId) async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      final params = ListQueryParams<Message>(
        // Add filtering by conversationId if possible
        // For MVP, we load all messages as there is only one conversation usually
      );
      _messages = await _getMessageListUseCase.execute(params, null);
      
      // Sort messages by timestamp if needed
      _messages.sort((a, b) => a.timestamp.compareTo(b.timestamp));
      
      _isLoading = false;
      notifyListeners();
    } catch (e) {
      debugPrint('ChatViewModel loadMessages: $e');
      _isLoading = false;
      _error = e.toString();
      notifyListeners();
    }
  }

  Future<void> sendMessage(String content, String conversationId) async {
    if (content.trim().isEmpty) return;

    _isSending = true;
    _error = null;
    notifyListeners();

    // Optimistic update
    final tempId = DateTime.now().millisecondsSinceEpoch.toString();
    final optimisticMessage = Message(
      id: tempId,
      conversationId: conversationId,
      content: content,
      sender: MessageSender.user,
      timestamp: DateTime.now(),
      status: MessageStatus.pending,
      retryCount: 0,
    );
    
    _messages.add(optimisticMessage);
    notifyListeners();

    try {
      final params = SendMessageParams(message: optimisticMessage);
      final sentMessage = await _sendMessageUseCase.execute(params, null);
      
      // 3. Update user message status to sent
      final index = _messages.indexWhere((m) => m.id == tempId);
      if (index != -1) {
        _messages[index] = optimisticMessage.copyWith(status: MessageStatus.sent);
      }
      
      // 4. Add AI response
      _messages.add(sentMessage);
      
      // Sort again just in case
      _messages.sort((a, b) => a.timestamp.compareTo(b.timestamp));
      
      _isSending = false;
      notifyListeners();
    } catch (e) {
      debugPrint('ChatViewModel sendMessage error: $e');
      _isSending = false;
      _error = e.toString();
      
      // Mark user message as failed
      final index = _messages.indexWhere((m) => m.id == tempId);
      if (index != -1) {
        _messages[index] = optimisticMessage.copyWith(status: MessageStatus.failed);
      }
      notifyListeners();
    }
  }

  Future<void> disconnect() async {
    try {
      final connections = await _getGatewayConnectionListUseCase.execute(
        ListQueryParams<GatewayConnection>(),
        null,
      );
      
      for (final connection in connections) {
        await _deleteGatewayConnectionUseCase.execute(
          DeleteParams(id: connection.id),
          null,
        );
      }
    } catch (e) {
      debugPrint('ChatViewModel disconnect error: $e');
      _error = e.toString();
      notifyListeners();
      rethrow;
    }
  }
}
