part of '../../../../surrealdb_query_builder.dart';

class Field {
  const Field({required this.name, this.alias});

  final String name;
  final String? alias;

  @override
  String toString() => name + ((alias != null) ? ' AS $alias' : '');
}
