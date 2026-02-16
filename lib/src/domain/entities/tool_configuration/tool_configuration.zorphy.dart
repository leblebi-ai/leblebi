// dart format width=80
// ignore_for_file: UNNECESSARY_CAST
// ignore_for_file: type=lint

part of 'tool_configuration.dart';

// **************************************************************************
// ZorphyGenerator
// **************************************************************************

@JsonSerializable(explicitToJson: true)
class ToolConfiguration {
  final String id;
  final String workspaceId;
  final String toolName;
  final bool isEnabled;
  final ToolScope? scope;
  final List<ToolPermission> permissions;
  final Map<String, dynamic>? configOverrides;
  final DateTime? lastUsedAt;
  final int usageCount;

  ToolConfiguration({
    required this.id,
    required this.workspaceId,
    required this.toolName,
    required this.isEnabled,
    this.scope,
    required this.permissions,
    this.configOverrides,
    this.lastUsedAt,
    required this.usageCount,
  });

  ToolConfiguration copyWith({
    String? id,
    String? workspaceId,
    String? toolName,
    bool? isEnabled,
    ToolScope? scope,
    List<ToolPermission>? permissions,
    Map<String, dynamic>? configOverrides,
    DateTime? lastUsedAt,
    int? usageCount,
  }) {
    return ToolConfiguration(
      id: id ?? this.id,
      workspaceId: workspaceId ?? this.workspaceId,
      toolName: toolName ?? this.toolName,
      isEnabled: isEnabled ?? this.isEnabled,
      scope: scope ?? this.scope,
      permissions: permissions ?? this.permissions,
      configOverrides: configOverrides ?? this.configOverrides,
      lastUsedAt: lastUsedAt ?? this.lastUsedAt,
      usageCount: usageCount ?? this.usageCount,
    );
  }

  ToolConfiguration copyWithToolConfiguration({
    String? id,
    String? workspaceId,
    String? toolName,
    bool? isEnabled,
    ToolScope? scope,
    List<ToolPermission>? permissions,
    Map<String, dynamic>? configOverrides,
    DateTime? lastUsedAt,
    int? usageCount,
  }) {
    return copyWith(
      id: id,
      workspaceId: workspaceId,
      toolName: toolName,
      isEnabled: isEnabled,
      scope: scope,
      permissions: permissions,
      configOverrides: configOverrides,
      lastUsedAt: lastUsedAt,
      usageCount: usageCount,
    );
  }

  ToolConfiguration patchWithToolConfiguration({
    ToolConfigurationPatch? patchInput,
  }) {
    final _patcher = patchInput ?? ToolConfigurationPatch();
    final _patchMap = _patcher.toPatch();
    return ToolConfiguration(
      id: _patchMap.containsKey(ToolConfiguration$.id)
          ? (_patchMap[ToolConfiguration$.id] is Function)
                ? _patchMap[ToolConfiguration$.id](this.id)
                : _patchMap[ToolConfiguration$.id]
          : this.id,
      workspaceId: _patchMap.containsKey(ToolConfiguration$.workspaceId)
          ? (_patchMap[ToolConfiguration$.workspaceId] is Function)
                ? _patchMap[ToolConfiguration$.workspaceId](this.workspaceId)
                : _patchMap[ToolConfiguration$.workspaceId]
          : this.workspaceId,
      toolName: _patchMap.containsKey(ToolConfiguration$.toolName)
          ? (_patchMap[ToolConfiguration$.toolName] is Function)
                ? _patchMap[ToolConfiguration$.toolName](this.toolName)
                : _patchMap[ToolConfiguration$.toolName]
          : this.toolName,
      isEnabled: _patchMap.containsKey(ToolConfiguration$.isEnabled)
          ? (_patchMap[ToolConfiguration$.isEnabled] is Function)
                ? _patchMap[ToolConfiguration$.isEnabled](this.isEnabled)
                : _patchMap[ToolConfiguration$.isEnabled]
          : this.isEnabled,
      scope: _patchMap.containsKey(ToolConfiguration$.scope)
          ? (_patchMap[ToolConfiguration$.scope] is Function)
                ? _patchMap[ToolConfiguration$.scope](this.scope)
                : _patchMap[ToolConfiguration$.scope]
          : this.scope,
      permissions: _patchMap.containsKey(ToolConfiguration$.permissions)
          ? (_patchMap[ToolConfiguration$.permissions] is Function)
                ? _patchMap[ToolConfiguration$.permissions](this.permissions)
                : _patchMap[ToolConfiguration$.permissions]
          : this.permissions,
      configOverrides: _patchMap.containsKey(ToolConfiguration$.configOverrides)
          ? (_patchMap[ToolConfiguration$.configOverrides] is Function)
                ? _patchMap[ToolConfiguration$.configOverrides](
                    this.configOverrides,
                  )
                : _patchMap[ToolConfiguration$.configOverrides]
          : this.configOverrides,
      lastUsedAt: _patchMap.containsKey(ToolConfiguration$.lastUsedAt)
          ? (_patchMap[ToolConfiguration$.lastUsedAt] is Function)
                ? _patchMap[ToolConfiguration$.lastUsedAt](this.lastUsedAt)
                : _patchMap[ToolConfiguration$.lastUsedAt]
          : this.lastUsedAt,
      usageCount: _patchMap.containsKey(ToolConfiguration$.usageCount)
          ? (_patchMap[ToolConfiguration$.usageCount] is Function)
                ? _patchMap[ToolConfiguration$.usageCount](this.usageCount)
                : _patchMap[ToolConfiguration$.usageCount]
          : this.usageCount,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is ToolConfiguration &&
        id == other.id &&
        workspaceId == other.workspaceId &&
        toolName == other.toolName &&
        isEnabled == other.isEnabled &&
        scope == other.scope &&
        permissions == other.permissions &&
        configOverrides == other.configOverrides &&
        lastUsedAt == other.lastUsedAt &&
        usageCount == other.usageCount;
  }

  @override
  int get hashCode {
    return Object.hash(
      this.id,
      this.workspaceId,
      this.toolName,
      this.isEnabled,
      this.scope,
      this.permissions,
      this.configOverrides,
      this.lastUsedAt,
      this.usageCount,
    );
  }

  @override
  String toString() {
    return 'ToolConfiguration(' +
        'id: ${id}' +
        ', ' +
        'workspaceId: ${workspaceId}' +
        ', ' +
        'toolName: ${toolName}' +
        ', ' +
        'isEnabled: ${isEnabled}' +
        ', ' +
        'scope: ${scope}' +
        ', ' +
        'permissions: ${permissions}' +
        ', ' +
        'configOverrides: ${configOverrides}' +
        ', ' +
        'lastUsedAt: ${lastUsedAt}' +
        ', ' +
        'usageCount: ${usageCount})';
  }

  /// Creates a [ToolConfiguration] instance from JSON
  factory ToolConfiguration.fromJson(Map<String, dynamic> json) =>
      _$ToolConfigurationFromJson(json);

  Map<String, dynamic> toJsonLean() {
    final Map<String, dynamic> data = _$ToolConfigurationToJson(this);
    return _sanitizeJson(data);
  }

  dynamic _sanitizeJson(dynamic json) {
    if (json is Map<String, dynamic>) {
      json.remove('_className_');
      return json..forEach((key, value) {
        json[key] = _sanitizeJson(value);
      });
    } else if (json is List) {
      return json.map((e) => _sanitizeJson(e)).toList();
    }
    return json;
  }
}

extension ToolConfigurationPropertyHelpers on ToolConfiguration {
  bool get hasScope => scope != null;
  bool get noScope => scope == null;
  ToolScope get scopeRequired =>
      scope ?? (throw StateError('scope is required but was null'));
  bool get hasPermissions => permissions.isNotEmpty;
  bool get noPermissions => permissions.isEmpty;
  Map<String, dynamic> get configOverridesRequired =>
      configOverrides ??
      (throw StateError('configOverrides is required but was null'));
  bool get hasConfigOverrides => configOverrides?.isNotEmpty ?? false;
  bool get noConfigOverrides => configOverrides?.isEmpty ?? true;
  bool get hasLastUsedAt => lastUsedAt != null;
  bool get noLastUsedAt => lastUsedAt == null;
  DateTime get lastUsedAtRequired =>
      lastUsedAt ?? (throw StateError('lastUsedAt is required but was null'));
}

extension ToolConfigurationSerialization on ToolConfiguration {
  Map<String, dynamic> toJson() => _$ToolConfigurationToJson(this);
  Map<String, dynamic> toJsonLean() {
    final Map<String, dynamic> data = _$ToolConfigurationToJson(this);
    return _sanitizeJson(data);
  }

  dynamic _sanitizeJson(dynamic json) {
    if (json is Map<String, dynamic>) {
      json.remove('_className_');
      return json..forEach((key, value) {
        json[key] = _sanitizeJson(value);
      });
    } else if (json is List) {
      return json.map((e) => _sanitizeJson(e)).toList();
    }
    return json;
  }
}

enum ToolConfiguration$ {
  id,
  workspaceId,
  toolName,
  isEnabled,
  scope,
  permissions,
  configOverrides,
  lastUsedAt,
  usageCount,
}

class ToolConfigurationPatch implements Patch<ToolConfiguration> {
  final Map<ToolConfiguration$, dynamic> _patch = {};

  static ToolConfigurationPatch create([Map<String, dynamic>? diff]) {
    final patch = ToolConfigurationPatch();
    if (diff != null) {
      diff.forEach((key, value) {
        try {
          final enumValue = ToolConfiguration$.values.firstWhere(
            (e) => e.name == key,
          );
          if (value is Function) {
            patch._patch[enumValue] = value();
          } else {
            patch._patch[enumValue] = value;
          }
        } catch (_) {}
      });
    }
    return patch;
  }

  static ToolConfigurationPatch fromPatch(
    Map<ToolConfiguration$, dynamic> patch,
  ) {
    final _patch = ToolConfigurationPatch();
    _patch._patch.addAll(patch);
    return _patch;
  }

  Map<ToolConfiguration$, dynamic> toPatch() => Map.from(_patch);

  ToolConfiguration applyTo(ToolConfiguration entity) {
    return entity.patchWithToolConfiguration(patchInput: this);
  }

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
    _patch.forEach((key, value) {
      if (value != null) {
        if (value is Function) {
          final result = value();
          json[key.name] = _convertToJson(result);
        } else {
          json[key.name] = _convertToJson(value);
        }
      }
    });
    return json;
  }

  dynamic _convertToJson(dynamic value) {
    if (value == null) return null;
    if (value is DateTime) return value.toIso8601String();
    if (value is Enum) return value.toString().split('.').last;
    if (value is List) return value.map((e) => _convertToJson(e)).toList();
    if (value is Map)
      return value.map((k, v) => MapEntry(k.toString(), _convertToJson(v)));
    if (value is num || value is bool || value is String) return value;
    try {
      if (value?.toJsonLean != null) return value.toJsonLean();
    } catch (_) {}
    if (value?.toJson != null) return value.toJson();
    return value.toString();
  }

  static ToolConfigurationPatch fromJson(Map<String, dynamic> json) {
    return create(json);
  }

  ToolConfigurationPatch withId(String? value) {
    _patch[ToolConfiguration$.id] = value;
    return this;
  }

  ToolConfigurationPatch withWorkspaceId(String? value) {
    _patch[ToolConfiguration$.workspaceId] = value;
    return this;
  }

  ToolConfigurationPatch withToolName(String? value) {
    _patch[ToolConfiguration$.toolName] = value;
    return this;
  }

  ToolConfigurationPatch withIsEnabled(bool? value) {
    _patch[ToolConfiguration$.isEnabled] = value;
    return this;
  }

  ToolConfigurationPatch withScope(ToolScope? value) {
    _patch[ToolConfiguration$.scope] = value;
    return this;
  }

  ToolConfigurationPatch withPermissions(List<ToolPermission>? value) {
    _patch[ToolConfiguration$.permissions] = value;
    return this;
  }

  ToolConfigurationPatch withConfigOverrides(Map<String, dynamic>? value) {
    _patch[ToolConfiguration$.configOverrides] = value;
    return this;
  }

  ToolConfigurationPatch withLastUsedAt(DateTime? value) {
    _patch[ToolConfiguration$.lastUsedAt] = value;
    return this;
  }

  ToolConfigurationPatch withUsageCount(int? value) {
    _patch[ToolConfiguration$.usageCount] = value;
    return this;
  }
}

/// Field descriptors for [ToolConfiguration] query construction
abstract final class ToolConfigurationFields {
  static String _$getid(ToolConfiguration e) => e.id;
  static const id = Field<ToolConfiguration, String>('id', _$getid);
  static String _$getworkspaceId(ToolConfiguration e) => e.workspaceId;
  static const workspaceId = Field<ToolConfiguration, String>(
    'workspaceId',
    _$getworkspaceId,
  );
  static String _$gettoolName(ToolConfiguration e) => e.toolName;
  static const toolName = Field<ToolConfiguration, String>(
    'toolName',
    _$gettoolName,
  );
  static bool _$getisEnabled(ToolConfiguration e) => e.isEnabled;
  static const isEnabled = Field<ToolConfiguration, bool>(
    'isEnabled',
    _$getisEnabled,
  );
  static ToolScope? _$getscope(ToolConfiguration e) => e.scope;
  static const scope = Field<ToolConfiguration, ToolScope?>(
    'scope',
    _$getscope,
  );
  static List<ToolPermission> _$getpermissions(ToolConfiguration e) =>
      e.permissions;
  static const permissions = Field<ToolConfiguration, List<ToolPermission>>(
    'permissions',
    _$getpermissions,
  );
  static Map<String, dynamic>? _$getconfigOverrides(ToolConfiguration e) =>
      e.configOverrides;
  static const configOverrides =
      Field<ToolConfiguration, Map<String, dynamic>?>(
        'configOverrides',
        _$getconfigOverrides,
      );
  static DateTime? _$getlastUsedAt(ToolConfiguration e) => e.lastUsedAt;
  static const lastUsedAt = Field<ToolConfiguration, DateTime?>(
    'lastUsedAt',
    _$getlastUsedAt,
  );
  static int _$getusageCount(ToolConfiguration e) => e.usageCount;
  static const usageCount = Field<ToolConfiguration, int>(
    'usageCount',
    _$getusageCount,
  );
}

extension ToolConfigurationCompareE on ToolConfiguration {
  Map<String, dynamic> compareToToolConfiguration(ToolConfiguration other) {
    final Map<String, dynamic> diff = {};

    if (id != other.id) {
      diff['id'] = () => other.id;
    }
    if (workspaceId != other.workspaceId) {
      diff['workspaceId'] = () => other.workspaceId;
    }
    if (toolName != other.toolName) {
      diff['toolName'] = () => other.toolName;
    }
    if (isEnabled != other.isEnabled) {
      diff['isEnabled'] = () => other.isEnabled;
    }
    if (scope != other.scope) {
      diff['scope'] = () => other.scope;
    }
    if (permissions != other.permissions) {
      diff['permissions'] = () => other.permissions;
    }
    if (configOverrides != other.configOverrides) {
      diff['configOverrides'] = () => other.configOverrides;
    }
    if (lastUsedAt != other.lastUsedAt) {
      diff['lastUsedAt'] = () => other.lastUsedAt;
    }
    if (usageCount != other.usageCount) {
      diff['usageCount'] = () => other.usageCount;
    }
    return diff;
  }
}
