part of '../../surrealdb_query_builder.dart';

T getInstance<T extends QueryBuilder>(List<String> query) {
  if (T.toString() == 'AfterWhere') {
    return AfterWhere(query) as T;
  }
  throw UnimplementedError();
}
