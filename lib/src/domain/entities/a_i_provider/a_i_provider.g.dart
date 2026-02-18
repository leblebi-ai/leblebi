// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'a_i_provider.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AIProvider _$AIProviderFromJson(Map<String, dynamic> json) => AIProvider(
  type: $enumDecode(_$AIProviderTypeEnumMap, json['type']),
  name: json['name'] as String,
  version: json['version'] as String,
  supportedProtocols: (json['supportedProtocols'] as List<dynamic>)
      .map((e) => e as String)
      .toList(),
  authMechanism: json['authMechanism'] as String,
  endpoints: ApiEndpoints.fromJson(json['endpoints'] as Map<String, dynamic>),
);

Map<String, dynamic> _$AIProviderToJson(AIProvider instance) =>
    <String, dynamic>{
      'type': _$AIProviderTypeEnumMap[instance.type]!,
      'name': instance.name,
      'version': instance.version,
      'supportedProtocols': instance.supportedProtocols,
      'authMechanism': instance.authMechanism,
      'endpoints': instance.endpoints.toJson(),
    };

const _$AIProviderTypeEnumMap = {
  AIProviderType.zeroClaw: 'zeroClaw',
  AIProviderType.picoClaw: 'picoClaw',
  AIProviderType.openClaw: 'openClaw',
};
