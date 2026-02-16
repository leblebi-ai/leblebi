// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'identity_config.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

IdentityConfig _$IdentityConfigFromJson(Map<String, dynamic> json) =>
    IdentityConfig(
      name: json['name'] as String,
      personality: json['personality'] as String?,
      systemPrompt: json['systemPrompt'] as String?,
      model: json['model'] as String,
      temperature: (json['temperature'] as num).toDouble(),
      autonomyLevel: $enumDecode(_$AutonomyLevelEnumMap, json['autonomyLevel']),
    );

Map<String, dynamic> _$IdentityConfigToJson(IdentityConfig instance) =>
    <String, dynamic>{
      'name': instance.name,
      'personality': instance.personality,
      'systemPrompt': instance.systemPrompt,
      'model': instance.model,
      'temperature': instance.temperature,
      'autonomyLevel': _$AutonomyLevelEnumMap[instance.autonomyLevel]!,
    };

const _$AutonomyLevelEnumMap = {
  AutonomyLevel.SUPERVISED: 'SUPERVISED',
  AutonomyLevel.SEMI_AUTONOMOUS: 'SEMI_AUTONOMOUS',
  AutonomyLevel.AUTONOMOUS: 'AUTONOMOUS',
};
