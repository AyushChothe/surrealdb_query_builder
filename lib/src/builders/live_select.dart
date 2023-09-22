part of '../../../surrealdb_query_builder.dart';

/// Handles Clasues for `LIVE SELECT`
final class SurrealdbClauseBuilderForLiveSelect extends QueryBuilder
    with Build, WhereClause<AfterWhereForLiveSelect>, FetchClause<End> {
  const SurrealdbClauseBuilderForLiveSelect(super._query);
}

final class AfterWhereForLiveSelect extends QueryBuilder
    with Build, FetchClause<End> {
  const AfterWhereForLiveSelect(super._query);
}
