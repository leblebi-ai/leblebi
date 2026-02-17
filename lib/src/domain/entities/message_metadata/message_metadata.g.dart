// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'message_metadata.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MessageMetadata _$MessageMetadataFromJson(Map<String, dynamic> json) =>
    MessageMetadata(
      tokenCount: (json['tokenCount'] as num?)?.toInt(),
      model: json['model'] as String?,
      provider: json['provider'] as String?,
      latencyMs: (json['latencyMs'] as num?)?.toInt(),
      toolCalls: (json['toolCalls'] as List<dynamic>?)
          ?.map((e) => ToolCall.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$MessageMetadataToJson(MessageMetadata instance) =>
    <String, dynamic>{
      'tokenCount': instance.tokenCount,
      'model': instance.model,
      'provider': instance.provider,
      'latencyMs': instance.latencyMs,
      'toolCalls': instance.toolCalls?.map((e) => e.toJson()).toList(),
    };
