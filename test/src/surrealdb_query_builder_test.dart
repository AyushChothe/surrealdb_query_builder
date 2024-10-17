import 'package:extension_type_unions/bounded_extension_type_unions.dart';
import 'package:surrealdb_query_builder/src/core/models/sdb_types/surrealdb_type.dart';
import 'package:surrealdb_query_builder/surrealdb_query_builder.dart';
import 'package:test/test.dart';

void main() {
  group('Test', () {
    test('union2', () {
      final Union2<Object, List<double>, (double, double)> union2 =
          [51.0, 52.0].u21;
      expect('${union2.value}', equals('[51.0, 52.0]'));
    });
  });
  group('Select', () {
    test('select statement', () {
      expect(
        SurrealdbQueryBuilder.select(thing: TableType('person')).build(),
        equals('SELECT * FROM type::table("person");'),
      );
    });
    test('select where and statement', () {
      expect(
        SurrealdbQueryBuilder.select(thing: TableType('person'))
            .where()
            .eq(field: 'name', value: 'Ayush')
            .and()
            .eq(field: 'age', value: '23')
            .next()
            .build(),
        equals(
          'SELECT * FROM type::table("person") WHERE name = Ayush && age = 23;',
        ),
      );
    });
    test('select where or statement', () {
      expect(
        SurrealdbQueryBuilder.select(thing: TableType('person'))
            .where()
            .eq(field: 'name', value: 'Ayush')
            .or()
            .eq(field: 'age', value: '23')
            .build(),
        equals(
          'SELECT * FROM type::table("person") WHERE name = Ayush || age = 23;',
        ),
      );
    });
    test('select order by asc statement', () {
      expect(
        SurrealdbQueryBuilder.select(
                fields: [const Field(name: 'name', alias: 'nm')],
                thing: TableType('person'))
            .orderBy(orderBys: [OrderBy(field: 'name')]).build(),
        equals('SELECT name AS nm FROM type::table("person") ORDER name ASC;'),
      );
    });
    test('select order by desc statement', () {
      expect(
        SurrealdbQueryBuilder.select(
          fields: [const Field(name: 'age')],
          thing: TableType('person'),
        ).orderBy(orderBys: [OrderBy(field: 'age', order: Order.desc)]).build(),
        equals('SELECT age FROM type::table("person") ORDER age DESC;'),
      );
    });
    test('select with only statement', () {
      expect(
        SurrealdbQueryBuilder.select(
                thing: RecordType.record('person:john'), only: true)
            .build(),
        equals('SELECT * FROM ONLY type::record("person:john");'),
      );
    });

    test('select value with only statement', () {
      expect(
        SurrealdbQueryBuilder.selectValue(
                thing: RecordType.record('person:john'),
                value: 'name',
                only: true)
            .build(),
        equals('SELECT VALUE name FROM ONLY type::record("person:john");'),
      );
    });
    test('select value without only statement', () {
      expect(
        SurrealdbQueryBuilder.selectValue(
                thing: RecordType.record('person:john'), value: 'name')
            .build(),
        equals('SELECT VALUE name FROM type::record("person:john");'),
      );
    });
    test('select complete with all options', () {
      expect(
        SurrealdbQueryBuilder.select(
          thing: TableType('person'),
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
        equals('SELECT name, age OMIT fullname FROM type::table("person") '
            'WITH INDEX unique_name '
            'WHERE name = ayush || name = ash && age != 0 '
            'ORDER age NUMERIC DESC LIMIT 5 START 0 '
            'FETCH projects TIMEOUT 5s PARALLEL;'),
      );
    });
  });

  group('Live Select', () {
    test('live select statement', () {
      expect(
          SurrealdbQueryBuilder.liveSelect(thing: TableType('person')).build(),
          equals('LIVE SELECT * FROM type::table("person");'));
    });
    test('live select value statement', () {
      expect(
          SurrealdbQueryBuilder.liveSelectValue(
                  thing: TableType('person'), value: 'name')
              .build(),
          equals('LIVE SELECT VALUE name FROM type::table("person");'));
    });

    test('live select diff statement', () {
      expect(
          SurrealdbQueryBuilder.liveSelectDiff(thing: TableType('person'))
              .build(),
          equals('LIVE SELECT DIFF FROM type::table("person");'));
    });
    test('live select where statement', () {
      expect(
          SurrealdbQueryBuilder.liveSelect(thing: TableType('person'))
              .where()
              .gt(field: 'age', value: '18')
              .build(),
          equals('LIVE SELECT * FROM type::table("person") WHERE age > 18;'));
    });
    test('live select fetch statement', () {
      expect(
          SurrealdbQueryBuilder.liveSelect(thing: TableType('person'))
              .fetch(fields: ['projects']).build(),
          equals('LIVE SELECT * FROM type::table("person") FETCH projects;'));
    });
    test('live select where and fetch statement', () {
      expect(
          SurrealdbQueryBuilder.liveSelect(thing: TableType('person'))
              .where()
              .gt(field: 'age', value: '18')
              .next()
              .fetch(fields: ['projects']).build(),
          equals(
            'LIVE SELECT * FROM type::table("person") '
            'WHERE age > 18 FETCH projects;',
          ));
    });
  });

  group('Logical Operators', () {
    test('nco (??)', () {
      expect(
        SurrealdbQueryBuilder.select(
          thing: RawType(SurrealdbOpBuilder.raw()
              .value(value: RawType('NULL'))
              .nco()
              .value(value: NumberType(0.u21))
              .nco()
              .value(value: BoolType(false.u21))
              .nco()
              .value(value: NumberType('10'.u22))
              .build(withSemicolon: false)),
        ).build(),
        equals('SELECT * FROM NULL ?? '
            'type::number(0) ?? '
            'type::bool(false) ?? '
            'type::number("10");'),
      );
    });

    test('tco (?:)', () {
      expect(
        SurrealdbQueryBuilder.select(
          thing: RawType(SurrealdbOpBuilder.raw()
              .value(value: RawType('NULL'))
              .tco()
              .value(value: NumberType(0.u21))
              .tco()
              .value(value: BoolType(false.u21))
              .tco()
              .value(value: NumberType('10'.u22))
              .build(withSemicolon: false)),
        ).build(),
        equals('SELECT * FROM NULL ?: '
            'type::number(0) ?: '
            'type::bool(false) ?: '
            'type::number("10");'),
      );
    });
  });

  group('Create', () {
    test('create statement', () {
      expect(
        SurrealdbQueryBuilder.create(thing: TableType('person'), content: {
          'name': StringType('Tobie'),
          'company': StringType('SurrealDB'),
          'skills': ArrayType(['Rust', 'Go', 'JavaScript'].u21),
          'date': DateTimeType('2024-02-15T15:27:00Z'.u22)
        }).build(),
        equals('CREATE type::table("person") CONTENT '
            '{"name":type::string("Tobie"),'
            '"company":type::string("SurrealDB"),'
            '"skills":type::array(["Rust","Go","JavaScript"]),'
            '"date":type::datetime("2024-02-15T15:27:00Z")};'),
      );
    });
    test('create statement with return none', () {
      expect(
        SurrealdbQueryBuilder.create(thing: TableType('person'), content: {
          'name': StringType('Tobie'),
          'company': StringType('SurrealDB'),
          'skills': ArrayType(['Rust', 'Go', 'JavaScript'].u21),
          'date': DateTimeType('2024-02-15T15:27:00Z'.u22)
        }).returns(Returns.none()).build(),
        equals('CREATE type::table("person") CONTENT '
            '{"name":type::string("Tobie"),'
            '"company":type::string("SurrealDB"),'
            '"skills":type::array(["Rust","Go","JavaScript"]),'
            '"date":type::datetime("2024-02-15T15:27:00Z")} '
            'RETURN NONE;'),
      );
    });

    test('create statement with return fields', () {
      expect(
        SurrealdbQueryBuilder.create(thing: TableType('person'), content: {
          'name': StringType('Tobie'),
          'company': StringType('SurrealDB'),
          'skills': ArrayType(['Rust', 'Go', 'JavaScript'].u21),
          'date': DateTimeType('2024-02-15T15:27:00Z'.u22)
        }).returns(Returns.fields(['skills'])).build(),
        equals('CREATE type::table("person") CONTENT '
            '{"name":type::string("Tobie"),'
            '"company":type::string("SurrealDB"),'
            '"skills":type::array(["Rust","Go","JavaScript"]),'
            '"date":type::datetime("2024-02-15T15:27:00Z")} '
            'RETURN skills;'),
      );
    });

    test('create only statement with return fields with timeout and parallel',
        () {
      expect(
        SurrealdbQueryBuilder.create(
          thing: TableType('person'),
          only: true,
          content: {
            'name': StringType('Tobie'),
            'company': StringType('SurrealDB'),
            'skills': ArrayType(['Rust', 'Go', 'JavaScript'].u21),
            'date': DateTimeType('2024-02-15T15:27:00Z'.u22)
          },
        )
            .returns(Returns.fields(['skills']))
            .timeout(duration: '5s')
            .parallel()
            .build(),
        equals('CREATE ONLY type::table("person") CONTENT '
            '{"name":type::string("Tobie"),'
            '"company":type::string("SurrealDB"),'
            '"skills":type::array(["Rust","Go","JavaScript"]),'
            '"date":type::datetime("2024-02-15T15:27:00Z")} '
            'RETURN skills TIMEOUT 5s PARALLEL;'),
      );
    });
  });

  group('Transaction', () {
    test('transaction block', () {
      expect(SurrealdbQueryBuilder.transaction(() sync* {
        const thing = 'person';
        yield SurrealdbQueryBuilder.create(thing: TableType(thing));
        yield SurrealdbQueryBuilder.select(thing: TableType(thing));

        const value = 'name';
        yield SurrealdbQueryBuilder.selectValue(
            thing: TableType(thing), value: value);
      }),
          equals([
            'BEGIN;',
            'CREATE type::table("person");',
            'SELECT * FROM type::table("person");',
            'SELECT VALUE name FROM type::table("person");',
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
