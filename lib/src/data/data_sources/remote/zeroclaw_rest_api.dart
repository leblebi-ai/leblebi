import 'dart:convert';
import 'package:http/http.dart' as http;

class ZeroClawRestApi {
  ZeroClawRestApi({http.Client? client}) : _client = client ?? http.Client();

  final http.Client _client;

  Future<Map<String, dynamic>> pair(String baseUrl, String code) async {
    final response = await _client.post(
      Uri.parse('$baseUrl/pair'),
      headers: {
        'Content-Type': 'application/json',
        'X-Pairing-Code': code,
      },
      body: jsonEncode({}),
    );

    if (response.statusCode == 200) {
      return jsonDecode(response.body) as Map<String, dynamic>;
    } else {
      print('ZeroClaw API Error (pair): ${response.statusCode} ${response.body}');
      throw Exception('Pairing failed: ${response.body}');
    }
  }

  Future<Map<String, dynamic>> sendMessage(
    String baseUrl,
    String token,
    String message,
  ) async {
    final response = await _client.post(
      Uri.parse('$baseUrl/webhook'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
      body: jsonEncode({'message': message}),
    );

    if (response.statusCode == 200) {
      // Handle raw string response or JSON
      try {
        return jsonDecode(response.body) as Map<String, dynamic>;
      } catch (_) {
        // If not JSON, maybe just text?
        // But the return type is Map.
        // Wrap it.
        return {'content': response.body};
      }
    } else {
      print('ZeroClaw API Error (sendMessage): ${response.statusCode} ${response.body}');
      throw Exception('Failed to send message: ${response.body}');
    }
  }

  Future<bool> checkHealth(String baseUrl) async {
    try {
      final response = await _client.get(Uri.parse('$baseUrl/health'));
      return response.statusCode == 200;
    } catch (_) {
      return false;
    }
  }
}
