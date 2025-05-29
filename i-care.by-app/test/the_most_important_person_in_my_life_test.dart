import 'package:icare_by_app/the_most_important_person_in_my_life.dart';
import 'package:test/test.dart';

void main() {
  test(
      'toJson method should return string in format "TheMostImportantPersonInMyLife.<value name>"',
      () {
    expect(TheMostImportantPersonInMyLife.absent.toJson(),
        'TheMostImportantPersonInMyLife.absent');
    expect(TheMostImportantPersonInMyLife.dontKnow.toJson(),
        'TheMostImportantPersonInMyLife.dontKnow');
    expect(TheMostImportantPersonInMyLife.spouseOrPartner.toJson(),
        'TheMostImportantPersonInMyLife.spouseOrPartner');
  });

  test(
      'fromJson method should convert string in format "TheMostImportantPersonInMyLife.<value name>" into matching TheMostImportantPersonInMyLife option',
      () {
    expect(
        TheMostImportantPersonInMyLife.fromJson(
            'TheMostImportantPersonInMyLife.absent'),
        TheMostImportantPersonInMyLife.absent);
    expect(
        TheMostImportantPersonInMyLife.fromJson(
            'TheMostImportantPersonInMyLife.dontKnow'),
        TheMostImportantPersonInMyLife.dontKnow);
    expect(
        TheMostImportantPersonInMyLife.fromJson(
            'TheMostImportantPersonInMyLife.spouseOrPartner'),
        TheMostImportantPersonInMyLife.spouseOrPartner);
  });

  test(
      'fromJson method should throw FormatException if json doesn\'t start with "TheMostImportantPersonInMyLife." prefix',
      () {
    expect(() => TheMostImportantPersonInMyLife.fromJson('absent'),
        throwsFormatException);
  });
}
