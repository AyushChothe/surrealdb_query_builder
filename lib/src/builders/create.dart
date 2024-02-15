// ignore_for_file: public_member_api_docs, sort_constructors_first
part of '../../../surrealdb_query_builder.dart';

/// Handles Clasues for `SELECT`
final class SurrealdbClauseBuilderForCreate extends QueryBuilder
    with Build, ReturnClause, TimeoutClause, ParallelClause {
  const SurrealdbClauseBuilderForCreate(super._query);
}

/// Handles `RETURN`
base mixin ReturnClause on QueryBuilder {
  AfterReturn returns(Returns returns) {
    _query.addAll(['RETURN', returns.value]);
    return AfterReturn(_query);
  }
}

final class AfterReturn extends QueryBuilder
    with Build, TimeoutClause, ParallelClause {
  const AfterReturn(super._query);
}
