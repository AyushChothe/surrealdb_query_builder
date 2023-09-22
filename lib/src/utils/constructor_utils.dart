part of '../../surrealdb_query_builder.dart';

/// Type gymnastics for QueryBuilder
T getInstance<T extends QueryBuilder>(List<String> query) => switch (T) {
      AfterWhere => AfterWhere(query),
      AfterFetch => AfterFetch(query),
      AfterWhereForLiveSelect => AfterWhereForLiveSelect(query),
      End => End(query),
      _ => throw UnimplementedError()
    } as T;
