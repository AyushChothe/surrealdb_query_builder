// ignore_for_file: prefer_const_constructors
import 'package:surrealdb_query_builder/surrealdb_query_builder.dart';
import 'package:test/test.dart';

void main() {
  group('SurrealdbQueryBuilder', () {
    test('can be instantiated', () {
      expect(SurrealdbQueryBuilder(), isNotNull);
    });

    test('select statement', () {
      expect(
        SurrealdbQueryBuilder.select(recordId: 'person').build(),
        equals('SELECT * FROM person;'),
      );
    });
    test('select where and statement', () {
      expect(
        SurrealdbQueryBuilder.select(recordId: 'person')
            .where()
            .eq(field: 'name', value: 'Ayush')
            .and()
            .eq(field: 'age', value: '23')
            .build(),
        equals('SELECT * FROM person WHERE name = Ayush AND age = 23;'),
      );
    });
    test('select where or statement', () {
      expect(
        SurrealdbQueryBuilder.select(recordId: 'person')
            .where()
            .eq(field: 'name', value: 'Ayush')
            .or()
            .eq(field: 'age', value: '23')
            .build(),
        equals('SELECT * FROM person WHERE name = Ayush OR age = 23;'),
      );
    });
    test('select order by asc statement', () {
      expect(
        SurrealdbQueryBuilder.select(fields: 'name', recordId: 'person')
            .orderBy(orderBys: [OrderBy(field: 'name')]).build(),
        equals('SELECT name FROM person ORDER name ASC;'),
      );
    });
    test('select order by desc statement', () {
      expect(
        SurrealdbQueryBuilder.select(
          fields: 'age',
          recordId: 'person',
        ).orderBy(orderBys: [OrderBy(field: 'age', order: Order.desc)]).build(),
        equals('SELECT age FROM person ORDER age DESC;'),
      );
    });
  });
}
