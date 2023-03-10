enum TmipimlIsSpouceOrPartner {
  husband,
  wife,
  boyfriend,
  girlfriend,
  ;

  static const String prefix = 'TmipimlIsSpouceOrPartner.';

  String toJson() => '$prefix$name';

  static TmipimlIsSpouceOrPartner fromJson(String json) {
    if (!json.startsWith(prefix)) {
      throw FormatException('json must start with "$prefix"');
    }

    String name = json.substring(prefix.length);
    TmipimlIsSpouceOrPartner res = values.byName(name);
    return res;
  }
}
