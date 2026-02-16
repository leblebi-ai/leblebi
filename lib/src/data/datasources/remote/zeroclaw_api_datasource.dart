import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/foundation.dart';

/// ZeroClaw Gateway API Datasource
///
/// Implements communication with ZeroClaw gateway REST API:
/// - POST /pair - Exchange pairing code for bearer token
/// - POST /webhook - Send messages and receive responses
/// - GET /health - Health check
///
/// References:
/// - https://github.com/zeroclaw-labs/zeroclaw
/// - specs/001-zeroclaw-integration/contracts/schema.graphql
class ZeroClawApiDatasource {
  final String baseUrl;
  final String? bearerToken;
  final http.Client _client;

  ZeroClawApiDatasource({
    required this.baseUrl,
    this.bearerToken,
    http.Client? client,
  }) : _client = client ?? http.Client();

  /// Pair with gateway using one-time pairing code
  /// Returns bearer token for subsequent requests
  Future<String> pair(String pairingCode) async {
    try {
      final response = await _client.post(
        Uri.parse('$baseUrl/pair'),
        headers: {
          'Content-Type': 'application/json',
          'X-Pairing-Code': pairingCode,
        },
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        return data['token'] as String;
      } else {
        throw ZeroClawApiException(
          'Pairing failed: ${response.statusCode}',
          response.statusCode,
          response.body,
        );
      }
    } catch (e) {
      if (e is ZeroClawApiException) rethrow;
      throw ZeroClawApiException('Network error: $e', 0, '');
    }
  }

  /// Send message to ZeroClaw agent via webhook
  /// Returns AI response message
  Future<ZeroClawMessageResponse> sendMessage(String message) async {
    if (bearerToken == null) {
      throw ZeroClawApiException(
        'Not authenticated. Call pair() first.',
        401,
        '',
      );
    }

    try {
      final response = await _client.post(
        Uri.parse('$baseUrl/webhook'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $bearerToken',
        },
        body: json.encode({'message': message}),
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        return ZeroClawMessageResponse.fromJson(data);
      } else {
        throw ZeroClawApiException(
          'Message failed: ${response.statusCode}',
          response.statusCode,
          response.body,
        );
      }
    } catch (e) {
      if (e is ZeroClawApiException) rethrow;
      throw ZeroClawApiException('Network error: $e', 0, '');
    }
  }

  /// Check gateway health
  Future<bool> healthCheck() async {
    try {
      final response = await _client.get(Uri.parse('$baseUrl/health'));
      return response.statusCode == 200;
    } catch (e) {
      debugPrint('Health check failed: $e');
      return false;
    }
  }

  /// Dispose HTTP client
  void dispose() {
    _client.close();
  }
}

/// ZeroClaw message response model
class ZeroClawMessageResponse {
  final String message;
  final String? provider;
  final String? model;
  final int? latencyMs;
  final Map<String, dynamic>? metadata;

  ZeroClawMessageResponse({
    required this.message,
    this.provider,
    this.model,
    this.latencyMs,
    this.metadata,
  });

  factory ZeroClawMessageResponse.fromJson(Map<String, dynamic> json) {
    return ZeroClawMessageResponse(
      message: json['message'] as String,
      provider: json['provider'] as String?,
      model: json['model'] as String?,
      latencyMs: json['latencyMs'] as int?,
      metadata: json['metadata'] as Map<String, dynamic>?,
    );
  }
}

/// ZeroClaw API exception
class ZeroClawApiException implements Exception {
  final String message;
  final int statusCode;
  final String responseBody;

  ZeroClawApiException(this.message, this.statusCode, this.responseBody);

  @override
  String toString() => 'ZeroClawApiException($statusCode): $message';
}
