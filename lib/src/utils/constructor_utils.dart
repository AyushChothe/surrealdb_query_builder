part of '../../surrealdb_query_builder.dart';

T getInstance<T extends QueryBuilder>(List<String> query) {
  switch (T.toString()) {
    case 'AfterWhere':
      return AfterWhere(query) as T;
    case 'AfterFetch':
      return AfterFetch(query) as T;
    case 'AfterWhereForLiveSelect':
      return AfterWhereForLiveSelect(query) as T;
    case 'End':
      return End(query) as T;
  }
  throw UnimplementedError();
}
