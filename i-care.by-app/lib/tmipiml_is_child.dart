enum TmipimlIsChild {
  son,
  daughter,
  ;

  static const String prefix = 'TmipimlIsChild.';

  String toJson() => '$prefix$name';

  static TmipimlIsChild fromJson(String json) {
    if (!json.startsWith(prefix)) {
      throw const FormatException('json must start with "$prefix"');
    }

    String name = json.substring(prefix.length);
    TmipimlIsChild res = values.byName(name);
    return res;
  }
}
