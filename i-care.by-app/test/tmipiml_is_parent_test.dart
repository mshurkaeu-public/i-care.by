import 'package:icare_by_app/tmipiml_is_parent.dart';
import 'package:test/test.dart';

void main() {
  test(
      'toJson method should return string in format "TmipimlIsParent.<value name>"',
      () {
    expect(TmipimlIsParent.father.toJson(), 'TmipimlIsParent.father');
    expect(TmipimlIsParent.mother.toJson(), 'TmipimlIsParent.mother');
  });

  test(
      'fromJson method should convert string in format "TmipimlIsParent.<value name>" into matching TmipimlIsParent option',
      () {
    expect(TmipimlIsParent.fromJson('TmipimlIsParent.father'),
        TmipimlIsParent.father);
    expect(TmipimlIsParent.fromJson('TmipimlIsParent.mother'),
        TmipimlIsParent.mother);
  });

  test(
      'fromJson method should throw FormatException if json doesn\'t start with "TmipimlIsParent" prefix',
      () {
    expect(() => TmipimlIsParent.fromJson('mother'), throwsFormatException);
  });
}
