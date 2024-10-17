part of '../../surrealdb_query_builder.dart';

extension ListX<T extends Object> on List<T> {
  String joinWithTrim([String sep = ', ']) =>
      map((e) => e.toString().trim()).where((e) => e.isNotEmpty).join(sep);
}
