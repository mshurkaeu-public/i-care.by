import 'package:icare_by_app/diary_record.dart';
import 'package:icare_by_app/the_most_important_person_in_my_life.dart';
import 'package:icare_by_app/tmipiml_is_child.dart';
import 'package:icare_by_app/tmipiml_is_grandparent.dart';
import 'package:icare_by_app/tmipiml_is_parent.dart';
import 'package:icare_by_app/tmipiml_is_spouce_or_partner.dart';
import 'package:test/test.dart';

void main() {
  test('date setter should set "date" in format yyyy-mm-dd', () {
    Map<String, Object> value = <String, Object>{};
    DiaryRecord record = DiaryRecord(value);
    record.date = DateTime(2017, 9, 17);
    expect(value['date'], '2017-09-17');
  });

  group('setting who', () {
    Map<String, Object?> getNotEmptyData() {
      Map<String, Object?> data = <String, Object>{
        'who': TheMostImportantPersonInMyLife.child,
        'whoDetails': TmipimlIsChild.daughter,
        'wantToDo': '- line 1\n- line 2',
      };

      return data;
    }

    void shouldRemoveWhoDetailsAndWantToDo(
        TheMostImportantPersonInMyLife? value) {
      Map<String, Object?> data = getNotEmptyData();
      DiaryRecord record = DiaryRecord(data);

      expect(data.containsKey('whoDetails'), true);
      expect(data.containsKey('wantToDo'), true);

      record.who = value;
      expect(data.containsKey('whoDetails'), false);
      expect(data.containsKey('wantToDo'), false);
    }

    test('setting who to null should remove whoDetails and wantToDo from data',
        () {
      shouldRemoveWhoDetailsAndWantToDo(null);
    });

    test(
        'setting who to "absent" should remove whoDetails and wantToDo from data',
        () {
      shouldRemoveWhoDetailsAndWantToDo(TheMostImportantPersonInMyLife.absent);
    });

    test(
        'setting who to "dontKnow" should remove whoDetails and wantToDo from data',
        () {
      shouldRemoveWhoDetailsAndWantToDo(
          TheMostImportantPersonInMyLife.dontKnow);
    });

    test('setting who to "me" should remove whoDetails from data', () {
      Map<String, Object?> data = getNotEmptyData();
      DiaryRecord record = DiaryRecord(data);

      expect(data.containsKey('whoDetails'), true);

      record.who = TheMostImportantPersonInMyLife.me;
      expect(data.containsKey('whoDetails'), false);
    });

    test('setting who to "me" should not affect wantToDo in data', () {
      Map<String, Object?> data = getNotEmptyData();
      DiaryRecord record = DiaryRecord(data);

      String oldWantToDo = data['wantToDo'] as String;

      record.who = TheMostImportantPersonInMyLife.me;
      expect(data['wantToDo'], oldWantToDo);
    });
  });

  test('wantToDo getter should throw UnsupportedError if "who" is "several"',
      () {
    DiaryRecord record = DiaryRecord(<String, Object>{
      'who': TheMostImportantPersonInMyLife.several,
    });
    expect(() => record.wantToDo, throwsUnsupportedError);
  });

  test('wantToDo setter should throw UnsupportedError if "who" is "several"',
      () {
    DiaryRecord record = DiaryRecord(<String, Object>{
      'who': TheMostImportantPersonInMyLife.several,
    });

    String wantToDo = 'Want to do-${DateTime.now().toIso8601String()}';
    expect(() {
      record.wantToDo = wantToDo;
    }, throwsUnsupportedError);
  });

  test('wantToDo getter should return "wantToDo" value from initial data', () {
    DiaryRecord record = DiaryRecord(<String, Object?>{
      'wantToDo': null,
    });
    expect(record.wantToDo, null);

    String value = DateTime.now().toIso8601String();
    record = DiaryRecord(<String, Object>{
      'wantToDo': value,
    });
    expect(record.wantToDo, value);
  });

  test('wantToDo getter should return value set by wantToDo setter', () {
    final DiaryRecord record = DiaryRecord(<String, Object>{});

    String value = DateTime.now().toIso8601String();
    record.wantToDo = value;
    expect(record.wantToDo, value);

    record.wantToDo = null;
    expect(record.wantToDo, null);
  });

  test(
      'wantToDoForSeveral getter should throw UnsupportedError if "who" is different from "several"',
      () {
    DiaryRecord record = DiaryRecord(<String, Object?>{
      'who': null,
    });
    expect(() => record.wantToDoForSeveral, throwsUnsupportedError);

    for (TheMostImportantPersonInMyLife value
        in TheMostImportantPersonInMyLife.values) {
      if (value != TheMostImportantPersonInMyLife.several) {
        record.who = value;
        expect(() => record.wantToDoForSeveral, throwsUnsupportedError);
      }
    }
  });

  test(
      'wantToDoForSeveral setter should throw UnsupportedError if "who" is different from "several"',
      () {
    DiaryRecord record = DiaryRecord(<String, Object?>{
      'who': null,
    });

    List<String> wantToDoLists = [
      'list 1',
      'list 2',
    ];
    expect(() {
      record.wantToDoForSeveral = wantToDoLists;
    }, throwsUnsupportedError);

    for (TheMostImportantPersonInMyLife value
        in TheMostImportantPersonInMyLife.values) {
      if (value != TheMostImportantPersonInMyLife.several) {
        record.who = value;
        expect(() {
          record.wantToDoForSeveral = wantToDoLists;
        }, throwsUnsupportedError);
      }
    }
  });

  test(
      'wantToDoForSeveral getter should return "wantToDo" value from initial data',
      () {
    DiaryRecord record = DiaryRecord(<String, Object?>{
      'who': TheMostImportantPersonInMyLife.several,
      'wantToDo': null,
    });
    expect(record.wantToDoForSeveral, null);

    List<String> value = <String>[
      'Want to do for the first person list.',
      'Want to do for the second person list.',
    ];
    record = DiaryRecord(<String, Object>{
      'who': TheMostImportantPersonInMyLife.several,
      'wantToDo': value,
    });
    expect(record.wantToDoForSeveral, value);
  });

  test(
      'wantToDoForSeveral getter should return value set by wantToDoForSeveral setter',
      () {
    final DiaryRecord record = DiaryRecord(<String, Object>{
      'who': TheMostImportantPersonInMyLife.several,
    });

    List<String> value = <String>[
      '1st list',
      '2nd list',
    ];
    record.wantToDoForSeveral = value;
    expect(record.wantToDoForSeveral, value);

    record.wantToDoForSeveral = null;
    expect(record.wantToDoForSeveral, null);
  });

  test('who getter should return "who" value from initial data', () {
    DiaryRecord record = DiaryRecord(<String, Object?>{
      'who': null,
    });
    expect(record.who, null);

    for (TheMostImportantPersonInMyLife value
        in TheMostImportantPersonInMyLife.values) {
      record = DiaryRecord(<String, Object>{
        'who': value,
      });
      expect(record.who, value);
    }
  });

  test('who getter should return value set by who setter', () {
    final DiaryRecord record = DiaryRecord(<String, Object>{});

    for (TheMostImportantPersonInMyLife value
        in TheMostImportantPersonInMyLife.values) {
      record.who = value;
      expect(record.who, value);
    }

    record.who = null;
    expect(record.who, null);
  });

  test(
      'whoName getter should throw UnsupportedError if "who" is different from "another"',
      () {
    DiaryRecord record = DiaryRecord(<String, Object?>{
      'who': null,
    });
    expect(() => record.whoName, throwsUnsupportedError);

    for (TheMostImportantPersonInMyLife value
        in TheMostImportantPersonInMyLife.values) {
      if (value != TheMostImportantPersonInMyLife.another) {
        record.who = value;
        expect(() => record.whoName, throwsUnsupportedError);
      }
    }
  });

  test(
      'whoName setter should throw UnsupportedError if "who" is different from "another"',
      () {
    DiaryRecord record = DiaryRecord(<String, Object?>{
      'who': null,
    });

    String name = 'Name-${DateTime.now().toIso8601String()}';
    expect(() {
      record.whoName = name;
    }, throwsUnsupportedError);

    for (TheMostImportantPersonInMyLife value
        in TheMostImportantPersonInMyLife.values) {
      if (value != TheMostImportantPersonInMyLife.another) {
        record.who = value;
        expect(() {
          record.whoName = name;
        }, throwsUnsupportedError);
      }
    }
  });

  test('whoName getter should return "whoDetails" value from initial data', () {
    DiaryRecord record = DiaryRecord(<String, Object>{
      'who': TheMostImportantPersonInMyLife.another,
    });
    expect(record.whoName, null);

    String value = 'Name-${DateTime.now().toIso8601String()}';
    record = DiaryRecord(<String, Object>{
      'who': TheMostImportantPersonInMyLife.another,
      'whoDetails': value
    });
    expect(record.whoName, value);
  });

  test('whoName getter should return value set by whoName setter', () {
    final DiaryRecord record = DiaryRecord(<String, Object>{
      'who': TheMostImportantPersonInMyLife.another,
    });

    String value = 'Name-${DateTime.now().toIso8601String()}';
    record.whoName = value;
    expect(record.whoName, value);

    record.whoName = null;
    expect(record.whoName, null);
  });

  test(
      'whoNames getter should throw UnsupportedError if "who" is different from "several"',
      () {
    DiaryRecord record = DiaryRecord(<String, Object?>{
      'who': null,
    });
    expect(() => record.whoNames, throwsUnsupportedError);

    for (TheMostImportantPersonInMyLife value
        in TheMostImportantPersonInMyLife.values) {
      if (value != TheMostImportantPersonInMyLife.several) {
        record.who = value;
        expect(() => record.whoNames, throwsUnsupportedError);
      }
    }
  });

  test(
      'whoNames setter should throw UnsupportedError if "who" is different from "several"',
      () {
    DiaryRecord record = DiaryRecord(<String, Object?>{
      'who': null,
    });

    List<String> names = [
      'name 1',
      'name 2',
    ];
    expect(() {
      record.whoNames = names;
    }, throwsUnsupportedError);

    for (TheMostImportantPersonInMyLife value
        in TheMostImportantPersonInMyLife.values) {
      if (value != TheMostImportantPersonInMyLife.several) {
        record.who = value;
        expect(() {
          record.whoNames = names;
        }, throwsUnsupportedError);
      }
    }
  });

  test('whoNames getter should return "whoDetails" value from initial data',
      () {
    DiaryRecord record = DiaryRecord(<String, Object>{
      'who': TheMostImportantPersonInMyLife.several,
    });
    expect(record.whoNames, null);

    List<String> value = [
      'Name 1 ${DateTime.now().toIso8601String()}',
      'Name 2 ${DateTime.now().toIso8601String()}',
    ];
    record = DiaryRecord(<String, Object>{
      'who': TheMostImportantPersonInMyLife.several,
      'whoDetails': value
    });
    expect(record.whoNames, value);
  });

  test('whoNames getter should return value set by whoNames setter', () {
    final DiaryRecord record = DiaryRecord(<String, Object>{
      'who': TheMostImportantPersonInMyLife.several,
    });

    List<String> value = [
      'Name 1 ${DateTime.now().toIso8601String()}',
      'Name 2 ${DateTime.now().toIso8601String()}',
    ];
    record.whoNames = value;
    expect(record.whoNames, value);

    record.whoNames = null;
    expect(record.whoNames, null);
  });

  test(
      'whoSubclass getter should throw UnsupportedError if "who" is different from ["child", "grandparent", "parent", "spouseOrPartner"]',
      () {
    DiaryRecord record = DiaryRecord(<String, Object?>{
      'who': null,
    });
    expect(() => record.whoSubclass, throwsUnsupportedError);

    for (TheMostImportantPersonInMyLife value
        in TheMostImportantPersonInMyLife.values) {
      if (value != TheMostImportantPersonInMyLife.child &&
          value != TheMostImportantPersonInMyLife.grandparent &&
          value != TheMostImportantPersonInMyLife.parent &&
          value != TheMostImportantPersonInMyLife.spouseOrPartner) {
        record.who = value;
        expect(() => record.whoSubclass, throwsUnsupportedError);
      }
    }
  });

  test(
      'whoSubclass setter should throw UnsupportedError if "who" is different from ["child", "grandparent", "parent", "spouseOrPartner"]',
      () {
    DiaryRecord record = DiaryRecord(<String, Object?>{
      'who': null,
    });

    int subClass = 0;
    expect(() {
      record.whoSubclass = subClass;
    }, throwsUnsupportedError);

    for (TheMostImportantPersonInMyLife value
        in TheMostImportantPersonInMyLife.values) {
      if (value != TheMostImportantPersonInMyLife.child &&
          value != TheMostImportantPersonInMyLife.grandparent &&
          value != TheMostImportantPersonInMyLife.parent &&
          value != TheMostImportantPersonInMyLife.spouseOrPartner) {
        record.who = value;
        expect(() {
          record.whoSubclass = subClass;
        }, throwsUnsupportedError);
      }
    }
  });

  test('whoSubclass getter should return "whoDetails" value from initial data',
      () {
    DiaryRecord record;

    for (TheMostImportantPersonInMyLife value in [
      TheMostImportantPersonInMyLife.child,
      TheMostImportantPersonInMyLife.grandparent,
      TheMostImportantPersonInMyLife.parent,
      TheMostImportantPersonInMyLife.spouseOrPartner,
    ]) {
      record = DiaryRecord(<String, Object>{
        'who': value,
      });
      expect(record.whoSubclass, null);
    }

    for (TmipimlIsChild value in TmipimlIsChild.values) {
      record = DiaryRecord(<String, Object>{
        'who': TheMostImportantPersonInMyLife.child,
        'whoDetails': value,
      });
      expect(record.whoSubclass, value);
    }

    for (TmipimlIsGrandparent value in TmipimlIsGrandparent.values) {
      record = DiaryRecord(<String, Object>{
        'who': TheMostImportantPersonInMyLife.grandparent,
        'whoDetails': value,
      });
      expect(record.whoSubclass, value);
    }

    for (TmipimlIsParent value in TmipimlIsParent.values) {
      record = DiaryRecord(<String, Object>{
        'who': TheMostImportantPersonInMyLife.parent,
        'whoDetails': value,
      });
      expect(record.whoSubclass, value);
    }

    for (TmipimlIsSpouceOrPartner value in TmipimlIsSpouceOrPartner.values) {
      record = DiaryRecord(<String, Object>{
        'who': TheMostImportantPersonInMyLife.parent,
        'whoDetails': value,
      });
      expect(record.whoSubclass, value);
    }
  });

  test('whoSubclass getter should return value set by whoSubclass setter', () {
    DiaryRecord record;

    record = DiaryRecord(<String, Object>{
      'who': TheMostImportantPersonInMyLife.child,
    });
    for (TmipimlIsChild value in TmipimlIsChild.values) {
      record.whoSubclass = value;
      expect(record.whoSubclass, value);
    }

    record = DiaryRecord(<String, Object>{
      'who': TheMostImportantPersonInMyLife.grandparent,
    });
    for (TmipimlIsGrandparent value in TmipimlIsGrandparent.values) {
      record.whoSubclass = value;
      expect(record.whoSubclass, value);
    }

    record = DiaryRecord(<String, Object>{
      'who': TheMostImportantPersonInMyLife.parent,
    });
    for (TmipimlIsParent value in TmipimlIsParent.values) {
      record.whoSubclass = value;
      expect(record.whoSubclass, value);
    }

    record = DiaryRecord(<String, Object>{
      'who': TheMostImportantPersonInMyLife.spouseOrPartner,
    });
    for (TmipimlIsSpouceOrPartner value in TmipimlIsSpouceOrPartner.values) {
      record.whoSubclass = value;
      expect(record.whoSubclass, value);
    }
  });
}
