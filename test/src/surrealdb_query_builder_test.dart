import 'package:surrealdb_query_builder/src/utils/list_utils.dart';
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
        SurrealdbQueryBuilder.select(
                fields: [const Field(name: 'name', alias: 'nm')],
                thing: 'person')
            .orderBy(orderBys: [OrderBy(field: 'name')]).build(),
        equals('SELECT name AS nm FROM person ORDER name ASC;'),
      );
    });
    test('select order by desc statement', () {
      expect(
        SurrealdbQueryBuilder.select(
          fields: [const Field(name: 'age')],
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
          fields: [const Field(name: 'name'), const Field(name: 'age')],
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

  group('Create', () {
    test('create statement', () {
      expect(
        SurrealdbQueryBuilder.create(thing: 'person', content: {
          'name': 'Tobie',
          'company': 'SurrealDB',
          'skills': ['Rust', 'Go', 'JavaScript'],
          'date': '2024-02-15T15:27:00Z'
        }).build(),
        equals('CREATE person CONTENT '
            '{"name":"Tobie",'
            '"company":"SurrealDB",'
            '"skills":["Rust","Go","JavaScript"],'
            '"date":"2024-02-15T15:27:00Z"};'),
      );
    });
    test('create statement with return none', () {
      expect(
        SurrealdbQueryBuilder.create(thing: 'person', content: {
          'name': 'Tobie',
          'company': 'SurrealDB',
          'skills': ['Rust', 'Go', 'JavaScript'],
          'date': '2024-02-15T15:27:00Z'
        }).returns(Returns.none()).build(),
        equals('CREATE person CONTENT '
            '{"name":"Tobie",'
            '"company":"SurrealDB",'
            '"skills":["Rust","Go","JavaScript"],'
            '"date":"2024-02-15T15:27:00Z"} RETURN NONE;'),
      );
    });

    test('create statement with return fields', () {
      expect(
        SurrealdbQueryBuilder.create(thing: 'person', content: {
          'name': 'Tobie',
          'company': 'SurrealDB',
          'skills': ['Rust', 'Go', 'JavaScript'],
          'date': '2024-02-15T15:27:00Z'
        }).returns(Returns.fields(['skills'])).build(),
        equals('CREATE person CONTENT '
            '{"name":"Tobie",'
            '"company":"SurrealDB",'
            '"skills":["Rust","Go","JavaScript"],'
            '"date":"2024-02-15T15:27:00Z"} '
            'RETURN skills;'),
      );
    });

    test('create only statement with return fields with timeout and parallel',
        () {
      expect(
        SurrealdbQueryBuilder.create(thing: 'person', only: true, content: {
          'name': 'Tobie',
          'company': 'SurrealDB',
          'skills': ['Rust', 'Go', 'JavaScript'],
          'date': '2024-02-15T15:27:00Z'
        })
            .returns(Returns.fields(['skills']))
            .timeout(duration: '5s')
            .parallel()
            .build(),
        equals('CREATE ONLY person CONTENT '
            '{"name":"Tobie",'
            '"company":"SurrealDB",'
            '"skills":["Rust","Go","JavaScript"],'
            '"date":"2024-02-15T15:27:00Z"} '
            'RETURN skills TIMEOUT 5s PARALLEL;'),
      );
    });
  });

  group('Transaction', () {
    test('transaction block', () {
      expect(SurrealdbQueryBuilder.transaction(() sync* {
        const thing = 'person';
        yield SurrealdbQueryBuilder.create(thing: thing);
        yield SurrealdbQueryBuilder.select(thing: thing);

        const value = 'name';
        yield SurrealdbQueryBuilder.selectValue(thing: thing, value: value);
      }),
          equals([
            'BEGIN;',
            'CREATE person;',
            'SELECT * FROM person;',
            'SELECT VALUE name FROM person;',
            'COMMIT;'
          ].joinWithTrim('\n')));
    });
  });
  group('Use', () {
    test(
      'Use ns statement',
      () => expect(
        SurrealdbQueryBuilder.use(ns: 'test').build(),
        equals('USE NS test;'),
      ),
    );
    test(
      'Use db statement',
      () => expect(
        SurrealdbQueryBuilder.use(db: 'test').build(),
        equals('USE DB test;'),
      ),
    );
    test(
      'Use statement with ns and db',
      () => expect(
        SurrealdbQueryBuilder.use(ns: 'test', db: 'data').build(),
        equals('USE NS test DB data;'),
      ),
    );
    test(
      'Use without ns and db',
      () => expect(
        () => SurrealdbQueryBuilder.use().build(),
        throwsA(isA<AssertionError>()),
      ),
    );
  });
}
