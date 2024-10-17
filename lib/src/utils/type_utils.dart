part of '../../surrealdb_query_builder.dart';

extension FormatX on dynamic {
  String format() => this is String ? '"$this"' : '$this';
}
