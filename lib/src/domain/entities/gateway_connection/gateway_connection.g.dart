// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'gateway_connection.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GatewayConnection _$GatewayConnectionFromJson(Map<String, dynamic> json) =>
    GatewayConnection(
      id: json['id'] as String,
      name: json['name'] as String,
      url: json['url'] as String,
      pairingCode: json['pairingCode'] as String?,
      bearerToken: json['bearerToken'] as String?,
      tokenExpiresAt: json['tokenExpiresAt'] == null
          ? null
          : DateTime.parse(json['tokenExpiresAt'] as String),
      status: $enumDecode(_$ConnectionStatusEnumMap, json['status']),
      lastConnectedAt: json['lastConnectedAt'] == null
          ? null
          : DateTime.parse(json['lastConnectedAt'] as String),
      lastError: json['lastError'] as String?,
      lastErrorAt: json['lastErrorAt'] == null
          ? null
          : DateTime.parse(json['lastErrorAt'] as String),
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: DateTime.parse(json['updatedAt'] as String),
    );

Map<String, dynamic> _$GatewayConnectionToJson(GatewayConnection instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'url': instance.url,
      'pairingCode': instance.pairingCode,
      'bearerToken': instance.bearerToken,
      'tokenExpiresAt': instance.tokenExpiresAt?.toIso8601String(),
      'status': _$ConnectionStatusEnumMap[instance.status]!,
      'lastConnectedAt': instance.lastConnectedAt?.toIso8601String(),
      'lastError': instance.lastError,
      'lastErrorAt': instance.lastErrorAt?.toIso8601String(),
      'createdAt': instance.createdAt.toIso8601String(),
      'updatedAt': instance.updatedAt.toIso8601String(),
    };

const _$ConnectionStatusEnumMap = {
  ConnectionStatus.DISCONNECTED: 'DISCONNECTED',
  ConnectionStatus.CONNECTING: 'CONNECTING',
  ConnectionStatus.CONNECTED: 'CONNECTED',
  ConnectionStatus.ERROR: 'ERROR',
  ConnectionStatus.RECONNECTING: 'RECONNECTING',
};
