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
