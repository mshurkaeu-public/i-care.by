import 'package:icare_by_app/tmipiml_is_child.dart';
import 'package:test/test.dart';

void main() {
  test(
      'toJson method should return string in format "TmipimlIsChild.<value name>"',
      () {
    expect(TmipimlIsChild.daughter.toJson(), 'TmipimlIsChild.daughter');
    expect(TmipimlIsChild.son.toJson(), 'TmipimlIsChild.son');
  });

  test(
      'fromJson method should convert string in format "TmipimlIsChild.<value name>" into matching TmipimlIsChild option',
      () {
    expect(TmipimlIsChild.fromJson('TmipimlIsChild.daughter'),
        TmipimlIsChild.daughter);
    expect(TmipimlIsChild.fromJson('TmipimlIsChild.son'), TmipimlIsChild.son);
  });

  test(
      'fromJson method should throw FormatException if json doesn\'t start with "TmipimlIsChild." prefix',
      () {
    expect(() => TmipimlIsChild.fromJson('son'), throwsFormatException);
  });
}
