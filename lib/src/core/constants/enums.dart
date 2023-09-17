part of '../../../../surrealdb_query_builder.dart';

enum Order {
  asc('ASC'),
  desc('DESC');

  const Order(this.value);
  final String value;
}

enum OrderType {
  rand('RAND()'),
  collate('COLLATE'),
  numeric('NUMERIC');

  const OrderType(this.value);
  final String value;
}
