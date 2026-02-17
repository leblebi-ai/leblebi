import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../../domain/entities/gateway_connection/gateway_connection.dart';
import '../../../domain/entities/conversation/conversation.dart';
import '../../../domain/entities/message/message.dart';
import 'zeroclaw_api_datasource.dart';

/// GraphQL to REST Adapter
///
/// Translates client-side GraphQL operations to ZeroClaw REST API calls.
/// Subscriptions are simulated via HTTP polling since ZeroClaw doesn't support true push.
///
/// REST API Mapping:
/// | GraphQL Operation      | REST Endpoint | Method |
/// |------------------------|---------------|--------|
/// | connectGateway         | /pair         | POST   |
/// | sendMessage            | /webhook      | POST   |
/// | testConnection         | /health       | GET    |
/// | GetConversation        | N/A (local)   | -      |
/// | GetGatewayConnection   | N/A (local)   | -      |
class GraphqlToRestAdapter {
  final ZeroClawApiDatasource _apiDatasource;

  GraphqlToRestAdapter({required ZeroClawApiDatasource apiDatasource})
    : _apiDatasource = apiDatasource;

  /// Execute ConnectGateway mutation
  /// POST /pair with X-Pairing-Code header
  Future<String> connectGateway({
    required String url,
    required String pairingCode,
  }) async {
    // Update API datasource with new base URL
    // Pairing code exchange happens in ZeroClawApiDatasource
    return await _apiDatasource.pair(pairingCode);
  }

  /// Execute SendMessage mutation
  /// POST /webhook with {"message": content}
  Future<Map<String, dynamic>> sendMessage({
    required String conversationId,
    required String content,
  }) async {
    final response = await _apiDatasource.webhook(content);
    return json.decode(response) as Map<String, dynamic>;
  }

  /// Execute TestConnection query
  /// GET /health
  Future<bool> testConnection() async {
    return await _apiDatasource.healthCheck();
  }

  /// Simulate MessageReceived subscription via polling
  /// Poll every 2 seconds to check for new messages
  Stream<Map<String, dynamic>> messageReceived({
    required String conversationId,
    Duration interval = const Duration(seconds: 2),
  }) async* {
    while (true) {
      try {
        // In a real implementation, this would fetch the latest messages
        // and compare with cached messages to detect new ones
        await Future.delayed(interval);
      } catch (e) {
        // Handle polling errors silently
        await Future.delayed(interval);
      }
    }
  }

  /// Simulate ConnectionStatusChanged subscription via polling
  /// Poll every 1 second to check connection status
  Stream<Map<String, dynamic>> connectionStatusChanged({
    Duration interval = const Duration(seconds: 1),
  }) async* {
    while (true) {
      try {
        final isConnected = await testConnection();
        yield {
          'status': isConnected ? 'connected' : 'disconnected',
          'timestamp': DateTime.now().toIso8601String(),
        };
        await Future.delayed(interval);
      } catch (e) {
        yield {
          'status': 'error',
          'error': e.toString(),
          'timestamp': DateTime.now().toIso8601String(),
        };
        await Future.delayed(interval);
      }
    }
  }
}
