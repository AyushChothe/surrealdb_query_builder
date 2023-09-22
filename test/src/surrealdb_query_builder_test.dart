import 'package:surrealdb_query_builder/surrealdb_query_builder.dart';
import 'package:test/test.dart';

void main() {
  group('Select', () {
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
        equals('SELECT * FROM person WHERE name = Ayush && age = 23;'),
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
        equals('SELECT * FROM person WHERE name = Ayush || age = 23;'),
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
            'WHERE name = ayush || name = ash && age != 0 '
            'ORDER age NUMERIC DESC LIMIT 5 START 0 '
            'FETCH projects TIMEOUT 5s PARALLEL;'),
      );
    });
  });

  group('Live Select', () {
    test('live select statement', () {
      expect(SurrealdbQueryBuilder.liveSelect(thing: 'person').build(),
          equals('LIVE SELECT * FROM person;'));
    });
    test('live select value statement', () {
      expect(
          SurrealdbQueryBuilder.liveSelectValue(thing: 'person', value: 'name')
              .build(),
          equals('LIVE SELECT VALUE name FROM person;'));
    });

    test('live select diff statement', () {
      expect(SurrealdbQueryBuilder.liveSelectDiff(thing: 'person').build(),
          equals('LIVE SELECT DIFF FROM person;'));
    });
    test('live select where statement', () {
      expect(
          SurrealdbQueryBuilder.liveSelect(thing: 'person')
              .where()
              .gt(field: 'age', value: '18')
              .build(),
          equals('LIVE SELECT * FROM person WHERE age > 18;'));
    });
    test('live select fetch statement', () {
      expect(
          SurrealdbQueryBuilder.liveSelect(thing: 'person')
              .fetch(fields: ['projects']).build(),
          equals('LIVE SELECT * FROM person FETCH projects;'));
    });
    test('live select where and fetch statement', () {
      expect(
          SurrealdbQueryBuilder.liveSelect(thing: 'person')
              .where()
              .gt(field: 'age', value: '18')
              .next()
              .fetch(fields: ['projects']).build(),
          equals('LIVE SELECT * FROM person WHERE age > 18 FETCH projects;'));
    });
  });

  group('Logical Operators', () {
    test('nco (??)', () {
      expect(
        SurrealdbQueryBuilder.select(
          thing: SurrealdbOpBuilder.raw()
              .value(value: 'NULL')
              .nco()
              .value(value: '0')
              .nco()
              .value(value: 'false')
              .nco()
              .value(value: '10')
              .build(withSemicolon: false),
        ).build(),
        equals('SELECT * FROM NULL ?? 0 ?? false ?? 10;'),
      );
    });

    test('tco (?:)', () {
      expect(
        SurrealdbQueryBuilder.select(
          thing: SurrealdbOpBuilder.raw()
              .value(value: 'NULL')
              .tco()
              .value(value: '0')
              .tco()
              .value(value: 'false')
              .tco()
              .value(value: '10')
              .build(withSemicolon: false),
        ).build(),
        equals('SELECT * FROM NULL ?: 0 ?: false ?: 10;'),
      );
    });
  });
}
