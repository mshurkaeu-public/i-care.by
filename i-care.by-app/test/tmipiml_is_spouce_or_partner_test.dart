import 'package:icare_by_app/tmipiml_is_spouce_or_partner.dart';
import 'package:test/test.dart';

void main() {
  test(
      'toJson method should return string in format "TmipimlIsSpouceOrPartner.<value name>"',
      () {
    expect(TmipimlIsSpouceOrPartner.boyfriend.toJson(),
        'TmipimlIsSpouceOrPartner.boyfriend');
    expect(TmipimlIsSpouceOrPartner.girlfriend.toJson(),
        'TmipimlIsSpouceOrPartner.girlfriend');
    expect(TmipimlIsSpouceOrPartner.wife.toJson(),
        'TmipimlIsSpouceOrPartner.wife');
  });

  test(
      'fromJson method should convert string in format "TmipimlIsSpouceOrPartner.<value name>" into matching TmipimlIsSpouceOrPartner option',
      () {
    expect(
        TmipimlIsSpouceOrPartner.fromJson('TmipimlIsSpouceOrPartner.boyfriend'),
        TmipimlIsSpouceOrPartner.boyfriend);
    expect(
        TmipimlIsSpouceOrPartner.fromJson(
            'TmipimlIsSpouceOrPartner.girlfriend'),
        TmipimlIsSpouceOrPartner.girlfriend);
    expect(TmipimlIsSpouceOrPartner.fromJson('TmipimlIsSpouceOrPartner.wife'),
        TmipimlIsSpouceOrPartner.wife);
  });

  test(
      'fromJson method should throw FormatException if json doesn\'t start with "TmipimlIsSpouceOrPartner" prefix',
      () {
    expect(() => TmipimlIsSpouceOrPartner.fromJson('girlfriend'),
        throwsFormatException);
  });
}
