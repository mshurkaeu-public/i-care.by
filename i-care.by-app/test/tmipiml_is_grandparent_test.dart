import 'package:icare_by_app/tmipiml_is_grandparent.dart';
import 'package:test/test.dart';

void main() {
  test(
      'toJson method should return string in format "TmipimlIsGrandparent.<value name>"',
      () {
    expect(TmipimlIsGrandparent.grandfather.toJson(),
        'TmipimlIsGrandparent.grandfather');
    expect(TmipimlIsGrandparent.grandmother.toJson(),
        'TmipimlIsGrandparent.grandmother');
  });

  test(
      'fromJson method should convert string in format "TmipimlIsGrandparent.<value name>" into matching TmipimlIsGrandparent option',
      () {
    expect(TmipimlIsGrandparent.fromJson('TmipimlIsGrandparent.grandfather'),
        TmipimlIsGrandparent.grandfather);
    expect(TmipimlIsGrandparent.fromJson('TmipimlIsGrandparent.grandmother'),
        TmipimlIsGrandparent.grandmother);
  });

  test(
      'fromJson method should throw FormatException if json doesn\'t start with "TmipimlIsGrandparent." prefix',
      () {
    expect(() => TmipimlIsGrandparent.fromJson('grandfather'),
        throwsFormatException);
  });
}
