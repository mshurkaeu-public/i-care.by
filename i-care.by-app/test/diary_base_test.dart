import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_gen/gen_l10n/app_localizations_be.dart';
import 'package:icare_by_app/diary_platform_interface.dart';
import 'package:test/test.dart';

class _DiaryBaseTester extends DiaryBase {
  _DiaryBaseTester();

  @override
  Future<bool> get exists => throw UnimplementedError();

  @override
  String getBriefExplanationWhereToFindDiary(AppLocalizations l10n) {
    throw UnimplementedError();
  }

  @override
  Future<void> moveExistingStorage(String newLocation) {
    throw UnimplementedError();
  }

  @override
  Future<String> readFromStorage() {
    throw UnimplementedError();
  }

  @override
  Future<void> saveToStorage() {
    throw UnimplementedError();
  }
}

class _AppLocalizationsStub extends AppLocalizationsBe {
  @override
  String get referenceToUserWithoutName => 'N/A';
}

void main() {
  test('Constructor call should initialize completely empty diary', () {
    _DiaryBaseTester tester = _DiaryBaseTester();
    _AppLocalizationsStub l10n = _AppLocalizationsStub();

    expect(tester.getRecordsCount(), 0);
    expect(tester.getNotEmptyUserName(l10n), 'N/A');
    expect(tester.getTimeOfTheVisitBeforeTheLatestOne(), null);
  });
}
