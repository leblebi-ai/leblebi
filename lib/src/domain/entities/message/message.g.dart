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
  timestamp: DateTime.parse(json['timestamp'] as String),
  status: $enumDecodeNullable(_$MessageStatusEnumMap, json['status']),
  toolCalls: (json['toolCalls'] as List<dynamic>?)
      ?.map((e) => ToolCall.fromJson(e as Map<String, dynamic>))
      .toList(),
  attachments: (json['attachments'] as List<dynamic>?)
      ?.map((e) => Attachment.fromJson(e as Map<String, dynamic>))
      .toList(),
  metadata: json['metadata'] == null
      ? null
      : MessageMetadata.fromJson(json['metadata'] as Map<String, dynamic>),
  replyToMessageId: json['replyToMessageId'] as String?,
  isEdited: json['isEdited'] as bool,
  editedAt: json['editedAt'] == null
      ? null
      : DateTime.parse(json['editedAt'] as String),
);

Map<String, dynamic> _$MessageToJson(Message instance) => <String, dynamic>{
  'id': instance.id,
  'conversationId': instance.conversationId,
  'sender': _$MessageSenderEnumMap[instance.sender]!,
  'content': instance.content,
  'timestamp': instance.timestamp.toIso8601String(),
  'status': _$MessageStatusEnumMap[instance.status],
  'toolCalls': instance.toolCalls?.map((e) => e.toJson()).toList(),
  'attachments': instance.attachments?.map((e) => e.toJson()).toList(),
  'metadata': instance.metadata?.toJson(),
  'replyToMessageId': instance.replyToMessageId,
  'isEdited': instance.isEdited,
  'editedAt': instance.editedAt?.toIso8601String(),
};

const _$MessageSenderEnumMap = {
  MessageSender.USER: 'USER',
  MessageSender.AI: 'AI',
  MessageSender.SYSTEM: 'SYSTEM',
};

const _$MessageStatusEnumMap = {
  MessageStatus.PENDING: 'PENDING',
  MessageStatus.SENT: 'SENT',
  MessageStatus.DELIVERED: 'DELIVERED',
  MessageStatus.FAILED: 'FAILED',
};
