import 'dart:io' show Directory, File;
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as path;

import 'l10n/generated/app_localizations.dart';
import 'diary_platform_interface.dart' show DiaryBase;

class Diary extends DiaryBase {
  String pathToDiaryFile = '';

  Future<File> _getDiaryFile() async {
    final Directory directory = await getApplicationDocumentsDirectory();

    pathToDiaryFile = path.join(directory.path, storagePath);

    final File diaryFile = File(pathToDiaryFile);
    return diaryFile;
  }

  @override
  Future<bool> get exists async {
    final File diaryFile = await _getDiaryFile();
    final bool res = await diaryFile.exists();

    return res;
  }

  @override
  String getBriefExplanationWhereToFindDiary(AppLocalizations l10n) {
    return l10n.briefExplanationWhereToFindDiaryIO(
        userPreferredPronoun ?? '', pathToDiaryFile);
  }

  @override
  Future<void> moveExistingStorage(String newLocation) async {
    File oldDiaryFile = await _getDiaryFile();

    if (await oldDiaryFile.exists()) {
      Directory docsDirectory = await getApplicationDocumentsDirectory();
      Directory backupsDirectory =
          Directory(path.join(docsDirectory.path, backupsContainer));
      if (!await backupsDirectory.exists()) {
        await backupsDirectory.create(recursive: true);
      }
      String newPath = path.join(docsDirectory.path, newLocation);

      await oldDiaryFile.rename(newPath);
    }
  }

  @override
  Future<String> readFromStorage() async {
    final File diaryFile = await _getDiaryFile();
    String res = await diaryFile.readAsString();

    return res;
  }

  @override
  Future<void> saveToStorage() async {
    final String json = buildJson();

    final File diaryFile = await _getDiaryFile();
    if (!await diaryFile.parent.exists()) {
      await diaryFile.parent.create(recursive: true);
    }

    await diaryFile.writeAsString(json);
  }
}
