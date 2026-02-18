// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'workspace.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Workspace _$WorkspaceFromJson(Map<String, dynamic> json) => Workspace(
  identity: WorkspaceIdentity.fromJson(
    json['identity'] as Map<String, dynamic>,
  ),
  gatewayConnectionId: json['gatewayConnectionId'] as String,
  createdAt: DateTime.parse(json['createdAt'] as String),
  updatedAt: json['updatedAt'] == null
      ? null
      : DateTime.parse(json['updatedAt'] as String),
  deletedAt: json['deletedAt'] == null
      ? null
      : DateTime.parse(json['deletedAt'] as String),
  id: json['id'] as String,
);

Map<String, dynamic> _$WorkspaceToJson(Workspace instance) => <String, dynamic>{
  'identity': instance.identity.toJson(),
  'gatewayConnectionId': instance.gatewayConnectionId,
  'createdAt': instance.createdAt.toIso8601String(),
  'updatedAt': instance.updatedAt?.toIso8601String(),
  'deletedAt': instance.deletedAt?.toIso8601String(),
  'id': instance.id,
};
