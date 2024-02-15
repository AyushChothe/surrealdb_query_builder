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

class Returns {
  factory Returns.none() => const Returns._('NONE');
  factory Returns.before() => const Returns._('BEFORE');
  factory Returns.after() => const Returns._('AFTER');
  factory Returns.diff() => const Returns._('DIFF');
  factory Returns.fields(List<String> fields) =>
      Returns._(fields.joinWithTrim());

  const Returns._(this.value);

  final String value;
}
