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
      {required SurrealDbType<dynamic> field,
      required SurrealDbType<dynamic> value}) {
    _query.addAll([field.toString(), '=', value.toString()]);
    return SurrealdbLogicalOpBuilder<T>(_query);
  }

  /// Handles `!=`
  SurrealdbLogicalOpBuilder<T> neq({
    required SurrealDbType<dynamic> field,
    required SurrealDbType<dynamic> value,
  }) {
    _query.addAll([field.toString(), '!=', value.toString()]);
    return SurrealdbLogicalOpBuilder<T>(_query);
  }

  /// Handles `==`
  SurrealdbLogicalOpBuilder<T> exact(
      {required SurrealDbType<dynamic> field,
      required SurrealDbType<dynamic> value}) {
    _query.addAll([field.toString(), '==', value.toString()]);
    return SurrealdbLogicalOpBuilder<T>(_query);
  }

  /// Handles `?=`
  SurrealdbLogicalOpBuilder<T> anyEq(
      {required SurrealDbType<dynamic> field,
      required SurrealDbType<dynamic> value}) {
    _query.addAll([field.toString(), '?=', value.toString()]);
    return SurrealdbLogicalOpBuilder<T>(_query);
  }

  /// Handles `*=`
  SurrealdbLogicalOpBuilder<T> allEq(
      {required SurrealDbType<dynamic> field,
      required SurrealDbType<dynamic> value}) {
    _query.addAll([field.toString(), '*=', value.toString()]);
    return SurrealdbLogicalOpBuilder<T>(_query);
  }

  /// Handles `~`
  SurrealdbLogicalOpBuilder<T> match(
      {required SurrealDbType<dynamic> field,
      required SurrealDbType<dynamic> value}) {
    _query.addAll([field.toString(), '~', value.toString()]);
    return SurrealdbLogicalOpBuilder<T>(_query);
  }

  /// Handles `!~`
  SurrealdbLogicalOpBuilder<T> notMatch(
      {required SurrealDbType<dynamic> field,
      required SurrealDbType<dynamic> value}) {
    _query.addAll([field.toString(), '!~', value.toString()]);
    return SurrealdbLogicalOpBuilder<T>(_query);
  }

  /// Handles `?~`
  SurrealdbLogicalOpBuilder<T> anyMatch(
      {required SurrealDbType<dynamic> field,
      required SurrealDbType<dynamic> value}) {
    _query.addAll([field.toString(), '?~', value.toString()]);
    return SurrealdbLogicalOpBuilder<T>(_query);
  }

  /// Handles `*~`
  SurrealdbLogicalOpBuilder<T> allMatch(
      {required SurrealDbType<dynamic> field,
      required SurrealDbType<dynamic> value}) {
    _query.addAll([field.toString(), '*~', value.toString()]);
    return SurrealdbLogicalOpBuilder<T>(_query);
  }

  /// Handles `>`
  SurrealdbLogicalOpBuilder<T> gt(
      {required SurrealDbType<dynamic> field,
      required SurrealDbType<dynamic> value}) {
    _query.addAll([field.toString(), '>', value.toString()]);
    return SurrealdbLogicalOpBuilder<T>(_query);
  }

  /// Handles `<`
  SurrealdbLogicalOpBuilder<T> lt(
      {required SurrealDbType<dynamic> field,
      required SurrealDbType<dynamic> value}) {
    _query.addAll([field.toString(), '<', value.toString()]);
    return SurrealdbLogicalOpBuilder<T>(_query);
  }

  /// Handles `>=`
  SurrealdbLogicalOpBuilder<T> gte(
      {required SurrealDbType<dynamic> field,
      required SurrealDbType<dynamic> value}) {
    _query.addAll([field.toString(), '>=', value.toString()]);
    return SurrealdbLogicalOpBuilder<T>(_query);
  }

  /// Handles `<=`
  SurrealdbLogicalOpBuilder<T> lte(
      {required SurrealDbType<dynamic> field,
      required SurrealDbType<dynamic> value}) {
    _query.addAll([field.toString(), '<=', value.toString()]);
    return SurrealdbLogicalOpBuilder<T>(_query);
  }

  /// Handles `CONTAINS`
  SurrealdbLogicalOpBuilder<T> contains(
      {required SurrealDbType<dynamic> field,
      required SurrealDbType<dynamic> value}) {
    _query.addAll([field.toString(), 'CONTAINS', value.toString()]);
    return SurrealdbLogicalOpBuilder<T>(_query);
  }

  /// Handles `CONTAINSNOT`
  SurrealdbLogicalOpBuilder<T> containsNot(
      {required SurrealDbType<dynamic> field,
      required SurrealDbType<dynamic> value}) {
    _query.addAll([field.toString(), 'CONTAINSNOT', value.toString()]);
    return SurrealdbLogicalOpBuilder<T>(_query);
  }

  /// Handles `CONTAINSALL`
  SurrealdbLogicalOpBuilder<T> containsAll(
      {required List<SurrealDbType<dynamic>> lhs,
      required List<SurrealDbType<dynamic>> rhs}) {
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
      {required List<SurrealDbType<dynamic>> lhs,
      required List<SurrealDbType<dynamic>> rhs}) {
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
      {required List<SurrealDbType<dynamic>> lhs,
      required List<SurrealDbType<dynamic>> rhs}) {
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
      {required SurrealDbType<dynamic> field,
      required List<SurrealDbType<dynamic>> value}) {
    _query.addAll([field.toString(), 'INSIDE', '[', value.joinWithTrim(), ']']);
    return SurrealdbLogicalOpBuilder<T>(_query);
  }

  /// Handles `NOTINSIDE`
  SurrealdbLogicalOpBuilder<T> notInside(
      {required SurrealDbType<dynamic> field,
      required List<SurrealDbType<dynamic>> value}) {
    _query.addAll(
        [field.toString(), 'NOTINSIDE', '[', value.joinWithTrim(), ']']);
    return SurrealdbLogicalOpBuilder<T>(_query);
  }

  /// Handles `ALLINSIDE`
  SurrealdbLogicalOpBuilder<T> allInside(
      {required List<SurrealDbType<dynamic>> lhs,
      required List<SurrealDbType<dynamic>> rhs}) {
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
      {required List<SurrealDbType<dynamic>> lhs,
      required List<SurrealDbType<dynamic>> rhs}) {
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
      {required List<SurrealDbType<dynamic>> lhs,
      required List<SurrealDbType<dynamic>> rhs}) {
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
      {required SurrealDbType<dynamic> field,
      required SurrealDbType<dynamic> value,
      SurrealDbType<dynamic> ref = const StringType('')}) {
    _query.addAll([field.toString(), '@$ref.toString()@', value.toString()]);
    return SurrealdbLogicalOpBuilder<T>(_query);
  }

  /// Handles raw value
  SurrealdbLogicalOpBuilder<T> value({required SurrealDbType<dynamic> value}) {
    _query.add(value.toString());
    return SurrealdbLogicalOpBuilder<T>(_query);
  }
}
