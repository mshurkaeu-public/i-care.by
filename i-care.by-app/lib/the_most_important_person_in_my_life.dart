/// The order of options is the same as was randomly generated for a poll https://t.me/icare_by_channel/3 on 2022-10-29
enum TheMostImportantPersonInMyLife {
  spouseOrPartner,
  parent,
  child,
  grandparent,
  another,
  several,
  dontKnow,
  me,
  absent,
  ;

  static const String prefix = 'TheMostImportantPersonInMyLife.';

  String toJson() => '$prefix$name';

  static TheMostImportantPersonInMyLife fromJson(String json) {
    if (!json.startsWith(prefix)) {
      throw FormatException('json must start with "$prefix"');
    }

    String name = json.substring(prefix.length);
    TheMostImportantPersonInMyLife res = values.byName(name);
    return res;
  }
}
