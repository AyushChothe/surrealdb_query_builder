part of '../surrealdb_query_builder.dart';

/// Handles `SELECT`
final class SurrealdbQueryBuilder extends QueryBuilder {
  SurrealdbQueryBuilder() : super([]);

  static SurrealdbClauseBuilder select({
    required String thing,
    List<String> fields = const ['*'],
    List<String> omitfields = const [],
    bool only = false,
  }) {
    final omit = omitfields.joinWithTrim();
    return SurrealdbClauseBuilder([
      'SELECT',
      fields.joinWithTrim(),
      if (omit.isNotEmpty) 'OMIT',
      omitfields.joinWithTrim(),
      'FROM',
      if (only) 'ONLY',
      thing
    ]);
  }

  static SurrealdbClauseBuilder selectValue({
    required String thing,
    required String value,
    bool only = false,
  }) =>
      SurrealdbClauseBuilder(
          ['SELECT', 'VALUE', value, 'FROM', if (only) 'ONLY', thing]);

  static SurrealdbClauseBuilder create({required String thing}) =>
      SurrealdbClauseBuilder(['CREATE', thing]);
}
