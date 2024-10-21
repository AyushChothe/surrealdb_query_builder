part of '../../../../../surrealdb_query_builder.dart';

abstract class SurrealDbType<T> {
  const SurrealDbType(this.value);

  final T value;

  String toValue();

  @override
  String toString() => toValue();
}

class RawType extends SurrealDbType<Object> {
  const RawType(super.value);

  @override
  String toValue() => '$value';
}

class TableType extends SurrealDbType<String> {
  const TableType(super.value);

  @override
  String toValue() => 'type::table(${value.format()})';
}

class ArrayType<T> extends SurrealDbType<Union2<Object, List<T>, String>> {
  ArrayType(super.value) : assert(value.isValid, 'Invalid value: $value');

  @override
  String toValue() => 'type::array(${value.format()})';
}

class BoolType extends SurrealDbType<Union2<Object, bool, String>> {
  BoolType(super.value) : assert(value.isValid, 'Invalid value: $value');

  @override
  String toValue() => 'type::bool(${value.format()})';
}

class BytesType extends SurrealDbType<Union2<Object, Uint8List, String>> {
  BytesType(super.value) : assert(value.isValid, 'Invalid value: $value');

  @override
  String toValue() => 'type::bytes(${value.format()})';
}

class DateTimeType extends SurrealDbType<Union2<Object, DateTime, String>> {
  DateTimeType(super.value) : assert(value.isValid, 'Invalid value: $value');

  @override
  String toValue() {
    final isoStr = value.split((dt) => dt.toIso8601String(), (str) => str);
    return 'type::datetime(${isoStr.format()})';
  }
}

class DurationType extends SurrealDbType<Union2<Object, Duration, String>> {
  DurationType(super.value) : assert(value.isValid, 'Invalid value: $value');

  /// [Duration] in microseconds as it is the lower precision
  /// supported by [Duration] class
  @override
  String toValue() {
    final durationStr = value.split((dr) {
      return '${dr.inMicroseconds}µs';
    }, (str) => str);
    return 'type::duration(${durationStr.format()})';
  }
}

class FieldType extends SurrealDbType<String> {
  const FieldType(super.value);

  @override
  String toValue() => 'type::field(${value.format()})';
}

class PointType
    extends SurrealDbType<Union2<Object, List<double>, (double, double)>> {
  PointType(super.value)
      : assert(value.isValid, 'Invalid value: $value'),
        assert(value.is1 && value.as1.length == 2, 'Length must be 2: $value');

  @override
  String toValue() {
    return 'type::point(${value.format()})';
  }
}

class StringType extends SurrealDbType<Object> {
  const StringType(super.value);

  @override
  String toValue() => 'type::string(${value.format()})';
}

class ThingType extends SurrealDbType<(Object, Object)> {
  const ThingType(super.value);

  @override
  String toValue() =>
      'type::thing{(${value.$1.format()}, ${value.$2.format()})';
}

class RangeType extends SurrealDbType<Union2<Object, List<int>, String>> {
  RangeType(super.value)
      : assert(value.isValid, 'Invalid value: $value'),
        assert(value.is1 && value.as1.length == 2, 'Length must be 2: $value');

  @override
  String toValue() => 'type::range(${value.format()})';
}

class RecordType extends SurrealDbType<(String, String?)> {
  const RecordType(super.value);

  factory RecordType.record(String record) => RecordType((record, null));
  factory RecordType.recordWithTable(String record, String table) =>
      RecordType((record, table));

  @override
  String toValue() {
    final end = (value.$2 == null) ? '' : ', ${value.$2.format()}';
    return 'type::record(${value.$1.format()}$end)';
  }
}

class UuidType extends SurrealDbType<String> {
  const UuidType(super.value);

  @override
  String toValue() => 'type::uuid(${value.format()})';
}

// Number Types

class NumberType extends SurrealDbType<Union2<Object, num, String>> {
  NumberType(super.value) : assert(value.isValid, 'Invalid value: $value');

  @override
  String toValue() => 'type::number(${value.format()})';
}

class FloatType extends NumberType {
  FloatType(super.value);

  @override
  String toValue() => 'type::float(${value.format()})';
}

class IntType extends NumberType {
  IntType(super.value);

  @override
  String toValue() => 'type::int(${value.format()})';
}

class DecimalType extends NumberType {
  DecimalType(super.value);

  @override
  String toValue() => 'type::decimal(${value.format()})';
}
