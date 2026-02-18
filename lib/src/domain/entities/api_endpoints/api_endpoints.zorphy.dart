// dart format width=80
// ignore_for_file: UNNECESSARY_CAST
// ignore_for_file: type=lint

part of 'api_endpoints.dart';

// **************************************************************************
// ZorphyGenerator
// **************************************************************************

@JsonSerializable(explicitToJson: true)
class ApiEndpoints {
  final String health;
  final String pair;
  final String webhook;

  ApiEndpoints({
    required this.health,
    required this.pair,
    required this.webhook,
  });

  ApiEndpoints copyWith({String? health, String? pair, String? webhook}) {
    return ApiEndpoints(
      health: health ?? this.health,
      pair: pair ?? this.pair,
      webhook: webhook ?? this.webhook,
    );
  }

  ApiEndpoints copyWithApiEndpoints({
    String? health,
    String? pair,
    String? webhook,
  }) {
    return copyWith(health: health, pair: pair, webhook: webhook);
  }

  ApiEndpoints patchWithApiEndpoints({ApiEndpointsPatch? patchInput}) {
    final _patcher = patchInput ?? ApiEndpointsPatch();
    final _patchMap = _patcher.toPatch();
    return ApiEndpoints(
      health: _patchMap.containsKey(ApiEndpoints$.health)
          ? (_patchMap[ApiEndpoints$.health] is Function)
                ? _patchMap[ApiEndpoints$.health](this.health)
                : _patchMap[ApiEndpoints$.health]
          : this.health,
      pair: _patchMap.containsKey(ApiEndpoints$.pair)
          ? (_patchMap[ApiEndpoints$.pair] is Function)
                ? _patchMap[ApiEndpoints$.pair](this.pair)
                : _patchMap[ApiEndpoints$.pair]
          : this.pair,
      webhook: _patchMap.containsKey(ApiEndpoints$.webhook)
          ? (_patchMap[ApiEndpoints$.webhook] is Function)
                ? _patchMap[ApiEndpoints$.webhook](this.webhook)
                : _patchMap[ApiEndpoints$.webhook]
          : this.webhook,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is ApiEndpoints &&
        health == other.health &&
        pair == other.pair &&
        webhook == other.webhook;
  }

  @override
  int get hashCode {
    return Object.hash(this.health, this.pair, this.webhook);
  }

  @override
  String toString() {
    return 'ApiEndpoints(' +
        'health: ${health}' +
        ', ' +
        'pair: ${pair}' +
        ', ' +
        'webhook: ${webhook})';
  }

  /// Creates a [ApiEndpoints] instance from JSON
  factory ApiEndpoints.fromJson(Map<String, dynamic> json) =>
      _$ApiEndpointsFromJson(json);

  Map<String, dynamic> toJsonLean() {
    final Map<String, dynamic> data = _$ApiEndpointsToJson(this);
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

extension ApiEndpointsPropertyHelpers on ApiEndpoints {}

extension ApiEndpointsSerialization on ApiEndpoints {
  Map<String, dynamic> toJson() => _$ApiEndpointsToJson(this);
  Map<String, dynamic> toJsonLean() {
    final Map<String, dynamic> data = _$ApiEndpointsToJson(this);
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

enum ApiEndpoints$ { health, pair, webhook }

class ApiEndpointsPatch implements Patch<ApiEndpoints> {
  final Map<ApiEndpoints$, dynamic> _patch = {};

  static ApiEndpointsPatch create([Map<String, dynamic>? diff]) {
    final patch = ApiEndpointsPatch();
    if (diff != null) {
      diff.forEach((key, value) {
        try {
          final enumValue = ApiEndpoints$.values.firstWhere(
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

  static ApiEndpointsPatch fromPatch(Map<ApiEndpoints$, dynamic> patch) {
    final _patch = ApiEndpointsPatch();
    _patch._patch.addAll(patch);
    return _patch;
  }

  Map<ApiEndpoints$, dynamic> toPatch() => Map.from(_patch);

  ApiEndpoints applyTo(ApiEndpoints entity) {
    return entity.patchWithApiEndpoints(patchInput: this);
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

  static ApiEndpointsPatch fromJson(Map<String, dynamic> json) {
    return create(json);
  }

  ApiEndpointsPatch withHealth(String? value) {
    _patch[ApiEndpoints$.health] = value;
    return this;
  }

  ApiEndpointsPatch withPair(String? value) {
    _patch[ApiEndpoints$.pair] = value;
    return this;
  }

  ApiEndpointsPatch withWebhook(String? value) {
    _patch[ApiEndpoints$.webhook] = value;
    return this;
  }
}

/// Field descriptors for [ApiEndpoints] query construction
abstract final class ApiEndpointsFields {
  static String _$gethealth(ApiEndpoints e) => e.health;
  static const health = Field<ApiEndpoints, String>('health', _$gethealth);
  static String _$getpair(ApiEndpoints e) => e.pair;
  static const pair = Field<ApiEndpoints, String>('pair', _$getpair);
  static String _$getwebhook(ApiEndpoints e) => e.webhook;
  static const webhook = Field<ApiEndpoints, String>('webhook', _$getwebhook);
}

extension ApiEndpointsCompareE on ApiEndpoints {
  Map<String, dynamic> compareToApiEndpoints(ApiEndpoints other) {
    final Map<String, dynamic> diff = {};

    if (health != other.health) {
      diff['health'] = () => other.health;
    }
    if (pair != other.pair) {
      diff['pair'] = () => other.pair;
    }
    if (webhook != other.webhook) {
      diff['webhook'] = () => other.webhook;
    }
    return diff;
  }
}
