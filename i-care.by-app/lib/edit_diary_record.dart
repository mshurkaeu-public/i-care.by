import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:multi_split_view/multi_split_view.dart';

import 'diary_platform_interface.dart'
    if (dart.library.io) 'diary_io.dart'
    if (dart.library.html) 'diary_web.dart';
import 'diary_record.dart';
import 'messages.dart';
import 'request_not_empty_list_of_persons_names.dart';
import 'the_most_important_person_in_my_life.dart';
import 'tmipiml_is_child.dart';
import 'tmipiml_is_grandparent.dart';
import 'tmipiml_is_parent.dart';
import 'tmipiml_is_spouce_or_partner.dart';

TextStyle _getMyHintStyle(ThemeData themeData) {
  TextStyle res = TextStyle(overflow: TextOverflow.visible);
  if (themeData.textTheme.bodySmall != null) {
    res = themeData.textTheme.bodySmall!.merge(res);
  }

  return res;
}

TextStyle? _getMyReferenceTextStyle(ThemeData themeData) {
  TextStyle res = TextStyle(color: themeData.disabledColor);
  if (themeData.textTheme.bodySmall != null) {
    res = themeData.textTheme.bodySmall!.merge(res);
  }

  return res;
}

/// This button looks the same way as standard [BackButton].
/// And behaves the same way.
class _BackToPreviousQuestionButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    AppLocalizations l10n = AppLocalizations.of(context);

    return IconButton(
      icon: const BackButtonIcon(),
      tooltip: l10n.backToThePreviousQuestionButtonTooltip,
      onPressed: () {
        Navigator.maybePop(context);
      },
    );
  }
}

class _DoneButton extends StatelessWidget {
  _DoneButton(void Function() onPressed) : _onPressed = onPressed;

  final void Function() _onPressed;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.check),
      tooltip: AppLocalizations.of(context).doneButtonText,
      onPressed: _onPressed,
    );
  }
}

class EditDiaryRecord extends StatefulWidget {
  EditDiaryRecord(
    Diary diary,
    DiaryRecord diaryRecord,
    this.onSubmit,
  )   : _diary = diary,
        _diaryRecord = diaryRecord;

  final Diary _diary;
  final DiaryRecord _diaryRecord;
  final void Function(DiaryRecord) onSubmit;

  @override
  State<EditDiaryRecord> createState() => _EditDiaryRecordState();
}

class _EditDiaryRecordState extends State<EditDiaryRecord> {
  List<int> _orderOfOptions = [0, 1, 2, 3, 4, 5, 6, 7, 8];
  TheMostImportantPersonInMyLife? _theMostImportantPerson;
  late DiaryRecord _stagingDiaryRecord;
  String? _anotherPersonName;
  TmipimlIsChild? _child;
  TmipimlIsGrandparent? _grandparent;
  TmipimlIsParent? _parent;
  List<String>? _severalPersonsNames;
  TmipimlIsSpouceOrPartner? _spouceOrPartner;

  void _copyFieldsFromStagingArea(DiaryRecord toRecord,
      {required DiaryRecord fromRecord}) {
    toRecord.who = _theMostImportantPerson;

    if (toRecord.who == TheMostImportantPersonInMyLife.several) {
      toRecord.whoNames = _severalPersonsNames;

      toRecord.wantToDoForSeveral = fromRecord.wantToDoForSeveral;
      toRecord.emotionsAndFeelingsOnWantToDoForSeveral =
          fromRecord.emotionsAndFeelingsOnWantToDoForSeveral;

      toRecord.doneForSeveral = fromRecord.doneForSeveral;
      toRecord.emotionsAndFeelingsOnDoneForSeveral =
          fromRecord.emotionsAndFeelingsOnDoneForSeveral;
    } else {
      switch (toRecord.who) {
        case TheMostImportantPersonInMyLife.another:
          toRecord.whoName = _anotherPersonName;
          break;

        case TheMostImportantPersonInMyLife.child:
          toRecord.whoSubclass = _child;
          break;

        case TheMostImportantPersonInMyLife.grandparent:
          toRecord.whoSubclass = _grandparent;
          break;

        case TheMostImportantPersonInMyLife.parent:
          toRecord.whoSubclass = _parent;
          break;

        case TheMostImportantPersonInMyLife.spouseOrPartner:
          toRecord.whoSubclass = _spouceOrPartner;
          break;

        default:
      }

      toRecord.wantToDo = fromRecord.wantToDo;
      toRecord.emotionsAndFeelingsOnWantToDo =
          fromRecord.emotionsAndFeelingsOnWantToDo;

      toRecord.done = fromRecord.done;
      toRecord.emotionsAndFeelingsOnDone = fromRecord.emotionsAndFeelingsOnDone;
    }
  }

  String Function(String, String) _getMessageToTheUserProvider() {
    AppLocalizations l10n = AppLocalizations.of(context);

    String Function(String, String) res;
    switch (_theMostImportantPerson) {
      case TheMostImportantPersonInMyLife.absent:
        res = l10n.messageWhenTmipiylIsAbsent;
        break;

      case TheMostImportantPersonInMyLife.dontKnow:
        res = l10n.messageWhenTmipiylIsUknownToUser;
        break;

      default:
        throw UnimplementedError();
    }
    return res;
  }

  Widget _nextButtonIfTrue(bool condition, AppLocalizations l10n) {
    if (condition) {
      return Padding(
        padding: EdgeInsets.only(top: 10),
        child: ElevatedButton(
          onPressed: _onSubmitFirstScreen,
          child: Text(l10n.nextButtonText),
        ),
      );
    } else {
      return SizedBox();
    }
  }

  void _onChildChanged(TmipimlIsChild? value) {
    setState(() {
      _child = value;
    });

    _copyFieldsFromStagingArea(_stagingDiaryRecord,
        fromRecord: _stagingDiaryRecord);

    _onSubmitFirstScreen();
  }

  void _onFinalSubmit() {
    DiaryRecord theRecord = widget._diaryRecord;
    _copyFieldsFromStagingArea(theRecord, fromRecord: _stagingDiaryRecord);

    widget.onSubmit(widget._diaryRecord);
  }

  void _onGrandparentChanged(TmipimlIsGrandparent? value) {
    setState(() {
      _grandparent = value;
    });

    _copyFieldsFromStagingArea(_stagingDiaryRecord,
        fromRecord: _stagingDiaryRecord);

    _onSubmitFirstScreen();
  }

  void _onParentChanged(TmipimlIsParent? value) {
    setState(() {
      _parent = value;
    });

    _copyFieldsFromStagingArea(_stagingDiaryRecord,
        fromRecord: _stagingDiaryRecord);

    _onSubmitFirstScreen();
  }

  void _onSpouceOrPartnerChanged(TmipimlIsSpouceOrPartner? value) {
    setState(() {
      _spouceOrPartner = value;
    });

    _copyFieldsFromStagingArea(_stagingDiaryRecord,
        fromRecord: _stagingDiaryRecord);

    _onSubmitFirstScreen();
  }

  void _onSubmitAnotherPersonName(String value) {
    _anotherPersonName = value;

    _copyFieldsFromStagingArea(_stagingDiaryRecord,
        fromRecord: _stagingDiaryRecord);

    _onSubmitFirstScreen();
  }

  void _onSubmitFirstScreen() {
    AppLocalizations l10n = AppLocalizations.of(context);
    String userName = widget._diary.getNotEmptyUserName(l10n);
    String userPreferredPronoun = widget._diary.userPreferredPronoun ?? '';

    Widget secondScreen;
    switch (_theMostImportantPerson!) {
      case TheMostImportantPersonInMyLife.absent:
      case TheMostImportantPersonInMyLife.dontKnow:
        secondScreen = _MessageToTheUser(
          userName,
          userPreferredPronoun,
          _getMessageToTheUserProvider(),
          _stagingDiaryRecord,
          onDoneButtonPressed: _onFinalSubmit,
          onNextButtonPressed: _onSubmitSecondScreen,
        );
        break;

      case TheMostImportantPersonInMyLife.another:
      case TheMostImportantPersonInMyLife.child:
      case TheMostImportantPersonInMyLife.grandparent:
      case TheMostImportantPersonInMyLife.me:
      case TheMostImportantPersonInMyLife.parent:
      case TheMostImportantPersonInMyLife.spouseOrPartner:
        secondScreen = _WhatDoYouWantToDoForThePerson(
          userName,
          userPreferredPronoun,
          _stagingDiaryRecord,
          onDoneButtonPressed: _onFinalSubmit,
          onNextButtonPressed: _onSubmitSecondScreen,
        );
        break;

      case TheMostImportantPersonInMyLife.several:
        secondScreen = _WhatDoYouWantToDoForThePersons(
          userName,
          userPreferredPronoun,
          _stagingDiaryRecord,
          onDoneButtonPressed: _onFinalSubmit,
          onNextButtonPressed: _onSubmitSecondScreen,
        );
        break;
    }

    NavigatorState navigator = Navigator.of(context);
    navigator.push(
      MaterialPageRoute(
        builder: (BuildContext context) => secondScreen,
      ),
    );
  }

  void _onSubmitSecondScreen() {
    AppLocalizations l10n = AppLocalizations.of(context);
    String userName = widget._diary.getNotEmptyUserName(l10n);
    String userPreferredPronoun = widget._diary.userPreferredPronoun ?? '';

    NavigatorState navigator = Navigator.of(context);
    Widget thirdScreen;
    switch (_theMostImportantPerson!) {
      case TheMostImportantPersonInMyLife.absent:
      case TheMostImportantPersonInMyLife.dontKnow:
        thirdScreen = _WhatsIsDoneForYourselfWithoutWantedToDo(
          userName: userName,
          userPreferredPronoun: userPreferredPronoun,
          diaryRecord: _stagingDiaryRecord,
          onDoneButtonPressed: _onFinalSubmit,
        );
        break;

      case TheMostImportantPersonInMyLife.another:
      case TheMostImportantPersonInMyLife.child:
      case TheMostImportantPersonInMyLife.grandparent:
      case TheMostImportantPersonInMyLife.me:
      case TheMostImportantPersonInMyLife.parent:
      case TheMostImportantPersonInMyLife.spouseOrPartner:
        thirdScreen = _WhatsIsDoneForThePerson(
          userName: userName,
          userPreferredPronoun: userPreferredPronoun,
          diaryRecord: _stagingDiaryRecord,
          onDoneButtonPressed: _onFinalSubmit,
        );
        break;

      case TheMostImportantPersonInMyLife.several:
        thirdScreen = _WhatIsDoneForThePersons(
          userName,
          userPreferredPronoun,
          _stagingDiaryRecord,
          onDoneButtonPressed: _onFinalSubmit,
        );
        break;
    }

    navigator.push(
      MaterialPageRoute(
        builder: (BuildContext context) => thirdScreen,
      ),
    );
  }

  void _onSubmitSeveralPersonsNames(String value) {
    _severalPersonsNames = [];
    for (String personName in value.split('\n')) {
      personName = personName.trim();
      if (personName.isNotEmpty) {
        _severalPersonsNames!.add(personName);
      }
    }

    _copyFieldsFromStagingArea(_stagingDiaryRecord,
        fromRecord: _stagingDiaryRecord);

    _onSubmitFirstScreen();
  }

  void _onTmipimlChanged(TheMostImportantPersonInMyLife? value) {
    setState(() {
      _theMostImportantPerson = value;
      // the next line is expected to null corresponding properties of the DiaryRecord instance if required
      _stagingDiaryRecord.who = value;
      _anotherPersonName = null;
      _child = null;
      _grandparent = null;
      _parent = null;
      _severalPersonsNames = null;
      _spouceOrPartner = null;
    });
  }

  void _onTmipiylOptionWithNoSuboptionsSelected(
      TheMostImportantPersonInMyLife? value) {
    _onTmipimlChanged(value);

    _copyFieldsFromStagingArea(_stagingDiaryRecord,
        fromRecord: _stagingDiaryRecord);

    _onSubmitFirstScreen();
  }

  @override
  Widget build(BuildContext context) {
    AppLocalizations l10n = AppLocalizations.of(context);
    String userName = widget._diary.getNotEmptyUserName(l10n);
    String userPreferredPronoun = widget._diary.userPreferredPronoun ?? '';

    List<Widget> options = <Widget>[
      RadioListTile<TheMostImportantPersonInMyLife>(
        title: _theMostImportantPerson ==
                TheMostImportantPersonInMyLife.spouseOrPartner
            ? Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(l10n.theMipiylOption_spouseOrPartner),
                  RadioListTile<TmipimlIsSpouceOrPartner>(
                    title: Text(l10n.spouseOrPartnerOption_husband),
                    value: TmipimlIsSpouceOrPartner.husband,
                    groupValue: _spouceOrPartner,
                    onChanged: _onSpouceOrPartnerChanged,
                  ),
                  RadioListTile<TmipimlIsSpouceOrPartner>(
                    title: Text(l10n.spouseOrPartnerOption_wife),
                    value: TmipimlIsSpouceOrPartner.wife,
                    groupValue: _spouceOrPartner,
                    onChanged: _onSpouceOrPartnerChanged,
                  ),
                  RadioListTile<TmipimlIsSpouceOrPartner>(
                    title: Text(l10n.spouseOrPartnerOption_boyfriend),
                    value: TmipimlIsSpouceOrPartner.boyfriend,
                    groupValue: _spouceOrPartner,
                    onChanged: _onSpouceOrPartnerChanged,
                  ),
                  RadioListTile<TmipimlIsSpouceOrPartner>(
                    title: Text(l10n.spouseOrPartnerOption_girlfriend),
                    value: TmipimlIsSpouceOrPartner.girlfriend,
                    groupValue: _spouceOrPartner,
                    onChanged: _onSpouceOrPartnerChanged,
                  ),
                  _nextButtonIfTrue(_spouceOrPartner != null, l10n),
                ],
              )
            : Text(l10n.theMipiylOption_spouseOrPartner),
        value: TheMostImportantPersonInMyLife.spouseOrPartner,
        groupValue: _theMostImportantPerson,
        onChanged: _onTmipimlChanged,
      ), // spouseOrPartner
      RadioListTile<TheMostImportantPersonInMyLife>(
        title: _theMostImportantPerson == TheMostImportantPersonInMyLife.parent
            ? Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(l10n.theMipiylOption_parent),
                  RadioListTile<TmipimlIsParent>(
                    title: Text(l10n.parentOption_mother),
                    value: TmipimlIsParent.mother,
                    groupValue: _parent,
                    onChanged: _onParentChanged,
                  ),
                  RadioListTile<TmipimlIsParent>(
                    title: Text(l10n.parentOption_father),
                    value: TmipimlIsParent.father,
                    groupValue: _parent,
                    onChanged: _onParentChanged,
                  ),
                  _nextButtonIfTrue(_parent != null, l10n),
                ],
              )
            : Text(l10n.theMipiylOption_parent),
        value: TheMostImportantPersonInMyLife.parent,
        groupValue: _theMostImportantPerson,
        onChanged: _onTmipimlChanged,
      ), // parent
      RadioListTile<TheMostImportantPersonInMyLife>(
        title: _theMostImportantPerson == TheMostImportantPersonInMyLife.child
            ? Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(l10n.theMipiylOption_child),
                  RadioListTile<TmipimlIsChild>(
                    title: Text(l10n.childOption_son),
                    value: TmipimlIsChild.son,
                    groupValue: _child,
                    onChanged: _onChildChanged,
                  ),
                  RadioListTile<TmipimlIsChild>(
                    title: Text(l10n.childOption_daughter),
                    value: TmipimlIsChild.daughter,
                    groupValue: _child,
                    onChanged: _onChildChanged,
                  ),
                  _nextButtonIfTrue(_child != null, l10n),
                ],
              )
            : Text(l10n.theMipiylOption_child),
        value: TheMostImportantPersonInMyLife.child,
        groupValue: _theMostImportantPerson,
        onChanged: _onTmipimlChanged,
      ), // child
      RadioListTile<TheMostImportantPersonInMyLife>(
        title: _theMostImportantPerson ==
                TheMostImportantPersonInMyLife.grandparent
            ? Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(l10n.theMipiylOption_grandparent),
                  RadioListTile<TmipimlIsGrandparent>(
                    title: Text(l10n.grandparentOption_grandfather),
                    value: TmipimlIsGrandparent.grandfather,
                    groupValue: _grandparent,
                    onChanged: _onGrandparentChanged,
                  ),
                  RadioListTile<TmipimlIsGrandparent>(
                    title: Text(l10n.grandparentOption_grandmother),
                    value: TmipimlIsGrandparent.grandmother,
                    groupValue: _grandparent,
                    onChanged: _onGrandparentChanged,
                  ),
                  _nextButtonIfTrue(_grandparent != null, l10n),
                ],
              )
            : Text(l10n.theMipiylOption_grandparent),
        value: TheMostImportantPersonInMyLife.grandparent,
        groupValue: _theMostImportantPerson,
        onChanged: _onTmipimlChanged,
      ), //grandparent
      RadioListTile<TheMostImportantPersonInMyLife>(
        title: _theMostImportantPerson == TheMostImportantPersonInMyLife.another
            ? RequestNotEmptyListOfPersonsNames(
                initialValue: _anotherPersonName ?? '',
                introductoryText: l10n.theMipiylOption_another,
                hintForInputField: l10n.hintForAnotherPersonNameRequest,
                messageIfListIsEmpty:
                    l10n.askUserToSpecifyNotEmptyAnotherPersonName(
                        userName, userPreferredPronoun),
                onSubmitNames: _onSubmitAnotherPersonName,
              )
            : Text(l10n.theMipiylOption_another),
        value: TheMostImportantPersonInMyLife.another,
        groupValue: _theMostImportantPerson,
        onChanged: _onTmipimlChanged,
      ), // another
      RadioListTile<TheMostImportantPersonInMyLife>(
        title: _theMostImportantPerson == TheMostImportantPersonInMyLife.several
            ? RequestNotEmptyListOfPersonsNames(
                initialValue: (_severalPersonsNames == null)
                    ? ''
                    : _severalPersonsNames!.join('\n'),
                introductoryText: l10n.theMipiylOption_several,
                maxLines: 7,
                //if only one name is required then option "another" is preferred to be used
                minLines: 2,
                minNames: 2,
                hintForInputField: l10n.hintForSeveralPersonsNamesRequest,
                messageIfListIsEmpty:
                    l10n.askUserToSpecifyNotEmptyListOfPersonsNames(
                        userName, userPreferredPronoun),
                messageIfThereAreTooFewNames:
                    l10n.askUserToSpecifyAtLeastTwoPersonsNames(
                        userName, userPreferredPronoun),
                onSubmitNames: _onSubmitSeveralPersonsNames,
              )
            : Text(l10n.theMipiylOption_several),
        value: TheMostImportantPersonInMyLife.several,
        groupValue: _theMostImportantPerson,
        onChanged: _onTmipimlChanged,
      ), //several
      RadioListTile<TheMostImportantPersonInMyLife>(
        title:
            _theMostImportantPerson == TheMostImportantPersonInMyLife.dontKnow
                ? Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(l10n.theMipiylOption_dontKnow),
                      _nextButtonIfTrue(true, l10n),
                    ],
                  )
                : Text(l10n.theMipiylOption_dontKnow),
        value: TheMostImportantPersonInMyLife.dontKnow,
        groupValue: _theMostImportantPerson,
        onChanged: _onTmipiylOptionWithNoSuboptionsSelected,
      ), //dontKnow
      RadioListTile<TheMostImportantPersonInMyLife>(
        title: _theMostImportantPerson == TheMostImportantPersonInMyLife.me
            ? Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(l10n.theMipiylOption_you),
                  _nextButtonIfTrue(true, l10n),
                ],
              )
            : Text(l10n.theMipiylOption_you),
        value: TheMostImportantPersonInMyLife.me,
        groupValue: _theMostImportantPerson,
        onChanged: _onTmipiylOptionWithNoSuboptionsSelected,
      ), // me
      RadioListTile<TheMostImportantPersonInMyLife>(
        title: _theMostImportantPerson == TheMostImportantPersonInMyLife.absent
            ? Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(l10n.theMipiylOption_absent),
                  _nextButtonIfTrue(true, l10n),
                ],
              )
            : Text(l10n.theMipiylOption_absent),
        value: TheMostImportantPersonInMyLife.absent,
        groupValue: _theMostImportantPerson,
        onChanged: _onTmipiylOptionWithNoSuboptionsSelected,
      ), // absent
    ];

    List<Widget> shuffledOptions = <Widget>[];
    for (int i in _orderOfOptions) {
      shuffledOptions.add(options[i]);
    }

    String question = l10n.whoIsTheMostImportantPersonInYourLife(
      userName,
      userPreferredPronoun,
    );

    return Scaffold(
      appBar: AppBar(
        title: Text(question),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.all(20),
            child: Text(
              l10n.whoIsTheMostImportantPersonInYourLife(
                  userName, userPreferredPronoun),
              style: Theme.of(context).textTheme.titleMedium,
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: shuffledOptions,
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  void initState() {
    super.initState();

    _orderOfOptions.shuffle();

    DiaryRecord data = widget._diaryRecord;
    _theMostImportantPerson = data.who;
    bool autoSubmitFirstScreen = false;
    bool autoSubmitSecondScreen = false;
    switch (_theMostImportantPerson) {
      case null:
        break;

      case TheMostImportantPersonInMyLife.absent:
        autoSubmitFirstScreen = true;
        autoSubmitSecondScreen = autoSubmitFirstScreen &&
            (data.emotionsAndFeelingsOnWantToDo != null ||
                data.done != null ||
                data.emotionsAndFeelingsOnDone != null);
        break;

      case TheMostImportantPersonInMyLife.another:
        _anotherPersonName = data.whoName;
        autoSubmitFirstScreen = (_anotherPersonName != null);
        autoSubmitSecondScreen = autoSubmitFirstScreen &&
            ((data.emotionsAndFeelingsOnWantToDo != null &&
                    data.wantToDo != null) ||
                data.done != null ||
                data.emotionsAndFeelingsOnDone != null);
        break;

      case TheMostImportantPersonInMyLife.child:
        _child = data.whoSubclass as TmipimlIsChild;
        autoSubmitFirstScreen = (_child != null);
        autoSubmitSecondScreen = autoSubmitFirstScreen &&
            ((data.emotionsAndFeelingsOnWantToDo != null &&
                    data.wantToDo != null) ||
                data.done != null ||
                data.emotionsAndFeelingsOnDone != null);
        break;

      case TheMostImportantPersonInMyLife.dontKnow:
        autoSubmitFirstScreen = true;
        autoSubmitSecondScreen = autoSubmitFirstScreen &&
            (data.emotionsAndFeelingsOnWantToDo != null ||
                data.done != null ||
                data.emotionsAndFeelingsOnDone != null);
        break;

      case TheMostImportantPersonInMyLife.grandparent:
        _grandparent = data.whoSubclass as TmipimlIsGrandparent;
        autoSubmitFirstScreen = (_grandparent != null);
        autoSubmitSecondScreen = autoSubmitFirstScreen &&
            ((data.emotionsAndFeelingsOnWantToDo != null &&
                    data.wantToDo != null) ||
                data.done != null ||
                data.emotionsAndFeelingsOnDone != null);
        break;

      case TheMostImportantPersonInMyLife.me:
        autoSubmitFirstScreen = true;
        autoSubmitSecondScreen = autoSubmitFirstScreen &&
            ((data.emotionsAndFeelingsOnWantToDo != null &&
                    data.wantToDo != null) ||
                data.done != null ||
                data.emotionsAndFeelingsOnDone != null);
        break;

      case TheMostImportantPersonInMyLife.parent:
        _parent = data.whoSubclass as TmipimlIsParent;
        autoSubmitFirstScreen = (_parent != null);
        autoSubmitSecondScreen = autoSubmitFirstScreen &&
            ((data.emotionsAndFeelingsOnWantToDo != null &&
                    data.wantToDo != null) ||
                data.done != null ||
                data.emotionsAndFeelingsOnDone != null);
        break;

      case TheMostImportantPersonInMyLife.several:
        _severalPersonsNames = data.whoNames;
        autoSubmitFirstScreen =
            (_severalPersonsNames != null && _severalPersonsNames!.length > 1);
        break;

      case TheMostImportantPersonInMyLife.spouseOrPartner:
        _spouceOrPartner = data.whoSubclass as TmipimlIsSpouceOrPartner;
        autoSubmitFirstScreen = (_spouceOrPartner != null);
        autoSubmitSecondScreen = autoSubmitFirstScreen &&
            ((data.emotionsAndFeelingsOnWantToDo != null &&
                    data.wantToDo != null) ||
                data.done != null ||
                data.emotionsAndFeelingsOnDone != null);
        break;
    }

    _stagingDiaryRecord = DiaryRecord({});
    _copyFieldsFromStagingArea(_stagingDiaryRecord, fromRecord: data);

    if (autoSubmitFirstScreen) {
      if (autoSubmitSecondScreen) {
        Timer(
          Duration(seconds: 0),
          () {
            _onSubmitFirstScreen();
            _onSubmitSecondScreen();
          },
        );
      } else {
        Timer(
          Duration(seconds: 0),
          _onSubmitFirstScreen,
        );
      }
    }
  }
}

class _EmotionsAndFeelingsRequest extends StatelessWidget {
  _EmotionsAndFeelingsRequest({
    required this.controller,
    required this.userName,
    required this.userPreferredPronoun,
  });

  final TextEditingController controller;
  final String userName;
  final String userPreferredPronoun;

  @override
  Widget build(BuildContext context) {
    AppLocalizations l10n = AppLocalizations.of(context);
    ThemeData themeData = Theme.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          l10n.questionAboutCurrentEmotionsAndFeelings(
            userName,
            userPreferredPronoun,
          ),
        ),
        SizedBox(height: 10),
        Expanded(
          child: TextField(
            controller: controller,
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              hintText: l10n.questionAboutCurrentEmotionsAndFeelingsHints(
                userName,
                userPreferredPronoun,
              ),
              hintStyle: _getMyHintStyle(themeData),
            ),
            maxLines: null,
            expands: true,
            textAlignVertical: TextAlignVertical.top,
          ),
        ),
      ],
    );
  }
}

class _MessageToTheUser extends _OneEmotionsAndFeelingsRequestContainer {
  _MessageToTheUser(
    String userName,
    String userPreferredPronoun,
    String Function(String, String) messageProvider,
    DiaryRecord diaryRecord, {
    required super.onDoneButtonPressed,
    required super.onNextButtonPressed,
  })  : _messageProvider = messageProvider,
        super(userName, userPreferredPronoun, diaryRecord, 0.8);

  final String Function(String, String) _messageProvider;

  @override
  State<StatefulWidget> createState() => _MessageToTheUserState();
}

class _MessageToTheUserState
    extends _OneEmotionsAndFeelingsRequestContainerState {
  @override
  void _onDoneButtonPressed() {
    super._onDoneButtonPressed();

    widget.onDoneButtonPressed();
  }

  @override
  void _onNextButtonPressed() {
    super._onNextButtonPressed();

    widget.onNextButtonPressed();
  }

  @override
  Widget getAppBarTitle(AppLocalizations l10n) {
    String question = l10n.questionAboutCurrentEmotionsAndFeelings(
      widget._userName,
      widget._userPreferredPronoun,
    );
    return Text(question);
  }

  @override
  Widget getFirstColumnChild(AppLocalizations l10n) {
    _MessageToTheUser w = (widget as _MessageToTheUser);
    return SingleChildScrollView(
      child: Text(w._messageProvider(w._userName, w._userPreferredPronoun)),
    );
  }
}

abstract class _OneEmotionsAndFeelingsRequestContainer extends StatefulWidget {
  _OneEmotionsAndFeelingsRequestContainer(
    String userName,
    String userPreferredPronoun,
    this.diaryRecord,
    double firstColumnInitialWeight, {
    required this.onDoneButtonPressed,
    required this.onNextButtonPressed,
  })  : _firstColumnInitialWeight = firstColumnInitialWeight,
        _userName = userName,
        _userPreferredPronoun = userPreferredPronoun;

  final double _firstColumnInitialWeight;
  final String _userName;
  final String _userPreferredPronoun;

  final DiaryRecord diaryRecord;
  final void Function() onDoneButtonPressed;
  final void Function() onNextButtonPressed;
}

abstract class _OneEmotionsAndFeelingsRequestContainerState
    extends State<_OneEmotionsAndFeelingsRequestContainer> {
  final TextEditingController _emotionsAndFeelingsController =
      TextEditingController();

  _saveEmotionsAndFeelingsIntoDiaryRecord() {
    String? emotionsAndFeelings = _emotionsAndFeelingsController.text;
    if (emotionsAndFeelings.isEmpty) {
      emotionsAndFeelings = null;
    }

    widget.diaryRecord.emotionsAndFeelingsOnWantToDo = emotionsAndFeelings;
  }

  @override
  Widget build(BuildContext context) {
    AppLocalizations l10n = AppLocalizations.of(context);

    return Scaffold(
      appBar: AppBar(
        leading: _BackToPreviousQuestionButton(),
        title: getAppBarTitle(l10n),
        actions: [
          _ToTheListOfDoneButton(_onNextButtonPressed),
          _DoneButton(_onDoneButtonPressed),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.all(20),
        child: _TwoAreasSplitView(
          axis: Axis.horizontal,
          initialFirstAreaWeight: widget._firstColumnInitialWeight,
          firstArea: getFirstColumnChild(l10n),
          secondArea: _EmotionsAndFeelingsRequest(
            controller: _emotionsAndFeelingsController,
            userName: widget._userName,
            userPreferredPronoun: widget._userPreferredPronoun,
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _emotionsAndFeelingsController.dispose();

    super.dispose();
  }

  Widget getAppBarTitle(AppLocalizations l10n);

  Widget getFirstColumnChild(AppLocalizations l10n);

  @override
  void initState() {
    super.initState();

    if (widget.diaryRecord.emotionsAndFeelingsOnWantToDo != null) {
      _emotionsAndFeelingsController.text =
          widget.diaryRecord.emotionsAndFeelingsOnWantToDo!;
    }
  }

  void _onDoneButtonPressed() {
    _saveEmotionsAndFeelingsIntoDiaryRecord();
  }

  void _onNextButtonPressed() {
    _saveEmotionsAndFeelingsIntoDiaryRecord();
  }
}

class _ToTheListOfDoneButton extends StatelessWidget {
  _ToTheListOfDoneButton(void Function() onPressed) : _onPressed = onPressed;

  final void Function() _onPressed;

  /// Returns the appropriate "back" icon for the given `platform`.
  static IconData _getIconData(TargetPlatform platform) {
    switch (platform) {
      case TargetPlatform.android:
      case TargetPlatform.fuchsia:
      case TargetPlatform.linux:
      case TargetPlatform.windows:
        return Icons.arrow_forward;
      case TargetPlatform.iOS:
      case TargetPlatform.macOS:
        return Icons.arrow_forward_ios;
    }
  }

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(_getIconData(Theme.of(context).platform)),
      tooltip: AppLocalizations.of(context).nextToTheListOfDoneButtonText,
      onPressed: _onPressed,
    );
  }
}

class _TwoAreasSplitView extends StatefulWidget {
  _TwoAreasSplitView({
    required this.axis,
    required this.firstArea,
    required this.initialFirstAreaWeight,
    required this.secondArea,
  });

  final Axis axis;
  final Widget firstArea;
  final double initialFirstAreaWeight;
  final Widget secondArea;

  @override
  State<StatefulWidget> createState() => _TwoAreasSplitViewState();
}

class _TwoAreasSplitViewState extends State<_TwoAreasSplitView> {
  MultiSplitViewController _multiSplitViewController =
      MultiSplitViewController();

  void _onDividerDoubleTap(int dividerIndex) {
    _restoreDefaultColumnsWeights();
  }

  void _restoreDefaultColumnsWeights() {
    _multiSplitViewController.areas = [
      Area(
        weight: widget.initialFirstAreaWeight,
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    ThemeData themeData = Theme.of(context);

    return MultiSplitViewTheme(
      data: MultiSplitViewThemeData(
        dividerPainter: DividerPainters.dashed(
          color: themeData.dividerColor,
          highlightedColor: themeData.indicatorColor,
          thickness: 3,
        ),
      ),
      child: MultiSplitView(
        axis: widget.axis,
        controller: _multiSplitViewController,
        onDividerDoubleTap: _onDividerDoubleTap,
        children: [
          Padding(
            padding: (widget.axis == Axis.horizontal)
                ? EdgeInsets.only(right: 9)
                : EdgeInsets.only(bottom: 9),
            child: widget.firstArea,
          ),
          Padding(
            padding: (widget.axis == Axis.horizontal)
                ? EdgeInsets.only(left: 9)
                : EdgeInsets.only(top: 9),
            child: widget.secondArea,
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _multiSplitViewController.dispose();

    super.dispose();
  }

  @override
  void initState() {
    super.initState();

    _restoreDefaultColumnsWeights();
  }
}

class _WhatDoYouWantToDoForThePerson
    extends _OneEmotionsAndFeelingsRequestContainer {
  _WhatDoYouWantToDoForThePerson(
    String userName,
    String userPreferredPronoun,
    DiaryRecord diaryRecord, {
    required super.onDoneButtonPressed,
    required super.onNextButtonPressed,
  }) : super(userName, userPreferredPronoun, diaryRecord, 0.6);

  @override
  State<StatefulWidget> createState() => _WhatDoYouWantToDoForThePersonState();
}

class _WhatDoYouWantToDoForThePersonState
    extends _OneEmotionsAndFeelingsRequestContainerState {
  final TextEditingController _wantToDoController = TextEditingController();

  String _getTheQuestion(AppLocalizations l10n) {
    String res = Messages.whatDoYouWantToDo(
      widget.diaryRecord,
      l10n,
      widget._userName,
      widget._userPreferredPronoun,
    );

    return res;
  }

  @override
  void _onDoneButtonPressed() {
    _saveWantToDoIntoDiaryRecord();

    super._onDoneButtonPressed();

    widget.onDoneButtonPressed();
  }

  @override
  void _onNextButtonPressed() {
    _saveWantToDoIntoDiaryRecord();

    super._onNextButtonPressed();

    widget.onNextButtonPressed();
  }

  void _saveWantToDoIntoDiaryRecord() {
    String? wantToDo = _wantToDoController.text;
    if (wantToDo.isEmpty) {
      wantToDo = null;
    }
    widget.diaryRecord.wantToDo = wantToDo;
  }

  @override
  void dispose() {
    _wantToDoController.dispose();

    super.dispose();
  }

  @override
  Widget getAppBarTitle(AppLocalizations l10n) {
    String question = _getTheQuestion(l10n);
    return Text(question);
  }

  @override
  Widget getFirstColumnChild(AppLocalizations l10n) {
    String question = _getTheQuestion(l10n);
    ThemeData themeData = Theme.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          question,
          //style: Theme.of(context).textTheme.titleMedium,
        ),
        SizedBox(height: 10),
        Expanded(
          child: TextField(
            controller: _wantToDoController,
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              hintText: l10n.exampleOfWantToDoForTmipiml,
              hintStyle: _getMyHintStyle(themeData),
            ),
            maxLines: null,
            expands: true,
            textAlignVertical: TextAlignVertical.top,
          ),
        ),
      ],
    );
  }

  @override
  void initState() {
    super.initState();

    if (widget.diaryRecord.wantToDo != null) {
      _wantToDoController.text = widget.diaryRecord.wantToDo!;
    }
  }
}

class _WhatDoYouWantToDoForThePersons extends StatefulWidget {
  _WhatDoYouWantToDoForThePersons(
    String userName,
    String userPreferredPronoun,
    this.diaryRecord, {
    required this.onDoneButtonPressed,
    required this.onNextButtonPressed,
  })  : _userName = userName,
        _userPreferredPronoun = userPreferredPronoun;

  final String _userPreferredPronoun;
  final String _userName;

  final DiaryRecord diaryRecord;
  final void Function() onDoneButtonPressed;
  final void Function() onNextButtonPressed;

  @override
  State<_WhatDoYouWantToDoForThePersons> createState() =>
      _WhatDoYouWantToDoForThePersonsState();
}

class _WhatDoYouWantToDoForThePersonsState
    extends State<_WhatDoYouWantToDoForThePersons> {
  late final List<String> _persons;
  final List<TextEditingController> _wantToDoControllers = [];
  final List<TextEditingController> _emotionsAndFeelingsOnWantToDoControllers =
      [];

  void _onDoneButtonPressed() {
    _saveWantToDoAndEmotionsAndFeelingsIntoDiaryRecord();

    widget.onDoneButtonPressed();
  }

  void _onNextButtonPressed() {
    _saveWantToDoAndEmotionsAndFeelingsIntoDiaryRecord();

    widget.onNextButtonPressed();
  }

  _saveWantToDoAndEmotionsAndFeelingsIntoDiaryRecord() {
    List<String> wantToDoForSeveral = [];
    List<String> emotionsAndFeelingsOnWantToDoForSeveral = [];
    for (int i = 0; i < _persons.length; i++) {
      String wantToDo = _wantToDoControllers[i].text;
      wantToDoForSeveral.add(wantToDo);

      String emotionsAndFeelingsOnWantToDo =
          _emotionsAndFeelingsOnWantToDoControllers[i].text;
      emotionsAndFeelingsOnWantToDoForSeveral
          .add(emotionsAndFeelingsOnWantToDo);
    }

    widget.diaryRecord.wantToDoForSeveral = wantToDoForSeveral;
    widget.diaryRecord.emotionsAndFeelingsOnWantToDoForSeveral =
        emotionsAndFeelingsOnWantToDoForSeveral;
  }

  @override
  Widget build(BuildContext context) {
    AppLocalizations l10n = AppLocalizations.of(context);
    String userName = widget._userName;
    String userPreferredPronoun = widget._userPreferredPronoun;
    ThemeData themeData = Theme.of(context);

    List<Widget> content = [];
    for (int i = 0; i < _persons.length; i++) {
      String personName = _persons[i];
      String question = Messages.whatDoYouWantToDo(
        widget.diaryRecord,
        l10n,
        userName,
        userPreferredPronoun,
        personName: personName,
      );

      content.add(SizedBox(height: 20));
      content.add(
        SizedBox(
          height: 180,
          child: _TwoAreasSplitView(
            axis: Axis.horizontal,
            initialFirstAreaWeight: 0.6,
            firstArea: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  question,
                ),
                Expanded(
                  child: TextField(
                    controller: _wantToDoControllers[i],
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: l10n.exampleOfWantToDoForTmipiml,
                      hintStyle: _getMyHintStyle(themeData),
                    ),
                    expands: true,
                    maxLines: null,
                    textAlignVertical: TextAlignVertical.top,
                  ),
                ),
              ],
            ),
            secondArea: _EmotionsAndFeelingsRequest(
              controller: _emotionsAndFeelingsOnWantToDoControllers[i],
              userName: userName,
              userPreferredPronoun: userPreferredPronoun,
            ),
          ),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        leading: _BackToPreviousQuestionButton(),
        title: Text(l10n.appTitle),
        actions: [
          _ToTheListOfDoneButton(_onNextButtonPressed),
          _DoneButton(_onDoneButtonPressed),
        ],
      ),
      body: ListView(
        padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
        children: content,
      ),
    );
  }

  @override
  void dispose() {
    for (int i = 0; i < _wantToDoControllers.length; i++) {
      _wantToDoControllers[i].dispose();
    }
    for (int i = 0; i < _emotionsAndFeelingsOnWantToDoControllers.length; i++) {
      _emotionsAndFeelingsOnWantToDoControllers[i].dispose();
    }

    super.dispose();
  }

  @override
  void initState() {
    super.initState();

    _persons = widget.diaryRecord.whoNames!;

    List<String> wantToDoForSeveral =
        widget.diaryRecord.wantToDoForSeveral ?? [];
    List<String> emotionsAndFeelingsOnWantToDoForSeveral =
        widget.diaryRecord.emotionsAndFeelingsOnWantToDoForSeveral ?? [];
    for (int i = 0; i < _persons.length; i++) {
      TextEditingController controller = TextEditingController();
      if (i < wantToDoForSeveral.length) {
        controller.text = wantToDoForSeveral[i];
      }
      _wantToDoControllers.add(controller);

      controller = TextEditingController();
      if (i < emotionsAndFeelingsOnWantToDoForSeveral.length) {
        controller.text = emotionsAndFeelingsOnWantToDoForSeveral[i];
      }
      _emotionsAndFeelingsOnWantToDoControllers.add(controller);
    }
  }
}

class _WhatsIsDoneForThePerson extends _WhatIsDoneRequestContainer {
  _WhatsIsDoneForThePerson({
    required String userName,
    required String userPreferredPronoun,
    required DiaryRecord diaryRecord,
    required super.onDoneButtonPressed,
  }) : super(
          userName,
          userPreferredPronoun,
          diaryRecord,
          0.2,
        );

  @override
  State<StatefulWidget> createState() => _WhatsIsDoneForThePersonState();
}

class _WhatsIsDoneForThePersonState extends _WhatIsDoneRequestContainerState {
  static Widget _buildEmotionsAndFeelingsOnWantedToDoArea(
    ThemeData themeData,
    AppLocalizations l10n,
    DiaryRecord diaryRecord,
    String? emotionsAndFeelingsOnWantedToDo,
    String userPreferredPronoun,
  ) {
    List<Widget> eafOnWantedToDoColumnChildren = [];
    eafOnWantedToDoColumnChildren.add(
      Text(
        l10n.yourEmotionsAndFeelingsLabel(userPreferredPronoun),
        style: TextStyle(
          color: themeData.disabledColor,
        ),
      ),
    );

    if (emotionsAndFeelingsOnWantedToDo != null) {
      eafOnWantedToDoColumnChildren.add(SizedBox(height: 10));
      eafOnWantedToDoColumnChildren.add(
        Text(
          emotionsAndFeelingsOnWantedToDo,
          style: _getMyReferenceTextStyle(themeData),
        ),
      );
    }

    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: eafOnWantedToDoColumnChildren,
      ),
    );
  }

  static Widget _buildWantedToDoArea(
    ThemeData themeData,
    AppLocalizations l10n,
    DiaryRecord diaryRecord,
    String? wantedToDo,
    String userPreferredPronoun, {
    String personName = '',
  }) {
    List<Widget> wantedToDoColumnChildren = [];
    wantedToDoColumnChildren.add(
      Text(
        Messages.youWantedToDo(
          diaryRecord,
          l10n,
          userPreferredPronoun,
          personName: personName,
        ),
        style: TextStyle(
          color: themeData.disabledColor,
        ),
      ),
    );

    if (wantedToDo != null) {
      wantedToDoColumnChildren.add(SizedBox(height: 10));
      wantedToDoColumnChildren.add(
        Text(
          wantedToDo,
          style: _getMyReferenceTextStyle(themeData),
        ),
      );
    }

    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: wantedToDoColumnChildren,
      ),
    );
  }

  @override
  Widget getFirstRowChild(AppLocalizations l10n) {
    ThemeData themeData = Theme.of(context);

    return _TwoAreasSplitView(
      axis: Axis.horizontal,
      initialFirstAreaWeight: 0.6,
      firstArea: _buildWantedToDoArea(
        themeData,
        l10n,
        widget._diaryRecord,
        widget._diaryRecord.wantToDo,
        widget._userPreferredPronoun,
      ),
      secondArea: _buildEmotionsAndFeelingsOnWantedToDoArea(
        themeData,
        l10n,
        widget._diaryRecord,
        widget._diaryRecord.emotionsAndFeelingsOnWantToDo,
        widget._userPreferredPronoun,
      ),
    );
  }
}

class _WhatIsDoneForThePersons extends StatefulWidget {
  _WhatIsDoneForThePersons(
    String userName,
    String userPreferredPronoun,
    this.diaryRecord, {
    required this.onDoneButtonPressed,
  })  : _userName = userName,
        _userPreferredPronoun = userPreferredPronoun;

  final String _userPreferredPronoun;
  final String _userName;

  final DiaryRecord diaryRecord;
  final void Function() onDoneButtonPressed;

  @override
  State<_WhatIsDoneForThePersons> createState() =>
      _WhatIsDoneForThePersonsState();
}

class _WhatIsDoneForThePersonsState extends State<_WhatIsDoneForThePersons> {
  late final List<String> _persons;
  final List<TextEditingController> _doneControllers = [];
  final List<TextEditingController> _emotionsAndFeelingsOnDoneControllers = [];

  void _onDoneButtonPressed() {
    _saveDoneAndEmotionsAndFeelingsIntoDiaryRecord();

    widget.onDoneButtonPressed();
  }

  _saveDoneAndEmotionsAndFeelingsIntoDiaryRecord() {
    List<String> doneForSeveral = [];
    List<String> emotionsAndFeelingsOnDoneForSeveral = [];
    for (int i = 0; i < _persons.length; i++) {
      String done = _doneControllers[i].text;
      doneForSeveral.add(done);

      String emotionsAndFeelingsOnDone =
          _emotionsAndFeelingsOnDoneControllers[i].text;
      emotionsAndFeelingsOnDoneForSeveral.add(emotionsAndFeelingsOnDone);
    }

    widget.diaryRecord.doneForSeveral = doneForSeveral;
    widget.diaryRecord.emotionsAndFeelingsOnDoneForSeveral =
        emotionsAndFeelingsOnDoneForSeveral;
  }

  @override
  Widget build(BuildContext context) {
    AppLocalizations l10n = AppLocalizations.of(context);
    String userName = widget._userName;
    String userPreferredPronoun = widget._userPreferredPronoun;
    ThemeData themeData = Theme.of(context);
    List<String> wantedToDoForSeveral =
        widget.diaryRecord.wantToDoForSeveral ?? [];
    List<String> eafOnWantedToDoForSeveral =
        widget.diaryRecord.emotionsAndFeelingsOnWantToDoForSeveral ?? [];

    List<Widget> content = [];
    for (int i = 0; i < _persons.length; i++) {
      String personName = _persons[i];
      String? wantedToDo;
      if (i < wantedToDoForSeveral.length) {
        wantedToDo = wantedToDoForSeveral[i];
      }

      String? emotionsAndFeelingsOnWantedToDo;
      if (i < eafOnWantedToDoForSeveral.length) {
        emotionsAndFeelingsOnWantedToDo = eafOnWantedToDoForSeveral[i];
      }

      String question = Messages.whatDidYouDoToday(
        widget.diaryRecord,
        l10n,
        userName,
        userPreferredPronoun,
        personName: personName,
      );

      content.add(SizedBox(height: 20));
      content.add(
        SizedBox(
          height: 250,
          child: _TwoAreasSplitView(
            axis: Axis.vertical,
            initialFirstAreaWeight: 0.28,
            firstArea: _TwoAreasSplitView(
              axis: Axis.horizontal,
              initialFirstAreaWeight: 0.6,
              firstArea: _WhatsIsDoneForThePersonState._buildWantedToDoArea(
                themeData,
                l10n,
                widget.diaryRecord,
                wantedToDo,
                userPreferredPronoun,
                personName: personName,
              ),
              secondArea: _WhatsIsDoneForThePersonState
                  ._buildEmotionsAndFeelingsOnWantedToDoArea(
                themeData,
                l10n,
                widget.diaryRecord,
                emotionsAndFeelingsOnWantedToDo,
                userPreferredPronoun,
              ),
            ),
            secondArea: _TwoAreasSplitView(
              axis: Axis.horizontal,
              initialFirstAreaWeight: 0.6,
              firstArea: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    question,
                    style: themeData.textTheme.titleMedium,
                  ),
                  Expanded(
                    child: TextField(
                      controller: _doneControllers[i],
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        hintStyle: _getMyHintStyle(themeData),
                      ),
                      expands: true,
                      maxLines: null,
                      textAlignVertical: TextAlignVertical.top,
                    ),
                  ),
                ],
              ),
              secondArea: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    l10n.questionAboutCurrentEmotionsAndFeelings(
                      userName,
                      userPreferredPronoun,
                    ),
                    style: themeData.textTheme.titleMedium,
                  ),
                  Expanded(
                    child: TextField(
                      controller: _emotionsAndFeelingsOnDoneControllers[i],
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        hintText:
                            l10n.questionAboutCurrentEmotionsAndFeelingsHints(
                          userName,
                          userPreferredPronoun,
                        ),
                        hintStyle: _getMyHintStyle(themeData),
                      ),
                      expands: true,
                      maxLines: null,
                      textAlignVertical: TextAlignVertical.top,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        leading: _BackToPreviousQuestionButton(),
        title: Text(l10n.appTitle),
        actions: [
          _DoneButton(_onDoneButtonPressed),
        ],
      ),
      body: ListView(
        padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
        children: content,
      ),
    );
  }

  @override
  void dispose() {
    for (int i = 0; i < _doneControllers.length; i++) {
      _doneControllers[i].dispose();
    }
    for (int i = 0; i < _emotionsAndFeelingsOnDoneControllers.length; i++) {
      _emotionsAndFeelingsOnDoneControllers[i].dispose();
    }

    super.dispose();
  }

  @override
  void initState() {
    super.initState();

    _persons = widget.diaryRecord.whoNames!;

    List<String> doneForSeveral = widget.diaryRecord.doneForSeveral ?? [];
    List<String> emotionsAndFeelingsOnDoneForSeveral =
        widget.diaryRecord.emotionsAndFeelingsOnDoneForSeveral ?? [];
    for (int i = 0; i < _persons.length; i++) {
      TextEditingController controller = TextEditingController();
      if (i < doneForSeveral.length) {
        controller.text = doneForSeveral[i];
      }
      _doneControllers.add(controller);

      controller = TextEditingController();
      if (i < emotionsAndFeelingsOnDoneForSeveral.length) {
        controller.text = emotionsAndFeelingsOnDoneForSeveral[i];
      }
      _emotionsAndFeelingsOnDoneControllers.add(controller);
    }
  }
}

class _WhatsIsDoneForYourselfWithoutWantedToDo
    extends _WhatIsDoneRequestContainer {
  _WhatsIsDoneForYourselfWithoutWantedToDo({
    required String userName,
    required String userPreferredPronoun,
    required DiaryRecord diaryRecord,
    required super.onDoneButtonPressed,
  }) : super(
          userName,
          userPreferredPronoun,
          diaryRecord,
          0.2,
        );

  @override
  State<StatefulWidget> createState() =>
      _WhatsIsDoneForYourselfWithoutWantedToDoState();
}

class _WhatsIsDoneForYourselfWithoutWantedToDoState
    extends _WhatIsDoneRequestContainerState {
  @override
  Widget getFirstRowChild(AppLocalizations l10n) {
    ThemeData themeData = Theme.of(context);

    List<Widget> eafOnWantedToDoColumnChildren = [];
    eafOnWantedToDoColumnChildren.add(
      Text(
        Messages.youAnsweredThatTmipiylWas(
          widget._diaryRecord,
          l10n,
          widget._userName,
          widget._userPreferredPronoun,
        ),
        style: TextStyle(
          color: themeData.disabledColor,
        ),
      ),
    );
    eafOnWantedToDoColumnChildren.add(SizedBox(height: 10));
    eafOnWantedToDoColumnChildren.add(
      Text(
        l10n.yourEmotionsAndFeelingsLabel(widget._userPreferredPronoun),
        style: TextStyle(
          color: themeData.disabledColor,
        ),
      ),
    );
    String? emotionsAndFeelingsOnWantedToDo =
        widget._diaryRecord.emotionsAndFeelingsOnWantToDo;
    if (emotionsAndFeelingsOnWantedToDo != null) {
      eafOnWantedToDoColumnChildren.add(SizedBox(height: 10));
      eafOnWantedToDoColumnChildren.add(
        Text(
          emotionsAndFeelingsOnWantedToDo,
          style: _getMyReferenceTextStyle(themeData),
        ),
      );
    }

    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: eafOnWantedToDoColumnChildren,
      ),
    );
  }
}

abstract class _WhatIsDoneRequestContainer extends StatefulWidget {
  _WhatIsDoneRequestContainer(
    String userName,
    String userPreferredPronoun,
    DiaryRecord diaryRecord,
    double firstColumnInitialWeight, {
    required this.onDoneButtonPressed,
  })  : _diaryRecord = diaryRecord,
        _firstRowInitialWeight = firstColumnInitialWeight,
        _userName = userName,
        _userPreferredPronoun = userPreferredPronoun;

  final DiaryRecord _diaryRecord;
  final double _firstRowInitialWeight;
  final void Function() onDoneButtonPressed;
  final String _userName;
  final String _userPreferredPronoun;
}

abstract class _WhatIsDoneRequestContainerState
    extends State<_WhatIsDoneRequestContainer> {
  final TextEditingController _doneController = TextEditingController();
  final TextEditingController _emotionsAndFeelingsController =
      TextEditingController();

  @override
  Widget build(BuildContext context) {
    AppLocalizations l10n = AppLocalizations.of(context);
    ThemeData themeData = Theme.of(context);

    String question = Messages.whatDidYouDoToday(
      widget._diaryRecord,
      l10n,
      widget._userName,
      widget._userPreferredPronoun,
    );

    return Scaffold(
      appBar: AppBar(
        leading: _BackToPreviousQuestionButton(),
        title: Text(question),
        actions: [
          _DoneButton(_onDoneButtonPressed),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.all(20),
        child: MultiSplitViewTheme(
          data: MultiSplitViewThemeData(
            dividerPainter: DividerPainters.dashed(
              color: themeData.dividerColor,
              highlightedColor: themeData.indicatorColor,
            ),
          ),
          child: _TwoAreasSplitView(
            axis: Axis.vertical,
            initialFirstAreaWeight: widget._firstRowInitialWeight,
            firstArea: getFirstRowChild(l10n),
            secondArea: _TwoAreasSplitView(
              axis: Axis.horizontal,
              initialFirstAreaWeight: 0.6,
              firstArea: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(question),
                  SizedBox(height: 10),
                  Expanded(
                    child: TextField(
                      controller: _doneController,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                      ),
                      maxLines: null,
                      expands: true,
                      textAlignVertical: TextAlignVertical.top,
                    ),
                  ),
                ],
              ),
              secondArea: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(l10n.questionAboutCurrentEmotionsAndFeelings(
                      widget._userName, widget._userPreferredPronoun)),
                  SizedBox(height: 10),
                  Expanded(
                    child: TextField(
                      controller: _emotionsAndFeelingsController,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        hintText:
                            l10n.questionAboutCurrentEmotionsAndFeelingsHints(
                                widget._userName, widget._userPreferredPronoun),
                        hintStyle: _getMyHintStyle(themeData),
                      ),
                      maxLines: null,
                      expands: true,
                      textAlignVertical: TextAlignVertical.top,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _doneController.dispose();
    _emotionsAndFeelingsController.dispose();

    super.dispose();
  }

  Widget getFirstRowChild(AppLocalizations l10n);

  @override
  void initState() {
    super.initState();

    if (widget._diaryRecord.done != null) {
      _doneController.text = widget._diaryRecord.done!;
    }

    if (widget._diaryRecord.emotionsAndFeelingsOnDone != null) {
      _emotionsAndFeelingsController.text =
          widget._diaryRecord.emotionsAndFeelingsOnDone!;
    }
  }

  void _onDoneButtonPressed() {
    String? done = _doneController.text;
    String? emotionsAndFeelings = _emotionsAndFeelingsController.text;

    if (done.isEmpty) {
      done = null;
    }
    if (emotionsAndFeelings.isEmpty) {
      emotionsAndFeelings = null;
    }

    DiaryRecord diaryRecord = widget._diaryRecord;
    diaryRecord.done = done;
    diaryRecord.emotionsAndFeelingsOnDone = emotionsAndFeelings;

    widget.onDoneButtonPressed();
  }
}
