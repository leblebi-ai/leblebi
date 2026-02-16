// dart format width=80
// ignore_for_file: UNNECESSARY_CAST
// ignore_for_file: type=lint

part of 'workspace.dart';

// **************************************************************************
// ZorphyGenerator
// **************************************************************************

@JsonSerializable(explicitToJson: true)
class Workspace {
  final String id;
  final String name;
  final String? description;
  final String? gatewayConnectionId;
  final IdentityConfig identityConfig;
  final List<ToolConfiguration> toolConfigurations;
  final String? activeConversationId;
  final DateTime createdAt;
  final DateTime updatedAt;
  final bool isDeleted;

  Workspace({
    required this.id,
    required this.name,
    this.description,
    this.gatewayConnectionId,
    required this.identityConfig,
    required this.toolConfigurations,
    this.activeConversationId,
    required this.createdAt,
    required this.updatedAt,
    required this.isDeleted,
  });

  Workspace copyWith({
    String? id,
    String? name,
    String? description,
    String? gatewayConnectionId,
    IdentityConfig? identityConfig,
    List<ToolConfiguration>? toolConfigurations,
    String? activeConversationId,
    DateTime? createdAt,
    DateTime? updatedAt,
    bool? isDeleted,
  }) {
    return Workspace(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
      gatewayConnectionId: gatewayConnectionId ?? this.gatewayConnectionId,
      identityConfig: identityConfig ?? this.identityConfig,
      toolConfigurations: toolConfigurations ?? this.toolConfigurations,
      activeConversationId: activeConversationId ?? this.activeConversationId,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      isDeleted: isDeleted ?? this.isDeleted,
    );
  }

  Workspace copyWithWorkspace({
    String? id,
    String? name,
    String? description,
    String? gatewayConnectionId,
    IdentityConfig? identityConfig,
    List<ToolConfiguration>? toolConfigurations,
    String? activeConversationId,
    DateTime? createdAt,
    DateTime? updatedAt,
    bool? isDeleted,
  }) {
    return copyWith(
      id: id,
      name: name,
      description: description,
      gatewayConnectionId: gatewayConnectionId,
      identityConfig: identityConfig,
      toolConfigurations: toolConfigurations,
      activeConversationId: activeConversationId,
      createdAt: createdAt,
      updatedAt: updatedAt,
      isDeleted: isDeleted,
    );
  }

  Workspace patchWithWorkspace({WorkspacePatch? patchInput}) {
    final _patcher = patchInput ?? WorkspacePatch();
    final _patchMap = _patcher.toPatch();
    return Workspace(
      id: _patchMap.containsKey(Workspace$.id)
          ? (_patchMap[Workspace$.id] is Function)
                ? _patchMap[Workspace$.id](this.id)
                : _patchMap[Workspace$.id]
          : this.id,
      name: _patchMap.containsKey(Workspace$.name)
          ? (_patchMap[Workspace$.name] is Function)
                ? _patchMap[Workspace$.name](this.name)
                : _patchMap[Workspace$.name]
          : this.name,
      description: _patchMap.containsKey(Workspace$.description)
          ? (_patchMap[Workspace$.description] is Function)
                ? _patchMap[Workspace$.description](this.description)
                : _patchMap[Workspace$.description]
          : this.description,
      gatewayConnectionId: _patchMap.containsKey(Workspace$.gatewayConnectionId)
          ? (_patchMap[Workspace$.gatewayConnectionId] is Function)
                ? _patchMap[Workspace$.gatewayConnectionId](
                    this.gatewayConnectionId,
                  )
                : _patchMap[Workspace$.gatewayConnectionId]
          : this.gatewayConnectionId,
      identityConfig: _patchMap.containsKey(Workspace$.identityConfig)
          ? (_patchMap[Workspace$.identityConfig] is Function)
                ? _patchMap[Workspace$.identityConfig](this.identityConfig)
                : _patchMap[Workspace$.identityConfig]
          : this.identityConfig,
      toolConfigurations: _patchMap.containsKey(Workspace$.toolConfigurations)
          ? (_patchMap[Workspace$.toolConfigurations] is Function)
                ? _patchMap[Workspace$.toolConfigurations](
                    this.toolConfigurations,
                  )
                : _patchMap[Workspace$.toolConfigurations]
          : this.toolConfigurations,
      activeConversationId:
          _patchMap.containsKey(Workspace$.activeConversationId)
          ? (_patchMap[Workspace$.activeConversationId] is Function)
                ? _patchMap[Workspace$.activeConversationId](
                    this.activeConversationId,
                  )
                : _patchMap[Workspace$.activeConversationId]
          : this.activeConversationId,
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
      isDeleted: _patchMap.containsKey(Workspace$.isDeleted)
          ? (_patchMap[Workspace$.isDeleted] is Function)
                ? _patchMap[Workspace$.isDeleted](this.isDeleted)
                : _patchMap[Workspace$.isDeleted]
          : this.isDeleted,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is Workspace &&
        id == other.id &&
        name == other.name &&
        description == other.description &&
        gatewayConnectionId == other.gatewayConnectionId &&
        identityConfig == other.identityConfig &&
        toolConfigurations == other.toolConfigurations &&
        activeConversationId == other.activeConversationId &&
        createdAt == other.createdAt &&
        updatedAt == other.updatedAt &&
        isDeleted == other.isDeleted;
  }

  @override
  int get hashCode {
    return Object.hash(
      this.id,
      this.name,
      this.description,
      this.gatewayConnectionId,
      this.identityConfig,
      this.toolConfigurations,
      this.activeConversationId,
      this.createdAt,
      this.updatedAt,
      this.isDeleted,
    );
  }

  @override
  String toString() {
    return 'Workspace(' +
        'id: ${id}' +
        ', ' +
        'name: ${name}' +
        ', ' +
        'description: ${description}' +
        ', ' +
        'gatewayConnectionId: ${gatewayConnectionId}' +
        ', ' +
        'identityConfig: ${identityConfig}' +
        ', ' +
        'toolConfigurations: ${toolConfigurations}' +
        ', ' +
        'activeConversationId: ${activeConversationId}' +
        ', ' +
        'createdAt: ${createdAt}' +
        ', ' +
        'updatedAt: ${updatedAt}' +
        ', ' +
        'isDeleted: ${isDeleted})';
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
  bool get hasDescription => description != null;
  bool get noDescription => description == null;
  String get descriptionRequired =>
      description ?? (throw StateError('description is required but was null'));
  bool get hasGatewayConnectionId => gatewayConnectionId != null;
  bool get noGatewayConnectionId => gatewayConnectionId == null;
  String get gatewayConnectionIdRequired =>
      gatewayConnectionId ??
      (throw StateError('gatewayConnectionId is required but was null'));
  bool get hasToolConfigurations => toolConfigurations.isNotEmpty;
  bool get noToolConfigurations => toolConfigurations.isEmpty;
  bool get hasActiveConversationId => activeConversationId != null;
  bool get noActiveConversationId => activeConversationId == null;
  String get activeConversationIdRequired =>
      activeConversationId ??
      (throw StateError('activeConversationId is required but was null'));
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
  id,
  name,
  description,
  gatewayConnectionId,
  identityConfig,
  toolConfigurations,
  activeConversationId,
  createdAt,
  updatedAt,
  isDeleted,
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

  WorkspacePatch withId(String? value) {
    _patch[Workspace$.id] = value;
    return this;
  }

  WorkspacePatch withName(String? value) {
    _patch[Workspace$.name] = value;
    return this;
  }

  WorkspacePatch withDescription(String? value) {
    _patch[Workspace$.description] = value;
    return this;
  }

  WorkspacePatch withGatewayConnectionId(String? value) {
    _patch[Workspace$.gatewayConnectionId] = value;
    return this;
  }

  WorkspacePatch withIdentityConfig(IdentityConfig? value) {
    _patch[Workspace$.identityConfig] = value;
    return this;
  }

  WorkspacePatch withIdentityConfigPatch(IdentityConfigPatch patch) {
    _patch[Workspace$.identityConfig] = patch;
    return this;
  }

  WorkspacePatch withIdentityConfigPatchFunc(
    IdentityConfigPatch Function(IdentityConfigPatch) patch,
  ) {
    _patch[Workspace$.identityConfig] = (dynamic current) {
      var currentPatch = IdentityConfigPatch();
      if (current != null) {
        currentPatch = current as IdentityConfigPatch;
      }
      return patch(currentPatch);
    };
    return this;
  }

  WorkspacePatch withToolConfigurations(List<ToolConfiguration>? value) {
    _patch[Workspace$.toolConfigurations] = value;
    return this;
  }

  WorkspacePatch updateToolConfigurationsAt(
    int index,
    ToolConfigurationPatch Function(ToolConfigurationPatch) patch,
  ) {
    _patch[Workspace$.toolConfigurations] = (List<dynamic> list) {
      var updatedList = List.from(list);
      if (index >= 0 && index < updatedList.length) {
        updatedList[index] = patch(
          updatedList[index] as ToolConfigurationPatch,
        );
      }
      return updatedList;
    };
    return this;
  }

  WorkspacePatch withActiveConversationId(String? value) {
    _patch[Workspace$.activeConversationId] = value;
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

  WorkspacePatch withIsDeleted(bool? value) {
    _patch[Workspace$.isDeleted] = value;
    return this;
  }
}

/// Field descriptors for [Workspace] query construction
abstract final class WorkspaceFields {
  static String _$getid(Workspace e) => e.id;
  static const id = Field<Workspace, String>('id', _$getid);
  static String _$getname(Workspace e) => e.name;
  static const name = Field<Workspace, String>('name', _$getname);
  static String? _$getdescription(Workspace e) => e.description;
  static const description = Field<Workspace, String?>(
    'description',
    _$getdescription,
  );
  static String? _$getgatewayConnectionId(Workspace e) => e.gatewayConnectionId;
  static const gatewayConnectionId = Field<Workspace, String?>(
    'gatewayConnectionId',
    _$getgatewayConnectionId,
  );
  static IdentityConfig _$getidentityConfig(Workspace e) => e.identityConfig;
  static const identityConfig = Field<Workspace, IdentityConfig>(
    'identityConfig',
    _$getidentityConfig,
  );
  static List<ToolConfiguration> _$gettoolConfigurations(Workspace e) =>
      e.toolConfigurations;
  static const toolConfigurations = Field<Workspace, List<ToolConfiguration>>(
    'toolConfigurations',
    _$gettoolConfigurations,
  );
  static String? _$getactiveConversationId(Workspace e) =>
      e.activeConversationId;
  static const activeConversationId = Field<Workspace, String?>(
    'activeConversationId',
    _$getactiveConversationId,
  );
  static DateTime _$getcreatedAt(Workspace e) => e.createdAt;
  static const createdAt = Field<Workspace, DateTime>(
    'createdAt',
    _$getcreatedAt,
  );
  static DateTime _$getupdatedAt(Workspace e) => e.updatedAt;
  static const updatedAt = Field<Workspace, DateTime>(
    'updatedAt',
    _$getupdatedAt,
  );
  static bool _$getisDeleted(Workspace e) => e.isDeleted;
  static const isDeleted = Field<Workspace, bool>('isDeleted', _$getisDeleted);
}

extension WorkspaceCompareE on Workspace {
  Map<String, dynamic> compareToWorkspace(Workspace other) {
    final Map<String, dynamic> diff = {};

    if (id != other.id) {
      diff['id'] = () => other.id;
    }
    if (name != other.name) {
      diff['name'] = () => other.name;
    }
    if (description != other.description) {
      diff['description'] = () => other.description;
    }
    if (gatewayConnectionId != other.gatewayConnectionId) {
      diff['gatewayConnectionId'] = () => other.gatewayConnectionId;
    }
    if (identityConfig != other.identityConfig) {
      diff['identityConfig'] = () => other.identityConfig;
    }
    if (toolConfigurations != other.toolConfigurations) {
      diff['toolConfigurations'] = () => other.toolConfigurations;
    }
    if (activeConversationId != other.activeConversationId) {
      diff['activeConversationId'] = () => other.activeConversationId;
    }
    if (createdAt != other.createdAt) {
      diff['createdAt'] = () => other.createdAt;
    }
    if (updatedAt != other.updatedAt) {
      diff['updatedAt'] = () => other.updatedAt;
    }
    if (isDeleted != other.isDeleted) {
      diff['isDeleted'] = () => other.isDeleted;
    }
    return diff;
  }
}
