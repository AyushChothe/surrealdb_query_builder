part of '../../../surrealdb_query_builder.dart';

/// Handles Logical Operators `&&`, `||`, `??`, `?:`
final class SurrealdbLogicalOpBuilder<T extends QueryBuilder>
    extends QueryBuilder with Build {
  SurrealdbLogicalOpBuilder(super._query);

  /// Handles `&&`
  SurrealdbOpBuilder<T> and() {
    _query.add('&&');
    return SurrealdbOpBuilder<T>(_query);
  }

  /// Handles `||`
  SurrealdbOpBuilder<T> or() {
    _query.add('||');
    return SurrealdbOpBuilder<T>(_query);
  }

  /// Handles `??`
  SurrealdbOpBuilder<T> nco() {
    _query.add('??');
    return SurrealdbOpBuilder<T>(_query);
  }

  /// Handles `?:`
  SurrealdbOpBuilder<T> tco() {
    _query.add('?:');
    return SurrealdbOpBuilder<T>(_query);
  }

  T next() => getInstance<T>(_query);
}
