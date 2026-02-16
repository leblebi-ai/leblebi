// dart format width=80
// ignore_for_file: UNNECESSARY_CAST
// ignore_for_file: type=lint

part of 'message.dart';

// **************************************************************************
// ZorphyGenerator
// **************************************************************************

@JsonSerializable(explicitToJson: true)
class Message {
  final String id;
  final String conversationId;
  final MessageSender sender;
  final String content;
  final DateTime timestamp;
  final MessageStatus? status;
  final List<ToolCall>? toolCalls;
  final List<Attachment>? attachments;
  final MessageMetadata? metadata;
  final String? replyToMessageId;
  final bool isEdited;
  final DateTime? editedAt;

  Message({
    required this.id,
    required this.conversationId,
    required this.sender,
    required this.content,
    required this.timestamp,
    this.status,
    this.toolCalls,
    this.attachments,
    this.metadata,
    this.replyToMessageId,
    required this.isEdited,
    this.editedAt,
  });

  Message copyWith({
    String? id,
    String? conversationId,
    MessageSender? sender,
    String? content,
    DateTime? timestamp,
    MessageStatus? status,
    List<ToolCall>? toolCalls,
    List<Attachment>? attachments,
    MessageMetadata? metadata,
    String? replyToMessageId,
    bool? isEdited,
    DateTime? editedAt,
  }) {
    return Message(
      id: id ?? this.id,
      conversationId: conversationId ?? this.conversationId,
      sender: sender ?? this.sender,
      content: content ?? this.content,
      timestamp: timestamp ?? this.timestamp,
      status: status ?? this.status,
      toolCalls: toolCalls ?? this.toolCalls,
      attachments: attachments ?? this.attachments,
      metadata: metadata ?? this.metadata,
      replyToMessageId: replyToMessageId ?? this.replyToMessageId,
      isEdited: isEdited ?? this.isEdited,
      editedAt: editedAt ?? this.editedAt,
    );
  }

  Message copyWithMessage({
    String? id,
    String? conversationId,
    MessageSender? sender,
    String? content,
    DateTime? timestamp,
    MessageStatus? status,
    List<ToolCall>? toolCalls,
    List<Attachment>? attachments,
    MessageMetadata? metadata,
    String? replyToMessageId,
    bool? isEdited,
    DateTime? editedAt,
  }) {
    return copyWith(
      id: id,
      conversationId: conversationId,
      sender: sender,
      content: content,
      timestamp: timestamp,
      status: status,
      toolCalls: toolCalls,
      attachments: attachments,
      metadata: metadata,
      replyToMessageId: replyToMessageId,
      isEdited: isEdited,
      editedAt: editedAt,
    );
  }

  Message patchWithMessage({MessagePatch? patchInput}) {
    final _patcher = patchInput ?? MessagePatch();
    final _patchMap = _patcher.toPatch();
    return Message(
      id: _patchMap.containsKey(Message$.id)
          ? (_patchMap[Message$.id] is Function)
                ? _patchMap[Message$.id](this.id)
                : _patchMap[Message$.id]
          : this.id,
      conversationId: _patchMap.containsKey(Message$.conversationId)
          ? (_patchMap[Message$.conversationId] is Function)
                ? _patchMap[Message$.conversationId](this.conversationId)
                : _patchMap[Message$.conversationId]
          : this.conversationId,
      sender: _patchMap.containsKey(Message$.sender)
          ? (_patchMap[Message$.sender] is Function)
                ? _patchMap[Message$.sender](this.sender)
                : _patchMap[Message$.sender]
          : this.sender,
      content: _patchMap.containsKey(Message$.content)
          ? (_patchMap[Message$.content] is Function)
                ? _patchMap[Message$.content](this.content)
                : _patchMap[Message$.content]
          : this.content,
      timestamp: _patchMap.containsKey(Message$.timestamp)
          ? (_patchMap[Message$.timestamp] is Function)
                ? _patchMap[Message$.timestamp](this.timestamp)
                : _patchMap[Message$.timestamp]
          : this.timestamp,
      status: _patchMap.containsKey(Message$.status)
          ? (_patchMap[Message$.status] is Function)
                ? _patchMap[Message$.status](this.status)
                : _patchMap[Message$.status]
          : this.status,
      toolCalls: _patchMap.containsKey(Message$.toolCalls)
          ? (_patchMap[Message$.toolCalls] is Function)
                ? _patchMap[Message$.toolCalls](this.toolCalls)
                : _patchMap[Message$.toolCalls]
          : this.toolCalls,
      attachments: _patchMap.containsKey(Message$.attachments)
          ? (_patchMap[Message$.attachments] is Function)
                ? _patchMap[Message$.attachments](this.attachments)
                : _patchMap[Message$.attachments]
          : this.attachments,
      metadata: _patchMap.containsKey(Message$.metadata)
          ? (_patchMap[Message$.metadata] is Function)
                ? _patchMap[Message$.metadata](this.metadata)
                : _patchMap[Message$.metadata]
          : this.metadata,
      replyToMessageId: _patchMap.containsKey(Message$.replyToMessageId)
          ? (_patchMap[Message$.replyToMessageId] is Function)
                ? _patchMap[Message$.replyToMessageId](this.replyToMessageId)
                : _patchMap[Message$.replyToMessageId]
          : this.replyToMessageId,
      isEdited: _patchMap.containsKey(Message$.isEdited)
          ? (_patchMap[Message$.isEdited] is Function)
                ? _patchMap[Message$.isEdited](this.isEdited)
                : _patchMap[Message$.isEdited]
          : this.isEdited,
      editedAt: _patchMap.containsKey(Message$.editedAt)
          ? (_patchMap[Message$.editedAt] is Function)
                ? _patchMap[Message$.editedAt](this.editedAt)
                : _patchMap[Message$.editedAt]
          : this.editedAt,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is Message &&
        id == other.id &&
        conversationId == other.conversationId &&
        sender == other.sender &&
        content == other.content &&
        timestamp == other.timestamp &&
        status == other.status &&
        toolCalls == other.toolCalls &&
        attachments == other.attachments &&
        metadata == other.metadata &&
        replyToMessageId == other.replyToMessageId &&
        isEdited == other.isEdited &&
        editedAt == other.editedAt;
  }

  @override
  int get hashCode {
    return Object.hash(
      this.id,
      this.conversationId,
      this.sender,
      this.content,
      this.timestamp,
      this.status,
      this.toolCalls,
      this.attachments,
      this.metadata,
      this.replyToMessageId,
      this.isEdited,
      this.editedAt,
    );
  }

  @override
  String toString() {
    return 'Message(' +
        'id: ${id}' +
        ', ' +
        'conversationId: ${conversationId}' +
        ', ' +
        'sender: ${sender}' +
        ', ' +
        'content: ${content}' +
        ', ' +
        'timestamp: ${timestamp}' +
        ', ' +
        'status: ${status}' +
        ', ' +
        'toolCalls: ${toolCalls}' +
        ', ' +
        'attachments: ${attachments}' +
        ', ' +
        'metadata: ${metadata}' +
        ', ' +
        'replyToMessageId: ${replyToMessageId}' +
        ', ' +
        'isEdited: ${isEdited}' +
        ', ' +
        'editedAt: ${editedAt})';
  }

  /// Creates a [Message] instance from JSON
  factory Message.fromJson(Map<String, dynamic> json) =>
      _$MessageFromJson(json);

  Map<String, dynamic> toJsonLean() {
    final Map<String, dynamic> data = _$MessageToJson(this);
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

extension MessagePropertyHelpers on Message {
  bool get isSenderUSER => sender == MessageSender.USER;
  bool get isSenderAI => sender == MessageSender.AI;
  bool get isSenderSYSTEM => sender == MessageSender.SYSTEM;
  bool get hasStatus => status != null;
  bool get noStatus => status == null;
  MessageStatus get statusRequired =>
      status ?? (throw StateError('status is required but was null'));
  bool get isStatusPENDING => status == MessageStatus.PENDING;
  bool get isStatusSENT => status == MessageStatus.SENT;
  bool get isStatusDELIVERED => status == MessageStatus.DELIVERED;
  bool get isStatusFAILED => status == MessageStatus.FAILED;
  List<ToolCall> get toolCallsRequired =>
      toolCalls ?? (throw StateError('toolCalls is required but was null'));
  bool get hasToolCalls => toolCalls?.isNotEmpty ?? false;
  bool get noToolCalls => toolCalls?.isEmpty ?? true;
  List<Attachment> get attachmentsRequired =>
      attachments ?? (throw StateError('attachments is required but was null'));
  bool get hasAttachments => attachments?.isNotEmpty ?? false;
  bool get noAttachments => attachments?.isEmpty ?? true;
  bool get hasMetadata => metadata != null;
  bool get noMetadata => metadata == null;
  MessageMetadata get metadataRequired =>
      metadata ?? (throw StateError('metadata is required but was null'));
  bool get hasReplyToMessageId => replyToMessageId != null;
  bool get noReplyToMessageId => replyToMessageId == null;
  String get replyToMessageIdRequired =>
      replyToMessageId ??
      (throw StateError('replyToMessageId is required but was null'));
  bool get hasEditedAt => editedAt != null;
  bool get noEditedAt => editedAt == null;
  DateTime get editedAtRequired =>
      editedAt ?? (throw StateError('editedAt is required but was null'));
}

extension MessageSerialization on Message {
  Map<String, dynamic> toJson() => _$MessageToJson(this);
  Map<String, dynamic> toJsonLean() {
    final Map<String, dynamic> data = _$MessageToJson(this);
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

enum Message$ {
  id,
  conversationId,
  sender,
  content,
  timestamp,
  status,
  toolCalls,
  attachments,
  metadata,
  replyToMessageId,
  isEdited,
  editedAt,
}

class MessagePatch implements Patch<Message> {
  final Map<Message$, dynamic> _patch = {};

  static MessagePatch create([Map<String, dynamic>? diff]) {
    final patch = MessagePatch();
    if (diff != null) {
      diff.forEach((key, value) {
        try {
          final enumValue = Message$.values.firstWhere((e) => e.name == key);
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

  static MessagePatch fromPatch(Map<Message$, dynamic> patch) {
    final _patch = MessagePatch();
    _patch._patch.addAll(patch);
    return _patch;
  }

  Map<Message$, dynamic> toPatch() => Map.from(_patch);

  Message applyTo(Message entity) {
    return entity.patchWithMessage(patchInput: this);
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

  static MessagePatch fromJson(Map<String, dynamic> json) {
    return create(json);
  }

  MessagePatch withId(String? value) {
    _patch[Message$.id] = value;
    return this;
  }

  MessagePatch withConversationId(String? value) {
    _patch[Message$.conversationId] = value;
    return this;
  }

  MessagePatch withSender(MessageSender? value) {
    _patch[Message$.sender] = value;
    return this;
  }

  MessagePatch withContent(String? value) {
    _patch[Message$.content] = value;
    return this;
  }

  MessagePatch withTimestamp(DateTime? value) {
    _patch[Message$.timestamp] = value;
    return this;
  }

  MessagePatch withStatus(MessageStatus? value) {
    _patch[Message$.status] = value;
    return this;
  }

  MessagePatch withToolCalls(List<ToolCall>? value) {
    _patch[Message$.toolCalls] = value;
    return this;
  }

  MessagePatch withAttachments(List<Attachment>? value) {
    _patch[Message$.attachments] = value;
    return this;
  }

  MessagePatch updateAttachmentsAt(
    int index,
    AttachmentPatch Function(AttachmentPatch) patch,
  ) {
    _patch[Message$.attachments] = (List<dynamic> list) {
      var updatedList = List.from(list);
      if (index >= 0 && index < updatedList.length) {
        updatedList[index] = patch(updatedList[index] as AttachmentPatch);
      }
      return updatedList;
    };
    return this;
  }

  MessagePatch withMetadata(MessageMetadata? value) {
    _patch[Message$.metadata] = value;
    return this;
  }

  MessagePatch withReplyToMessageId(String? value) {
    _patch[Message$.replyToMessageId] = value;
    return this;
  }

  MessagePatch withIsEdited(bool? value) {
    _patch[Message$.isEdited] = value;
    return this;
  }

  MessagePatch withEditedAt(DateTime? value) {
    _patch[Message$.editedAt] = value;
    return this;
  }
}

/// Field descriptors for [Message] query construction
abstract final class MessageFields {
  static String _$getid(Message e) => e.id;
  static const id = Field<Message, String>('id', _$getid);
  static String _$getconversationId(Message e) => e.conversationId;
  static const conversationId = Field<Message, String>(
    'conversationId',
    _$getconversationId,
  );
  static MessageSender _$getsender(Message e) => e.sender;
  static const sender = Field<Message, MessageSender>('sender', _$getsender);
  static String _$getcontent(Message e) => e.content;
  static const content = Field<Message, String>('content', _$getcontent);
  static DateTime _$gettimestamp(Message e) => e.timestamp;
  static const timestamp = Field<Message, DateTime>(
    'timestamp',
    _$gettimestamp,
  );
  static MessageStatus? _$getstatus(Message e) => e.status;
  static const status = Field<Message, MessageStatus?>('status', _$getstatus);
  static List<ToolCall>? _$gettoolCalls(Message e) => e.toolCalls;
  static const toolCalls = Field<Message, List<ToolCall>?>(
    'toolCalls',
    _$gettoolCalls,
  );
  static List<Attachment>? _$getattachments(Message e) => e.attachments;
  static const attachments = Field<Message, List<Attachment>?>(
    'attachments',
    _$getattachments,
  );
  static MessageMetadata? _$getmetadata(Message e) => e.metadata;
  static const metadata = Field<Message, MessageMetadata?>(
    'metadata',
    _$getmetadata,
  );
  static String? _$getreplyToMessageId(Message e) => e.replyToMessageId;
  static const replyToMessageId = Field<Message, String?>(
    'replyToMessageId',
    _$getreplyToMessageId,
  );
  static bool _$getisEdited(Message e) => e.isEdited;
  static const isEdited = Field<Message, bool>('isEdited', _$getisEdited);
  static DateTime? _$geteditedAt(Message e) => e.editedAt;
  static const editedAt = Field<Message, DateTime?>('editedAt', _$geteditedAt);
}

extension MessageCompareE on Message {
  Map<String, dynamic> compareToMessage(Message other) {
    final Map<String, dynamic> diff = {};

    if (id != other.id) {
      diff['id'] = () => other.id;
    }
    if (conversationId != other.conversationId) {
      diff['conversationId'] = () => other.conversationId;
    }
    if (sender != other.sender) {
      diff['sender'] = () => other.sender;
    }
    if (content != other.content) {
      diff['content'] = () => other.content;
    }
    if (timestamp != other.timestamp) {
      diff['timestamp'] = () => other.timestamp;
    }
    if (status != other.status) {
      diff['status'] = () => other.status;
    }
    if (toolCalls != other.toolCalls) {
      diff['toolCalls'] = () => other.toolCalls;
    }
    if (attachments != other.attachments) {
      diff['attachments'] = () => other.attachments;
    }
    if (metadata != other.metadata) {
      diff['metadata'] = () => other.metadata;
    }
    if (replyToMessageId != other.replyToMessageId) {
      diff['replyToMessageId'] = () => other.replyToMessageId;
    }
    if (isEdited != other.isEdited) {
      diff['isEdited'] = () => other.isEdited;
    }
    if (editedAt != other.editedAt) {
      diff['editedAt'] = () => other.editedAt;
    }
    return diff;
  }
}
