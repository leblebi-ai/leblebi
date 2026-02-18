// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'gateway_connection.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GatewayConnection _$GatewayConnectionFromJson(Map<String, dynamic> json) =>
    GatewayConnection(
      id: json['id'] as String,
      providerType: $enumDecode(_$AIProviderTypeEnumMap, json['providerType']),
      name: json['name'] as String,
      url: json['url'] as String,
      pairingCode: json['pairingCode'] as String?,
      bearerToken: json['bearerToken'] as String?,
      status: $enumDecode(_$ConnectionStatusEnumMap, json['status']),
      lastConnectedAt: json['lastConnectedAt'] == null
          ? null
          : DateTime.parse(json['lastConnectedAt'] as String),
      lastErrorAt: json['lastErrorAt'] == null
          ? null
          : DateTime.parse(json['lastErrorAt'] as String),
      lastError: json['lastError'] as String?,
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: DateTime.parse(json['updatedAt'] as String),
    );

Map<String, dynamic> _$GatewayConnectionToJson(GatewayConnection instance) =>
    <String, dynamic>{
      'id': instance.id,
      'providerType': _$AIProviderTypeEnumMap[instance.providerType]!,
      'name': instance.name,
      'url': instance.url,
      'pairingCode': instance.pairingCode,
      'bearerToken': instance.bearerToken,
      'status': _$ConnectionStatusEnumMap[instance.status]!,
      'lastConnectedAt': instance.lastConnectedAt?.toIso8601String(),
      'lastErrorAt': instance.lastErrorAt?.toIso8601String(),
      'lastError': instance.lastError,
      'createdAt': instance.createdAt.toIso8601String(),
      'updatedAt': instance.updatedAt.toIso8601String(),
    };

const _$AIProviderTypeEnumMap = {
  AIProviderType.zeroClaw: 'zeroClaw',
  AIProviderType.picoClaw: 'picoClaw',
  AIProviderType.openClaw: 'openClaw',
};

const _$ConnectionStatusEnumMap = {
  ConnectionStatus.disconnected: 'disconnected',
  ConnectionStatus.connecting: 'connecting',
  ConnectionStatus.connected: 'connected',
  ConnectionStatus.error: 'error',
  ConnectionStatus.reconnecting: 'reconnecting',
};
