import 'package:surrealdb_query_builder/surrealdb_query_builder.dart';
import 'package:test/test.dart';

void main() {
  group('SurrealdbQueryBuilder', () {
    test('can be instantiated', () {
      expect(SurrealdbQueryBuilder(), isNotNull);
    });

    test('select statement', () {
      expect(
        SurrealdbQueryBuilder.select(thing: 'person').build(),
        equals('SELECT * FROM person;'),
      );
    });
    test('select where and statement', () {
      expect(
        SurrealdbQueryBuilder.select(thing: 'person')
            .where()
            .eq(field: 'name', value: 'Ayush')
            .and()
            .eq(field: 'age', value: '23')
            .next()
            .build(),
        equals('SELECT * FROM person WHERE name = Ayush AND age = 23;'),
      );
    });
    test('select where or statement', () {
      expect(
        SurrealdbQueryBuilder.select(thing: 'person')
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
        SurrealdbQueryBuilder.select(fields: ['name'], thing: 'person')
            .orderBy(orderBys: [OrderBy(field: 'name')]).build(),
        equals('SELECT name FROM person ORDER name ASC;'),
      );
    });
    test('select order by desc statement', () {
      expect(
        SurrealdbQueryBuilder.select(
          fields: ['age'],
          thing: 'person',
        ).orderBy(orderBys: [OrderBy(field: 'age', order: Order.desc)]).build(),
        equals('SELECT age FROM person ORDER age DESC;'),
      );
    });
    test('select with only statement', () {
      expect(
        SurrealdbQueryBuilder.select(thing: 'person:john', only: true).build(),
        equals('SELECT * FROM ONLY person:john;'),
      );
    });

    test('select value with only statement', () {
      expect(
        SurrealdbQueryBuilder.selectValue(
                thing: 'person:john', value: 'name', only: true)
            .build(),
        equals('SELECT VALUE name FROM ONLY person:john;'),
      );
    });
    test('select value without only statement', () {
      expect(
        SurrealdbQueryBuilder.selectValue(thing: 'person:john', value: 'name')
            .build(),
        equals('SELECT VALUE name FROM person:john;'),
      );
    });
    test('select complete with all options', () {
      expect(
        SurrealdbQueryBuilder.select(
          thing: 'person',
          omitfields: ['fullname'],
          fields: ['name', 'age'],
        )
            .withIndex(indexes: ['unique_name'])
            .where()
            .eq(field: 'name', value: 'ayush')
            .or()
            .eq(field: 'name', value: 'ash')
            .and()
            .neq(field: 'age', value: '0')
            .next()
            .orderBy(orderBys: [
              OrderBy(field: 'age', order: Order.desc, type: OrderType.numeric)
            ])
            .limit(limit: '5')
            .start(start: '0')
            .fetch(fields: ['projects'])
            .timeout(duration: '5s')
            .parallel()
            .build(),
        equals(
            'SELECT name, age OMIT fullname FROM person WITH INDEX unique_name '
            'WHERE name = ayush OR name = ash AND age != 0 '
            'ORDER age NUMERIC DESC LIMIT 5 START 0 '
            'FETCH projects TIMEOUT 5s PARALLEL;'),
      );
    });
  });
}
