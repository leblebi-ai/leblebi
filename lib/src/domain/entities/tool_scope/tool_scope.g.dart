// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'tool_scope.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ToolScope _$ToolScopeFromJson(Map<String, dynamic> json) => ToolScope(
  allowedDirectories: (json['allowedDirectories'] as List<dynamic>?)
      ?.map((e) => e as String)
      .toList(),
  allowedDomains: (json['allowedDomains'] as List<dynamic>?)
      ?.map((e) => e as String)
      .toList(),
  allowedCommands: (json['allowedCommands'] as List<dynamic>?)
      ?.map((e) => e as String)
      .toList(),
  workspaceOnly: json['workspaceOnly'] as bool,
);

Map<String, dynamic> _$ToolScopeToJson(ToolScope instance) => <String, dynamic>{
  'allowedDirectories': instance.allowedDirectories,
  'allowedDomains': instance.allowedDomains,
  'allowedCommands': instance.allowedCommands,
  'workspaceOnly': instance.workspaceOnly,
};
