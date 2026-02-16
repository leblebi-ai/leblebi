// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'attachment.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Attachment _$AttachmentFromJson(Map<String, dynamic> json) => Attachment(
  id: json['id'] as String,
  filename: json['filename'] as String,
  mimeType: json['mimeType'] as String,
  sizeBytes: (json['sizeBytes'] as num).toInt(),
  localPath: json['localPath'] as String?,
  url: json['url'] as String?,
);

Map<String, dynamic> _$AttachmentToJson(Attachment instance) =>
    <String, dynamic>{
      'id': instance.id,
      'filename': instance.filename,
      'mimeType': instance.mimeType,
      'sizeBytes': instance.sizeBytes,
      'localPath': instance.localPath,
      'url': instance.url,
    };
