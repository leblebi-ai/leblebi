// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'message.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Message _$MessageFromJson(Map<String, dynamic> json) => Message(
  id: json['id'] as String,
  conversationId: json['conversationId'] as String,
  sender: $enumDecode(_$MessageSenderEnumMap, json['sender']),
  content: json['content'] as String,
  status: $enumDecode(_$MessageStatusEnumMap, json['status']),
  timestamp: DateTime.parse(json['timestamp'] as String),
  retryCount: (json['retryCount'] as num?)?.toInt(),
  errorMessage: json['errorMessage'] as String?,
  metadata: json['metadata'] == null
      ? null
      : MessageMetadata.fromJson(json['metadata'] as Map<String, dynamic>),
);

Map<String, dynamic> _$MessageToJson(Message instance) => <String, dynamic>{
  'id': instance.id,
  'conversationId': instance.conversationId,
  'sender': _$MessageSenderEnumMap[instance.sender]!,
  'content': instance.content,
  'status': _$MessageStatusEnumMap[instance.status]!,
  'timestamp': instance.timestamp.toIso8601String(),
  'retryCount': instance.retryCount,
  'errorMessage': instance.errorMessage,
  'metadata': instance.metadata?.toJson(),
};

const _$MessageSenderEnumMap = {
  MessageSender.user: 'user',
  MessageSender.ai: 'ai',
  MessageSender.system: 'system',
};

const _$MessageStatusEnumMap = {
  MessageStatus.pending: 'pending',
  MessageStatus.sent: 'sent',
  MessageStatus.delivered: 'delivered',
  MessageStatus.failed: 'failed',
};
