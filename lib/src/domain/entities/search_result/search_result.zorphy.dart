// dart format width=80
// ignore_for_file: UNNECESSARY_CAST
// ignore_for_file: type=lint

part of 'search_result.dart';

// **************************************************************************
// ZorphyGenerator
// **************************************************************************

@JsonSerializable(explicitToJson: true)
class SearchResult {
  final Message message;
  final String workspaceName;
  final String conversationTitle;
  final double relevanceScore;
  final SearchMatchType matchType;
  final String? highlightedSnippet;

  SearchResult({
    required this.message,
    required this.workspaceName,
    required this.conversationTitle,
    required this.relevanceScore,
    required this.matchType,
    this.highlightedSnippet,
  });

  SearchResult copyWith({
    Message? message,
    String? workspaceName,
    String? conversationTitle,
    double? relevanceScore,
    SearchMatchType? matchType,
    String? highlightedSnippet,
  }) {
    return SearchResult(
      message: message ?? this.message,
      workspaceName: workspaceName ?? this.workspaceName,
      conversationTitle: conversationTitle ?? this.conversationTitle,
      relevanceScore: relevanceScore ?? this.relevanceScore,
      matchType: matchType ?? this.matchType,
      highlightedSnippet: highlightedSnippet ?? this.highlightedSnippet,
    );
  }

  SearchResult copyWithSearchResult({
    Message? message,
    String? workspaceName,
    String? conversationTitle,
    double? relevanceScore,
    SearchMatchType? matchType,
    String? highlightedSnippet,
  }) {
    return copyWith(
      message: message,
      workspaceName: workspaceName,
      conversationTitle: conversationTitle,
      relevanceScore: relevanceScore,
      matchType: matchType,
      highlightedSnippet: highlightedSnippet,
    );
  }

  SearchResult patchWithSearchResult({SearchResultPatch? patchInput}) {
    final _patcher = patchInput ?? SearchResultPatch();
    final _patchMap = _patcher.toPatch();
    return SearchResult(
      message: _patchMap.containsKey(SearchResult$.message)
          ? (_patchMap[SearchResult$.message] is Function)
                ? _patchMap[SearchResult$.message](this.message)
                : _patchMap[SearchResult$.message]
          : this.message,
      workspaceName: _patchMap.containsKey(SearchResult$.workspaceName)
          ? (_patchMap[SearchResult$.workspaceName] is Function)
                ? _patchMap[SearchResult$.workspaceName](this.workspaceName)
                : _patchMap[SearchResult$.workspaceName]
          : this.workspaceName,
      conversationTitle: _patchMap.containsKey(SearchResult$.conversationTitle)
          ? (_patchMap[SearchResult$.conversationTitle] is Function)
                ? _patchMap[SearchResult$.conversationTitle](
                    this.conversationTitle,
                  )
                : _patchMap[SearchResult$.conversationTitle]
          : this.conversationTitle,
      relevanceScore: _patchMap.containsKey(SearchResult$.relevanceScore)
          ? (_patchMap[SearchResult$.relevanceScore] is Function)
                ? _patchMap[SearchResult$.relevanceScore](this.relevanceScore)
                : _patchMap[SearchResult$.relevanceScore]
          : this.relevanceScore,
      matchType: _patchMap.containsKey(SearchResult$.matchType)
          ? (_patchMap[SearchResult$.matchType] is Function)
                ? _patchMap[SearchResult$.matchType](this.matchType)
                : _patchMap[SearchResult$.matchType]
          : this.matchType,
      highlightedSnippet:
          _patchMap.containsKey(SearchResult$.highlightedSnippet)
          ? (_patchMap[SearchResult$.highlightedSnippet] is Function)
                ? _patchMap[SearchResult$.highlightedSnippet](
                    this.highlightedSnippet,
                  )
                : _patchMap[SearchResult$.highlightedSnippet]
          : this.highlightedSnippet,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is SearchResult &&
        message == other.message &&
        workspaceName == other.workspaceName &&
        conversationTitle == other.conversationTitle &&
        relevanceScore == other.relevanceScore &&
        matchType == other.matchType &&
        highlightedSnippet == other.highlightedSnippet;
  }

  @override
  int get hashCode {
    return Object.hash(
      this.message,
      this.workspaceName,
      this.conversationTitle,
      this.relevanceScore,
      this.matchType,
      this.highlightedSnippet,
    );
  }

  @override
  String toString() {
    return 'SearchResult(' +
        'message: ${message}' +
        ', ' +
        'workspaceName: ${workspaceName}' +
        ', ' +
        'conversationTitle: ${conversationTitle}' +
        ', ' +
        'relevanceScore: ${relevanceScore}' +
        ', ' +
        'matchType: ${matchType}' +
        ', ' +
        'highlightedSnippet: ${highlightedSnippet})';
  }

  /// Creates a [SearchResult] instance from JSON
  factory SearchResult.fromJson(Map<String, dynamic> json) =>
      _$SearchResultFromJson(json);

  Map<String, dynamic> toJsonLean() {
    final Map<String, dynamic> data = _$SearchResultToJson(this);
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

extension SearchResultPropertyHelpers on SearchResult {
  bool get isMatchTypeKEYWORD => matchType == SearchMatchType.KEYWORD;
  bool get isMatchTypeSEMANTIC => matchType == SearchMatchType.SEMANTIC;
  bool get isMatchTypeHYBRID => matchType == SearchMatchType.HYBRID;
  bool get hasHighlightedSnippet => highlightedSnippet != null;
  bool get noHighlightedSnippet => highlightedSnippet == null;
  String get highlightedSnippetRequired =>
      highlightedSnippet ??
      (throw StateError('highlightedSnippet is required but was null'));
}

extension SearchResultSerialization on SearchResult {
  Map<String, dynamic> toJson() => _$SearchResultToJson(this);
  Map<String, dynamic> toJsonLean() {
    final Map<String, dynamic> data = _$SearchResultToJson(this);
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

enum SearchResult$ {
  message,
  workspaceName,
  conversationTitle,
  relevanceScore,
  matchType,
  highlightedSnippet,
}

class SearchResultPatch implements Patch<SearchResult> {
  final Map<SearchResult$, dynamic> _patch = {};

  static SearchResultPatch create([Map<String, dynamic>? diff]) {
    final patch = SearchResultPatch();
    if (diff != null) {
      diff.forEach((key, value) {
        try {
          final enumValue = SearchResult$.values.firstWhere(
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

  static SearchResultPatch fromPatch(Map<SearchResult$, dynamic> patch) {
    final _patch = SearchResultPatch();
    _patch._patch.addAll(patch);
    return _patch;
  }

  Map<SearchResult$, dynamic> toPatch() => Map.from(_patch);

  SearchResult applyTo(SearchResult entity) {
    return entity.patchWithSearchResult(patchInput: this);
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

  static SearchResultPatch fromJson(Map<String, dynamic> json) {
    return create(json);
  }

  SearchResultPatch withMessage(Message? value) {
    _patch[SearchResult$.message] = value;
    return this;
  }

  SearchResultPatch withMessagePatch(MessagePatch patch) {
    _patch[SearchResult$.message] = patch;
    return this;
  }

  SearchResultPatch withMessagePatchFunc(
    MessagePatch Function(MessagePatch) patch,
  ) {
    _patch[SearchResult$.message] = (dynamic current) {
      var currentPatch = MessagePatch();
      if (current != null) {
        currentPatch = current as MessagePatch;
      }
      return patch(currentPatch);
    };
    return this;
  }

  SearchResultPatch withWorkspaceName(String? value) {
    _patch[SearchResult$.workspaceName] = value;
    return this;
  }

  SearchResultPatch withConversationTitle(String? value) {
    _patch[SearchResult$.conversationTitle] = value;
    return this;
  }

  SearchResultPatch withRelevanceScore(double? value) {
    _patch[SearchResult$.relevanceScore] = value;
    return this;
  }

  SearchResultPatch withMatchType(SearchMatchType? value) {
    _patch[SearchResult$.matchType] = value;
    return this;
  }

  SearchResultPatch withHighlightedSnippet(String? value) {
    _patch[SearchResult$.highlightedSnippet] = value;
    return this;
  }
}

/// Field descriptors for [SearchResult] query construction
abstract final class SearchResultFields {
  static Message _$getmessage(SearchResult e) => e.message;
  static const message = Field<SearchResult, Message>('message', _$getmessage);
  static String _$getworkspaceName(SearchResult e) => e.workspaceName;
  static const workspaceName = Field<SearchResult, String>(
    'workspaceName',
    _$getworkspaceName,
  );
  static String _$getconversationTitle(SearchResult e) => e.conversationTitle;
  static const conversationTitle = Field<SearchResult, String>(
    'conversationTitle',
    _$getconversationTitle,
  );
  static double _$getrelevanceScore(SearchResult e) => e.relevanceScore;
  static const relevanceScore = Field<SearchResult, double>(
    'relevanceScore',
    _$getrelevanceScore,
  );
  static SearchMatchType _$getmatchType(SearchResult e) => e.matchType;
  static const matchType = Field<SearchResult, SearchMatchType>(
    'matchType',
    _$getmatchType,
  );
  static String? _$gethighlightedSnippet(SearchResult e) =>
      e.highlightedSnippet;
  static const highlightedSnippet = Field<SearchResult, String?>(
    'highlightedSnippet',
    _$gethighlightedSnippet,
  );
}

extension SearchResultCompareE on SearchResult {
  Map<String, dynamic> compareToSearchResult(SearchResult other) {
    final Map<String, dynamic> diff = {};

    if (message != other.message) {
      diff['message'] = () => other.message;
    }
    if (workspaceName != other.workspaceName) {
      diff['workspaceName'] = () => other.workspaceName;
    }
    if (conversationTitle != other.conversationTitle) {
      diff['conversationTitle'] = () => other.conversationTitle;
    }
    if (relevanceScore != other.relevanceScore) {
      diff['relevanceScore'] = () => other.relevanceScore;
    }
    if (matchType != other.matchType) {
      diff['matchType'] = () => other.matchType;
    }
    if (highlightedSnippet != other.highlightedSnippet) {
      diff['highlightedSnippet'] = () => other.highlightedSnippet;
    }
    return diff;
  }
}
