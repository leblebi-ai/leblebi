// dart format width=80
// ignore_for_file: UNNECESSARY_CAST
// ignore_for_file: type=lint

part of 'attachment.dart';

// **************************************************************************
// ZorphyGenerator
// **************************************************************************

@JsonSerializable(explicitToJson: true)
class Attachment {
  final String id;
  final String filename;
  final String mimeType;
  final int sizeBytes;
  final String? localPath;
  final String? url;

  Attachment({
    required this.id,
    required this.filename,
    required this.mimeType,
    required this.sizeBytes,
    this.localPath,
    this.url,
  });

  Attachment copyWith({
    String? id,
    String? filename,
    String? mimeType,
    int? sizeBytes,
    String? localPath,
    String? url,
  }) {
    return Attachment(
      id: id ?? this.id,
      filename: filename ?? this.filename,
      mimeType: mimeType ?? this.mimeType,
      sizeBytes: sizeBytes ?? this.sizeBytes,
      localPath: localPath ?? this.localPath,
      url: url ?? this.url,
    );
  }

  Attachment copyWithAttachment({
    String? id,
    String? filename,
    String? mimeType,
    int? sizeBytes,
    String? localPath,
    String? url,
  }) {
    return copyWith(
      id: id,
      filename: filename,
      mimeType: mimeType,
      sizeBytes: sizeBytes,
      localPath: localPath,
      url: url,
    );
  }

  Attachment patchWithAttachment({AttachmentPatch? patchInput}) {
    final _patcher = patchInput ?? AttachmentPatch();
    final _patchMap = _patcher.toPatch();
    return Attachment(
      id: _patchMap.containsKey(Attachment$.id)
          ? (_patchMap[Attachment$.id] is Function)
                ? _patchMap[Attachment$.id](this.id)
                : _patchMap[Attachment$.id]
          : this.id,
      filename: _patchMap.containsKey(Attachment$.filename)
          ? (_patchMap[Attachment$.filename] is Function)
                ? _patchMap[Attachment$.filename](this.filename)
                : _patchMap[Attachment$.filename]
          : this.filename,
      mimeType: _patchMap.containsKey(Attachment$.mimeType)
          ? (_patchMap[Attachment$.mimeType] is Function)
                ? _patchMap[Attachment$.mimeType](this.mimeType)
                : _patchMap[Attachment$.mimeType]
          : this.mimeType,
      sizeBytes: _patchMap.containsKey(Attachment$.sizeBytes)
          ? (_patchMap[Attachment$.sizeBytes] is Function)
                ? _patchMap[Attachment$.sizeBytes](this.sizeBytes)
                : _patchMap[Attachment$.sizeBytes]
          : this.sizeBytes,
      localPath: _patchMap.containsKey(Attachment$.localPath)
          ? (_patchMap[Attachment$.localPath] is Function)
                ? _patchMap[Attachment$.localPath](this.localPath)
                : _patchMap[Attachment$.localPath]
          : this.localPath,
      url: _patchMap.containsKey(Attachment$.url)
          ? (_patchMap[Attachment$.url] is Function)
                ? _patchMap[Attachment$.url](this.url)
                : _patchMap[Attachment$.url]
          : this.url,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is Attachment &&
        id == other.id &&
        filename == other.filename &&
        mimeType == other.mimeType &&
        sizeBytes == other.sizeBytes &&
        localPath == other.localPath &&
        url == other.url;
  }

  @override
  int get hashCode {
    return Object.hash(
      this.id,
      this.filename,
      this.mimeType,
      this.sizeBytes,
      this.localPath,
      this.url,
    );
  }

  @override
  String toString() {
    return 'Attachment(' +
        'id: ${id}' +
        ', ' +
        'filename: ${filename}' +
        ', ' +
        'mimeType: ${mimeType}' +
        ', ' +
        'sizeBytes: ${sizeBytes}' +
        ', ' +
        'localPath: ${localPath}' +
        ', ' +
        'url: ${url})';
  }

  /// Creates a [Attachment] instance from JSON
  factory Attachment.fromJson(Map<String, dynamic> json) =>
      _$AttachmentFromJson(json);

  Map<String, dynamic> toJsonLean() {
    final Map<String, dynamic> data = _$AttachmentToJson(this);
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

extension AttachmentPropertyHelpers on Attachment {
  bool get hasLocalPath => localPath != null;
  bool get noLocalPath => localPath == null;
  String get localPathRequired =>
      localPath ?? (throw StateError('localPath is required but was null'));
  bool get hasUrl => url != null;
  bool get noUrl => url == null;
  String get urlRequired =>
      url ?? (throw StateError('url is required but was null'));
}

extension AttachmentSerialization on Attachment {
  Map<String, dynamic> toJson() => _$AttachmentToJson(this);
  Map<String, dynamic> toJsonLean() {
    final Map<String, dynamic> data = _$AttachmentToJson(this);
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

enum Attachment$ { id, filename, mimeType, sizeBytes, localPath, url }

class AttachmentPatch implements Patch<Attachment> {
  final Map<Attachment$, dynamic> _patch = {};

  static AttachmentPatch create([Map<String, dynamic>? diff]) {
    final patch = AttachmentPatch();
    if (diff != null) {
      diff.forEach((key, value) {
        try {
          final enumValue = Attachment$.values.firstWhere((e) => e.name == key);
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

  static AttachmentPatch fromPatch(Map<Attachment$, dynamic> patch) {
    final _patch = AttachmentPatch();
    _patch._patch.addAll(patch);
    return _patch;
  }

  Map<Attachment$, dynamic> toPatch() => Map.from(_patch);

  Attachment applyTo(Attachment entity) {
    return entity.patchWithAttachment(patchInput: this);
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

  static AttachmentPatch fromJson(Map<String, dynamic> json) {
    return create(json);
  }

  AttachmentPatch withId(String? value) {
    _patch[Attachment$.id] = value;
    return this;
  }

  AttachmentPatch withFilename(String? value) {
    _patch[Attachment$.filename] = value;
    return this;
  }

  AttachmentPatch withMimeType(String? value) {
    _patch[Attachment$.mimeType] = value;
    return this;
  }

  AttachmentPatch withSizeBytes(int? value) {
    _patch[Attachment$.sizeBytes] = value;
    return this;
  }

  AttachmentPatch withLocalPath(String? value) {
    _patch[Attachment$.localPath] = value;
    return this;
  }

  AttachmentPatch withUrl(String? value) {
    _patch[Attachment$.url] = value;
    return this;
  }
}

/// Field descriptors for [Attachment] query construction
abstract final class AttachmentFields {
  static String _$getid(Attachment e) => e.id;
  static const id = Field<Attachment, String>('id', _$getid);
  static String _$getfilename(Attachment e) => e.filename;
  static const filename = Field<Attachment, String>('filename', _$getfilename);
  static String _$getmimeType(Attachment e) => e.mimeType;
  static const mimeType = Field<Attachment, String>('mimeType', _$getmimeType);
  static int _$getsizeBytes(Attachment e) => e.sizeBytes;
  static const sizeBytes = Field<Attachment, int>('sizeBytes', _$getsizeBytes);
  static String? _$getlocalPath(Attachment e) => e.localPath;
  static const localPath = Field<Attachment, String?>(
    'localPath',
    _$getlocalPath,
  );
  static String? _$geturl(Attachment e) => e.url;
  static const url = Field<Attachment, String?>('url', _$geturl);
}

extension AttachmentCompareE on Attachment {
  Map<String, dynamic> compareToAttachment(Attachment other) {
    final Map<String, dynamic> diff = {};

    if (id != other.id) {
      diff['id'] = () => other.id;
    }
    if (filename != other.filename) {
      diff['filename'] = () => other.filename;
    }
    if (mimeType != other.mimeType) {
      diff['mimeType'] = () => other.mimeType;
    }
    if (sizeBytes != other.sizeBytes) {
      diff['sizeBytes'] = () => other.sizeBytes;
    }
    if (localPath != other.localPath) {
      diff['localPath'] = () => other.localPath;
    }
    if (url != other.url) {
      diff['url'] = () => other.url;
    }
    return diff;
  }
}
