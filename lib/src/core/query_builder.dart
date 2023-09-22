part of '../../../surrealdb_query_builder.dart';

/// Base class for all Builders
abstract final class QueryBuilder {
  const QueryBuilder(this._query);
  final List<String> _query;
}

/// Handles `END` of [QueryBuilder]
final class End extends QueryBuilder with Build {
  const End(super._query);
}

/// Add Build method on [QueryBuilder] that ends
base mixin Build on QueryBuilder {
  String build({bool withSemicolon = true}) {
    return '${_query.joinWithTrim(' ')}${withSemicolon ? ';' : ''}';
  }
}
