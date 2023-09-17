part of '../../surrealdb_query_builder.dart';

T getInstance<T extends QueryBuilder>(List<String> query) {
  if (T is AfterWhere) {
    return AfterWhere(query) as T;
  }
  throw UnimplementedError();
}
