// dart format width=80
// ignore_for_file: UNNECESSARY_CAST
// ignore_for_file: type=lint

part of 'message_metadata.dart';

// **************************************************************************
// ZorphyGenerator
// **************************************************************************

@JsonSerializable(explicitToJson: true)
class MessageMetadata {
  final int? tokenCount;
  final String? model;
  final double? temperature;
  final String? provider;
  final int? latencyMs;

  MessageMetadata({
    this.tokenCount,
    this.model,
    this.temperature,
    this.provider,
    this.latencyMs,
  });

  MessageMetadata copyWith({
    int? tokenCount,
    String? model,
    double? temperature,
    String? provider,
    int? latencyMs,
  }) {
    return MessageMetadata(
      tokenCount: tokenCount ?? this.tokenCount,
      model: model ?? this.model,
      temperature: temperature ?? this.temperature,
      provider: provider ?? this.provider,
      latencyMs: latencyMs ?? this.latencyMs,
    );
  }

  MessageMetadata copyWithMessageMetadata({
    int? tokenCount,
    String? model,
    double? temperature,
    String? provider,
    int? latencyMs,
  }) {
    return copyWith(
      tokenCount: tokenCount,
      model: model,
      temperature: temperature,
      provider: provider,
      latencyMs: latencyMs,
    );
  }

  MessageMetadata patchWithMessageMetadata({MessageMetadataPatch? patchInput}) {
    final _patcher = patchInput ?? MessageMetadataPatch();
    final _patchMap = _patcher.toPatch();
    return MessageMetadata(
      tokenCount: _patchMap.containsKey(MessageMetadata$.tokenCount)
          ? (_patchMap[MessageMetadata$.tokenCount] is Function)
                ? _patchMap[MessageMetadata$.tokenCount](this.tokenCount)
                : _patchMap[MessageMetadata$.tokenCount]
          : this.tokenCount,
      model: _patchMap.containsKey(MessageMetadata$.model)
          ? (_patchMap[MessageMetadata$.model] is Function)
                ? _patchMap[MessageMetadata$.model](this.model)
                : _patchMap[MessageMetadata$.model]
          : this.model,
      temperature: _patchMap.containsKey(MessageMetadata$.temperature)
          ? (_patchMap[MessageMetadata$.temperature] is Function)
                ? _patchMap[MessageMetadata$.temperature](this.temperature)
                : _patchMap[MessageMetadata$.temperature]
          : this.temperature,
      provider: _patchMap.containsKey(MessageMetadata$.provider)
          ? (_patchMap[MessageMetadata$.provider] is Function)
                ? _patchMap[MessageMetadata$.provider](this.provider)
                : _patchMap[MessageMetadata$.provider]
          : this.provider,
      latencyMs: _patchMap.containsKey(MessageMetadata$.latencyMs)
          ? (_patchMap[MessageMetadata$.latencyMs] is Function)
                ? _patchMap[MessageMetadata$.latencyMs](this.latencyMs)
                : _patchMap[MessageMetadata$.latencyMs]
          : this.latencyMs,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is MessageMetadata &&
        tokenCount == other.tokenCount &&
        model == other.model &&
        temperature == other.temperature &&
        provider == other.provider &&
        latencyMs == other.latencyMs;
  }

  @override
  int get hashCode {
    return Object.hash(
      this.tokenCount,
      this.model,
      this.temperature,
      this.provider,
      this.latencyMs,
    );
  }

  @override
  String toString() {
    return 'MessageMetadata(' +
        'tokenCount: ${tokenCount}' +
        ', ' +
        'model: ${model}' +
        ', ' +
        'temperature: ${temperature}' +
        ', ' +
        'provider: ${provider}' +
        ', ' +
        'latencyMs: ${latencyMs})';
  }

  /// Creates a [MessageMetadata] instance from JSON
  factory MessageMetadata.fromJson(Map<String, dynamic> json) =>
      _$MessageMetadataFromJson(json);

  Map<String, dynamic> toJsonLean() {
    final Map<String, dynamic> data = _$MessageMetadataToJson(this);
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

extension MessageMetadataPropertyHelpers on MessageMetadata {
  bool get hasTokenCount => tokenCount != null;
  bool get noTokenCount => tokenCount == null;
  int get tokenCountRequired =>
      tokenCount ?? (throw StateError('tokenCount is required but was null'));
  bool get hasModel => model != null;
  bool get noModel => model == null;
  String get modelRequired =>
      model ?? (throw StateError('model is required but was null'));
  bool get hasTemperature => temperature != null;
  bool get noTemperature => temperature == null;
  double get temperatureRequired =>
      temperature ?? (throw StateError('temperature is required but was null'));
  bool get hasProvider => provider != null;
  bool get noProvider => provider == null;
  String get providerRequired =>
      provider ?? (throw StateError('provider is required but was null'));
  bool get hasLatencyMs => latencyMs != null;
  bool get noLatencyMs => latencyMs == null;
  int get latencyMsRequired =>
      latencyMs ?? (throw StateError('latencyMs is required but was null'));
}

extension MessageMetadataSerialization on MessageMetadata {
  Map<String, dynamic> toJson() => _$MessageMetadataToJson(this);
  Map<String, dynamic> toJsonLean() {
    final Map<String, dynamic> data = _$MessageMetadataToJson(this);
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

enum MessageMetadata$ { tokenCount, model, temperature, provider, latencyMs }

class MessageMetadataPatch implements Patch<MessageMetadata> {
  final Map<MessageMetadata$, dynamic> _patch = {};

  static MessageMetadataPatch create([Map<String, dynamic>? diff]) {
    final patch = MessageMetadataPatch();
    if (diff != null) {
      diff.forEach((key, value) {
        try {
          final enumValue = MessageMetadata$.values.firstWhere(
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

  static MessageMetadataPatch fromPatch(Map<MessageMetadata$, dynamic> patch) {
    final _patch = MessageMetadataPatch();
    _patch._patch.addAll(patch);
    return _patch;
  }

  Map<MessageMetadata$, dynamic> toPatch() => Map.from(_patch);

  MessageMetadata applyTo(MessageMetadata entity) {
    return entity.patchWithMessageMetadata(patchInput: this);
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

  static MessageMetadataPatch fromJson(Map<String, dynamic> json) {
    return create(json);
  }

  MessageMetadataPatch withTokenCount(int? value) {
    _patch[MessageMetadata$.tokenCount] = value;
    return this;
  }

  MessageMetadataPatch withModel(String? value) {
    _patch[MessageMetadata$.model] = value;
    return this;
  }

  MessageMetadataPatch withTemperature(double? value) {
    _patch[MessageMetadata$.temperature] = value;
    return this;
  }

  MessageMetadataPatch withProvider(String? value) {
    _patch[MessageMetadata$.provider] = value;
    return this;
  }

  MessageMetadataPatch withLatencyMs(int? value) {
    _patch[MessageMetadata$.latencyMs] = value;
    return this;
  }
}

/// Field descriptors for [MessageMetadata] query construction
abstract final class MessageMetadataFields {
  static int? _$gettokenCount(MessageMetadata e) => e.tokenCount;
  static const tokenCount = Field<MessageMetadata, int?>(
    'tokenCount',
    _$gettokenCount,
  );
  static String? _$getmodel(MessageMetadata e) => e.model;
  static const model = Field<MessageMetadata, String?>('model', _$getmodel);
  static double? _$gettemperature(MessageMetadata e) => e.temperature;
  static const temperature = Field<MessageMetadata, double?>(
    'temperature',
    _$gettemperature,
  );
  static String? _$getprovider(MessageMetadata e) => e.provider;
  static const provider = Field<MessageMetadata, String?>(
    'provider',
    _$getprovider,
  );
  static int? _$getlatencyMs(MessageMetadata e) => e.latencyMs;
  static const latencyMs = Field<MessageMetadata, int?>(
    'latencyMs',
    _$getlatencyMs,
  );
}

extension MessageMetadataCompareE on MessageMetadata {
  Map<String, dynamic> compareToMessageMetadata(MessageMetadata other) {
    final Map<String, dynamic> diff = {};

    if (tokenCount != other.tokenCount) {
      diff['tokenCount'] = () => other.tokenCount;
    }
    if (model != other.model) {
      diff['model'] = () => other.model;
    }
    if (temperature != other.temperature) {
      diff['temperature'] = () => other.temperature;
    }
    if (provider != other.provider) {
      diff['provider'] = () => other.provider;
    }
    if (latencyMs != other.latencyMs) {
      diff['latencyMs'] = () => other.latencyMs;
    }
    return diff;
  }
}
