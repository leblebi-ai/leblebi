// dart format width=80
// ignore_for_file: UNNECESSARY_CAST
// ignore_for_file: type=lint

part of 'a_i_provider.dart';

// **************************************************************************
// ZorphyGenerator
// **************************************************************************

@JsonSerializable(explicitToJson: true)
class AIProvider {
  final AIProviderType type;
  final String name;
  final String version;
  final List<String> supportedProtocols;
  final String authMechanism;
  final ApiEndpoints endpoints;

  AIProvider({
    required this.type,
    required this.name,
    required this.version,
    required this.supportedProtocols,
    required this.authMechanism,
    required this.endpoints,
  });

  AIProvider copyWith({
    AIProviderType? type,
    String? name,
    String? version,
    List<String>? supportedProtocols,
    String? authMechanism,
    ApiEndpoints? endpoints,
  }) {
    return AIProvider(
      type: type ?? this.type,
      name: name ?? this.name,
      version: version ?? this.version,
      supportedProtocols: supportedProtocols ?? this.supportedProtocols,
      authMechanism: authMechanism ?? this.authMechanism,
      endpoints: endpoints ?? this.endpoints,
    );
  }

  AIProvider copyWithAIProvider({
    AIProviderType? type,
    String? name,
    String? version,
    List<String>? supportedProtocols,
    String? authMechanism,
    ApiEndpoints? endpoints,
  }) {
    return copyWith(
      type: type,
      name: name,
      version: version,
      supportedProtocols: supportedProtocols,
      authMechanism: authMechanism,
      endpoints: endpoints,
    );
  }

  AIProvider patchWithAIProvider({AIProviderPatch? patchInput}) {
    final _patcher = patchInput ?? AIProviderPatch();
    final _patchMap = _patcher.toPatch();
    return AIProvider(
      type: _patchMap.containsKey(AIProvider$.type)
          ? (_patchMap[AIProvider$.type] is Function)
                ? _patchMap[AIProvider$.type](this.type)
                : _patchMap[AIProvider$.type]
          : this.type,
      name: _patchMap.containsKey(AIProvider$.name)
          ? (_patchMap[AIProvider$.name] is Function)
                ? _patchMap[AIProvider$.name](this.name)
                : _patchMap[AIProvider$.name]
          : this.name,
      version: _patchMap.containsKey(AIProvider$.version)
          ? (_patchMap[AIProvider$.version] is Function)
                ? _patchMap[AIProvider$.version](this.version)
                : _patchMap[AIProvider$.version]
          : this.version,
      supportedProtocols: _patchMap.containsKey(AIProvider$.supportedProtocols)
          ? (_patchMap[AIProvider$.supportedProtocols] is Function)
                ? _patchMap[AIProvider$.supportedProtocols](
                    this.supportedProtocols,
                  )
                : _patchMap[AIProvider$.supportedProtocols]
          : this.supportedProtocols,
      authMechanism: _patchMap.containsKey(AIProvider$.authMechanism)
          ? (_patchMap[AIProvider$.authMechanism] is Function)
                ? _patchMap[AIProvider$.authMechanism](this.authMechanism)
                : _patchMap[AIProvider$.authMechanism]
          : this.authMechanism,
      endpoints: _patchMap.containsKey(AIProvider$.endpoints)
          ? (_patchMap[AIProvider$.endpoints] is Function)
                ? _patchMap[AIProvider$.endpoints](this.endpoints)
                : _patchMap[AIProvider$.endpoints]
          : this.endpoints,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is AIProvider &&
        type == other.type &&
        name == other.name &&
        version == other.version &&
        supportedProtocols == other.supportedProtocols &&
        authMechanism == other.authMechanism &&
        endpoints == other.endpoints;
  }

  @override
  int get hashCode {
    return Object.hash(
      this.type,
      this.name,
      this.version,
      this.supportedProtocols,
      this.authMechanism,
      this.endpoints,
    );
  }

  @override
  String toString() {
    return 'AIProvider(' +
        'type: ${type}' +
        ', ' +
        'name: ${name}' +
        ', ' +
        'version: ${version}' +
        ', ' +
        'supportedProtocols: ${supportedProtocols}' +
        ', ' +
        'authMechanism: ${authMechanism}' +
        ', ' +
        'endpoints: ${endpoints})';
  }

  /// Creates a [AIProvider] instance from JSON
  factory AIProvider.fromJson(Map<String, dynamic> json) =>
      _$AIProviderFromJson(json);

  Map<String, dynamic> toJsonLean() {
    final Map<String, dynamic> data = _$AIProviderToJson(this);
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

extension AIProviderPropertyHelpers on AIProvider {
  bool get isTypeZeroClaw => type == AIProviderType.zeroClaw;
  bool get isTypePicoClaw => type == AIProviderType.picoClaw;
  bool get isTypeOpenClaw => type == AIProviderType.openClaw;
  bool get hasSupportedProtocols => supportedProtocols.isNotEmpty;
  bool get noSupportedProtocols => supportedProtocols.isEmpty;
}

extension AIProviderSerialization on AIProvider {
  Map<String, dynamic> toJson() => _$AIProviderToJson(this);
  Map<String, dynamic> toJsonLean() {
    final Map<String, dynamic> data = _$AIProviderToJson(this);
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

enum AIProvider$ {
  type,
  name,
  version,
  supportedProtocols,
  authMechanism,
  endpoints,
}

class AIProviderPatch implements Patch<AIProvider> {
  final Map<AIProvider$, dynamic> _patch = {};

  static AIProviderPatch create([Map<String, dynamic>? diff]) {
    final patch = AIProviderPatch();
    if (diff != null) {
      diff.forEach((key, value) {
        try {
          final enumValue = AIProvider$.values.firstWhere((e) => e.name == key);
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

  static AIProviderPatch fromPatch(Map<AIProvider$, dynamic> patch) {
    final _patch = AIProviderPatch();
    _patch._patch.addAll(patch);
    return _patch;
  }

  Map<AIProvider$, dynamic> toPatch() => Map.from(_patch);

  AIProvider applyTo(AIProvider entity) {
    return entity.patchWithAIProvider(patchInput: this);
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

  static AIProviderPatch fromJson(Map<String, dynamic> json) {
    return create(json);
  }

  AIProviderPatch withType(AIProviderType? value) {
    _patch[AIProvider$.type] = value;
    return this;
  }

  AIProviderPatch withName(String? value) {
    _patch[AIProvider$.name] = value;
    return this;
  }

  AIProviderPatch withVersion(String? value) {
    _patch[AIProvider$.version] = value;
    return this;
  }

  AIProviderPatch withSupportedProtocols(List<String>? value) {
    _patch[AIProvider$.supportedProtocols] = value;
    return this;
  }

  AIProviderPatch withAuthMechanism(String? value) {
    _patch[AIProvider$.authMechanism] = value;
    return this;
  }

  AIProviderPatch withEndpoints(ApiEndpoints? value) {
    _patch[AIProvider$.endpoints] = value;
    return this;
  }
}

/// Field descriptors for [AIProvider] query construction
abstract final class AIProviderFields {
  static AIProviderType _$gettype(AIProvider e) => e.type;
  static const type = Field<AIProvider, AIProviderType>('type', _$gettype);
  static String _$getname(AIProvider e) => e.name;
  static const name = Field<AIProvider, String>('name', _$getname);
  static String _$getversion(AIProvider e) => e.version;
  static const version = Field<AIProvider, String>('version', _$getversion);
  static List<String> _$getsupportedProtocols(AIProvider e) =>
      e.supportedProtocols;
  static const supportedProtocols = Field<AIProvider, List<String>>(
    'supportedProtocols',
    _$getsupportedProtocols,
  );
  static String _$getauthMechanism(AIProvider e) => e.authMechanism;
  static const authMechanism = Field<AIProvider, String>(
    'authMechanism',
    _$getauthMechanism,
  );
  static ApiEndpoints _$getendpoints(AIProvider e) => e.endpoints;
  static const endpoints = Field<AIProvider, ApiEndpoints>(
    'endpoints',
    _$getendpoints,
  );
}

extension AIProviderCompareE on AIProvider {
  Map<String, dynamic> compareToAIProvider(AIProvider other) {
    final Map<String, dynamic> diff = {};

    if (type != other.type) {
      diff['type'] = () => other.type;
    }
    if (name != other.name) {
      diff['name'] = () => other.name;
    }
    if (version != other.version) {
      diff['version'] = () => other.version;
    }
    if (supportedProtocols != other.supportedProtocols) {
      diff['supportedProtocols'] = () => other.supportedProtocols;
    }
    if (authMechanism != other.authMechanism) {
      diff['authMechanism'] = () => other.authMechanism;
    }
    if (endpoints != other.endpoints) {
      diff['endpoints'] = () => other.endpoints;
    }
    return diff;
  }
}
