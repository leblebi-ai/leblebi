import 'dart:convert';
import 'package:http/http.dart' as http;

class ZeroClawRestApi {
  ZeroClawRestApi({http.Client? client}) : _client = client ?? http.Client();

  final http.Client _client;

  Future<Map<String, dynamic>> pair(String baseUrl, String code) async {
    final response = await _client.post(
      Uri.parse('$baseUrl/pair'),
      headers: {'Content-Type': 'application/json', 'X-Pairing-Code': code},
      body: jsonEncode({}),
    );

    if (response.statusCode == 200) {
      return jsonDecode(response.body) as Map<String, dynamic>;
    } else {
      print(
        'ZeroClaw API Error (pair): ${response.statusCode} ${response.body}',
      );
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
      print(
        'ZeroClaw API Error (sendMessage): ${response.statusCode} ${response.body}',
      );
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

  // ==================== Workspace Endpoints ====================

  /// Get all workspaces
  /// GET /workspaces
  Future<List<Map<String, dynamic>>> getWorkspaces(
    String baseUrl,
    String token, {
    bool includeDeleted = false,
  }) async {
    final uri = Uri.parse('$baseUrl/workspaces').replace(
      queryParameters: includeDeleted ? {'include_deleted': 'true'} : {},
    );

    final response = await _client.get(
      uri,
      headers: {'Authorization': 'Bearer $token'},
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body) as Map<String, dynamic>;
      return (data['workspaces'] as List).cast<Map<String, dynamic>>();
    } else {
      print(
        'ZeroClaw API Error (getWorkspaces): ${response.statusCode} ${response.body}',
      );
      throw Exception('Failed to get workspaces: ${response.body}');
    }
  }

  /// Get workspace by ID
  /// GET /workspaces/{id}
  Future<Map<String, dynamic>> getWorkspace(
    String baseUrl,
    String token,
    String workspaceId,
  ) async {
    final response = await _client.get(
      Uri.parse('$baseUrl/workspaces/$workspaceId'),
      headers: {'Authorization': 'Bearer $token'},
    );

    if (response.statusCode == 200) {
      return jsonDecode(response.body) as Map<String, dynamic>;
    } else {
      print(
        'ZeroClaw API Error (getWorkspace): ${response.statusCode} ${response.body}',
      );
      throw Exception('Failed to get workspace: ${response.body}');
    }
  }

  /// Create new workspace
  /// POST /workspaces
  Future<Map<String, dynamic>> createWorkspace(
    String baseUrl,
    String token,
    Map<String, dynamic> workspaceData,
  ) async {
    final response = await _client.post(
      Uri.parse('$baseUrl/workspaces'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
      body: jsonEncode(workspaceData),
    );

    if (response.statusCode == 201 || response.statusCode == 200) {
      return jsonDecode(response.body) as Map<String, dynamic>;
    } else {
      print(
        'ZeroClaw API Error (createWorkspace): ${response.statusCode} ${response.body}',
      );
      throw Exception('Failed to create workspace: ${response.body}');
    }
  }

  /// Update workspace
  /// PUT /workspaces/{id}
  Future<Map<String, dynamic>> updateWorkspace(
    String baseUrl,
    String token,
    String workspaceId,
    Map<String, dynamic> workspaceData,
  ) async {
    final response = await _client.put(
      Uri.parse('$baseUrl/workspaces/$workspaceId'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
      body: jsonEncode(workspaceData),
    );

    if (response.statusCode == 200) {
      return jsonDecode(response.body) as Map<String, dynamic>;
    } else {
      print(
        'ZeroClaw API Error (updateWorkspace): ${response.statusCode} ${response.body}',
      );
      throw Exception('Failed to update workspace: ${response.body}');
    }
  }

  /// Soft delete workspace (move to trash)
  /// DELETE /workspaces/{id}
  Future<void> deleteWorkspace(
    String baseUrl,
    String token,
    String workspaceId,
  ) async {
    final response = await _client.delete(
      Uri.parse('$baseUrl/workspaces/$workspaceId'),
      headers: {'Authorization': 'Bearer $token'},
    );

    if (response.statusCode != 200 && response.statusCode != 204) {
      print(
        'ZeroClaw API Error (deleteWorkspace): ${response.statusCode} ${response.body}',
      );
      throw Exception('Failed to delete workspace: ${response.body}');
    }
  }

  /// Restore workspace from trash
  /// POST /workspaces/{id}/restore
  Future<Map<String, dynamic>> restoreWorkspace(
    String baseUrl,
    String token,
    String workspaceId,
  ) async {
    final response = await _client.post(
      Uri.parse('$baseUrl/workspaces/$workspaceId/restore'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
      body: jsonEncode({}),
    );

    if (response.statusCode == 200) {
      return jsonDecode(response.body) as Map<String, dynamic>;
    } else {
      print(
        'ZeroClaw API Error (restoreWorkspace): ${response.statusCode} ${response.body}',
      );
      throw Exception('Failed to restore workspace: ${response.body}');
    }
  }

  /// Permanently delete workspace
  /// DELETE /workspaces/{id}/permanent
  Future<void> permanentDeleteWorkspace(
    String baseUrl,
    String token,
    String workspaceId,
  ) async {
    final response = await _client.delete(
      Uri.parse('$baseUrl/workspaces/$workspaceId/permanent'),
      headers: {'Authorization': 'Bearer $token'},
    );

    if (response.statusCode != 200 && response.statusCode != 204) {
      print(
        'ZeroClaw API Error (permanentDeleteWorkspace): ${response.statusCode} ${response.body}',
      );
      throw Exception(
        'Failed to permanently delete workspace: ${response.body}',
      );
    }
  }

  /// Get conversations by workspace
  /// GET /workspaces/{id}/conversations
  Future<List<Map<String, dynamic>>> getConversationsByWorkspace(
    String baseUrl,
    String token,
    String workspaceId,
  ) async {
    final response = await _client.get(
      Uri.parse('$baseUrl/workspaces/$workspaceId/conversations'),
      headers: {'Authorization': 'Bearer $token'},
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body) as Map<String, dynamic>;
      return (data['conversations'] as List).cast<Map<String, dynamic>>();
    } else {
      print(
        'ZeroClaw API Error (getConversationsByWorkspace): ${response.statusCode} ${response.body}',
      );
      throw Exception('Failed to get conversations: ${response.body}');
    }
  }

  /// Purge expired trash
  /// POST /workspaces/purge-expired
  Future<int> purgeExpiredTrash(String baseUrl, String token) async {
    final response = await _client.post(
      Uri.parse('$baseUrl/workspaces/purge-expired'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
      body: jsonEncode({}),
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body) as Map<String, dynamic>;
      return data['purged_count'] as int;
    } else {
      print(
        'ZeroClaw API Error (purgeExpiredTrash): ${response.statusCode} ${response.body}',
      );
      throw Exception('Failed to purge expired trash: ${response.body}');
    }
  }

  // ==================== Conversation Endpoints (Workspace-Scoped) ====================

  /// Get conversation by ID within a workspace
  /// GET /workspaces/{workspaceId}/conversations/{conversationId}
  Future<Map<String, dynamic>> getConversation(
    String baseUrl,
    String token,
    String workspaceId,
    String conversationId,
  ) async {
    final response = await _client.get(
      Uri.parse(
        '$baseUrl/workspaces/$workspaceId/conversations/$conversationId',
      ),
      headers: {'Authorization': 'Bearer $token'},
    );

    if (response.statusCode == 200) {
      return jsonDecode(response.body) as Map<String, dynamic>;
    } else {
      print(
        'ZeroClaw API Error (getConversation): ${response.statusCode} ${response.body}',
      );
      throw Exception('Failed to get conversation: ${response.body}');
    }
  }

  /// Create conversation in workspace
  /// POST /workspaces/{workspaceId}/conversations
  Future<Map<String, dynamic>> createConversation(
    String baseUrl,
    String token,
    String workspaceId,
    Map<String, dynamic> conversationData,
  ) async {
    final response = await _client.post(
      Uri.parse('$baseUrl/workspaces/$workspaceId/conversations'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
      body: jsonEncode(conversationData),
    );

    if (response.statusCode == 201 || response.statusCode == 200) {
      return jsonDecode(response.body) as Map<String, dynamic>;
    } else {
      print(
        'ZeroClaw API Error (createConversation): ${response.statusCode} ${response.body}',
      );
      throw Exception('Failed to create conversation: ${response.body}');
    }
  }

  /// Update conversation
  /// PUT /workspaces/{workspaceId}/conversations/{conversationId}
  Future<Map<String, dynamic>> updateConversation(
    String baseUrl,
    String token,
    String workspaceId,
    String conversationId,
    Map<String, dynamic> conversationData,
  ) async {
    final response = await _client.put(
      Uri.parse(
        '$baseUrl/workspaces/$workspaceId/conversations/$conversationId',
      ),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
      body: jsonEncode(conversationData),
    );

    if (response.statusCode == 200) {
      return jsonDecode(response.body) as Map<String, dynamic>;
    } else {
      print(
        'ZeroClaw API Error (updateConversation): ${response.statusCode} ${response.body}',
      );
      throw Exception('Failed to update conversation: ${response.body}');
    }
  }

  /// Delete conversation
  /// DELETE /workspaces/{workspaceId}/conversations/{conversationId}
  Future<void> deleteConversation(
    String baseUrl,
    String token,
    String workspaceId,
    String conversationId,
  ) async {
    final response = await _client.delete(
      Uri.parse(
        '$baseUrl/workspaces/$workspaceId/conversations/$conversationId',
      ),
      headers: {'Authorization': 'Bearer $token'},
    );

    if (response.statusCode != 200 && response.statusCode != 204) {
      print(
        'ZeroClaw API Error (deleteConversation): ${response.statusCode} ${response.body}',
      );
      throw Exception('Failed to delete conversation: ${response.body}');
    }
  }
}
