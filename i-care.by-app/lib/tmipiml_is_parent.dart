enum TmipimlIsParent {
  mother,
  father,
  ;

  static const String prefix = 'TmipimlIsParent.';

  String toJson() => '$prefix$name';

  static TmipimlIsParent fromJson(String json) {
    if (!json.startsWith(prefix)) {
      throw FormatException('json must start with "$prefix"');
    }

    String name = json.substring(prefix.length);
    TmipimlIsParent res = values.byName(name);
    return res;
  }
}
