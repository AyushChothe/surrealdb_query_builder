part of '../../../surrealdb_query_builder.dart';

/// Handles `WHERE`
base mixin WhereClause<T extends QueryBuilder> on QueryBuilder {
  SurrealdbOpBuilder<T> where() {
    _query.add('WHERE');
    return SurrealdbOpBuilder<T>(_query);
  }
}

/// Handles `FETCH`
base mixin FetchClause<T extends QueryBuilder> on QueryBuilder {
  T fetch({
    required List<String> fields,
  }) {
    _query.addAll(['FETCH', fields.joinWithTrim()]);
    return getInstance<T>(_query);
  }
}
