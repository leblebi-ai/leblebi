// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'message_metadata.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MessageMetadata _$MessageMetadataFromJson(Map<String, dynamic> json) =>
    MessageMetadata(
      tokenCount: (json['tokenCount'] as num?)?.toInt(),
      model: json['model'] as String?,
      temperature: (json['temperature'] as num?)?.toDouble(),
      provider: json['provider'] as String?,
      latencyMs: (json['latencyMs'] as num?)?.toInt(),
    );

Map<String, dynamic> _$MessageMetadataToJson(MessageMetadata instance) =>
    <String, dynamic>{
      'tokenCount': instance.tokenCount,
      'model': instance.model,
      'temperature': instance.temperature,
      'provider': instance.provider,
      'latencyMs': instance.latencyMs,
    };
