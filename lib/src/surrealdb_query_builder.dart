part of '../surrealdb_query_builder.dart';

/// Handles all base queries
final class SurrealdbQueryBuilder extends QueryBuilder {
  SurrealdbQueryBuilder() : super([]);

  static SurrealdbClauseBuilderForSelect select({
    required SurrealDbType<dynamic> thing,
    List<Field> fields = const [Field(name: '*')],
    List<String> omitfields = const [],
    bool only = false,
  }) {
    final omit = omitfields.joinWithTrim();
    return SurrealdbClauseBuilderForSelect([
      'SELECT',
      fields.map((e) => e.toString()).toList().joinWithTrim(),
      if (omit.isNotEmpty) 'OMIT',
      omitfields.joinWithTrim(),
      'FROM',
      if (only) 'ONLY',
      thing.toString()
    ]);
  }

  static SurrealdbClauseBuilderForSelect selectValue({
    required SurrealDbType<dynamic> thing,
    required String value,
    bool only = false,
  }) =>
      SurrealdbClauseBuilderForSelect([
        'SELECT',
        'VALUE',
        value.trim(),
        'FROM',
        if (only) 'ONLY',
        thing.toString()
      ]);

  static SurrealdbClauseBuilderForLiveSelect liveSelect({
    required SurrealDbType<dynamic> thing,
    List<Field> fields = const [Field(name: '*')],
  }) {
    return SurrealdbClauseBuilderForLiveSelect([
      'LIVE',
      'SELECT',
      fields.map((e) => e.toString()).toList().joinWithTrim(),
      'FROM',
      thing.toString()
    ]);
  }

  static SurrealdbClauseBuilderForLiveSelect liveSelectValue({
    required SurrealDbType<dynamic> thing,
    required String value,
  }) {
    return SurrealdbClauseBuilderForLiveSelect(
        ['LIVE', 'SELECT', 'VALUE', value.trim(), 'FROM', thing.toString()]);
  }

  static SurrealdbClauseBuilderForLiveSelect liveSelectDiff(
      {required SurrealDbType<dynamic> thing}) {
    return SurrealdbClauseBuilderForLiveSelect(
        ['LIVE', 'SELECT', 'DIFF', 'FROM', thing.toString()]);
  }

  static SurrealdbClauseBuilderForCreate create({
    required SurrealDbType<dynamic> thing,
    Map<String, SurrealDbType<dynamic>>? content,
    bool only = false,
  }) =>
      SurrealdbClauseBuilderForCreate([
        'CREATE',
        if (only) 'ONLY',
        thing.toString(),
        if (content != null) ...['CONTENT', content.encode()]
      ]);

  static String transaction(Iterable<Build> Function() statements) => [
        'BEGIN;',
        ...statements().map((e) => e.build()),
        'COMMIT;'
      ].joinWithTrim('\n');

  static End use({String? ns, String? db}) {
    assert(!(ns == null && db == null), 'Both ns and db cannot be null');
    return End([
      'USE',
      if (ns != null) ...['NS', ns],
      if (db != null) ...['DB', db]
    ]);
  }
}
