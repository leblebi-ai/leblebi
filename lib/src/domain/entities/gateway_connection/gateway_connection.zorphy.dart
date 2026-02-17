// dart format width=80
// ignore_for_file: UNNECESSARY_CAST
// ignore_for_file: type=lint

part of 'gateway_connection.dart';

// **************************************************************************
// ZorphyGenerator
// **************************************************************************

@JsonSerializable(explicitToJson: true)
class GatewayConnection {
  final String id;
  final AIProviderType providerType;
  final String name;
  final String url;
  final String? pairingCode;
  final String? bearerToken;
  final ConnectionStatus status;
  final DateTime? lastConnectedAt;
  final DateTime? lastErrorAt;
  final String? lastError;
  final DateTime createdAt;
  final DateTime updatedAt;

  GatewayConnection({
    required this.id,
    required this.providerType,
    required this.name,
    required this.url,
    this.pairingCode,
    this.bearerToken,
    required this.status,
    this.lastConnectedAt,
    this.lastErrorAt,
    this.lastError,
    required this.createdAt,
    required this.updatedAt,
  });

  GatewayConnection copyWith({
    String? id,
    AIProviderType? providerType,
    String? name,
    String? url,
    String? pairingCode,
    String? bearerToken,
    ConnectionStatus? status,
    DateTime? lastConnectedAt,
    DateTime? lastErrorAt,
    String? lastError,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return GatewayConnection(
      id: id ?? this.id,
      providerType: providerType ?? this.providerType,
      name: name ?? this.name,
      url: url ?? this.url,
      pairingCode: pairingCode ?? this.pairingCode,
      bearerToken: bearerToken ?? this.bearerToken,
      status: status ?? this.status,
      lastConnectedAt: lastConnectedAt ?? this.lastConnectedAt,
      lastErrorAt: lastErrorAt ?? this.lastErrorAt,
      lastError: lastError ?? this.lastError,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  GatewayConnection copyWithGatewayConnection({
    String? id,
    AIProviderType? providerType,
    String? name,
    String? url,
    String? pairingCode,
    String? bearerToken,
    ConnectionStatus? status,
    DateTime? lastConnectedAt,
    DateTime? lastErrorAt,
    String? lastError,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return copyWith(
      id: id,
      providerType: providerType,
      name: name,
      url: url,
      pairingCode: pairingCode,
      bearerToken: bearerToken,
      status: status,
      lastConnectedAt: lastConnectedAt,
      lastErrorAt: lastErrorAt,
      lastError: lastError,
      createdAt: createdAt,
      updatedAt: updatedAt,
    );
  }

  GatewayConnection patchWithGatewayConnection({
    GatewayConnectionPatch? patchInput,
  }) {
    final _patcher = patchInput ?? GatewayConnectionPatch();
    final _patchMap = _patcher.toPatch();
    return GatewayConnection(
      id: _patchMap.containsKey(GatewayConnection$.id)
          ? (_patchMap[GatewayConnection$.id] is Function)
                ? _patchMap[GatewayConnection$.id](this.id)
                : _patchMap[GatewayConnection$.id]
          : this.id,
      providerType: _patchMap.containsKey(GatewayConnection$.providerType)
          ? (_patchMap[GatewayConnection$.providerType] is Function)
                ? _patchMap[GatewayConnection$.providerType](this.providerType)
                : _patchMap[GatewayConnection$.providerType]
          : this.providerType,
      name: _patchMap.containsKey(GatewayConnection$.name)
          ? (_patchMap[GatewayConnection$.name] is Function)
                ? _patchMap[GatewayConnection$.name](this.name)
                : _patchMap[GatewayConnection$.name]
          : this.name,
      url: _patchMap.containsKey(GatewayConnection$.url)
          ? (_patchMap[GatewayConnection$.url] is Function)
                ? _patchMap[GatewayConnection$.url](this.url)
                : _patchMap[GatewayConnection$.url]
          : this.url,
      pairingCode: _patchMap.containsKey(GatewayConnection$.pairingCode)
          ? (_patchMap[GatewayConnection$.pairingCode] is Function)
                ? _patchMap[GatewayConnection$.pairingCode](this.pairingCode)
                : _patchMap[GatewayConnection$.pairingCode]
          : this.pairingCode,
      bearerToken: _patchMap.containsKey(GatewayConnection$.bearerToken)
          ? (_patchMap[GatewayConnection$.bearerToken] is Function)
                ? _patchMap[GatewayConnection$.bearerToken](this.bearerToken)
                : _patchMap[GatewayConnection$.bearerToken]
          : this.bearerToken,
      status: _patchMap.containsKey(GatewayConnection$.status)
          ? (_patchMap[GatewayConnection$.status] is Function)
                ? _patchMap[GatewayConnection$.status](this.status)
                : _patchMap[GatewayConnection$.status]
          : this.status,
      lastConnectedAt: _patchMap.containsKey(GatewayConnection$.lastConnectedAt)
          ? (_patchMap[GatewayConnection$.lastConnectedAt] is Function)
                ? _patchMap[GatewayConnection$.lastConnectedAt](
                    this.lastConnectedAt,
                  )
                : _patchMap[GatewayConnection$.lastConnectedAt]
          : this.lastConnectedAt,
      lastErrorAt: _patchMap.containsKey(GatewayConnection$.lastErrorAt)
          ? (_patchMap[GatewayConnection$.lastErrorAt] is Function)
                ? _patchMap[GatewayConnection$.lastErrorAt](this.lastErrorAt)
                : _patchMap[GatewayConnection$.lastErrorAt]
          : this.lastErrorAt,
      lastError: _patchMap.containsKey(GatewayConnection$.lastError)
          ? (_patchMap[GatewayConnection$.lastError] is Function)
                ? _patchMap[GatewayConnection$.lastError](this.lastError)
                : _patchMap[GatewayConnection$.lastError]
          : this.lastError,
      createdAt: _patchMap.containsKey(GatewayConnection$.createdAt)
          ? (_patchMap[GatewayConnection$.createdAt] is Function)
                ? _patchMap[GatewayConnection$.createdAt](this.createdAt)
                : _patchMap[GatewayConnection$.createdAt]
          : this.createdAt,
      updatedAt: _patchMap.containsKey(GatewayConnection$.updatedAt)
          ? (_patchMap[GatewayConnection$.updatedAt] is Function)
                ? _patchMap[GatewayConnection$.updatedAt](this.updatedAt)
                : _patchMap[GatewayConnection$.updatedAt]
          : this.updatedAt,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is GatewayConnection &&
        id == other.id &&
        providerType == other.providerType &&
        name == other.name &&
        url == other.url &&
        pairingCode == other.pairingCode &&
        bearerToken == other.bearerToken &&
        status == other.status &&
        lastConnectedAt == other.lastConnectedAt &&
        lastErrorAt == other.lastErrorAt &&
        lastError == other.lastError &&
        createdAt == other.createdAt &&
        updatedAt == other.updatedAt;
  }

  @override
  int get hashCode {
    return Object.hash(
      this.id,
      this.providerType,
      this.name,
      this.url,
      this.pairingCode,
      this.bearerToken,
      this.status,
      this.lastConnectedAt,
      this.lastErrorAt,
      this.lastError,
      this.createdAt,
      this.updatedAt,
    );
  }

  @override
  String toString() {
    return 'GatewayConnection(' +
        'id: ${id}' +
        ', ' +
        'providerType: ${providerType}' +
        ', ' +
        'name: ${name}' +
        ', ' +
        'url: ${url}' +
        ', ' +
        'pairingCode: ${pairingCode}' +
        ', ' +
        'bearerToken: ${bearerToken}' +
        ', ' +
        'status: ${status}' +
        ', ' +
        'lastConnectedAt: ${lastConnectedAt}' +
        ', ' +
        'lastErrorAt: ${lastErrorAt}' +
        ', ' +
        'lastError: ${lastError}' +
        ', ' +
        'createdAt: ${createdAt}' +
        ', ' +
        'updatedAt: ${updatedAt})';
  }

  /// Creates a [GatewayConnection] instance from JSON
  factory GatewayConnection.fromJson(Map<String, dynamic> json) =>
      _$GatewayConnectionFromJson(json);

  Map<String, dynamic> toJsonLean() {
    final Map<String, dynamic> data = _$GatewayConnectionToJson(this);
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

extension GatewayConnectionPropertyHelpers on GatewayConnection {
  bool get isProviderTypeZeroClaw => providerType == AIProviderType.zeroClaw;
  bool get isProviderTypePicoClaw => providerType == AIProviderType.picoClaw;
  bool get isProviderTypeOpenClaw => providerType == AIProviderType.openClaw;
  bool get hasPairingCode => pairingCode != null;
  bool get noPairingCode => pairingCode == null;
  String get pairingCodeRequired =>
      pairingCode ?? (throw StateError('pairingCode is required but was null'));
  bool get hasBearerToken => bearerToken != null;
  bool get noBearerToken => bearerToken == null;
  String get bearerTokenRequired =>
      bearerToken ?? (throw StateError('bearerToken is required but was null'));
  bool get isStatusDisconnected => status == ConnectionStatus.disconnected;
  bool get isStatusConnecting => status == ConnectionStatus.connecting;
  bool get isStatusConnected => status == ConnectionStatus.connected;
  bool get isStatusError => status == ConnectionStatus.error;
  bool get isStatusReconnecting => status == ConnectionStatus.reconnecting;
  bool get hasLastConnectedAt => lastConnectedAt != null;
  bool get noLastConnectedAt => lastConnectedAt == null;
  DateTime get lastConnectedAtRequired =>
      lastConnectedAt ??
      (throw StateError('lastConnectedAt is required but was null'));
  bool get hasLastErrorAt => lastErrorAt != null;
  bool get noLastErrorAt => lastErrorAt == null;
  DateTime get lastErrorAtRequired =>
      lastErrorAt ?? (throw StateError('lastErrorAt is required but was null'));
  bool get hasLastError => lastError != null;
  bool get noLastError => lastError == null;
  String get lastErrorRequired =>
      lastError ?? (throw StateError('lastError is required but was null'));
}

extension GatewayConnectionSerialization on GatewayConnection {
  Map<String, dynamic> toJson() => _$GatewayConnectionToJson(this);
  Map<String, dynamic> toJsonLean() {
    final Map<String, dynamic> data = _$GatewayConnectionToJson(this);
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

enum GatewayConnection$ {
  id,
  providerType,
  name,
  url,
  pairingCode,
  bearerToken,
  status,
  lastConnectedAt,
  lastErrorAt,
  lastError,
  createdAt,
  updatedAt,
}

class GatewayConnectionPatch implements Patch<GatewayConnection> {
  final Map<GatewayConnection$, dynamic> _patch = {};

  static GatewayConnectionPatch create([Map<String, dynamic>? diff]) {
    final patch = GatewayConnectionPatch();
    if (diff != null) {
      diff.forEach((key, value) {
        try {
          final enumValue = GatewayConnection$.values.firstWhere(
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

  static GatewayConnectionPatch fromPatch(
    Map<GatewayConnection$, dynamic> patch,
  ) {
    final _patch = GatewayConnectionPatch();
    _patch._patch.addAll(patch);
    return _patch;
  }

  Map<GatewayConnection$, dynamic> toPatch() => Map.from(_patch);

  GatewayConnection applyTo(GatewayConnection entity) {
    return entity.patchWithGatewayConnection(patchInput: this);
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

  static GatewayConnectionPatch fromJson(Map<String, dynamic> json) {
    return create(json);
  }

  GatewayConnectionPatch withId(String? value) {
    _patch[GatewayConnection$.id] = value;
    return this;
  }

  GatewayConnectionPatch withProviderType(AIProviderType? value) {
    _patch[GatewayConnection$.providerType] = value;
    return this;
  }

  GatewayConnectionPatch withName(String? value) {
    _patch[GatewayConnection$.name] = value;
    return this;
  }

  GatewayConnectionPatch withUrl(String? value) {
    _patch[GatewayConnection$.url] = value;
    return this;
  }

  GatewayConnectionPatch withPairingCode(String? value) {
    _patch[GatewayConnection$.pairingCode] = value;
    return this;
  }

  GatewayConnectionPatch withBearerToken(String? value) {
    _patch[GatewayConnection$.bearerToken] = value;
    return this;
  }

  GatewayConnectionPatch withStatus(ConnectionStatus? value) {
    _patch[GatewayConnection$.status] = value;
    return this;
  }

  GatewayConnectionPatch withLastConnectedAt(DateTime? value) {
    _patch[GatewayConnection$.lastConnectedAt] = value;
    return this;
  }

  GatewayConnectionPatch withLastErrorAt(DateTime? value) {
    _patch[GatewayConnection$.lastErrorAt] = value;
    return this;
  }

  GatewayConnectionPatch withLastError(String? value) {
    _patch[GatewayConnection$.lastError] = value;
    return this;
  }

  GatewayConnectionPatch withCreatedAt(DateTime? value) {
    _patch[GatewayConnection$.createdAt] = value;
    return this;
  }

  GatewayConnectionPatch withUpdatedAt(DateTime? value) {
    _patch[GatewayConnection$.updatedAt] = value;
    return this;
  }
}

/// Field descriptors for [GatewayConnection] query construction
abstract final class GatewayConnectionFields {
  static String _$getid(GatewayConnection e) => e.id;
  static const id = Field<GatewayConnection, String>('id', _$getid);
  static AIProviderType _$getproviderType(GatewayConnection e) =>
      e.providerType;
  static const providerType = Field<GatewayConnection, AIProviderType>(
    'providerType',
    _$getproviderType,
  );
  static String _$getname(GatewayConnection e) => e.name;
  static const name = Field<GatewayConnection, String>('name', _$getname);
  static String _$geturl(GatewayConnection e) => e.url;
  static const url = Field<GatewayConnection, String>('url', _$geturl);
  static String? _$getpairingCode(GatewayConnection e) => e.pairingCode;
  static const pairingCode = Field<GatewayConnection, String?>(
    'pairingCode',
    _$getpairingCode,
  );
  static String? _$getbearerToken(GatewayConnection e) => e.bearerToken;
  static const bearerToken = Field<GatewayConnection, String?>(
    'bearerToken',
    _$getbearerToken,
  );
  static ConnectionStatus _$getstatus(GatewayConnection e) => e.status;
  static const status = Field<GatewayConnection, ConnectionStatus>(
    'status',
    _$getstatus,
  );
  static DateTime? _$getlastConnectedAt(GatewayConnection e) =>
      e.lastConnectedAt;
  static const lastConnectedAt = Field<GatewayConnection, DateTime?>(
    'lastConnectedAt',
    _$getlastConnectedAt,
  );
  static DateTime? _$getlastErrorAt(GatewayConnection e) => e.lastErrorAt;
  static const lastErrorAt = Field<GatewayConnection, DateTime?>(
    'lastErrorAt',
    _$getlastErrorAt,
  );
  static String? _$getlastError(GatewayConnection e) => e.lastError;
  static const lastError = Field<GatewayConnection, String?>(
    'lastError',
    _$getlastError,
  );
  static DateTime _$getcreatedAt(GatewayConnection e) => e.createdAt;
  static const createdAt = Field<GatewayConnection, DateTime>(
    'createdAt',
    _$getcreatedAt,
  );
  static DateTime _$getupdatedAt(GatewayConnection e) => e.updatedAt;
  static const updatedAt = Field<GatewayConnection, DateTime>(
    'updatedAt',
    _$getupdatedAt,
  );
}

extension GatewayConnectionCompareE on GatewayConnection {
  Map<String, dynamic> compareToGatewayConnection(GatewayConnection other) {
    final Map<String, dynamic> diff = {};

    if (id != other.id) {
      diff['id'] = () => other.id;
    }
    if (providerType != other.providerType) {
      diff['providerType'] = () => other.providerType;
    }
    if (name != other.name) {
      diff['name'] = () => other.name;
    }
    if (url != other.url) {
      diff['url'] = () => other.url;
    }
    if (pairingCode != other.pairingCode) {
      diff['pairingCode'] = () => other.pairingCode;
    }
    if (bearerToken != other.bearerToken) {
      diff['bearerToken'] = () => other.bearerToken;
    }
    if (status != other.status) {
      diff['status'] = () => other.status;
    }
    if (lastConnectedAt != other.lastConnectedAt) {
      diff['lastConnectedAt'] = () => other.lastConnectedAt;
    }
    if (lastErrorAt != other.lastErrorAt) {
      diff['lastErrorAt'] = () => other.lastErrorAt;
    }
    if (lastError != other.lastError) {
      diff['lastError'] = () => other.lastError;
    }
    if (createdAt != other.createdAt) {
      diff['createdAt'] = () => other.createdAt;
    }
    if (updatedAt != other.updatedAt) {
      diff['updatedAt'] = () => other.updatedAt;
    }
    return diff;
  }
}
