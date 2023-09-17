// ignore_for_file: public_member_api_docs, sort_constructors_first
part of '../../../surrealdb_query_builder.dart';

/// Handles `WHERE`, `ORDER BY`
final class SurrealdbClauseBuilder extends QueryBuilder
    with
        Build,
        WhereClause,
        OrderByClause,
        SplitAtClause,
        GroupByClause,
        LimitClause,
        StartClause,
        FetchClause,
        TimeoutClause,
        ParallelClause {
  const SurrealdbClauseBuilder(super._query);
}

/// Handles `WHERE`
base mixin WhereClause on QueryBuilder {
  SurrealdbOpBuilder<AfterWhere> where() {
    _query.add('WHERE');
    return SurrealdbOpBuilder<AfterWhere>(_query);
  }
}

final class AfterWhere extends QueryBuilder
    with
        Build,
        OrderByClause,
        SplitAtClause,
        GroupByClause,
        LimitClause,
        StartClause,
        FetchClause,
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
        SplitAtClause,
        GroupByClause,
        LimitClause,
        StartClause,
        FetchClause,
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
        GroupByClause,
        LimitClause,
        StartClause,
        FetchClause,
        TimeoutClause,
        ParallelClause {
  const AfterSplitAt(super._query);
}

/// Handles `GROUP`
base mixin GroupByClause on QueryBuilder {
  AfterGroupBy groupBy({
    required List<String> fields,
  }) {
    _query.addAll(['GROUP', fields.map((e) => e.trim()).join(', ')]);
    return AfterGroupBy(_query);
  }
}

final class AfterGroupBy extends QueryBuilder
    with
        Build,
        LimitClause,
        StartClause,
        FetchClause,
        TimeoutClause,
        ParallelClause {
  const AfterGroupBy(super._query);
}

/// Handles `LIMIT`
base mixin LimitClause on QueryBuilder {
  AfterLimit limit({
    required String limit,
  }) {
    _query.addAll(['LIMIT', limit]);
    return AfterLimit(_query);
  }
}

final class AfterLimit extends QueryBuilder
    with Build, StartClause, FetchClause, TimeoutClause, ParallelClause {
  const AfterLimit(super._query);
}

/// Handles `START`
base mixin StartClause on QueryBuilder {
  AfterStart start({
    required String start,
  }) {
    _query.addAll(['START', start]);
    return AfterStart(_query);
  }
}

final class AfterStart extends QueryBuilder
    with Build, FetchClause, TimeoutClause, ParallelClause {
  const AfterStart(super._query);
}

/// Handles `FETCH`
base mixin FetchClause on QueryBuilder {
  AfterFetch fetch({
    required List<String> fields,
  }) {
    _query.addAll(['FETCH', fields.map((e) => e.trim()).join(', ')]);
    return AfterFetch(_query);
  }
}

final class AfterFetch extends QueryBuilder
    with Build, TimeoutClause, ParallelClause {
  const AfterFetch(super._query);
}

/// Handles `TIMEOUT`
base mixin TimeoutClause on QueryBuilder {
  AfterTimeout timeout({
    required String duration,
  }) {
    _query.addAll(['TIMEOUT', duration]);
    return AfterTimeout(_query);
  }
}

final class AfterTimeout extends QueryBuilder with Build, ParallelClause {
  const AfterTimeout(super._query);
}

/// Handles `PARALLEL`
base mixin ParallelClause on QueryBuilder {
  AfterParallel parallel() {
    _query.add('PARALLEL');
    return AfterParallel(_query);
  }
}

final class AfterParallel extends QueryBuilder with Build {
  const AfterParallel(super._query);
}
