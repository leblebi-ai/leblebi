// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'api_endpoints.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ApiEndpoints _$ApiEndpointsFromJson(Map<String, dynamic> json) => ApiEndpoints(
  health: json['health'] as String,
  pair: json['pair'] as String,
  webhook: json['webhook'] as String,
);

Map<String, dynamic> _$ApiEndpointsToJson(ApiEndpoints instance) =>
    <String, dynamic>{
      'health': instance.health,
      'pair': instance.pair,
      'webhook': instance.webhook,
    };
