// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'workspace.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Workspace _$WorkspaceFromJson(Map<String, dynamic> json) => Workspace(
  id: json['id'] as String,
  name: json['name'] as String,
  description: json['description'] as String?,
  gatewayConnectionId: json['gatewayConnectionId'] as String?,
  identityConfig: IdentityConfig.fromJson(
    json['identityConfig'] as Map<String, dynamic>,
  ),
  toolConfigurations: (json['toolConfigurations'] as List<dynamic>)
      .map((e) => ToolConfiguration.fromJson(e as Map<String, dynamic>))
      .toList(),
  activeConversationId: json['activeConversationId'] as String?,
  createdAt: DateTime.parse(json['createdAt'] as String),
  updatedAt: DateTime.parse(json['updatedAt'] as String),
  isDeleted: json['isDeleted'] as bool,
);

Map<String, dynamic> _$WorkspaceToJson(Workspace instance) => <String, dynamic>{
  'id': instance.id,
  'name': instance.name,
  'description': instance.description,
  'gatewayConnectionId': instance.gatewayConnectionId,
  'identityConfig': instance.identityConfig.toJson(),
  'toolConfigurations': instance.toolConfigurations
      .map((e) => e.toJson())
      .toList(),
  'activeConversationId': instance.activeConversationId,
  'createdAt': instance.createdAt.toIso8601String(),
  'updatedAt': instance.updatedAt.toIso8601String(),
  'isDeleted': instance.isDeleted,
};
