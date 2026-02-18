// dart format width=80
// ignore_for_file: UNNECESSARY_CAST
// ignore_for_file: type=lint

part of 'workspace.dart';

// **************************************************************************
// ZorphyGenerator
// **************************************************************************

@JsonSerializable(explicitToJson: true)
class Workspace {
  final WorkspaceIdentity identity;
  final String gatewayConnectionId;
  final DateTime createdAt;
  final DateTime? updatedAt;
  final DateTime? deletedAt;
  final String id;

  Workspace({
    required this.identity,
    required this.gatewayConnectionId,
    required this.createdAt,
    this.updatedAt,
    this.deletedAt,
    required this.id,
  });

  Workspace copyWith({
    WorkspaceIdentity? identity,
    String? gatewayConnectionId,
    DateTime? createdAt,
    DateTime? updatedAt,
    DateTime? deletedAt,
    String? id,
  }) {
    return Workspace(
      identity: identity ?? this.identity,
      gatewayConnectionId: gatewayConnectionId ?? this.gatewayConnectionId,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      deletedAt: deletedAt ?? this.deletedAt,
      id: id ?? this.id,
    );
  }

  Workspace copyWithWorkspace({
    WorkspaceIdentity? identity,
    String? gatewayConnectionId,
    DateTime? createdAt,
    DateTime? updatedAt,
    DateTime? deletedAt,
    String? id,
  }) {
    return copyWith(
      identity: identity,
      gatewayConnectionId: gatewayConnectionId,
      createdAt: createdAt,
      updatedAt: updatedAt,
      deletedAt: deletedAt,
      id: id,
    );
  }

  Workspace patchWithWorkspace({WorkspacePatch? patchInput}) {
    final _patcher = patchInput ?? WorkspacePatch();
    final _patchMap = _patcher.toPatch();
    return Workspace(
      identity: _patchMap.containsKey(Workspace$.identity)
          ? (_patchMap[Workspace$.identity] is Function)
                ? _patchMap[Workspace$.identity](this.identity)
                : _patchMap[Workspace$.identity]
          : this.identity,
      gatewayConnectionId: _patchMap.containsKey(Workspace$.gatewayConnectionId)
          ? (_patchMap[Workspace$.gatewayConnectionId] is Function)
                ? _patchMap[Workspace$.gatewayConnectionId](
                    this.gatewayConnectionId,
                  )
                : _patchMap[Workspace$.gatewayConnectionId]
          : this.gatewayConnectionId,
      createdAt: _patchMap.containsKey(Workspace$.createdAt)
          ? (_patchMap[Workspace$.createdAt] is Function)
                ? _patchMap[Workspace$.createdAt](this.createdAt)
                : _patchMap[Workspace$.createdAt]
          : this.createdAt,
      updatedAt: _patchMap.containsKey(Workspace$.updatedAt)
          ? (_patchMap[Workspace$.updatedAt] is Function)
                ? _patchMap[Workspace$.updatedAt](this.updatedAt)
                : _patchMap[Workspace$.updatedAt]
          : this.updatedAt,
      deletedAt: _patchMap.containsKey(Workspace$.deletedAt)
          ? (_patchMap[Workspace$.deletedAt] is Function)
                ? _patchMap[Workspace$.deletedAt](this.deletedAt)
                : _patchMap[Workspace$.deletedAt]
          : this.deletedAt,
      id: _patchMap.containsKey(Workspace$.id)
          ? (_patchMap[Workspace$.id] is Function)
                ? _patchMap[Workspace$.id](this.id)
                : _patchMap[Workspace$.id]
          : this.id,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is Workspace &&
        identity == other.identity &&
        gatewayConnectionId == other.gatewayConnectionId &&
        createdAt == other.createdAt &&
        updatedAt == other.updatedAt &&
        deletedAt == other.deletedAt &&
        id == other.id;
  }

  @override
  int get hashCode {
    return Object.hash(
      this.identity,
      this.gatewayConnectionId,
      this.createdAt,
      this.updatedAt,
      this.deletedAt,
      this.id,
    );
  }

  @override
  String toString() {
    return 'Workspace(' +
        'identity: ${identity}' +
        ', ' +
        'gatewayConnectionId: ${gatewayConnectionId}' +
        ', ' +
        'createdAt: ${createdAt}' +
        ', ' +
        'updatedAt: ${updatedAt}' +
        ', ' +
        'deletedAt: ${deletedAt}' +
        ', ' +
        'id: ${id})';
  }

  /// Creates a [Workspace] instance from JSON
  factory Workspace.fromJson(Map<String, dynamic> json) =>
      _$WorkspaceFromJson(json);

  Map<String, dynamic> toJsonLean() {
    final Map<String, dynamic> data = _$WorkspaceToJson(this);
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

extension WorkspacePropertyHelpers on Workspace {
  bool get hasUpdatedAt => updatedAt != null;
  bool get noUpdatedAt => updatedAt == null;
  DateTime get updatedAtRequired =>
      updatedAt ?? (throw StateError('updatedAt is required but was null'));
  bool get hasDeletedAt => deletedAt != null;
  bool get noDeletedAt => deletedAt == null;
  DateTime get deletedAtRequired =>
      deletedAt ?? (throw StateError('deletedAt is required but was null'));
}

extension WorkspaceSerialization on Workspace {
  Map<String, dynamic> toJson() => _$WorkspaceToJson(this);
  Map<String, dynamic> toJsonLean() {
    final Map<String, dynamic> data = _$WorkspaceToJson(this);
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

enum Workspace$ {
  identity,
  gatewayConnectionId,
  createdAt,
  updatedAt,
  deletedAt,
  id,
}

class WorkspacePatch implements Patch<Workspace> {
  final Map<Workspace$, dynamic> _patch = {};

  static WorkspacePatch create([Map<String, dynamic>? diff]) {
    final patch = WorkspacePatch();
    if (diff != null) {
      diff.forEach((key, value) {
        try {
          final enumValue = Workspace$.values.firstWhere((e) => e.name == key);
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

  static WorkspacePatch fromPatch(Map<Workspace$, dynamic> patch) {
    final _patch = WorkspacePatch();
    _patch._patch.addAll(patch);
    return _patch;
  }

  Map<Workspace$, dynamic> toPatch() => Map.from(_patch);

  Workspace applyTo(Workspace entity) {
    return entity.patchWithWorkspace(patchInput: this);
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

  static WorkspacePatch fromJson(Map<String, dynamic> json) {
    return create(json);
  }

  WorkspacePatch withIdentity(WorkspaceIdentity? value) {
    _patch[Workspace$.identity] = value;
    return this;
  }

  WorkspacePatch withGatewayConnectionId(String? value) {
    _patch[Workspace$.gatewayConnectionId] = value;
    return this;
  }

  WorkspacePatch withCreatedAt(DateTime? value) {
    _patch[Workspace$.createdAt] = value;
    return this;
  }

  WorkspacePatch withUpdatedAt(DateTime? value) {
    _patch[Workspace$.updatedAt] = value;
    return this;
  }

  WorkspacePatch withDeletedAt(DateTime? value) {
    _patch[Workspace$.deletedAt] = value;
    return this;
  }

  WorkspacePatch withId(String? value) {
    _patch[Workspace$.id] = value;
    return this;
  }
}

/// Field descriptors for [Workspace] query construction
abstract final class WorkspaceFields {
  static WorkspaceIdentity _$getidentity(Workspace e) => e.identity;
  static const identity = Field<Workspace, WorkspaceIdentity>(
    'identity',
    _$getidentity,
  );
  static String _$getgatewayConnectionId(Workspace e) => e.gatewayConnectionId;
  static const gatewayConnectionId = Field<Workspace, String>(
    'gatewayConnectionId',
    _$getgatewayConnectionId,
  );
  static DateTime _$getcreatedAt(Workspace e) => e.createdAt;
  static const createdAt = Field<Workspace, DateTime>(
    'createdAt',
    _$getcreatedAt,
  );
  static DateTime? _$getupdatedAt(Workspace e) => e.updatedAt;
  static const updatedAt = Field<Workspace, DateTime?>(
    'updatedAt',
    _$getupdatedAt,
  );
  static DateTime? _$getdeletedAt(Workspace e) => e.deletedAt;
  static const deletedAt = Field<Workspace, DateTime?>(
    'deletedAt',
    _$getdeletedAt,
  );
  static String _$getid(Workspace e) => e.id;
  static const id = Field<Workspace, String>('id', _$getid);
}

extension WorkspaceCompareE on Workspace {
  Map<String, dynamic> compareToWorkspace(Workspace other) {
    final Map<String, dynamic> diff = {};

    if (identity != other.identity) {
      diff['identity'] = () => other.identity;
    }
    if (gatewayConnectionId != other.gatewayConnectionId) {
      diff['gatewayConnectionId'] = () => other.gatewayConnectionId;
    }
    if (createdAt != other.createdAt) {
      diff['createdAt'] = () => other.createdAt;
    }
    if (updatedAt != other.updatedAt) {
      diff['updatedAt'] = () => other.updatedAt;
    }
    if (deletedAt != other.deletedAt) {
      diff['deletedAt'] = () => other.deletedAt;
    }
    if (id != other.id) {
      diff['id'] = () => other.id;
    }
    return diff;
  }
}
