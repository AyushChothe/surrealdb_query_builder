part of '../../surrealdb_query_builder.dart';

extension FormatX on dynamic {
  String format() {
    if (this is List) {
      return '[${(this as List<Object>).map((e) => e.format()).join(',')}]';
    }
    return this is String ? '"$this"' : '$this';
  }
}

extension EncodeX on Map<String, SurrealDbType<dynamic>> {
  String encode() {
    // TODO(Ayush): Handle Recursive [encode]
    final jsonString =
        entries.map((e) => '"${e.key}":${e.value.format()}').join(',');

    return '{$jsonString}';
  }
}
