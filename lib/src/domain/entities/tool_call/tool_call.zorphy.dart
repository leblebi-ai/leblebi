// dart format width=80
// ignore_for_file: UNNECESSARY_CAST
// ignore_for_file: type=lint

part of 'tool_call.dart';

// **************************************************************************
// ZorphyGenerator
// **************************************************************************

@JsonSerializable(explicitToJson: true)
class ToolCall {
  final String toolName;
  final Map<String, dynamic> arguments;
  final ToolCallStatus status;
  final String? result;
  final String? error;
  final DateTime? executedAt;

  ToolCall({
    required this.toolName,
    required this.arguments,
    required this.status,
    this.result,
    this.error,
    this.executedAt,
  });

  ToolCall copyWith({
    String? toolName,
    Map<String, dynamic>? arguments,
    ToolCallStatus? status,
    String? result,
    String? error,
    DateTime? executedAt,
  }) {
    return ToolCall(
      toolName: toolName ?? this.toolName,
      arguments: arguments ?? this.arguments,
      status: status ?? this.status,
      result: result ?? this.result,
      error: error ?? this.error,
      executedAt: executedAt ?? this.executedAt,
    );
  }

  ToolCall copyWithToolCall({
    String? toolName,
    Map<String, dynamic>? arguments,
    ToolCallStatus? status,
    String? result,
    String? error,
    DateTime? executedAt,
  }) {
    return copyWith(
      toolName: toolName,
      arguments: arguments,
      status: status,
      result: result,
      error: error,
      executedAt: executedAt,
    );
  }

  ToolCall patchWithToolCall({ToolCallPatch? patchInput}) {
    final _patcher = patchInput ?? ToolCallPatch();
    final _patchMap = _patcher.toPatch();
    return ToolCall(
      toolName: _patchMap.containsKey(ToolCall$.toolName)
          ? (_patchMap[ToolCall$.toolName] is Function)
                ? _patchMap[ToolCall$.toolName](this.toolName)
                : _patchMap[ToolCall$.toolName]
          : this.toolName,
      arguments: _patchMap.containsKey(ToolCall$.arguments)
          ? (_patchMap[ToolCall$.arguments] is Function)
                ? _patchMap[ToolCall$.arguments](this.arguments)
                : _patchMap[ToolCall$.arguments]
          : this.arguments,
      status: _patchMap.containsKey(ToolCall$.status)
          ? (_patchMap[ToolCall$.status] is Function)
                ? _patchMap[ToolCall$.status](this.status)
                : _patchMap[ToolCall$.status]
          : this.status,
      result: _patchMap.containsKey(ToolCall$.result)
          ? (_patchMap[ToolCall$.result] is Function)
                ? _patchMap[ToolCall$.result](this.result)
                : _patchMap[ToolCall$.result]
          : this.result,
      error: _patchMap.containsKey(ToolCall$.error)
          ? (_patchMap[ToolCall$.error] is Function)
                ? _patchMap[ToolCall$.error](this.error)
                : _patchMap[ToolCall$.error]
          : this.error,
      executedAt: _patchMap.containsKey(ToolCall$.executedAt)
          ? (_patchMap[ToolCall$.executedAt] is Function)
                ? _patchMap[ToolCall$.executedAt](this.executedAt)
                : _patchMap[ToolCall$.executedAt]
          : this.executedAt,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is ToolCall &&
        toolName == other.toolName &&
        arguments == other.arguments &&
        status == other.status &&
        result == other.result &&
        error == other.error &&
        executedAt == other.executedAt;
  }

  @override
  int get hashCode {
    return Object.hash(
      this.toolName,
      this.arguments,
      this.status,
      this.result,
      this.error,
      this.executedAt,
    );
  }

  @override
  String toString() {
    return 'ToolCall(' +
        'toolName: ${toolName}' +
        ', ' +
        'arguments: ${arguments}' +
        ', ' +
        'status: ${status}' +
        ', ' +
        'result: ${result}' +
        ', ' +
        'error: ${error}' +
        ', ' +
        'executedAt: ${executedAt})';
  }

  /// Creates a [ToolCall] instance from JSON
  factory ToolCall.fromJson(Map<String, dynamic> json) =>
      _$ToolCallFromJson(json);

  Map<String, dynamic> toJsonLean() {
    final Map<String, dynamic> data = _$ToolCallToJson(this);
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

extension ToolCallPropertyHelpers on ToolCall {
  bool get hasArguments => arguments.isNotEmpty;
  bool get noArguments => arguments.isEmpty;
  bool get isStatusPENDING => status == ToolCallStatus.PENDING;
  bool get isStatusEXECUTING => status == ToolCallStatus.EXECUTING;
  bool get isStatusSUCCESS => status == ToolCallStatus.SUCCESS;
  bool get isStatusERROR => status == ToolCallStatus.ERROR;
  bool get hasResult => result != null;
  bool get noResult => result == null;
  String get resultRequired =>
      result ?? (throw StateError('result is required but was null'));
  bool get hasError => error != null;
  bool get noError => error == null;
  String get errorRequired =>
      error ?? (throw StateError('error is required but was null'));
  bool get hasExecutedAt => executedAt != null;
  bool get noExecutedAt => executedAt == null;
  DateTime get executedAtRequired =>
      executedAt ?? (throw StateError('executedAt is required but was null'));
}

extension ToolCallSerialization on ToolCall {
  Map<String, dynamic> toJson() => _$ToolCallToJson(this);
  Map<String, dynamic> toJsonLean() {
    final Map<String, dynamic> data = _$ToolCallToJson(this);
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

enum ToolCall$ { toolName, arguments, status, result, error, executedAt }

class ToolCallPatch implements Patch<ToolCall> {
  final Map<ToolCall$, dynamic> _patch = {};

  static ToolCallPatch create([Map<String, dynamic>? diff]) {
    final patch = ToolCallPatch();
    if (diff != null) {
      diff.forEach((key, value) {
        try {
          final enumValue = ToolCall$.values.firstWhere((e) => e.name == key);
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

  static ToolCallPatch fromPatch(Map<ToolCall$, dynamic> patch) {
    final _patch = ToolCallPatch();
    _patch._patch.addAll(patch);
    return _patch;
  }

  Map<ToolCall$, dynamic> toPatch() => Map.from(_patch);

  ToolCall applyTo(ToolCall entity) {
    return entity.patchWithToolCall(patchInput: this);
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

  static ToolCallPatch fromJson(Map<String, dynamic> json) {
    return create(json);
  }

  ToolCallPatch withToolName(String? value) {
    _patch[ToolCall$.toolName] = value;
    return this;
  }

  ToolCallPatch withArguments(Map<String, dynamic>? value) {
    _patch[ToolCall$.arguments] = value;
    return this;
  }

  ToolCallPatch withStatus(ToolCallStatus? value) {
    _patch[ToolCall$.status] = value;
    return this;
  }

  ToolCallPatch withResult(String? value) {
    _patch[ToolCall$.result] = value;
    return this;
  }

  ToolCallPatch withError(String? value) {
    _patch[ToolCall$.error] = value;
    return this;
  }

  ToolCallPatch withExecutedAt(DateTime? value) {
    _patch[ToolCall$.executedAt] = value;
    return this;
  }
}

/// Field descriptors for [ToolCall] query construction
abstract final class ToolCallFields {
  static String _$gettoolName(ToolCall e) => e.toolName;
  static const toolName = Field<ToolCall, String>('toolName', _$gettoolName);
  static Map<String, dynamic> _$getarguments(ToolCall e) => e.arguments;
  static const arguments = Field<ToolCall, Map<String, dynamic>>(
    'arguments',
    _$getarguments,
  );
  static ToolCallStatus _$getstatus(ToolCall e) => e.status;
  static const status = Field<ToolCall, ToolCallStatus>('status', _$getstatus);
  static String? _$getresult(ToolCall e) => e.result;
  static const result = Field<ToolCall, String?>('result', _$getresult);
  static String? _$geterror(ToolCall e) => e.error;
  static const error = Field<ToolCall, String?>('error', _$geterror);
  static DateTime? _$getexecutedAt(ToolCall e) => e.executedAt;
  static const executedAt = Field<ToolCall, DateTime?>(
    'executedAt',
    _$getexecutedAt,
  );
}

extension ToolCallCompareE on ToolCall {
  Map<String, dynamic> compareToToolCall(ToolCall other) {
    final Map<String, dynamic> diff = {};

    if (toolName != other.toolName) {
      diff['toolName'] = () => other.toolName;
    }
    if (arguments != other.arguments) {
      diff['arguments'] = () => other.arguments;
    }
    if (status != other.status) {
      diff['status'] = () => other.status;
    }
    if (result != other.result) {
      diff['result'] = () => other.result;
    }
    if (error != other.error) {
      diff['error'] = () => other.error;
    }
    if (executedAt != other.executedAt) {
      diff['executedAt'] = () => other.executedAt;
    }
    return diff;
  }
}
