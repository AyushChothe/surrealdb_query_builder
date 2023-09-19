extension ListX on List<String> {
  String joinWithTrim([String sep = ', ']) =>
      map((e) => e.trim()).where((e) => e.isNotEmpty).join(sep);
}
