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

  /// Handles `CONTAINS`
  SurrealdbLogicalOpBuilder<T> contains(
      {required String field, required String value}) {
    _query.addAll([field, 'CONTAINS', value]);
    return SurrealdbLogicalOpBuilder<T>(_query);
  }

  /// Handles `CONTAINSNOT`
  SurrealdbLogicalOpBuilder<T> containsNot(
      {required String field, required String value}) {
    _query.addAll([field, 'CONTAINSNOT', value]);
    return SurrealdbLogicalOpBuilder<T>(_query);
  }

  /// Handles `CONTAINSALL`
  SurrealdbLogicalOpBuilder<T> containsAll(
      {required List<String> lhs, required List<String> rhs}) {
    _query.addAll([
      '[',
      lhs.joinWithTrim(),
      ']',
      'CONTAINSALL',
      '[',
      rhs.joinWithTrim(),
      ']'
    ]);
    return SurrealdbLogicalOpBuilder<T>(_query);
  }

  /// Handles `CONTAINSANY`
  SurrealdbLogicalOpBuilder<T> containsAny(
      {required List<String> lhs, required List<String> rhs}) {
    _query.addAll([
      '[',
      lhs.joinWithTrim(),
      ']',
      'CONTAINSANY',
      '[',
      rhs.joinWithTrim(),
      ']'
    ]);
    return SurrealdbLogicalOpBuilder<T>(_query);
  }

  /// Handles `CONTAINSNONE`
  SurrealdbLogicalOpBuilder<T> containsNone(
      {required List<String> lhs, required List<String> rhs}) {
    _query.addAll([
      '[',
      lhs.joinWithTrim(),
      ']',
      'CONTAINSNONE',
      '[',
      rhs.joinWithTrim(),
      ']'
    ]);
    return SurrealdbLogicalOpBuilder<T>(_query);
  }

  /// Handles `INSIDE`
  SurrealdbLogicalOpBuilder<T> inside(
      {required String field, required List<String> value}) {
    _query.addAll([field, 'INSIDE', '[', value.joinWithTrim(), ']']);
    return SurrealdbLogicalOpBuilder<T>(_query);
  }

  /// Handles `NOTINSIDE`
  SurrealdbLogicalOpBuilder<T> notInside(
      {required String field, required List<String> value}) {
    _query.addAll([field, 'NOTINSIDE', '[', value.joinWithTrim(), ']']);
    return SurrealdbLogicalOpBuilder<T>(_query);
  }

  /// Handles `ALLINSIDE`
  SurrealdbLogicalOpBuilder<T> allInside(
      {required List<String> lhs, required List<String> rhs}) {
    _query.addAll([
      '[',
      lhs.joinWithTrim(),
      ']',
      'ALLINSIDE',
      '[',
      rhs.joinWithTrim(),
      ']'
    ]);
    return SurrealdbLogicalOpBuilder<T>(_query);
  }

  /// Handles `ANYINSIDE`
  SurrealdbLogicalOpBuilder<T> anyInside(
      {required List<String> lhs, required List<String> rhs}) {
    _query.addAll([
      '[',
      lhs.joinWithTrim(),
      ']',
      'ANYINSIDE',
      '[',
      rhs.joinWithTrim(),
      ']'
    ]);
    return SurrealdbLogicalOpBuilder<T>(_query);
  }

  /// Handles `NONEINSIDE`
  SurrealdbLogicalOpBuilder<T> noneInside(
      {required List<String> lhs, required List<String> rhs}) {
    _query.addAll([
      '[',
      lhs.joinWithTrim(),
      ']',
      'NONEINSIDE',
      '[',
      rhs.joinWithTrim(),
      ']'
    ]);
    return SurrealdbLogicalOpBuilder<T>(_query);
  }

  /// Handles `@@` or `@[ref]@`
  SurrealdbLogicalOpBuilder<T> matches(
      {required String field, required String value, String ref = ''}) {
    _query.addAll([field, '@$ref@', value]);
    return SurrealdbLogicalOpBuilder<T>(_query);
  }

  /// Handles raw value
  SurrealdbLogicalOpBuilder<T> value({required String value}) {
    _query.add(value);
    return SurrealdbLogicalOpBuilder<T>(_query);
  }
}
