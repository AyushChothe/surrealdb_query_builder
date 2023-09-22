part of '../../../surrealdb_query_builder.dart';

/// Handles Operators `=`, `!=`
final class SurrealdbOpBuilder<T extends QueryBuilder> extends QueryBuilder {
  const SurrealdbOpBuilder(super._query);

  SurrealdbLogicalOpBuilder<T> eq(
      {required String field, required String value}) {
    _query.addAll([field, '=', value]);
    return SurrealdbLogicalOpBuilder<T>(_query);
  }

  SurrealdbLogicalOpBuilder<T> neq({
    required String field,
    required String value,
  }) {
    _query.addAll([field, '!=', value]);
    return SurrealdbLogicalOpBuilder<T>(_query);
  }

  SurrealdbLogicalOpBuilder<T> gt(
      {required String field, required String value}) {
    _query.addAll([field, '>', value]);
    return SurrealdbLogicalOpBuilder<T>(_query);
  }

  SurrealdbLogicalOpBuilder<T> lt(
      {required String field, required String value}) {
    _query.addAll([field, '<', value]);
    return SurrealdbLogicalOpBuilder<T>(_query);
  }

  SurrealdbLogicalOpBuilder<T> gte(
      {required String field, required String value}) {
    _query.addAll([field, '>=', value]);
    return SurrealdbLogicalOpBuilder<T>(_query);
  }

  SurrealdbLogicalOpBuilder<T> lte(
      {required String field, required String value}) {
    _query.addAll([field, '<=', value]);
    return SurrealdbLogicalOpBuilder<T>(_query);
  }
}
