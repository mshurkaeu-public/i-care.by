// ignore: avoid_web_libraries_in_flutter
import 'dart:html';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'diary_platform_interface.dart' show DiaryBase;

class Diary extends DiaryBase {
  final Storage _localStorage = window.localStorage;

  @override
  Future<void> moveExistingStorage(String newLocation) async {
    String? oldData = _localStorage[storagePath];
    _localStorage.remove(storagePath);

    if (oldData != null) {
      _localStorage[newLocation] = oldData;
    }
  }

  @override
  Future<bool> get exists async {
    final bool res = (_localStorage[storagePath] != null);
    return res;
  }

  @override
  String getBriefExplanationWhereToFindDiary(AppLocalizations l10n) {
    return l10n.briefExplanationWhereToFindDiaryWeb(userPreferredPronoun ?? '');
  }

  @override
  Future<String> readFromStorage() async {
    String res = _localStorage[storagePath]!;

    return res;
  }

  @override
  Future<void> saveToStorage() async {
    String json = buildJson();

    _localStorage[storagePath] = json;
  }
}
