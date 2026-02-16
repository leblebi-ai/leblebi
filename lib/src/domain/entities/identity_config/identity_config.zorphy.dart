// dart format width=80
// ignore_for_file: UNNECESSARY_CAST
// ignore_for_file: type=lint

part of 'identity_config.dart';

// **************************************************************************
// ZorphyGenerator
// **************************************************************************

@JsonSerializable(explicitToJson: true)
class IdentityConfig {
  final String name;
  final String? personality;
  final String? systemPrompt;
  final String model;
  final double temperature;
  final AutonomyLevel autonomyLevel;

  IdentityConfig({
    required this.name,
    this.personality,
    this.systemPrompt,
    required this.model,
    required this.temperature,
    required this.autonomyLevel,
  });

  IdentityConfig copyWith({
    String? name,
    String? personality,
    String? systemPrompt,
    String? model,
    double? temperature,
    AutonomyLevel? autonomyLevel,
  }) {
    return IdentityConfig(
      name: name ?? this.name,
      personality: personality ?? this.personality,
      systemPrompt: systemPrompt ?? this.systemPrompt,
      model: model ?? this.model,
      temperature: temperature ?? this.temperature,
      autonomyLevel: autonomyLevel ?? this.autonomyLevel,
    );
  }

  IdentityConfig copyWithIdentityConfig({
    String? name,
    String? personality,
    String? systemPrompt,
    String? model,
    double? temperature,
    AutonomyLevel? autonomyLevel,
  }) {
    return copyWith(
      name: name,
      personality: personality,
      systemPrompt: systemPrompt,
      model: model,
      temperature: temperature,
      autonomyLevel: autonomyLevel,
    );
  }

  IdentityConfig patchWithIdentityConfig({IdentityConfigPatch? patchInput}) {
    final _patcher = patchInput ?? IdentityConfigPatch();
    final _patchMap = _patcher.toPatch();
    return IdentityConfig(
      name: _patchMap.containsKey(IdentityConfig$.name)
          ? (_patchMap[IdentityConfig$.name] is Function)
                ? _patchMap[IdentityConfig$.name](this.name)
                : _patchMap[IdentityConfig$.name]
          : this.name,
      personality: _patchMap.containsKey(IdentityConfig$.personality)
          ? (_patchMap[IdentityConfig$.personality] is Function)
                ? _patchMap[IdentityConfig$.personality](this.personality)
                : _patchMap[IdentityConfig$.personality]
          : this.personality,
      systemPrompt: _patchMap.containsKey(IdentityConfig$.systemPrompt)
          ? (_patchMap[IdentityConfig$.systemPrompt] is Function)
                ? _patchMap[IdentityConfig$.systemPrompt](this.systemPrompt)
                : _patchMap[IdentityConfig$.systemPrompt]
          : this.systemPrompt,
      model: _patchMap.containsKey(IdentityConfig$.model)
          ? (_patchMap[IdentityConfig$.model] is Function)
                ? _patchMap[IdentityConfig$.model](this.model)
                : _patchMap[IdentityConfig$.model]
          : this.model,
      temperature: _patchMap.containsKey(IdentityConfig$.temperature)
          ? (_patchMap[IdentityConfig$.temperature] is Function)
                ? _patchMap[IdentityConfig$.temperature](this.temperature)
                : _patchMap[IdentityConfig$.temperature]
          : this.temperature,
      autonomyLevel: _patchMap.containsKey(IdentityConfig$.autonomyLevel)
          ? (_patchMap[IdentityConfig$.autonomyLevel] is Function)
                ? _patchMap[IdentityConfig$.autonomyLevel](this.autonomyLevel)
                : _patchMap[IdentityConfig$.autonomyLevel]
          : this.autonomyLevel,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is IdentityConfig &&
        name == other.name &&
        personality == other.personality &&
        systemPrompt == other.systemPrompt &&
        model == other.model &&
        temperature == other.temperature &&
        autonomyLevel == other.autonomyLevel;
  }

  @override
  int get hashCode {
    return Object.hash(
      this.name,
      this.personality,
      this.systemPrompt,
      this.model,
      this.temperature,
      this.autonomyLevel,
    );
  }

  @override
  String toString() {
    return 'IdentityConfig(' +
        'name: ${name}' +
        ', ' +
        'personality: ${personality}' +
        ', ' +
        'systemPrompt: ${systemPrompt}' +
        ', ' +
        'model: ${model}' +
        ', ' +
        'temperature: ${temperature}' +
        ', ' +
        'autonomyLevel: ${autonomyLevel})';
  }

  /// Creates a [IdentityConfig] instance from JSON
  factory IdentityConfig.fromJson(Map<String, dynamic> json) =>
      _$IdentityConfigFromJson(json);

  Map<String, dynamic> toJsonLean() {
    final Map<String, dynamic> data = _$IdentityConfigToJson(this);
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

extension IdentityConfigPropertyHelpers on IdentityConfig {
  bool get hasPersonality => personality != null;
  bool get noPersonality => personality == null;
  String get personalityRequired =>
      personality ?? (throw StateError('personality is required but was null'));
  bool get hasSystemPrompt => systemPrompt != null;
  bool get noSystemPrompt => systemPrompt == null;
  String get systemPromptRequired =>
      systemPrompt ??
      (throw StateError('systemPrompt is required but was null'));
  bool get isAutonomyLevelSUPERVISED =>
      autonomyLevel == AutonomyLevel.SUPERVISED;
  bool get isAutonomyLevelSEMI_AUTONOMOUS =>
      autonomyLevel == AutonomyLevel.SEMI_AUTONOMOUS;
  bool get isAutonomyLevelAUTONOMOUS =>
      autonomyLevel == AutonomyLevel.AUTONOMOUS;
}

extension IdentityConfigSerialization on IdentityConfig {
  Map<String, dynamic> toJson() => _$IdentityConfigToJson(this);
  Map<String, dynamic> toJsonLean() {
    final Map<String, dynamic> data = _$IdentityConfigToJson(this);
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

enum IdentityConfig$ {
  name,
  personality,
  systemPrompt,
  model,
  temperature,
  autonomyLevel,
}

class IdentityConfigPatch implements Patch<IdentityConfig> {
  final Map<IdentityConfig$, dynamic> _patch = {};

  static IdentityConfigPatch create([Map<String, dynamic>? diff]) {
    final patch = IdentityConfigPatch();
    if (diff != null) {
      diff.forEach((key, value) {
        try {
          final enumValue = IdentityConfig$.values.firstWhere(
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

  static IdentityConfigPatch fromPatch(Map<IdentityConfig$, dynamic> patch) {
    final _patch = IdentityConfigPatch();
    _patch._patch.addAll(patch);
    return _patch;
  }

  Map<IdentityConfig$, dynamic> toPatch() => Map.from(_patch);

  IdentityConfig applyTo(IdentityConfig entity) {
    return entity.patchWithIdentityConfig(patchInput: this);
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

  static IdentityConfigPatch fromJson(Map<String, dynamic> json) {
    return create(json);
  }

  IdentityConfigPatch withName(String? value) {
    _patch[IdentityConfig$.name] = value;
    return this;
  }

  IdentityConfigPatch withPersonality(String? value) {
    _patch[IdentityConfig$.personality] = value;
    return this;
  }

  IdentityConfigPatch withSystemPrompt(String? value) {
    _patch[IdentityConfig$.systemPrompt] = value;
    return this;
  }

  IdentityConfigPatch withModel(String? value) {
    _patch[IdentityConfig$.model] = value;
    return this;
  }

  IdentityConfigPatch withTemperature(double? value) {
    _patch[IdentityConfig$.temperature] = value;
    return this;
  }

  IdentityConfigPatch withAutonomyLevel(AutonomyLevel? value) {
    _patch[IdentityConfig$.autonomyLevel] = value;
    return this;
  }
}

/// Field descriptors for [IdentityConfig] query construction
abstract final class IdentityConfigFields {
  static String _$getname(IdentityConfig e) => e.name;
  static const name = Field<IdentityConfig, String>('name', _$getname);
  static String? _$getpersonality(IdentityConfig e) => e.personality;
  static const personality = Field<IdentityConfig, String?>(
    'personality',
    _$getpersonality,
  );
  static String? _$getsystemPrompt(IdentityConfig e) => e.systemPrompt;
  static const systemPrompt = Field<IdentityConfig, String?>(
    'systemPrompt',
    _$getsystemPrompt,
  );
  static String _$getmodel(IdentityConfig e) => e.model;
  static const model = Field<IdentityConfig, String>('model', _$getmodel);
  static double _$gettemperature(IdentityConfig e) => e.temperature;
  static const temperature = Field<IdentityConfig, double>(
    'temperature',
    _$gettemperature,
  );
  static AutonomyLevel _$getautonomyLevel(IdentityConfig e) => e.autonomyLevel;
  static const autonomyLevel = Field<IdentityConfig, AutonomyLevel>(
    'autonomyLevel',
    _$getautonomyLevel,
  );
}

extension IdentityConfigCompareE on IdentityConfig {
  Map<String, dynamic> compareToIdentityConfig(IdentityConfig other) {
    final Map<String, dynamic> diff = {};

    if (name != other.name) {
      diff['name'] = () => other.name;
    }
    if (personality != other.personality) {
      diff['personality'] = () => other.personality;
    }
    if (systemPrompt != other.systemPrompt) {
      diff['systemPrompt'] = () => other.systemPrompt;
    }
    if (model != other.model) {
      diff['model'] = () => other.model;
    }
    if (temperature != other.temperature) {
      diff['temperature'] = () => other.temperature;
    }
    if (autonomyLevel != other.autonomyLevel) {
      diff['autonomyLevel'] = () => other.autonomyLevel;
    }
    return diff;
  }
}
