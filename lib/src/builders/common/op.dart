part of '../../../surrealdb_query_builder.dart';

/// Handles Operators `=`, `!=`,
/// `==`, `?=`, `*=`, `~`, `!~`, `?~`, `*~`,
/// `>`, `<`, `>=`, `<=`
final class SurrealdbOpBuilder<T extends QueryBuilder> extends QueryBuilder {
  const SurrealdbOpBuilder(super._query);

  /// For external use only
  factory SurrealdbOpBuilder.raw() =>
      SurrealdbOpBuilder(List.empty(growable: true));

  /// Handles `=`
  SurrealdbLogicalOpBuilder<T> eq(
      {required String field, required String value}) {
    _query.addAll([field, '=', value]);
    return SurrealdbLogicalOpBuilder<T>(_query);
  }

  /// Handles `!=`
  SurrealdbLogicalOpBuilder<T> neq({
    required String field,
    required String value,
  }) {
    _query.addAll([field, '!=', value]);
    return SurrealdbLogicalOpBuilder<T>(_query);
  }

  /// Handles `==`
  SurrealdbLogicalOpBuilder<T> exact(
      {required String field, required String value}) {
    _query.addAll([field, '==', value]);
    return SurrealdbLogicalOpBuilder<T>(_query);
  }

  /// Handles `?=`
  SurrealdbLogicalOpBuilder<T> anyEq(
      {required String field, required String value}) {
    _query.addAll([field, '?=', value]);
    return SurrealdbLogicalOpBuilder<T>(_query);
  }

  /// Handles `*=`
  SurrealdbLogicalOpBuilder<T> allEq(
      {required String field, required String value}) {
    _query.addAll([field, '*=', value]);
    return SurrealdbLogicalOpBuilder<T>(_query);
  }

  /// Handles `~`
  SurrealdbLogicalOpBuilder<T> match(
      {required String field, required String value}) {
    _query.addAll([field, '~', value]);
    return SurrealdbLogicalOpBuilder<T>(_query);
  }

  /// Handles `!~`
  SurrealdbLogicalOpBuilder<T> notMatch(
      {required String field, required String value}) {
    _query.addAll([field, '!~', value]);
    return SurrealdbLogicalOpBuilder<T>(_query);
  }

  /// Handles `?~`
  SurrealdbLogicalOpBuilder<T> anyMatch(
      {required String field, required String value}) {
    _query.addAll([field, '?~', value]);
    return SurrealdbLogicalOpBuilder<T>(_query);
  }

  /// Handles `*~`
  SurrealdbLogicalOpBuilder<T> allMatch(
      {required String field, required String value}) {
    _query.addAll([field, '*~', value]);
    return SurrealdbLogicalOpBuilder<T>(_query);
  }

  /// Handles `>`
  SurrealdbLogicalOpBuilder<T> gt(
      {required String field, required String value}) {
    _query.addAll([field, '>', value]);
    return SurrealdbLogicalOpBuilder<T>(_query);
  }

  /// Handles `<`
  SurrealdbLogicalOpBuilder<T> lt(
      {required String field, required String value}) {
    _query.addAll([field, '<', value]);
    return SurrealdbLogicalOpBuilder<T>(_query);
  }

  /// Handles `>=`
  SurrealdbLogicalOpBuilder<T> gte(
      {required String field, required String value}) {
    _query.addAll([field, '>=', value]);
    return SurrealdbLogicalOpBuilder<T>(_query);
  }

  /// Handles `<=`
  SurrealdbLogicalOpBuilder<T> lte(
      {required String field, required String value}) {
    _query.addAll([field, '<=', value]);
    return SurrealdbLogicalOpBuilder<T>(_query);
  }

  /// Handles raw value
  SurrealdbLogicalOpBuilder<T> value({required String value}) {
    _query.add(value);
    return SurrealdbLogicalOpBuilder<T>(_query);
  }
}
