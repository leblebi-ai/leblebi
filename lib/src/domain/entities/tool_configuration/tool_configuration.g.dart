// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'tool_configuration.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ToolConfiguration _$ToolConfigurationFromJson(Map<String, dynamic> json) =>
    ToolConfiguration(
      id: json['id'] as String,
      workspaceId: json['workspaceId'] as String,
      toolName: json['toolName'] as String,
      isEnabled: json['isEnabled'] as bool,
      scope: json['scope'] == null
          ? null
          : ToolScope.fromJson(json['scope'] as Map<String, dynamic>),
      permissions: (json['permissions'] as List<dynamic>)
          .map((e) => $enumDecode(_$ToolPermissionEnumMap, e))
          .toList(),
      configOverrides: json['configOverrides'] as Map<String, dynamic>?,
      lastUsedAt: json['lastUsedAt'] == null
          ? null
          : DateTime.parse(json['lastUsedAt'] as String),
      usageCount: (json['usageCount'] as num).toInt(),
    );

Map<String, dynamic> _$ToolConfigurationToJson(ToolConfiguration instance) =>
    <String, dynamic>{
      'id': instance.id,
      'workspaceId': instance.workspaceId,
      'toolName': instance.toolName,
      'isEnabled': instance.isEnabled,
      'scope': instance.scope?.toJson(),
      'permissions': instance.permissions
          .map((e) => _$ToolPermissionEnumMap[e]!)
          .toList(),
      'configOverrides': instance.configOverrides,
      'lastUsedAt': instance.lastUsedAt?.toIso8601String(),
      'usageCount': instance.usageCount,
    };

const _$ToolPermissionEnumMap = {
  ToolPermission.READ: 'READ',
  ToolPermission.WRITE: 'WRITE',
  ToolPermission.EXECUTE: 'EXECUTE',
  ToolPermission.NETWORK: 'NETWORK',
};
