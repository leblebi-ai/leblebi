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
  final MessageStatus status;
  final DateTime timestamp;
  final int? retryCount;
  final String? errorMessage;
  final MessageMetadata? metadata;

  Message({
    required this.id,
    required this.conversationId,
    required this.sender,
    required this.content,
    required this.status,
    required this.timestamp,
    this.retryCount,
    this.errorMessage,
    this.metadata,
  });

  Message copyWith({
    String? id,
    String? conversationId,
    MessageSender? sender,
    String? content,
    MessageStatus? status,
    DateTime? timestamp,
    int? retryCount,
    String? errorMessage,
    MessageMetadata? metadata,
  }) {
    return Message(
      id: id ?? this.id,
      conversationId: conversationId ?? this.conversationId,
      sender: sender ?? this.sender,
      content: content ?? this.content,
      status: status ?? this.status,
      timestamp: timestamp ?? this.timestamp,
      retryCount: retryCount ?? this.retryCount,
      errorMessage: errorMessage ?? this.errorMessage,
      metadata: metadata ?? this.metadata,
    );
  }

  Message copyWithMessage({
    String? id,
    String? conversationId,
    MessageSender? sender,
    String? content,
    MessageStatus? status,
    DateTime? timestamp,
    int? retryCount,
    String? errorMessage,
    MessageMetadata? metadata,
  }) {
    return copyWith(
      id: id,
      conversationId: conversationId,
      sender: sender,
      content: content,
      status: status,
      timestamp: timestamp,
      retryCount: retryCount,
      errorMessage: errorMessage,
      metadata: metadata,
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
      status: _patchMap.containsKey(Message$.status)
          ? (_patchMap[Message$.status] is Function)
                ? _patchMap[Message$.status](this.status)
                : _patchMap[Message$.status]
          : this.status,
      timestamp: _patchMap.containsKey(Message$.timestamp)
          ? (_patchMap[Message$.timestamp] is Function)
                ? _patchMap[Message$.timestamp](this.timestamp)
                : _patchMap[Message$.timestamp]
          : this.timestamp,
      retryCount: _patchMap.containsKey(Message$.retryCount)
          ? (_patchMap[Message$.retryCount] is Function)
                ? _patchMap[Message$.retryCount](this.retryCount)
                : _patchMap[Message$.retryCount]
          : this.retryCount,
      errorMessage: _patchMap.containsKey(Message$.errorMessage)
          ? (_patchMap[Message$.errorMessage] is Function)
                ? _patchMap[Message$.errorMessage](this.errorMessage)
                : _patchMap[Message$.errorMessage]
          : this.errorMessage,
      metadata: _patchMap.containsKey(Message$.metadata)
          ? (_patchMap[Message$.metadata] is Function)
                ? _patchMap[Message$.metadata](this.metadata)
                : _patchMap[Message$.metadata]
          : this.metadata,
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
        status == other.status &&
        timestamp == other.timestamp &&
        retryCount == other.retryCount &&
        errorMessage == other.errorMessage &&
        metadata == other.metadata;
  }

  @override
  int get hashCode {
    return Object.hash(
      this.id,
      this.conversationId,
      this.sender,
      this.content,
      this.status,
      this.timestamp,
      this.retryCount,
      this.errorMessage,
      this.metadata,
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
        'status: ${status}' +
        ', ' +
        'timestamp: ${timestamp}' +
        ', ' +
        'retryCount: ${retryCount}' +
        ', ' +
        'errorMessage: ${errorMessage}' +
        ', ' +
        'metadata: ${metadata})';
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
  bool get isSenderUser => sender == MessageSender.user;
  bool get isSenderAi => sender == MessageSender.ai;
  bool get isSenderSystem => sender == MessageSender.system;
  bool get isStatusPending => status == MessageStatus.pending;
  bool get isStatusSent => status == MessageStatus.sent;
  bool get isStatusDelivered => status == MessageStatus.delivered;
  bool get isStatusFailed => status == MessageStatus.failed;
  bool get hasRetryCount => retryCount != null;
  bool get noRetryCount => retryCount == null;
  int get retryCountRequired =>
      retryCount ?? (throw StateError('retryCount is required but was null'));
  bool get hasErrorMessage => errorMessage != null;
  bool get noErrorMessage => errorMessage == null;
  String get errorMessageRequired =>
      errorMessage ??
      (throw StateError('errorMessage is required but was null'));
  bool get hasMetadata => metadata != null;
  bool get noMetadata => metadata == null;
  MessageMetadata get metadataRequired =>
      metadata ?? (throw StateError('metadata is required but was null'));
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
  status,
  timestamp,
  retryCount,
  errorMessage,
  metadata,
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

  MessagePatch withStatus(MessageStatus? value) {
    _patch[Message$.status] = value;
    return this;
  }

  MessagePatch withTimestamp(DateTime? value) {
    _patch[Message$.timestamp] = value;
    return this;
  }

  MessagePatch withRetryCount(int? value) {
    _patch[Message$.retryCount] = value;
    return this;
  }

  MessagePatch withErrorMessage(String? value) {
    _patch[Message$.errorMessage] = value;
    return this;
  }

  MessagePatch withMetadata(MessageMetadata? value) {
    _patch[Message$.metadata] = value;
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
  static MessageStatus _$getstatus(Message e) => e.status;
  static const status = Field<Message, MessageStatus>('status', _$getstatus);
  static DateTime _$gettimestamp(Message e) => e.timestamp;
  static const timestamp = Field<Message, DateTime>(
    'timestamp',
    _$gettimestamp,
  );
  static int? _$getretryCount(Message e) => e.retryCount;
  static const retryCount = Field<Message, int?>('retryCount', _$getretryCount);
  static String? _$geterrorMessage(Message e) => e.errorMessage;
  static const errorMessage = Field<Message, String?>(
    'errorMessage',
    _$geterrorMessage,
  );
  static MessageMetadata? _$getmetadata(Message e) => e.metadata;
  static const metadata = Field<Message, MessageMetadata?>(
    'metadata',
    _$getmetadata,
  );
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
    if (status != other.status) {
      diff['status'] = () => other.status;
    }
    if (timestamp != other.timestamp) {
      diff['timestamp'] = () => other.timestamp;
    }
    if (retryCount != other.retryCount) {
      diff['retryCount'] = () => other.retryCount;
    }
    if (errorMessage != other.errorMessage) {
      diff['errorMessage'] = () => other.errorMessage;
    }
    if (metadata != other.metadata) {
      diff['metadata'] = () => other.metadata;
    }
    return diff;
  }
}
