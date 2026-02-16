// dart format width=80
// ignore_for_file: UNNECESSARY_CAST
// ignore_for_file: type=lint

part of 'conversation.dart';

// **************************************************************************
// ZorphyGenerator
// **************************************************************************

@JsonSerializable(explicitToJson: true)
class Conversation {
  final String id;
  final String workspaceId;
  final String title;
  final List<Message> messages;
  final DateTime createdAt;
  final DateTime updatedAt;
  final DateTime? lastMessageAt;
  final int messageCount;
  final bool isArchived;
  final Map<String, dynamic>? metadata;

  Conversation({
    required this.id,
    required this.workspaceId,
    required this.title,
    required this.messages,
    required this.createdAt,
    required this.updatedAt,
    this.lastMessageAt,
    required this.messageCount,
    required this.isArchived,
    this.metadata,
  });

  Conversation copyWith({
    String? id,
    String? workspaceId,
    String? title,
    List<Message>? messages,
    DateTime? createdAt,
    DateTime? updatedAt,
    DateTime? lastMessageAt,
    int? messageCount,
    bool? isArchived,
    Map<String, dynamic>? metadata,
  }) {
    return Conversation(
      id: id ?? this.id,
      workspaceId: workspaceId ?? this.workspaceId,
      title: title ?? this.title,
      messages: messages ?? this.messages,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      lastMessageAt: lastMessageAt ?? this.lastMessageAt,
      messageCount: messageCount ?? this.messageCount,
      isArchived: isArchived ?? this.isArchived,
      metadata: metadata ?? this.metadata,
    );
  }

  Conversation copyWithConversation({
    String? id,
    String? workspaceId,
    String? title,
    List<Message>? messages,
    DateTime? createdAt,
    DateTime? updatedAt,
    DateTime? lastMessageAt,
    int? messageCount,
    bool? isArchived,
    Map<String, dynamic>? metadata,
  }) {
    return copyWith(
      id: id,
      workspaceId: workspaceId,
      title: title,
      messages: messages,
      createdAt: createdAt,
      updatedAt: updatedAt,
      lastMessageAt: lastMessageAt,
      messageCount: messageCount,
      isArchived: isArchived,
      metadata: metadata,
    );
  }

  Conversation patchWithConversation({ConversationPatch? patchInput}) {
    final _patcher = patchInput ?? ConversationPatch();
    final _patchMap = _patcher.toPatch();
    return Conversation(
      id: _patchMap.containsKey(Conversation$.id)
          ? (_patchMap[Conversation$.id] is Function)
                ? _patchMap[Conversation$.id](this.id)
                : _patchMap[Conversation$.id]
          : this.id,
      workspaceId: _patchMap.containsKey(Conversation$.workspaceId)
          ? (_patchMap[Conversation$.workspaceId] is Function)
                ? _patchMap[Conversation$.workspaceId](this.workspaceId)
                : _patchMap[Conversation$.workspaceId]
          : this.workspaceId,
      title: _patchMap.containsKey(Conversation$.title)
          ? (_patchMap[Conversation$.title] is Function)
                ? _patchMap[Conversation$.title](this.title)
                : _patchMap[Conversation$.title]
          : this.title,
      messages: _patchMap.containsKey(Conversation$.messages)
          ? (_patchMap[Conversation$.messages] is Function)
                ? _patchMap[Conversation$.messages](this.messages)
                : _patchMap[Conversation$.messages]
          : this.messages,
      createdAt: _patchMap.containsKey(Conversation$.createdAt)
          ? (_patchMap[Conversation$.createdAt] is Function)
                ? _patchMap[Conversation$.createdAt](this.createdAt)
                : _patchMap[Conversation$.createdAt]
          : this.createdAt,
      updatedAt: _patchMap.containsKey(Conversation$.updatedAt)
          ? (_patchMap[Conversation$.updatedAt] is Function)
                ? _patchMap[Conversation$.updatedAt](this.updatedAt)
                : _patchMap[Conversation$.updatedAt]
          : this.updatedAt,
      lastMessageAt: _patchMap.containsKey(Conversation$.lastMessageAt)
          ? (_patchMap[Conversation$.lastMessageAt] is Function)
                ? _patchMap[Conversation$.lastMessageAt](this.lastMessageAt)
                : _patchMap[Conversation$.lastMessageAt]
          : this.lastMessageAt,
      messageCount: _patchMap.containsKey(Conversation$.messageCount)
          ? (_patchMap[Conversation$.messageCount] is Function)
                ? _patchMap[Conversation$.messageCount](this.messageCount)
                : _patchMap[Conversation$.messageCount]
          : this.messageCount,
      isArchived: _patchMap.containsKey(Conversation$.isArchived)
          ? (_patchMap[Conversation$.isArchived] is Function)
                ? _patchMap[Conversation$.isArchived](this.isArchived)
                : _patchMap[Conversation$.isArchived]
          : this.isArchived,
      metadata: _patchMap.containsKey(Conversation$.metadata)
          ? (_patchMap[Conversation$.metadata] is Function)
                ? _patchMap[Conversation$.metadata](this.metadata)
                : _patchMap[Conversation$.metadata]
          : this.metadata,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is Conversation &&
        id == other.id &&
        workspaceId == other.workspaceId &&
        title == other.title &&
        messages == other.messages &&
        createdAt == other.createdAt &&
        updatedAt == other.updatedAt &&
        lastMessageAt == other.lastMessageAt &&
        messageCount == other.messageCount &&
        isArchived == other.isArchived &&
        metadata == other.metadata;
  }

  @override
  int get hashCode {
    return Object.hash(
      this.id,
      this.workspaceId,
      this.title,
      this.messages,
      this.createdAt,
      this.updatedAt,
      this.lastMessageAt,
      this.messageCount,
      this.isArchived,
      this.metadata,
    );
  }

  @override
  String toString() {
    return 'Conversation(' +
        'id: ${id}' +
        ', ' +
        'workspaceId: ${workspaceId}' +
        ', ' +
        'title: ${title}' +
        ', ' +
        'messages: ${messages}' +
        ', ' +
        'createdAt: ${createdAt}' +
        ', ' +
        'updatedAt: ${updatedAt}' +
        ', ' +
        'lastMessageAt: ${lastMessageAt}' +
        ', ' +
        'messageCount: ${messageCount}' +
        ', ' +
        'isArchived: ${isArchived}' +
        ', ' +
        'metadata: ${metadata})';
  }

  /// Creates a [Conversation] instance from JSON
  factory Conversation.fromJson(Map<String, dynamic> json) =>
      _$ConversationFromJson(json);

  Map<String, dynamic> toJsonLean() {
    final Map<String, dynamic> data = _$ConversationToJson(this);
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

extension ConversationPropertyHelpers on Conversation {
  bool get hasMessages => messages.isNotEmpty;
  bool get noMessages => messages.isEmpty;
  bool get hasLastMessageAt => lastMessageAt != null;
  bool get noLastMessageAt => lastMessageAt == null;
  DateTime get lastMessageAtRequired =>
      lastMessageAt ??
      (throw StateError('lastMessageAt is required but was null'));
  Map<String, dynamic> get metadataRequired =>
      metadata ?? (throw StateError('metadata is required but was null'));
  bool get hasMetadata => metadata?.isNotEmpty ?? false;
  bool get noMetadata => metadata?.isEmpty ?? true;
}

extension ConversationSerialization on Conversation {
  Map<String, dynamic> toJson() => _$ConversationToJson(this);
  Map<String, dynamic> toJsonLean() {
    final Map<String, dynamic> data = _$ConversationToJson(this);
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

enum Conversation$ {
  id,
  workspaceId,
  title,
  messages,
  createdAt,
  updatedAt,
  lastMessageAt,
  messageCount,
  isArchived,
  metadata,
}

class ConversationPatch implements Patch<Conversation> {
  final Map<Conversation$, dynamic> _patch = {};

  static ConversationPatch create([Map<String, dynamic>? diff]) {
    final patch = ConversationPatch();
    if (diff != null) {
      diff.forEach((key, value) {
        try {
          final enumValue = Conversation$.values.firstWhere(
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

  static ConversationPatch fromPatch(Map<Conversation$, dynamic> patch) {
    final _patch = ConversationPatch();
    _patch._patch.addAll(patch);
    return _patch;
  }

  Map<Conversation$, dynamic> toPatch() => Map.from(_patch);

  Conversation applyTo(Conversation entity) {
    return entity.patchWithConversation(patchInput: this);
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

  static ConversationPatch fromJson(Map<String, dynamic> json) {
    return create(json);
  }

  ConversationPatch withId(String? value) {
    _patch[Conversation$.id] = value;
    return this;
  }

  ConversationPatch withWorkspaceId(String? value) {
    _patch[Conversation$.workspaceId] = value;
    return this;
  }

  ConversationPatch withTitle(String? value) {
    _patch[Conversation$.title] = value;
    return this;
  }

  ConversationPatch withMessages(List<Message>? value) {
    _patch[Conversation$.messages] = value;
    return this;
  }

  ConversationPatch withCreatedAt(DateTime? value) {
    _patch[Conversation$.createdAt] = value;
    return this;
  }

  ConversationPatch withUpdatedAt(DateTime? value) {
    _patch[Conversation$.updatedAt] = value;
    return this;
  }

  ConversationPatch withLastMessageAt(DateTime? value) {
    _patch[Conversation$.lastMessageAt] = value;
    return this;
  }

  ConversationPatch withMessageCount(int? value) {
    _patch[Conversation$.messageCount] = value;
    return this;
  }

  ConversationPatch withIsArchived(bool? value) {
    _patch[Conversation$.isArchived] = value;
    return this;
  }

  ConversationPatch withMetadata(Map<String, dynamic>? value) {
    _patch[Conversation$.metadata] = value;
    return this;
  }
}

/// Field descriptors for [Conversation] query construction
abstract final class ConversationFields {
  static String _$getid(Conversation e) => e.id;
  static const id = Field<Conversation, String>('id', _$getid);
  static String _$getworkspaceId(Conversation e) => e.workspaceId;
  static const workspaceId = Field<Conversation, String>(
    'workspaceId',
    _$getworkspaceId,
  );
  static String _$gettitle(Conversation e) => e.title;
  static const title = Field<Conversation, String>('title', _$gettitle);
  static List<Message> _$getmessages(Conversation e) => e.messages;
  static const messages = Field<Conversation, List<Message>>(
    'messages',
    _$getmessages,
  );
  static DateTime _$getcreatedAt(Conversation e) => e.createdAt;
  static const createdAt = Field<Conversation, DateTime>(
    'createdAt',
    _$getcreatedAt,
  );
  static DateTime _$getupdatedAt(Conversation e) => e.updatedAt;
  static const updatedAt = Field<Conversation, DateTime>(
    'updatedAt',
    _$getupdatedAt,
  );
  static DateTime? _$getlastMessageAt(Conversation e) => e.lastMessageAt;
  static const lastMessageAt = Field<Conversation, DateTime?>(
    'lastMessageAt',
    _$getlastMessageAt,
  );
  static int _$getmessageCount(Conversation e) => e.messageCount;
  static const messageCount = Field<Conversation, int>(
    'messageCount',
    _$getmessageCount,
  );
  static bool _$getisArchived(Conversation e) => e.isArchived;
  static const isArchived = Field<Conversation, bool>(
    'isArchived',
    _$getisArchived,
  );
  static Map<String, dynamic>? _$getmetadata(Conversation e) => e.metadata;
  static const metadata = Field<Conversation, Map<String, dynamic>?>(
    'metadata',
    _$getmetadata,
  );
}

extension ConversationCompareE on Conversation {
  Map<String, dynamic> compareToConversation(Conversation other) {
    final Map<String, dynamic> diff = {};

    if (id != other.id) {
      diff['id'] = () => other.id;
    }
    if (workspaceId != other.workspaceId) {
      diff['workspaceId'] = () => other.workspaceId;
    }
    if (title != other.title) {
      diff['title'] = () => other.title;
    }
    if (messages != other.messages) {
      diff['messages'] = () => other.messages;
    }
    if (createdAt != other.createdAt) {
      diff['createdAt'] = () => other.createdAt;
    }
    if (updatedAt != other.updatedAt) {
      diff['updatedAt'] = () => other.updatedAt;
    }
    if (lastMessageAt != other.lastMessageAt) {
      diff['lastMessageAt'] = () => other.lastMessageAt;
    }
    if (messageCount != other.messageCount) {
      diff['messageCount'] = () => other.messageCount;
    }
    if (isArchived != other.isArchived) {
      diff['isArchived'] = () => other.isArchived;
    }
    if (metadata != other.metadata) {
      diff['metadata'] = () => other.metadata;
    }
    return diff;
  }
}
