// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'search_result.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SearchResult _$SearchResultFromJson(Map<String, dynamic> json) => SearchResult(
  message: Message.fromJson(json['message'] as Map<String, dynamic>),
  workspaceName: json['workspaceName'] as String,
  conversationTitle: json['conversationTitle'] as String,
  relevanceScore: (json['relevanceScore'] as num).toDouble(),
  matchType: $enumDecode(_$SearchMatchTypeEnumMap, json['matchType']),
  highlightedSnippet: json['highlightedSnippet'] as String?,
);

Map<String, dynamic> _$SearchResultToJson(SearchResult instance) =>
    <String, dynamic>{
      'message': instance.message.toJson(),
      'workspaceName': instance.workspaceName,
      'conversationTitle': instance.conversationTitle,
      'relevanceScore': instance.relevanceScore,
      'matchType': _$SearchMatchTypeEnumMap[instance.matchType]!,
      'highlightedSnippet': instance.highlightedSnippet,
    };

const _$SearchMatchTypeEnumMap = {
  SearchMatchType.KEYWORD: 'KEYWORD',
  SearchMatchType.SEMANTIC: 'SEMANTIC',
  SearchMatchType.HYBRID: 'HYBRID',
};
