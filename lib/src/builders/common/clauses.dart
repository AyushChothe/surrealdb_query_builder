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

/// Handles `TIMEOUT`
base mixin TimeoutClause on QueryBuilder {
  AfterTimeout timeout({
    required String duration,
  }) {
    _query.addAll(['TIMEOUT', duration]);
    return AfterTimeout(_query);
  }
}

final class AfterTimeout extends QueryBuilder with Build, ParallelClause {
  const AfterTimeout(super._query);
}

/// Handles `PARALLEL`
base mixin ParallelClause on QueryBuilder {
  End parallel() {
    _query.add('PARALLEL');
    return End(_query);
  }
}
