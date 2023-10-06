part of '../../../../surrealdb_query_builder.dart';

class OrderBy {
  OrderBy({
    required this.field,
    this.type,
    this.order = Order.asc,
  });
  final String field;
  final OrderType? type;
  final Order order;
}

class Field {
  const Field({required this.name, this.alias});

  final String name;
  final String? alias;

  @override
  String toString() => name + ((alias != null) ? ' AS $alias' : '');
}
