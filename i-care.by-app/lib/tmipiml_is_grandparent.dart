enum TmipimlIsGrandparent {
  grandfather,
  grandmother,
  ;

  static const String prefix = 'TmipimlIsGrandparent.';

  String toJson() => '$prefix$name';

  static TmipimlIsGrandparent fromJson(String json) {
    if (!json.startsWith(prefix)) {
      throw FormatException('json must start with "$prefix"');
    }

    String name = json.substring(prefix.length);
    TmipimlIsGrandparent res = values.byName(name);
    return res;
  }
}
