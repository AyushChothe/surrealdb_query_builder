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
        SurrealdbQueryBuilder.select(thing: const TableType('person')).build(),
        equals('SELECT * FROM type::table("person");'),
      );
    });
    test('select where and statement', () {
      expect(
        SurrealdbQueryBuilder.select(thing: const TableType('person'))
            .where()
            .eq(
                field: const FieldType('name'),
                value: const StringType('Ayush'))
            .and()
            .eq(field: const FieldType('age'), value: NumberType(23.u21))
            .next()
            .build(),
        equals(
          'SELECT * FROM type::table("person") WHERE '
          'type::field("name") = type::string("Ayush") '
          '&& type::field("age") = type::number(23);',
        ),
      );
    });
    test('select where or statement', () {
      expect(
        SurrealdbQueryBuilder.select(thing: const TableType('person'))
            .where()
            .eq(
                field: const FieldType('name'),
                value: const StringType('Ayush'))
            .or()
            .eq(field: const FieldType('age'), value: NumberType(23.u21))
            .build(),
        equals(
          'SELECT * FROM type::table("person") WHERE '
          'type::field("name") = type::string("Ayush") '
          '|| type::field("age") = type::number(23);',
        ),
      );
    });
    test('select order by asc statement', () {
      expect(
        SurrealdbQueryBuilder.select(
                fields: [const Field(name: 'name', alias: 'nm')],
                thing: const TableType('person'))
            .orderBy(orderBys: [OrderBy(field: 'name')]).build(),
        equals('SELECT name AS nm FROM type::table("person") ORDER name ASC;'),
      );
    });
    test('select order by desc statement', () {
      expect(
        SurrealdbQueryBuilder.select(
          fields: [const Field(name: 'age')],
          thing: const TableType('person'),
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
          thing: const TableType('person'),
          omitfields: ['fullname'],
          fields: [const Field(name: 'name'), const Field(name: 'age')],
        )
            .withIndex(indexes: ['unique_name'])
            .where()
            .eq(
                field: const FieldType('name'),
                value: const StringType('ayush'))
            .or()
            .eq(field: const FieldType('name'), value: const StringType('ash'))
            .and()
            .neq(field: const FieldType('age'), value: NumberType('0'.u22))
            .next()
            .orderBy(orderBys: [
              OrderBy(field: 'age', order: Order.desc, type: OrderType.numeric)
            ])
            .limit(limit: IntType(5.u21))
            .start(start: IntType(0.u21))
            .fetch(fields: [const FieldType('projects')])
            .timeout(duration: '5s')
            .parallel()
            .build(),
        equals('SELECT name, age OMIT fullname FROM type::table("person") '
            'WITH INDEX unique_name '
            'WHERE type::field("name") = type::string("ayush") '
            '|| type::field("name") = type::string("ash") '
            '&& type::field("age") != type::number("0") '
            'ORDER age NUMERIC DESC LIMIT type::int(5) START type::int(0) '
            'FETCH type::field("projects") TIMEOUT 5s PARALLEL;'),
      );
    });
  });

  group('Live Select', () {
    test('live select statement', () {
      expect(
          SurrealdbQueryBuilder.liveSelect(thing: const TableType('person'))
              .build(),
          equals('LIVE SELECT * FROM type::table("person");'));
    });
    test('live select value statement', () {
      expect(
          SurrealdbQueryBuilder.liveSelectValue(
                  thing: const TableType('person'), value: 'name')
              .build(),
          equals('LIVE SELECT VALUE name FROM type::table("person");'));
    });

    test('live select diff statement', () {
      expect(
          SurrealdbQueryBuilder.liveSelectDiff(thing: const TableType('person'))
              .build(),
          equals('LIVE SELECT DIFF FROM type::table("person");'));
    });
    test('live select where statement', () {
      expect(
          SurrealdbQueryBuilder.liveSelect(thing: const TableType('person'))
              .where()
              .gt(field: const FieldType('age'), value: NumberType(18.u21))
              .build(),
          equals('LIVE SELECT * FROM type::table("person") WHERE '
              'type::field("age") > type::number(18);'));
    });
    test('live select fetch statement', () {
      expect(
          SurrealdbQueryBuilder.liveSelect(thing: const TableType('person'))
              .fetch(fields: [const FieldType('projects')]).build(),
          equals('LIVE SELECT * FROM type::table("person") '
              'FETCH type::field("projects");'));
    });
    test('live select where and fetch statement', () {
      expect(
          SurrealdbQueryBuilder.liveSelect(thing: const TableType('person'))
              .where()
              .gt(field: const FieldType('age'), value: NumberType(18.u21))
              .next()
              .fetch(fields: [const FieldType('projects')]).build(),
          equals(
            'LIVE SELECT * FROM type::table("person") '
            'WHERE type::field("age") > type::number(18) '
            'FETCH type::field("projects");',
          ));
    });
  });

  group('Logical Operators', () {
    test('nco (??)', () {
      expect(
        SurrealdbQueryBuilder.select(
          thing: RawType(SurrealdbOpBuilder.raw()
              .value(value: const RawType('NULL'))
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
              .value(value: const RawType('NULL'))
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
        SurrealdbQueryBuilder.create(
            thing: const TableType('person'),
            content: {
              'name': const StringType('Tobie'),
              'company': const StringType('SurrealDB'),
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
        SurrealdbQueryBuilder.create(
            thing: const TableType('person'),
            content: {
              'name': const StringType('Tobie'),
              'company': const StringType('SurrealDB'),
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
        SurrealdbQueryBuilder.create(
            thing: const TableType('person'),
            content: {
              'name': const StringType('Tobie'),
              'company': const StringType('SurrealDB'),
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
          thing: const TableType('person'),
          only: true,
          content: {
            'name': const StringType('Tobie'),
            'company': const StringType('SurrealDB'),
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
        yield SurrealdbQueryBuilder.create(thing: const TableType(thing));
        yield SurrealdbQueryBuilder.select(thing: const TableType(thing));

        const value = 'name';
        yield SurrealdbQueryBuilder.selectValue(
            thing: const TableType(thing), value: value);
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
