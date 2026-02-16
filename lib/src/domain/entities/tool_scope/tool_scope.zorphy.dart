// dart format width=80
// ignore_for_file: UNNECESSARY_CAST
// ignore_for_file: type=lint

part of 'tool_scope.dart';

// **************************************************************************
// ZorphyGenerator
// **************************************************************************

@JsonSerializable(explicitToJson: true)
class ToolScope {
  final List<String>? allowedDirectories;
  final List<String>? allowedDomains;
  final List<String>? allowedCommands;
  final bool workspaceOnly;

  ToolScope({
    this.allowedDirectories,
    this.allowedDomains,
    this.allowedCommands,
    required this.workspaceOnly,
  });

  ToolScope copyWith({
    List<String>? allowedDirectories,
    List<String>? allowedDomains,
    List<String>? allowedCommands,
    bool? workspaceOnly,
  }) {
    return ToolScope(
      allowedDirectories: allowedDirectories ?? this.allowedDirectories,
      allowedDomains: allowedDomains ?? this.allowedDomains,
      allowedCommands: allowedCommands ?? this.allowedCommands,
      workspaceOnly: workspaceOnly ?? this.workspaceOnly,
    );
  }

  ToolScope copyWithToolScope({
    List<String>? allowedDirectories,
    List<String>? allowedDomains,
    List<String>? allowedCommands,
    bool? workspaceOnly,
  }) {
    return copyWith(
      allowedDirectories: allowedDirectories,
      allowedDomains: allowedDomains,
      allowedCommands: allowedCommands,
      workspaceOnly: workspaceOnly,
    );
  }

  ToolScope patchWithToolScope({ToolScopePatch? patchInput}) {
    final _patcher = patchInput ?? ToolScopePatch();
    final _patchMap = _patcher.toPatch();
    return ToolScope(
      allowedDirectories: _patchMap.containsKey(ToolScope$.allowedDirectories)
          ? (_patchMap[ToolScope$.allowedDirectories] is Function)
                ? _patchMap[ToolScope$.allowedDirectories](
                    this.allowedDirectories,
                  )
                : _patchMap[ToolScope$.allowedDirectories]
          : this.allowedDirectories,
      allowedDomains: _patchMap.containsKey(ToolScope$.allowedDomains)
          ? (_patchMap[ToolScope$.allowedDomains] is Function)
                ? _patchMap[ToolScope$.allowedDomains](this.allowedDomains)
                : _patchMap[ToolScope$.allowedDomains]
          : this.allowedDomains,
      allowedCommands: _patchMap.containsKey(ToolScope$.allowedCommands)
          ? (_patchMap[ToolScope$.allowedCommands] is Function)
                ? _patchMap[ToolScope$.allowedCommands](this.allowedCommands)
                : _patchMap[ToolScope$.allowedCommands]
          : this.allowedCommands,
      workspaceOnly: _patchMap.containsKey(ToolScope$.workspaceOnly)
          ? (_patchMap[ToolScope$.workspaceOnly] is Function)
                ? _patchMap[ToolScope$.workspaceOnly](this.workspaceOnly)
                : _patchMap[ToolScope$.workspaceOnly]
          : this.workspaceOnly,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is ToolScope &&
        allowedDirectories == other.allowedDirectories &&
        allowedDomains == other.allowedDomains &&
        allowedCommands == other.allowedCommands &&
        workspaceOnly == other.workspaceOnly;
  }

  @override
  int get hashCode {
    return Object.hash(
      this.allowedDirectories,
      this.allowedDomains,
      this.allowedCommands,
      this.workspaceOnly,
    );
  }

  @override
  String toString() {
    return 'ToolScope(' +
        'allowedDirectories: ${allowedDirectories}' +
        ', ' +
        'allowedDomains: ${allowedDomains}' +
        ', ' +
        'allowedCommands: ${allowedCommands}' +
        ', ' +
        'workspaceOnly: ${workspaceOnly})';
  }

  /// Creates a [ToolScope] instance from JSON
  factory ToolScope.fromJson(Map<String, dynamic> json) =>
      _$ToolScopeFromJson(json);

  Map<String, dynamic> toJsonLean() {
    final Map<String, dynamic> data = _$ToolScopeToJson(this);
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

extension ToolScopePropertyHelpers on ToolScope {
  List<String> get allowedDirectoriesRequired =>
      allowedDirectories ??
      (throw StateError('allowedDirectories is required but was null'));
  bool get hasAllowedDirectories => allowedDirectories?.isNotEmpty ?? false;
  bool get noAllowedDirectories => allowedDirectories?.isEmpty ?? true;
  List<String> get allowedDomainsRequired =>
      allowedDomains ??
      (throw StateError('allowedDomains is required but was null'));
  bool get hasAllowedDomains => allowedDomains?.isNotEmpty ?? false;
  bool get noAllowedDomains => allowedDomains?.isEmpty ?? true;
  List<String> get allowedCommandsRequired =>
      allowedCommands ??
      (throw StateError('allowedCommands is required but was null'));
  bool get hasAllowedCommands => allowedCommands?.isNotEmpty ?? false;
  bool get noAllowedCommands => allowedCommands?.isEmpty ?? true;
}

extension ToolScopeSerialization on ToolScope {
  Map<String, dynamic> toJson() => _$ToolScopeToJson(this);
  Map<String, dynamic> toJsonLean() {
    final Map<String, dynamic> data = _$ToolScopeToJson(this);
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

enum ToolScope$ {
  allowedDirectories,
  allowedDomains,
  allowedCommands,
  workspaceOnly,
}

class ToolScopePatch implements Patch<ToolScope> {
  final Map<ToolScope$, dynamic> _patch = {};

  static ToolScopePatch create([Map<String, dynamic>? diff]) {
    final patch = ToolScopePatch();
    if (diff != null) {
      diff.forEach((key, value) {
        try {
          final enumValue = ToolScope$.values.firstWhere((e) => e.name == key);
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

  static ToolScopePatch fromPatch(Map<ToolScope$, dynamic> patch) {
    final _patch = ToolScopePatch();
    _patch._patch.addAll(patch);
    return _patch;
  }

  Map<ToolScope$, dynamic> toPatch() => Map.from(_patch);

  ToolScope applyTo(ToolScope entity) {
    return entity.patchWithToolScope(patchInput: this);
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

  static ToolScopePatch fromJson(Map<String, dynamic> json) {
    return create(json);
  }

  ToolScopePatch withAllowedDirectories(List<String>? value) {
    _patch[ToolScope$.allowedDirectories] = value;
    return this;
  }

  ToolScopePatch withAllowedDomains(List<String>? value) {
    _patch[ToolScope$.allowedDomains] = value;
    return this;
  }

  ToolScopePatch withAllowedCommands(List<String>? value) {
    _patch[ToolScope$.allowedCommands] = value;
    return this;
  }

  ToolScopePatch withWorkspaceOnly(bool? value) {
    _patch[ToolScope$.workspaceOnly] = value;
    return this;
  }
}

/// Field descriptors for [ToolScope] query construction
abstract final class ToolScopeFields {
  static List<String>? _$getallowedDirectories(ToolScope e) =>
      e.allowedDirectories;
  static const allowedDirectories = Field<ToolScope, List<String>?>(
    'allowedDirectories',
    _$getallowedDirectories,
  );
  static List<String>? _$getallowedDomains(ToolScope e) => e.allowedDomains;
  static const allowedDomains = Field<ToolScope, List<String>?>(
    'allowedDomains',
    _$getallowedDomains,
  );
  static List<String>? _$getallowedCommands(ToolScope e) => e.allowedCommands;
  static const allowedCommands = Field<ToolScope, List<String>?>(
    'allowedCommands',
    _$getallowedCommands,
  );
  static bool _$getworkspaceOnly(ToolScope e) => e.workspaceOnly;
  static const workspaceOnly = Field<ToolScope, bool>(
    'workspaceOnly',
    _$getworkspaceOnly,
  );
}

extension ToolScopeCompareE on ToolScope {
  Map<String, dynamic> compareToToolScope(ToolScope other) {
    final Map<String, dynamic> diff = {};

    if (allowedDirectories != other.allowedDirectories) {
      diff['allowedDirectories'] = () => other.allowedDirectories;
    }
    if (allowedDomains != other.allowedDomains) {
      diff['allowedDomains'] = () => other.allowedDomains;
    }
    if (allowedCommands != other.allowedCommands) {
      diff['allowedCommands'] = () => other.allowedCommands;
    }
    if (workspaceOnly != other.workspaceOnly) {
      diff['workspaceOnly'] = () => other.workspaceOnly;
    }
    return diff;
  }
}
