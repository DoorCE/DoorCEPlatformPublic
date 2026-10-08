import 'package:flutter/foundation.dart';

// Immutable class to avoid accidental changes to state in navigation
class QueryParams {
  final int page;
  final String? searchQuery;
  final Map<String, dynamic> filters; // unmodifiable view

  QueryParams.draft({
    required this.filters,
    this.page = 0,
    this.searchQuery
  });

  QueryParams({
    required Map<String, dynamic> filters,
    this.page = 0,
    this.searchQuery,
  }) : filters = _deepUnmodifiable(Map<String, dynamic>.from(filters));

  // make lists/maps inside filters unmodifiable, then freeze the map
  static Map<String, dynamic> _deepUnmodifiable(Map<String, dynamic> src) {
    final out = <String, dynamic>{};
    src.forEach((k, v) {
      if (v is List) {
        out[k] = List.unmodifiable(v);
      } else if (v is Map<String, dynamic>) {
        out[k] = Map.unmodifiable(v);
      } else {
        out[k] = v;
      }
    });
    return Map.unmodifiable(out);
  }

  QueryParams copyWith({int? page, String? searchQuery, Map<String, dynamic>? filters}) {
    return QueryParams(
      page: page ?? this.page,
      searchQuery: searchQuery ?? this.searchQuery,
      filters: filters != null ? Map<String, dynamic>.from(filters) : Map<String, dynamic>.from(this.filters),
    );
  }

  QueryParams copy() => copyWith();

  Map<String, dynamic> toJson() => {
    'page': page,
    'searchQuery': searchQuery,
    'filters': filters,
  };

  // don't throw inside ==; return false for other types
  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! QueryParams) return false;
    if (page != other.page) return false;
    if (searchQuery != other.searchQuery) return false;
    if (filters.length != other.filters.length) return false;
    for (final k in filters.keys) {
      if (!other.filters.containsKey(k)) return false;
      final a = filters[k];
      final b = other.filters[k];
      if (a is Iterable && b is Iterable) {
        if (!listEquals(a.toList(), b.toList())) return false;
      } else {
        if (a != b) return false;
      }
    }
    return true;
  }

  @override
  int get hashCode => Object.hash(page, searchQuery, Object.hashAll(filters.entries.map((e) => Object.hash(e.key, e.value))));
}