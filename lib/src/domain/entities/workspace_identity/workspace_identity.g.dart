// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'workspace_identity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

WorkspaceIdentity _$WorkspaceIdentityFromJson(Map<String, dynamic> json) =>
    WorkspaceIdentity(
      name: json['name'] as String,
      persona: json['persona'] as String?,
      systemPrompt: json['systemPrompt'] as String?,
      toolConfigs: json['toolConfigs'] as Map<String, dynamic>?,
    );

Map<String, dynamic> _$WorkspaceIdentityToJson(WorkspaceIdentity instance) =>
    <String, dynamic>{
      'name': instance.name,
      'persona': instance.persona,
      'systemPrompt': instance.systemPrompt,
      'toolConfigs': instance.toolConfigs,
    };
