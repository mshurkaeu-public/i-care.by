import 'dart:convert';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:icare_by_app/the_most_important_person_in_my_life.dart';
import 'package:icare_by_app/tmipiml_is_child.dart';
import 'package:icare_by_app/tmipiml_is_grandparent.dart';
import 'package:icare_by_app/tmipiml_is_parent.dart';
import 'package:icare_by_app/tmipiml_is_spouce_or_partner.dart';

import 'diary_record.dart';
import 'known_diary_states.dart';

abstract class DiaryBase {
  DiaryBase()
      : _allData = <Object, Object?>{},
        _user = <Object, Object?>{},
        _records = [] {
    _allData[_formatVersionKey] = _currentFormatVersion;
    _allData[_userKey] = _user;
    _allData[_recordsKey] = _records;
  }

  static const String _currentFormatVersion = '0.1';
  static const String _formatVersionKey = 'formatVersion';
  static const String _recordDateKey = 'date';
  static const String _recordDoneKey = 'done';
  static const String _recordEmotionsAndFeelingsOnDoneKey = 'eafOnDone';
  static const String _recordEmotionsAndFeelingsOnWantToDoKey = 'eafOnWantToDo';
  static const String _recordsKey = 'records';
  static const String _recordWantToDoKey = 'wantToDo';
  static const String _recordWhoDetailsKey = 'whoDetails';
  static const String _recordWhoKey = 'who';
  static const String _userKey = 'user';
  static const String _userLatestVisitKey = 'latestVisit';
  static const String _userNameKey = 'name';
  static const String _userPreferredPronoun = 'preferredPronoun';
  static const String _userVisitBeforeTheLatestOneKey =
      'visitBeforeTheLatestOne';

  Map<Object, Object?> _allData;
  Map<Object, Object?> _user;
  List<dynamic> _records;
  bool _hasUnsavedModifications = false;

  final String storageContainer = 'i-care.by';
  final String backupsContainer = 'i-care.by/backups';
  final String storageName = 'diary.json';
  final String storagePath = 'i-care.by/diary.json';

  static String _formatSmallPositiveIntAsTwoDigits(int n) {
    if (n >= 10) {
      return '$n';
    } else {
      return '0$n';
    }
  }

  Future<void> _moveExistingStorageToBackups() async {
    String backupLocation = '$backupsContainer/${generateBackupName()}';
    await moveExistingStorage(backupLocation);
  }

  static bool _stringIsNullOrWhitespace(String? s) {
    if (s == null) return true;

    if (s.isEmpty) return true;

    if (s.replaceAll(RegExp(r'\s+'), '').isEmpty) return true;

    return false;
  }

  String buildJson() {
    JsonEncoder jsonEncoder = JsonEncoder.withIndent('\t');
    String res = jsonEncoder.convert(_allData);
    return res;
  }

  Future<bool> get exists;

  String generateBackupName() {
    DateTime d = DateTime.now();

    String year = '${d.year}';
    String month = _formatSmallPositiveIntAsTwoDigits(d.month);
    String day = _formatSmallPositiveIntAsTwoDigits(d.day);
    String hours = _formatSmallPositiveIntAsTwoDigits(d.hour);
    String minutes = _formatSmallPositiveIntAsTwoDigits(d.minute);
    String seconds = _formatSmallPositiveIntAsTwoDigits(d.second);

    String nowAsString = '$year-$month-${day}_$hours-$minutes-$seconds';

    String backupName = '$storageName.$nowAsString.bak';

    return backupName;
  }

  String getBriefExplanationWhereToFindDiary(AppLocalizations l10n);

  String? getLatestRecordDateAsString() {
    // assumes that _records list is sorted by "date" field descently
    if (_records.isEmpty) {
      return null;
    } else {
      String? date = _records[0][_recordDateKey] as String?;
      return date;
    }
  }

  String getNotEmptyUserName(AppLocalizations l10n) {
    String? userName = _user[_userNameKey] as String?;
    String res = (userName == null || userName.isEmpty)
        ? l10n.referenceToUserWithoutName
        : userName;
    return res;
  }

  List<dynamic> getRecords() {
    return _records;
  }

  int getRecordsCount() {
    return _records.length;
  }

  DateTime? getTimeOfTheVisitBeforeTheLatestOne() {
    String? visitBeforeTheLatestOne =
        _user[_userVisitBeforeTheLatestOneKey] as String?;
    if (visitBeforeTheLatestOne == null) {
      return null;
    } else {
      DateTime res = DateTime.parse(visitBeforeTheLatestOne);
      return res;
    }
  }

  DiaryRecord getTodayRecord() {
    Map<Object, dynamic> data = <String, Object>{};
    DiaryRecord newRecord = DiaryRecord(data);
    newRecord.date = DateTime.now();
    String filter = data[_recordDateKey] as String;

    for (Map<Object, dynamic> recordData in _records) {
      if (recordData[_recordDateKey] == filter) {
        DiaryRecord res = DiaryRecord(recordData);
        return res;
      }
    }

    _records.insert(0, data);
    _hasUnsavedModifications = true;

    return newRecord;
  }

  Future<void> moveExistingStorage(String newLocation);

  Future<String> readFromStorage();

  Future<KnownDiaryStates> reloadState() async {
    //await Future.delayed(Duration(seconds: 5));
    //throw UnimplementedError('error triggered just for test');
    _allData = <Object, Object?>{};
    _user = <Object, Object?>{};
    _records = [];
    _allData[_formatVersionKey] = _currentFormatVersion;
    _allData[_userKey] = _user;
    _allData[_recordsKey] = _records;

    _hasUnsavedModifications = false;

    if (!await exists) {
      return KnownDiaryStates.doesntExist;
    }

    final String str = await readFromStorage();
    if (str.isEmpty) {
      return KnownDiaryStates.absolutelyEmpty;
    }

    Map<Object, dynamic> readData;
    try {
      readData = await json.decode(
        str,
        reviver: (Object? key, Object? value) {
          if (value == null) {
            return null;
          }

          if (key is String) {
            switch (key) {
              case _recordWhoKey:
                return TheMostImportantPersonInMyLife.fromJson(value as String);

              case _recordWhoDetailsKey:
                if (value is String) {
                  if (value.startsWith(TmipimlIsChild.prefix)) {
                    return TmipimlIsChild.fromJson(value);
                  } else if (value.startsWith(TmipimlIsGrandparent.prefix)) {
                    return TmipimlIsGrandparent.fromJson(value);
                  } else if (value.startsWith(TmipimlIsParent.prefix)) {
                    return TmipimlIsParent.fromJson(value);
                  } else if (value
                      .startsWith(TmipimlIsSpouceOrPartner.prefix)) {
                    return TmipimlIsSpouceOrPartner.fromJson(value);
                  }
                } else if (value is List<dynamic>) {
                  List<String> res = [];
                  for (String v in value) {
                    res.add(v);
                  }
                  return res;
                }
                break;

              case _recordDoneKey:
              case _recordEmotionsAndFeelingsOnDoneKey:
              case _recordEmotionsAndFeelingsOnWantToDoKey:
              case _recordWantToDoKey:
                if (value is List<dynamic>) {
                  List<String> res = [];
                  for (String v in value) {
                    res.add(v);
                  }
                  return res;
                }
            }
          }

          return value;
        },
      );
    } on FormatException {
      //the diary data is present, but cannot be decoded normally
      await _moveExistingStorageToBackups();
      return KnownDiaryStates.absolutelyEmpty;
    }

    if (readData.isEmpty) {
      return KnownDiaryStates.absolutelyEmpty;
    }

    if (readData[_formatVersionKey] == null) {
      await _moveExistingStorageToBackups();
      return KnownDiaryStates.absolutelyEmpty;
    }

    if (readData[_userKey] == null ||
        _stringIsNullOrWhitespace((readData[_userKey]
            as Map<Object, Object?>)[_userNameKey] as String?)) {
      //the diary data is not empty, but doesn't contain user's name. Not sure what it means.
      await _moveExistingStorageToBackups();
      return KnownDiaryStates.absolutelyEmpty;
    }
    //here we know that user's name is specified in the data

    if (readData[_recordsKey] == null) {
      //the diary data is not empty, but doesn't contain records list. Not sure what it means.
      await _moveExistingStorageToBackups();
      return KnownDiaryStates.absolutelyEmpty;
    }
    //here we know that user's name is specified in the data and records section is also present

    _allData = readData;
    _user = _allData[_userKey] as Map<Object, dynamic>;
    _records = _allData[_recordsKey] as List<dynamic>;

    return KnownDiaryStates.valid;
  }

  Future<void> saveModifications({DiaryRecord? modifiedRecord}) async {
    //await Future.delayed(Duration(seconds: 5));
    //throw UnimplementedError('error triggered just for test');

    if (!_hasUnsavedModifications && modifiedRecord == null) {
      return;
    }

    await saveToStorage();

    _hasUnsavedModifications = false;
  }

  Future<void> saveToStorage();

  void updateRecentVisitTime() {
    String? previousVisit = _user[_userLatestVisitKey] as String?;
    _user[_userLatestVisitKey] = DateTime.now().toIso8601String();
    if (previousVisit != null) {
      _user[_userVisitBeforeTheLatestOneKey] = previousVisit;
    }

    _hasUnsavedModifications = true;
  }

  String? get userName {
    return _user[_userNameKey] as String?;
  }

  set userName(String? value) {
    if (_user[_userNameKey] != value) {
      _user[_userNameKey] = value;
      _hasUnsavedModifications = true;
    }
  }

  String? get userPreferredPronoun {
    return _user[_userPreferredPronoun] as String?;
  }

  set userPreferredPronoun(String? value) {
    if (_user[_userPreferredPronoun] != value) {
      _user[_userPreferredPronoun] = value;
      _hasUnsavedModifications = true;
    }
  }
}

class Diary extends DiaryBase {
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
