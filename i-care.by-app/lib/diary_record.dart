import 'the_most_important_person_in_my_life.dart';

class DiaryRecord {
  DiaryRecord(Map<Object, Object?> data) : _data = data;

  static const String _dateKey = 'date';
  static const String _doneKey = 'done';
  static const String _emotionsAndFeelingsOnDoneKey = 'eafOnDone';
  static const String _emotionsAndFeelingsOnWantToDoKey = 'eafOnWantToDo';
  static const String _wantToDoKey = 'wantToDo';
  static const String _whoDetailsKey = 'whoDetails';
  static const String _whoKey = 'who';

  final Map<Object, Object?> _data;

  set date(DateTime value) {
    String year = '${value.year}';
    String month = value.month < 10 ? '0${value.month}' : '${value.month}';
    String day = value.day < 10 ? '0${value.day}' : '${value.day}';

    _data[_dateKey] = '$year-$month-$day';
  }

  String? get dateAsString {
    return _data[_dateKey] as String?;
  }

  String? get done {
    if (who == TheMostImportantPersonInMyLife.several) {
      throw UnsupportedError(
          'Single done list is meaningful only if "who" is not "several".');
    }
    return _data[_doneKey] as String?;
  }

  set done(String? value) {
    if (who == TheMostImportantPersonInMyLife.several) {
      throw UnsupportedError(
          'Single done list is meaningful only if "who" is not "several".');
    }
    if (value == null) {
      _data.remove(_doneKey);
    } else {
      _data[_doneKey] = value;
    }
  }

  List<String>? get doneForSeveral {
    if (who != TheMostImportantPersonInMyLife.several) {
      throw UnsupportedError(
          'Multiple done lists are meaningful only if "who" is "several".');
    }
    return _data[_doneKey] as List<String>?;
  }

  set doneForSeveral(List<String>? value) {
    if (who != TheMostImportantPersonInMyLife.several) {
      throw UnsupportedError(
          'Multiple done lists are meaningful only if "who" is "several".');
    }
    if (value == null) {
      _data.remove(_doneKey);
    } else {
      _data[_doneKey] = value;
    }
  }

  String? get emotionsAndFeelingsOnDone {
    if (who == TheMostImportantPersonInMyLife.several) {
      throw UnsupportedError(
          'Single emotions and feelings list is meaningful only if "who" is not "several".');
    }
    return _data[_emotionsAndFeelingsOnDoneKey] as String?;
  }

  set emotionsAndFeelingsOnDone(String? value) {
    if (who == TheMostImportantPersonInMyLife.several) {
      throw UnsupportedError(
          'Single emotions and feelings list is meaningful only if "who" is not "several".');
    }
    if (value == null) {
      _data.remove(_emotionsAndFeelingsOnDoneKey);
    } else {
      _data[_emotionsAndFeelingsOnDoneKey] = value;
    }
  }

  List<String>? get emotionsAndFeelingsOnDoneForSeveral {
    if (who != TheMostImportantPersonInMyLife.several) {
      throw UnsupportedError(
          'Multiple emotions and feelings lists are meaningful only if "who" is "several".');
    }
    return _data[_emotionsAndFeelingsOnDoneKey] as List<String>?;
  }

  set emotionsAndFeelingsOnDoneForSeveral(List<String>? value) {
    if (who != TheMostImportantPersonInMyLife.several) {
      throw UnsupportedError(
          'Multiple emotions and feelings lists are meaningful only if "who" is "several".');
    }
    if (value == null) {
      _data.remove(_emotionsAndFeelingsOnDoneKey);
    } else {
      _data[_emotionsAndFeelingsOnDoneKey] = value;
    }
  }

  String? get emotionsAndFeelingsOnWantToDo {
    if (who == TheMostImportantPersonInMyLife.several) {
      throw UnsupportedError(
          'Single emotions and feelings list is meaningful only if "who" is not "several".');
    }
    return _data[_emotionsAndFeelingsOnWantToDoKey] as String?;
  }

  set emotionsAndFeelingsOnWantToDo(String? value) {
    if (who == TheMostImportantPersonInMyLife.several) {
      throw UnsupportedError(
          'Single emotions and feelings list is meaningful only if "who" is not "several".');
    }
    if (value == null) {
      _data.remove(_emotionsAndFeelingsOnWantToDoKey);
    } else {
      _data[_emotionsAndFeelingsOnWantToDoKey] = value;
    }
  }

  List<String>? get emotionsAndFeelingsOnWantToDoForSeveral {
    if (who != TheMostImportantPersonInMyLife.several) {
      throw UnsupportedError(
          'Multiple emotions and feelings lists are meaningful only if "who" is "several".');
    }
    return _data[_emotionsAndFeelingsOnWantToDoKey] as List<String>?;
  }

  set emotionsAndFeelingsOnWantToDoForSeveral(List<String>? value) {
    if (who != TheMostImportantPersonInMyLife.several) {
      throw UnsupportedError(
          'Multiple emotions and feelings lists are meaningful only if "who" is "several".');
    }
    if (value == null) {
      _data.remove(_emotionsAndFeelingsOnWantToDoKey);
    } else {
      _data[_emotionsAndFeelingsOnWantToDoKey] = value;
    }
  }

  String? get wantToDo {
    if (who == TheMostImportantPersonInMyLife.several) {
      throw UnsupportedError(
          'Single todo list is meaningful only if "who" is not "several".');
    }
    return _data[_wantToDoKey] as String?;
  }

  set wantToDo(String? value) {
    if (who == TheMostImportantPersonInMyLife.several) {
      throw UnsupportedError(
          'Single todo list is meaningful only if "who" is not "several".');
    }
    if (value == null) {
      _data.remove(_wantToDoKey);
    } else {
      _data[_wantToDoKey] = value;
    }
  }

  List<String>? get wantToDoForSeveral {
    if (who != TheMostImportantPersonInMyLife.several) {
      throw UnsupportedError(
          'Multiple todo lists are meaningful only if "who" is "several".');
    }
    return _data[_wantToDoKey] as List<String>?;
  }

  set wantToDoForSeveral(List<String>? value) {
    if (who != TheMostImportantPersonInMyLife.several) {
      throw UnsupportedError(
          'Multiple todo lists are meaningful only if "who" is "several".');
    }
    if (value == null) {
      _data.remove(_wantToDoKey);
    } else {
      _data[_wantToDoKey] = value;
    }
  }

  TheMostImportantPersonInMyLife? get who {
    return _data[_whoKey] as TheMostImportantPersonInMyLife?;
  }

  set who(TheMostImportantPersonInMyLife? value) {
    if (value == null) {
      _data.remove(_doneKey);
      _data.remove(_emotionsAndFeelingsOnDoneKey);
      _data.remove(_emotionsAndFeelingsOnWantToDoKey);
      _data.remove(_whoKey);
      _data.remove(_whoDetailsKey);
      _data.remove(_wantToDoKey);
    } else {
      _data[_whoKey] = value;

      if (value == TheMostImportantPersonInMyLife.absent ||
          value == TheMostImportantPersonInMyLife.dontKnow) {
        _data.remove(_whoDetailsKey);
        _data.remove(_wantToDoKey);
      } else if (value == TheMostImportantPersonInMyLife.me) {
        _data.remove(_whoDetailsKey);
      }

      if (value == TheMostImportantPersonInMyLife.several) {
        if (_data[_doneKey] is String) {
          _data.remove(_doneKey);
        }
        if (_data[_emotionsAndFeelingsOnDoneKey] is String) {
          _data.remove(_emotionsAndFeelingsOnDoneKey);
        }
        if (_data[_emotionsAndFeelingsOnWantToDoKey] is String) {
          _data.remove(_emotionsAndFeelingsOnWantToDoKey);
        }
        if (_data[_wantToDoKey] is String) {
          _data.remove(_wantToDoKey);
        }
      } else {
        if (_data[_doneKey] is List<String>) {
          _data.remove(_doneKey);
        }
        if (_data[_emotionsAndFeelingsOnDoneKey] is List<String>) {
          _data.remove(_emotionsAndFeelingsOnDoneKey);
        }
        if (_data[_emotionsAndFeelingsOnWantToDoKey] is List<String>) {
          _data.remove(_emotionsAndFeelingsOnWantToDoKey);
        }
        if (_data[_wantToDoKey] is List<String>) {
          _data.remove(_wantToDoKey);
        }
      }
    }
  }

  String? get whoName {
    if (who != TheMostImportantPersonInMyLife.another) {
      throw UnsupportedError('Name is meaningful only if "who" is "another".');
    }
    return _data[_whoDetailsKey] as String?;
  }

  set whoName(String? value) {
    if (who != TheMostImportantPersonInMyLife.another) {
      throw UnsupportedError('Name is meaningful only if "who" is "another".');
    }
    if (value == null) {
      _data.remove(_whoDetailsKey);
    } else {
      _data[_whoDetailsKey] = value;
    }
  }

  List<String>? get whoNames {
    if (who != TheMostImportantPersonInMyLife.several) {
      throw UnsupportedError(
          'List of names is meaningful only if "who" is "several".');
    }
    return _data[_whoDetailsKey] as List<String>?;
  }

  set whoNames(List<String>? value) {
    if (who != TheMostImportantPersonInMyLife.several) {
      throw UnsupportedError(
          'List of names is meaningful only if "who" is "several".');
    }
    if (value == null) {
      _data.remove(_whoDetailsKey);
    } else {
      _data[_whoDetailsKey] = value;
    }
  }

  Object? get whoSubclass {
    if (who != TheMostImportantPersonInMyLife.child &&
        who != TheMostImportantPersonInMyLife.grandparent &&
        who != TheMostImportantPersonInMyLife.parent &&
        who != TheMostImportantPersonInMyLife.spouseOrPartner) {
      throw UnsupportedError(
          'Subclass is meaningful only if "who" is one of ["child", "grandparent", "parent", "spouseOrPartner"].');
    }
    return _data[_whoDetailsKey];
  }

  set whoSubclass(Object? value) {
    if (who != TheMostImportantPersonInMyLife.child &&
        who != TheMostImportantPersonInMyLife.grandparent &&
        who != TheMostImportantPersonInMyLife.parent &&
        who != TheMostImportantPersonInMyLife.spouseOrPartner) {
      throw UnsupportedError(
          'Subclass is meaningful only if "who" is one of ["child", "grandparent", "parent", "spouseOrPartner"].');
    }
    if (value == null) {
      _data.remove(_whoDetailsKey);
    } else {
      _data[_whoDetailsKey] = value;
    }
  }
}
