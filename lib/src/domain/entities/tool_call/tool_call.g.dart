// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'tool_call.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ToolCall _$ToolCallFromJson(Map<String, dynamic> json) => ToolCall(
  toolName: json['toolName'] as String,
  arguments: json['arguments'] as Map<String, dynamic>,
  status: $enumDecode(_$ToolCallStatusEnumMap, json['status']),
  result: json['result'] as String?,
  error: json['error'] as String?,
  executedAt: json['executedAt'] == null
      ? null
      : DateTime.parse(json['executedAt'] as String),
);

Map<String, dynamic> _$ToolCallToJson(ToolCall instance) => <String, dynamic>{
  'toolName': instance.toolName,
  'arguments': instance.arguments,
  'status': _$ToolCallStatusEnumMap[instance.status]!,
  'result': instance.result,
  'error': instance.error,
  'executedAt': instance.executedAt?.toIso8601String(),
};

const _$ToolCallStatusEnumMap = {
  ToolCallStatus.PENDING: 'PENDING',
  ToolCallStatus.EXECUTING: 'EXECUTING',
  ToolCallStatus.SUCCESS: 'SUCCESS',
  ToolCallStatus.ERROR: 'ERROR',
};
