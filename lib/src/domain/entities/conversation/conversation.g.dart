// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'conversation.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Conversation _$ConversationFromJson(Map<String, dynamic> json) => Conversation(
  id: json['id'] as String,
  workspaceId: json['workspaceId'] as String,
  title: json['title'] as String,
  messages: (json['messages'] as List<dynamic>)
      .map((e) => Message.fromJson(e as Map<String, dynamic>))
      .toList(),
  createdAt: DateTime.parse(json['createdAt'] as String),
  updatedAt: DateTime.parse(json['updatedAt'] as String),
  lastMessageAt: json['lastMessageAt'] == null
      ? null
      : DateTime.parse(json['lastMessageAt'] as String),
  messageCount: (json['messageCount'] as num).toInt(),
  isArchived: json['isArchived'] as bool,
  metadata: json['metadata'] as Map<String, dynamic>?,
);

Map<String, dynamic> _$ConversationToJson(Conversation instance) =>
    <String, dynamic>{
      'id': instance.id,
      'workspaceId': instance.workspaceId,
      'title': instance.title,
      'messages': instance.messages.map((e) => e.toJson()).toList(),
      'createdAt': instance.createdAt.toIso8601String(),
      'updatedAt': instance.updatedAt.toIso8601String(),
      'lastMessageAt': instance.lastMessageAt?.toIso8601String(),
      'messageCount': instance.messageCount,
      'isArchived': instance.isArchived,
      'metadata': instance.metadata,
    };
