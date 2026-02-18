import 'dart:convert';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:zuraffa/zuraffa.dart';

import '../../../domain/entities/gateway_connection/gateway_connection.dart';
import 'gateway_connection_data_source.dart';

class GatewayConnectionLocalDataSource
    with Loggable, FailureHandler
    implements GatewayConnectionDataSource {
  GatewayConnectionLocalDataSource(this._secureStorage);

  final FlutterSecureStorage _secureStorage;
  static const String boxName = 'gateway_connections';

  Future<Box<String>> get _box async {
    if (!Hive.isBoxOpen(boxName)) {
      return await Hive.openBox<String>(boxName);
    }
    return Hive.box<String>(boxName);
  }

  @override
  Future<GatewayConnection> get(QueryParams<GatewayConnection> params) async {
    final box = await _box;
    if (box.isEmpty) {
      throw NotFoundFailure('No gateway connection found');
    }

    // For MVP, return first connection found (assuming only one active)
    final jsonStr = box.values.first;
    final jsonMap = jsonDecode(jsonStr) as Map<String, dynamic>;
    final id = jsonMap['id'] as String;

    // Retrieve token securely
    final token = await _secureStorage.read(key: 'token_$id');
    if (token != null) {
      jsonMap['bearerToken'] = token;
    }

    return GatewayConnection.fromJson(jsonMap);
  }

  @override
  Future<List<GatewayConnection>> getList(
    ListQueryParams<GatewayConnection> params,
  ) async {
    final box = await _box;
    final connections = <GatewayConnection>[];

    for (final jsonStr in box.values) {
      final jsonMap = jsonDecode(jsonStr) as Map<String, dynamic>;
      final id = jsonMap['id'] as String;

      final token = await _secureStorage.read(key: 'token_$id');
      if (token != null) {
        jsonMap['bearerToken'] = token;
      }
      connections.add(GatewayConnection.fromJson(jsonMap));
    }

    return connections;
  }

  @override
  Future<GatewayConnection> create(GatewayConnection gatewayConnection) async {
    final box = await _box;
    final token = gatewayConnection.bearerToken;

    if (token != null) {
      try {
        await _secureStorage.write(
          key: 'token_${gatewayConnection.id}',
          value: token,
        );
      } catch (e) {
        // Fallback or rethrow with clear message
        print('SecureStorage Write Error: $e');
        // If secure storage fails, we might still want to proceed but warn
        // For now, let's rethrow but log it
        rethrow;
      }
    }

    final jsonMap = gatewayConnection.toJson();
    jsonMap['bearerToken'] = null; // Don't store token in Hive

    await box.put(gatewayConnection.id, jsonEncode(jsonMap));
    return gatewayConnection;
  }

  @override
  Future<GatewayConnection> update(
    UpdateParams<String, Partial<GatewayConnection>> params,
  ) async {
    // For MVP, we'll implement simple overwrite if we can get the full object
    // Or if params.data is handled carefully.
    // Zuraffa's update usually expects partial data.
    // Implementing full partial update logic manually is complex.
    // For now, throw unimplemented as we rely on create (overwrite) for updates mostly.
    // Or check if params.id exists and overwrite.

    throw UnimplementedError('Update not implemented yet');
  }

  @override
  Future<void> delete(DeleteParams<String> params) async {
    final box = await _box;
    final id = params.id;
    await box.delete(id);
    await _secureStorage.delete(key: 'token_$id');
  }
}
