part of '../../../surrealdb_query_builder.dart';

/// Handles Logical Operators `AND`, `OR`
final class SurrealdbLogicalOpBuilder<T extends QueryBuilder>
    extends QueryBuilder with Build {
  SurrealdbLogicalOpBuilder(super._query);

  SurrealdbOpBuilder<T> and() {
    _query.add('AND');
    return SurrealdbOpBuilder<T>(_query);
  }

  SurrealdbOpBuilder<T> or() {
    _query.add('OR');
    return SurrealdbOpBuilder<T>(_query);
  }

  T next() => getInstance<T>(_query);
}
