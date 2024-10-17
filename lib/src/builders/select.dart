// ignore_for_file: public_member_api_docs, sort_constructors_first
part of '../../../surrealdb_query_builder.dart';

/// Handles Clasues for `SELECT`
final class SurrealdbClauseBuilderForSelect extends QueryBuilder
    with
        Build,
        WithClause,
        WhereClause<AfterWhere>,
        OrderByClause,
        SplitAtClause,
        GroupByClause,
        LimitClause,
        StartClause,
        FetchClause<AfterFetch>,
        TimeoutClause,
        ParallelClause {
  const SurrealdbClauseBuilderForSelect(super._query);
}

/// Handles `NOINDEX`, `INDEX`
base mixin WithClause on QueryBuilder {
  AfterWith withIndex({required List<String> indexes}) {
    assert(indexes.isNotEmpty, 'indexes cannot be empty');
    _query.addAll(['WITH', 'INDEX', indexes.joinWithTrim()]);
    return AfterWith(_query);
  }

  AfterWith withNoIndex() {
    _query.addAll(['WITH', 'NOINDEX']);
    return AfterWith(_query);
  }
}

final class AfterWith extends QueryBuilder
    with
        Build,
        WhereClause<AfterWhere>,
        OrderByClause,
        SplitAtClause,
        GroupByClause,
        LimitClause,
        StartClause,
        FetchClause<AfterFetch>,
        TimeoutClause,
        ParallelClause {
  const AfterWith(super._query);
}

final class AfterWhere extends QueryBuilder
    with
        Build,
        OrderByClause,
        SplitAtClause,
        GroupByClause,
        LimitClause,
        StartClause,
        FetchClause<AfterFetch>,
        TimeoutClause,
        ParallelClause {
  const AfterWhere(super._query);
}

/// Handles `ORDER BY`

base mixin OrderByClause on QueryBuilder {
  AfterOrderBy orderBy({required List<OrderBy> orderBys}) {
    assert(orderBys.isNotEmpty, 'orderBys cannot be empty');
    _query
      ..add('ORDER')
      ..addAll([
        for (final ob in orderBys) ...[
          ob.field,
          if (ob.type != null) ob.type!.value,
          ob.order.value
        ]
      ]);
    return AfterOrderBy(_query);
  }
}

final class AfterOrderBy extends QueryBuilder
    with
        Build,
        LimitClause,
        StartClause,
        FetchClause<AfterFetch>,
        TimeoutClause,
        ParallelClause {
  const AfterOrderBy(super._query);
}

/// Handles `SPLIT`
base mixin SplitAtClause on QueryBuilder {
  AfterSplitAt splitAt({
    required String field,
  }) {
    _query.addAll(['SPLIT', field]);
    return AfterSplitAt(_query);
  }
}

final class AfterSplitAt extends QueryBuilder
    with
        Build,
        LimitClause,
        StartClause,
        FetchClause<AfterFetch>,
        TimeoutClause,
        ParallelClause {
  const AfterSplitAt(super._query);
}

/// Handles `GROUP`
base mixin GroupByClause on QueryBuilder {
  AfterGroupBy groupBy({
    required List<String> fields,
  }) {
    _query.addAll(['GROUP', fields.joinWithTrim()]);
    return AfterGroupBy(_query);
  }
}

final class AfterGroupBy extends QueryBuilder
    with
        Build,
        LimitClause,
        StartClause,
        FetchClause<AfterFetch>,
        TimeoutClause,
        ParallelClause {
  const AfterGroupBy(super._query);
}

/// Handles `LIMIT`
base mixin LimitClause on QueryBuilder {
  AfterLimit limit({
    required IntType limit,
  }) {
    _query.addAll(['LIMIT', limit.toString()]);
    return AfterLimit(_query);
  }
}

final class AfterLimit extends QueryBuilder
    with
        Build,
        StartClause,
        FetchClause<AfterFetch>,
        TimeoutClause,
        ParallelClause {
  const AfterLimit(super._query);
}

/// Handles `START`
base mixin StartClause on QueryBuilder {
  AfterStart start({
    required IntType start,
  }) {
    _query.addAll(['START', start.toString()]);
    return AfterStart(_query);
  }
}

final class AfterStart extends QueryBuilder
    with Build, FetchClause<AfterFetch>, TimeoutClause, ParallelClause {
  const AfterStart(super._query);
}

final class AfterFetch extends QueryBuilder
    with Build, TimeoutClause, ParallelClause {
  const AfterFetch(super._query);
}
