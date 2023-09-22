part of '../surrealdb_query_builder.dart';

/// Handles all base queries
final class SurrealdbQueryBuilder extends QueryBuilder {
  SurrealdbQueryBuilder() : super([]);

  static SurrealdbClauseBuilderForSelect select({
    required String thing,
    List<String> fields = const ['*'],
    List<String> omitfields = const [],
    bool only = false,
  }) {
    final omit = omitfields.joinWithTrim();
    return SurrealdbClauseBuilderForSelect([
      'SELECT',
      fields.joinWithTrim(),
      if (omit.isNotEmpty) 'OMIT',
      omitfields.joinWithTrim(),
      'FROM',
      if (only) 'ONLY',
      thing
    ]);
  }

  static SurrealdbClauseBuilderForSelect selectValue({
    required String thing,
    required String value,
    bool only = false,
  }) =>
      SurrealdbClauseBuilderForSelect(
          ['SELECT', 'VALUE', value.trim(), 'FROM', if (only) 'ONLY', thing]);

  static SurrealdbClauseBuilderForLiveSelect liveSelect({
    required String thing,
    List<String> fields = const ['*'],
  }) {
    return SurrealdbClauseBuilderForLiveSelect(
        ['LIVE', 'SELECT', fields.joinWithTrim(), 'FROM', thing]);
  }

  static SurrealdbClauseBuilderForLiveSelect liveSelectValue({
    required String thing,
    required String value,
  }) {
    return SurrealdbClauseBuilderForLiveSelect(
        ['LIVE', 'SELECT', 'VALUE', value.trim(), 'FROM', thing]);
  }

  static SurrealdbClauseBuilderForLiveSelect liveSelectDiff(
      {required String thing}) {
    return SurrealdbClauseBuilderForLiveSelect(
        ['LIVE', 'SELECT', 'DIFF', 'FROM', thing]);
  }

  static SurrealdbClauseBuilderForSelect create({required String thing}) =>
      SurrealdbClauseBuilderForSelect(['CREATE', thing]);
}
