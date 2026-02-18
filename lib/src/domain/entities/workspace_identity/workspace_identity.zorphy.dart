// dart format width=80
// ignore_for_file: UNNECESSARY_CAST
// ignore_for_file: type=lint

part of 'workspace_identity.dart';

// **************************************************************************
// ZorphyGenerator
// **************************************************************************

@JsonSerializable(explicitToJson: true)
class WorkspaceIdentity {
  final String name;
  final String? persona;
  final String? systemPrompt;
  final Map<String, dynamic>? toolConfigs;

  WorkspaceIdentity({
    required this.name,
    this.persona,
    this.systemPrompt,
    this.toolConfigs,
  });

  WorkspaceIdentity copyWith({
    String? name,
    String? persona,
    String? systemPrompt,
    Map<String, dynamic>? toolConfigs,
  }) {
    return WorkspaceIdentity(
      name: name ?? this.name,
      persona: persona ?? this.persona,
      systemPrompt: systemPrompt ?? this.systemPrompt,
      toolConfigs: toolConfigs ?? this.toolConfigs,
    );
  }

  WorkspaceIdentity copyWithWorkspaceIdentity({
    String? name,
    String? persona,
    String? systemPrompt,
    Map<String, dynamic>? toolConfigs,
  }) {
    return copyWith(
      name: name,
      persona: persona,
      systemPrompt: systemPrompt,
      toolConfigs: toolConfigs,
    );
  }

  WorkspaceIdentity patchWithWorkspaceIdentity({
    WorkspaceIdentityPatch? patchInput,
  }) {
    final _patcher = patchInput ?? WorkspaceIdentityPatch();
    final _patchMap = _patcher.toPatch();
    return WorkspaceIdentity(
      name: _patchMap.containsKey(WorkspaceIdentity$.name)
          ? (_patchMap[WorkspaceIdentity$.name] is Function)
                ? _patchMap[WorkspaceIdentity$.name](this.name)
                : _patchMap[WorkspaceIdentity$.name]
          : this.name,
      persona: _patchMap.containsKey(WorkspaceIdentity$.persona)
          ? (_patchMap[WorkspaceIdentity$.persona] is Function)
                ? _patchMap[WorkspaceIdentity$.persona](this.persona)
                : _patchMap[WorkspaceIdentity$.persona]
          : this.persona,
      systemPrompt: _patchMap.containsKey(WorkspaceIdentity$.systemPrompt)
          ? (_patchMap[WorkspaceIdentity$.systemPrompt] is Function)
                ? _patchMap[WorkspaceIdentity$.systemPrompt](this.systemPrompt)
                : _patchMap[WorkspaceIdentity$.systemPrompt]
          : this.systemPrompt,
      toolConfigs: _patchMap.containsKey(WorkspaceIdentity$.toolConfigs)
          ? (_patchMap[WorkspaceIdentity$.toolConfigs] is Function)
                ? _patchMap[WorkspaceIdentity$.toolConfigs](this.toolConfigs)
                : _patchMap[WorkspaceIdentity$.toolConfigs]
          : this.toolConfigs,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is WorkspaceIdentity &&
        name == other.name &&
        persona == other.persona &&
        systemPrompt == other.systemPrompt &&
        toolConfigs == other.toolConfigs;
  }

  @override
  int get hashCode {
    return Object.hash(
      this.name,
      this.persona,
      this.systemPrompt,
      this.toolConfigs,
    );
  }

  @override
  String toString() {
    return 'WorkspaceIdentity(' +
        'name: ${name}' +
        ', ' +
        'persona: ${persona}' +
        ', ' +
        'systemPrompt: ${systemPrompt}' +
        ', ' +
        'toolConfigs: ${toolConfigs})';
  }

  /// Creates a [WorkspaceIdentity] instance from JSON
  factory WorkspaceIdentity.fromJson(Map<String, dynamic> json) =>
      _$WorkspaceIdentityFromJson(json);

  Map<String, dynamic> toJsonLean() {
    final Map<String, dynamic> data = _$WorkspaceIdentityToJson(this);
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

extension WorkspaceIdentityPropertyHelpers on WorkspaceIdentity {
  bool get hasPersona => persona != null;
  bool get noPersona => persona == null;
  String get personaRequired =>
      persona ?? (throw StateError('persona is required but was null'));
  bool get hasSystemPrompt => systemPrompt != null;
  bool get noSystemPrompt => systemPrompt == null;
  String get systemPromptRequired =>
      systemPrompt ??
      (throw StateError('systemPrompt is required but was null'));
  Map<String, dynamic> get toolConfigsRequired =>
      toolConfigs ?? (throw StateError('toolConfigs is required but was null'));
  bool get hasToolConfigs => toolConfigs?.isNotEmpty ?? false;
  bool get noToolConfigs => toolConfigs?.isEmpty ?? true;
}

extension WorkspaceIdentitySerialization on WorkspaceIdentity {
  Map<String, dynamic> toJson() => _$WorkspaceIdentityToJson(this);
  Map<String, dynamic> toJsonLean() {
    final Map<String, dynamic> data = _$WorkspaceIdentityToJson(this);
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

enum WorkspaceIdentity$ { name, persona, systemPrompt, toolConfigs }

class WorkspaceIdentityPatch implements Patch<WorkspaceIdentity> {
  final Map<WorkspaceIdentity$, dynamic> _patch = {};

  static WorkspaceIdentityPatch create([Map<String, dynamic>? diff]) {
    final patch = WorkspaceIdentityPatch();
    if (diff != null) {
      diff.forEach((key, value) {
        try {
          final enumValue = WorkspaceIdentity$.values.firstWhere(
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

  static WorkspaceIdentityPatch fromPatch(
    Map<WorkspaceIdentity$, dynamic> patch,
  ) {
    final _patch = WorkspaceIdentityPatch();
    _patch._patch.addAll(patch);
    return _patch;
  }

  Map<WorkspaceIdentity$, dynamic> toPatch() => Map.from(_patch);

  WorkspaceIdentity applyTo(WorkspaceIdentity entity) {
    return entity.patchWithWorkspaceIdentity(patchInput: this);
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

  static WorkspaceIdentityPatch fromJson(Map<String, dynamic> json) {
    return create(json);
  }

  WorkspaceIdentityPatch withName(String? value) {
    _patch[WorkspaceIdentity$.name] = value;
    return this;
  }

  WorkspaceIdentityPatch withPersona(String? value) {
    _patch[WorkspaceIdentity$.persona] = value;
    return this;
  }

  WorkspaceIdentityPatch withSystemPrompt(String? value) {
    _patch[WorkspaceIdentity$.systemPrompt] = value;
    return this;
  }

  WorkspaceIdentityPatch withToolConfigs(Map<String, dynamic>? value) {
    _patch[WorkspaceIdentity$.toolConfigs] = value;
    return this;
  }
}

/// Field descriptors for [WorkspaceIdentity] query construction
abstract final class WorkspaceIdentityFields {
  static String _$getname(WorkspaceIdentity e) => e.name;
  static const name = Field<WorkspaceIdentity, String>('name', _$getname);
  static String? _$getpersona(WorkspaceIdentity e) => e.persona;
  static const persona = Field<WorkspaceIdentity, String?>(
    'persona',
    _$getpersona,
  );
  static String? _$getsystemPrompt(WorkspaceIdentity e) => e.systemPrompt;
  static const systemPrompt = Field<WorkspaceIdentity, String?>(
    'systemPrompt',
    _$getsystemPrompt,
  );
  static Map<String, dynamic>? _$gettoolConfigs(WorkspaceIdentity e) =>
      e.toolConfigs;
  static const toolConfigs = Field<WorkspaceIdentity, Map<String, dynamic>?>(
    'toolConfigs',
    _$gettoolConfigs,
  );
}

extension WorkspaceIdentityCompareE on WorkspaceIdentity {
  Map<String, dynamic> compareToWorkspaceIdentity(WorkspaceIdentity other) {
    final Map<String, dynamic> diff = {};

    if (name != other.name) {
      diff['name'] = () => other.name;
    }
    if (persona != other.persona) {
      diff['persona'] = () => other.persona;
    }
    if (systemPrompt != other.systemPrompt) {
      diff['systemPrompt'] = () => other.systemPrompt;
    }
    if (toolConfigs != other.toolConfigs) {
      diff['toolConfigs'] = () => other.toolConfigs;
    }
    return diff;
  }
}
