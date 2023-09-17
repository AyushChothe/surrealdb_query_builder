part of '../surrealdb_query_builder.dart';

/// Handles `SELECT`
final class SurrealdbQueryBuilder extends QueryBuilder {
  SurrealdbQueryBuilder() : super([]);

  static SurrealdbClauseBuilder select({
    required String recordId,
    String fields = '*',
  }) =>
      SurrealdbClauseBuilder(['SELECT', fields, 'FROM', recordId]);

  static SurrealdbClauseBuilder create({required String recordId}) =>
      SurrealdbClauseBuilder(['CREATE', recordId]);
}
