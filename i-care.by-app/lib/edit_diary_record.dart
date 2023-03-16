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
      color: Colors.green,
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
  String? _done;
  String? _emotionsAndFeelingsOnDone;
  String? _emotionsAndFeelingsOnWantToDo;
  TmipimlIsGrandparent? _grandparent;
  TmipimlIsParent? _parent;
  List<String>? _severalPersonsNames;
  TmipimlIsSpouceOrPartner? _spouceOrPartner;
  String? _wantToDo;
  List<String>? _wantToDoForSeveral;

  void _copyFieldsFromStagingArea(DiaryRecord toRecord,
      {DiaryRecord? fromRecord}) {
    toRecord.who = _theMostImportantPerson;

    if (toRecord.who == TheMostImportantPersonInMyLife.several) {
      toRecord.whoNames = _severalPersonsNames;
      toRecord.wantToDoForSeveral = _wantToDoForSeveral;
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

      toRecord.wantToDo = _wantToDo;

      if (fromRecord == null) {
        toRecord.emotionsAndFeelingsOnWantToDo = _emotionsAndFeelingsOnWantToDo;

        toRecord.done = _done;
        toRecord.emotionsAndFeelingsOnDone = _emotionsAndFeelingsOnDone;
      } else {
        toRecord.emotionsAndFeelingsOnWantToDo =
            fromRecord.emotionsAndFeelingsOnWantToDo;

        toRecord.done = fromRecord.done;
        toRecord.emotionsAndFeelingsOnDone =
            fromRecord.emotionsAndFeelingsOnDone;
      }
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
    _onSubmitFirstScreen();
  }

  void _onFinalSubmit() {
    DiaryRecord theRecord = widget._diaryRecord;
    _copyFieldsFromStagingArea(theRecord, fromRecord: _stagingDiaryRecord);

    widget.onSubmit(widget._diaryRecord);
  }

  void _onFinalSubmitOfWantToDoAndEaf(String? wantToDo, String? emotionsAndFeelings) {
    if (wantToDo != null && wantToDo.isEmpty) {
      wantToDo = null;
    }
    if (emotionsAndFeelings != null && emotionsAndFeelings.isEmpty) {
      emotionsAndFeelings = null;
    }

    _wantToDo = wantToDo;
    _emotionsAndFeelingsOnWantToDo = emotionsAndFeelings;

    DiaryRecord theRecord = widget._diaryRecord;
    _copyFieldsFromStagingArea(theRecord);

    widget.onSubmit(widget._diaryRecord);
  }

  void _onFinalSubmitOfWantToDoForSeveral(List<String> wantToDoForSeveral) {
    _wantToDoForSeveral = wantToDoForSeveral;

    DiaryRecord theRecord = widget._diaryRecord;
    _copyFieldsFromStagingArea(theRecord);

    widget.onSubmit(widget._diaryRecord);
  }

  void _onGrandparentChanged(TmipimlIsGrandparent? value) {
    setState(() {
      _grandparent = value;
    });
    _onSubmitFirstScreen();
  }

  void _onNextEmotionsAndFeelings(String emotionsAndFeelings) {
    setState(() {
      _emotionsAndFeelingsOnWantToDo = emotionsAndFeelings;
    });
    _onSubmitSecondScreen();
  }

  void _onNextWantToDoWithEmotionsAndFeelings(
      String wantToDo, String emotionsAndFeelings) {
    setState(() {
      _emotionsAndFeelingsOnWantToDo = emotionsAndFeelings;
      _wantToDo = wantToDo;
    });
    _onSubmitSecondScreen();
  }

  void _onParentChanged(TmipimlIsParent? value) {
    setState(() {
      _parent = value;
    });
    _onSubmitFirstScreen();
  }

  void _onSpouceOrPartnerChanged(TmipimlIsSpouceOrPartner? value) {
    setState(() {
      _spouceOrPartner = value;
    });
    _onSubmitFirstScreen();
  }

  void _onSubmitAnotherPersonName(String value) {
    _anotherPersonName = value;
    _onSubmitFirstScreen();
  }

  void _onSubmitFirstScreen() {
    AppLocalizations l10n = AppLocalizations.of(context);
    String userName = widget._diary.getNotEmptyUserName(l10n);
    String userPreferredPronoun = widget._diary.userPreferredPronoun ?? '';
    _copyFieldsFromStagingArea(_stagingDiaryRecord,
        fromRecord: _stagingDiaryRecord);

    NavigatorState navigator = Navigator.of(context);
    switch (_theMostImportantPerson!) {
      case TheMostImportantPersonInMyLife.absent:
      case TheMostImportantPersonInMyLife.dontKnow:
        navigator.push(
          MaterialPageRoute(
            builder: (BuildContext context) => _MessageToTheUser(
              userName,
              userPreferredPronoun,
              _getMessageToTheUserProvider(),
              _stagingDiaryRecord,
              _onFinalSubmit,
              _onNextEmotionsAndFeelings,
            ),
          ),
        );
        break;

      case TheMostImportantPersonInMyLife.another:
      case TheMostImportantPersonInMyLife.child:
      case TheMostImportantPersonInMyLife.grandparent:
      case TheMostImportantPersonInMyLife.me:
      case TheMostImportantPersonInMyLife.parent:
      case TheMostImportantPersonInMyLife.spouseOrPartner:
        navigator.push(
          MaterialPageRoute(
            builder: (BuildContext context) => _WhatDoYouWantToDoForThePerson(
                userName,
                userPreferredPronoun,
                _stagingDiaryRecord,
                _onFinalSubmitOfWantToDoAndEaf,
                _onNextWantToDoWithEmotionsAndFeelings),
          ),
        );
        break;

      case TheMostImportantPersonInMyLife.several:
        navigator.push(
          MaterialPageRoute(
            builder: (BuildContext context) => _WhatDoYouWantToDoForThePersons(
                userName,
                userPreferredPronoun,
                _severalPersonsNames!,
                _wantToDoForSeveral,
                _onFinalSubmitOfWantToDoForSeveral),
          ),
        );
        break;
    }
  }

  void _onSubmitSecondScreen() {
    AppLocalizations l10n = AppLocalizations.of(context);
    String userName = widget._diary.getNotEmptyUserName(l10n);
    String userPreferredPronoun = widget._diary.userPreferredPronoun ?? '';
    _copyFieldsFromStagingArea(_stagingDiaryRecord,
        fromRecord: _stagingDiaryRecord);

    NavigatorState navigator = Navigator.of(context);
    switch (_theMostImportantPerson!) {
      case TheMostImportantPersonInMyLife.absent:
      case TheMostImportantPersonInMyLife.dontKnow:
        navigator.push(
          MaterialPageRoute(
            builder: (BuildContext context) =>
                _WhatsIsDoneForYourselfWithoutWantedToDo(
              userName: userName,
              userPreferredPronoun: userPreferredPronoun,
              diaryRecord: _stagingDiaryRecord,
              onDoneButtonPressed: _onFinalSubmit,
            ),
          ),
        );
        break;

      case TheMostImportantPersonInMyLife.another:
      case TheMostImportantPersonInMyLife.child:
      case TheMostImportantPersonInMyLife.grandparent:
      case TheMostImportantPersonInMyLife.me:
      case TheMostImportantPersonInMyLife.parent:
      case TheMostImportantPersonInMyLife.spouseOrPartner:
        navigator.push(
          MaterialPageRoute(
            builder: (BuildContext context) => _WhatsIsDoneForThePerson(
              userName: userName,
              userPreferredPronoun: userPreferredPronoun,
              diaryRecord: _stagingDiaryRecord,
              onDoneButtonPressed: _onFinalSubmit,
            ),
          ),
        );
        break;

      case TheMostImportantPersonInMyLife.several:
        //TODO: write code
        showAboutDialog(
          context: context,
          children: [
            Text(
                '_onSubmitSecondScreen(several)'),
          ],
        );
        break;
    }
  }

  void _onSubmitSeveralPersonsNames(String value) {
    _severalPersonsNames = [];
    for (String personName in value.split('\n')) {
      personName = personName.trim();
      if (personName.isNotEmpty) {
        _severalPersonsNames!.add(personName);
      }
    }
    _onSubmitFirstScreen();
  }

  void _onTmipimlChanged(TheMostImportantPersonInMyLife? value) {
    setState(() {
      _theMostImportantPerson = value;
      _anotherPersonName = null;
      _child = null;
      _done = null;
      _emotionsAndFeelingsOnDone = null;
      _emotionsAndFeelingsOnWantToDo = null;
      _grandparent = null;
      _parent = null;
      _severalPersonsNames = null;
      _spouceOrPartner = null;
      _wantToDo = null;
      _wantToDoForSeveral = null;
    });
  }

  void _onTmipiylOptionWithNoSuboptionsSelected(
      TheMostImportantPersonInMyLife? value) {
    _onTmipimlChanged(value);
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
        _done = data.done;
        _emotionsAndFeelingsOnDone = data.emotionsAndFeelingsOnDone;
        _emotionsAndFeelingsOnWantToDo = data.emotionsAndFeelingsOnWantToDo;
        autoSubmitFirstScreen = true;
        autoSubmitSecondScreen = autoSubmitFirstScreen &&
            (_emotionsAndFeelingsOnWantToDo != null ||
                data.done != null ||
                data.emotionsAndFeelingsOnDone != null);
        break;

      case TheMostImportantPersonInMyLife.another:
        _anotherPersonName = data.whoName;
        _done = data.done;
        _emotionsAndFeelingsOnDone = data.emotionsAndFeelingsOnDone;
        _emotionsAndFeelingsOnWantToDo = data.emotionsAndFeelingsOnWantToDo;
        _wantToDo = data.wantToDo;
        autoSubmitFirstScreen = (_anotherPersonName != null);
        autoSubmitSecondScreen = autoSubmitFirstScreen &&
            ((_emotionsAndFeelingsOnWantToDo != null && _wantToDo != null) ||
                data.done != null ||
                data.emotionsAndFeelingsOnDone != null);
        break;

      case TheMostImportantPersonInMyLife.child:
        _child = data.whoSubclass as TmipimlIsChild;
        _done = data.done;
        _emotionsAndFeelingsOnDone = data.emotionsAndFeelingsOnDone;
        _emotionsAndFeelingsOnWantToDo = data.emotionsAndFeelingsOnWantToDo;
        _wantToDo = data.wantToDo;
        autoSubmitFirstScreen = (_child != null);
        autoSubmitSecondScreen = autoSubmitFirstScreen &&
            ((_emotionsAndFeelingsOnWantToDo != null && _wantToDo != null) ||
                data.done != null ||
                data.emotionsAndFeelingsOnDone != null);
        break;

      case TheMostImportantPersonInMyLife.dontKnow:
        _done = data.done;
        _emotionsAndFeelingsOnDone = data.emotionsAndFeelingsOnDone;
        _emotionsAndFeelingsOnWantToDo = data.emotionsAndFeelingsOnWantToDo;
        autoSubmitFirstScreen = true;
        autoSubmitSecondScreen = autoSubmitFirstScreen &&
            (_emotionsAndFeelingsOnWantToDo != null ||
                data.done != null ||
                data.emotionsAndFeelingsOnDone != null);
        break;

      case TheMostImportantPersonInMyLife.grandparent:
        _done = data.done;
        _emotionsAndFeelingsOnDone = data.emotionsAndFeelingsOnDone;
        _emotionsAndFeelingsOnWantToDo = data.emotionsAndFeelingsOnWantToDo;
        _grandparent = data.whoSubclass as TmipimlIsGrandparent;
        _wantToDo = data.wantToDo;
        autoSubmitFirstScreen = (_grandparent != null);
        autoSubmitSecondScreen = autoSubmitFirstScreen &&
            ((_emotionsAndFeelingsOnWantToDo != null && _wantToDo != null) ||
                data.done != null ||
                data.emotionsAndFeelingsOnDone != null);
        break;

      case TheMostImportantPersonInMyLife.me:
        _done = data.done;
        _emotionsAndFeelingsOnDone = data.emotionsAndFeelingsOnDone;
        _emotionsAndFeelingsOnWantToDo = data.emotionsAndFeelingsOnWantToDo;
        _wantToDo = data.wantToDo;
        autoSubmitFirstScreen = true;
        autoSubmitSecondScreen = autoSubmitFirstScreen &&
            ((_emotionsAndFeelingsOnWantToDo != null && _wantToDo != null) ||
                data.done != null ||
                data.emotionsAndFeelingsOnDone != null);
        break;

      case TheMostImportantPersonInMyLife.parent:
        _done = data.done;
        _emotionsAndFeelingsOnDone = data.emotionsAndFeelingsOnDone;
        _emotionsAndFeelingsOnWantToDo = data.emotionsAndFeelingsOnWantToDo;
        _parent = data.whoSubclass as TmipimlIsParent;
        _wantToDo = data.wantToDo;
        autoSubmitFirstScreen = (_parent != null);
        autoSubmitSecondScreen = autoSubmitFirstScreen &&
            ((_emotionsAndFeelingsOnWantToDo != null && _wantToDo != null) ||
                data.done != null ||
                data.emotionsAndFeelingsOnDone != null);
        break;

      case TheMostImportantPersonInMyLife.several:
        _severalPersonsNames = data.whoNames;
        _wantToDoForSeveral = data.wantToDoForSeveral;
        autoSubmitFirstScreen =
            (_severalPersonsNames != null && _severalPersonsNames!.length > 1);
        break;

      case TheMostImportantPersonInMyLife.spouseOrPartner:
        _done = data.done;
        _emotionsAndFeelingsOnDone = data.emotionsAndFeelingsOnDone;
        _emotionsAndFeelingsOnWantToDo = data.emotionsAndFeelingsOnWantToDo;
        _spouceOrPartner = data.whoSubclass as TmipimlIsSpouceOrPartner;
        _wantToDo = data.wantToDo;
        autoSubmitFirstScreen = (_spouceOrPartner != null);
        autoSubmitSecondScreen = autoSubmitFirstScreen &&
            ((_emotionsAndFeelingsOnWantToDo != null && _wantToDo != null) ||
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

class _MessageToTheUser extends _OneEmotionsAndFeelingsRequestContainer {
  _MessageToTheUser(
      String userName,
      String userPreferredPronoun,
      String Function(String, String) messageProvider,
      DiaryRecord diaryRecord,
      this.onDoneButtonPressed,
      void Function(String) onNextButtonPressed)
      : _messageProvider = messageProvider,
        _onNextButtonPressed = onNextButtonPressed,
        super(userName, userPreferredPronoun, diaryRecord,
            0.8);

  final String Function(String, String) _messageProvider;
  final void Function() onDoneButtonPressed;
  final void Function(String) _onNextButtonPressed;

  @override
  State<StatefulWidget> createState() => _MessageToTheUserState();
}

class _MessageToTheUserState
    extends _OneEmotionsAndFeelingsRequestContainerState {
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

  @override
  void onDoneButtonPressed() {
    super.onDoneButtonPressed();

    (widget as _MessageToTheUser).onDoneButtonPressed();
  }

  @override
  void onNextButtonPressed() {
    (widget as _MessageToTheUser)
        ._onNextButtonPressed(_emotionsAndFeelingsController.text);
  }
}

abstract class _OneEmotionsAndFeelingsRequestContainer extends StatefulWidget {
  _OneEmotionsAndFeelingsRequestContainer(
    String userName,
    String userPreferredPronoun,
    this.diaryRecord,
    double firstColumnInitialWeight,
  )   : _firstColumnInitialWeight = firstColumnInitialWeight,
        _userName = userName,
        _userPreferredPronoun = userPreferredPronoun;

  final double _firstColumnInitialWeight;
  final String _userName;
  final String _userPreferredPronoun;

  final DiaryRecord diaryRecord;
}

abstract class _OneEmotionsAndFeelingsRequestContainerState
    extends State<_OneEmotionsAndFeelingsRequestContainer> {
  late final TextEditingController _emotionsAndFeelingsController;

  @override
  Widget build(BuildContext context) {
    AppLocalizations l10n = AppLocalizations.of(context);
    ThemeData themeData = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        leading: _BackToPreviousQuestionButton(),
        title: getAppBarTitle(l10n),
        actions: [
          _ToTheListOfDoneButton(onNextButtonPressed),
          _DoneButton(onDoneButtonPressed),
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
          child: MultiSplitView(
            axis: Axis.horizontal,
            initialAreas: [
              Area(
                weight: widget._firstColumnInitialWeight,
                minimalSize: 40,
              ),
              Area(minimalSize: 40),
            ],
            children: [
              getFirstColumnChild(l10n),
              Column(
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
                      minLines: 5,
                    ),
                  ),
                ],
              ),
            ],
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

    _emotionsAndFeelingsController = TextEditingController();
    if (widget.diaryRecord.emotionsAndFeelingsOnWantToDo != null) {
      _emotionsAndFeelingsController.text =
          widget.diaryRecord.emotionsAndFeelingsOnWantToDo!;
    }
  }

  void onDoneButtonPressed() {
    String? emotionsAndFeelings = _emotionsAndFeelingsController.text;
    if (emotionsAndFeelings.isEmpty) {
      emotionsAndFeelings = null;
    }

    widget.diaryRecord.emotionsAndFeelingsOnWantToDo = emotionsAndFeelings;
  }

  void onNextButtonPressed();
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

class _WhatDoYouWantToDoForThePerson
    extends _OneEmotionsAndFeelingsRequestContainer {
  _WhatDoYouWantToDoForThePerson(
      String userName,
      String userPreferredPronoun,
      DiaryRecord diaryRecord,
      this.onDoneButtonPressed,
      void Function(String, String) onNextButtonPressed)
      : _onNextButtonPressed = onNextButtonPressed,
        super(userName, userPreferredPronoun,
            diaryRecord, 0.6);

  final void Function(String, String) onDoneButtonPressed;
  final void Function(String, String) _onNextButtonPressed;

  @override
  State<StatefulWidget> createState() => _WhatDoYouWantToDoForThePersonState();
}

class _WhatDoYouWantToDoForThePersonState
    extends _OneEmotionsAndFeelingsRequestContainerState {
  late final TextEditingController _wantToDoController;

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
            minLines: 5,
            maxLines: null,
          ),
        ),
      ],
    );
  }

  @override
  void initState() {
    super.initState();

    _wantToDoController = TextEditingController();
    if (widget.diaryRecord.wantToDo != null) {
      _wantToDoController.text = widget.diaryRecord.wantToDo!;
    }
  }

  @override
  void onDoneButtonPressed() {
    (widget as _WhatDoYouWantToDoForThePerson).onDoneButtonPressed(
        _wantToDoController.text, _emotionsAndFeelingsController.text);
  }

  @override
  void onNextButtonPressed() {
    (widget as _WhatDoYouWantToDoForThePerson)._onNextButtonPressed(
        _wantToDoController.text, _emotionsAndFeelingsController.text);
  }
}

class _WhatDoYouWantToDoForThePersons extends StatefulWidget {
  _WhatDoYouWantToDoForThePersons(
      String userName,
      String userPreferredPronoun,
      List<String> persons,
      List<String>? initialAnswers,
      void Function(List<String>) onDoneButtonPressed)
      : _userName = userName,
        _userPreferredPronoun = userPreferredPronoun,
        _persons = persons,
        _initialAnswers = initialAnswers,
        _onDoneButtonPressed = onDoneButtonPressed;

  final List<String>? _initialAnswers;
  final void Function(List<String>) _onDoneButtonPressed;
  final List<String> _persons;
  final String _userPreferredPronoun;
  final String _userName;

  @override
  State<_WhatDoYouWantToDoForThePersons> createState() =>
      _WhatDoYouWantToDoForThePersonsState();
}

class _WhatDoYouWantToDoForThePersonsState
    extends State<_WhatDoYouWantToDoForThePersons> {
  final List<TextEditingController> _wantToDoControllers = [];

  void _onDoneButtonPressed() {
    List<String> wantToDoForSeveral = [];
    for (int i = 0; i < _wantToDoControllers.length; i++) {
      String wantToDo = _wantToDoControllers[i].text;
      wantToDoForSeveral.add(wantToDo);
    }

    widget._onDoneButtonPressed(wantToDoForSeveral);
  }

  void _onNextButtonPressed() {
    // TODO: write the code
    showAboutDialog(
      context: context,
      children: [
        Text('Гэты код пакуль што не напісаны.'),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    AppLocalizations l10n = AppLocalizations.of(context);
    String myself = l10n.theMipiylOption_you;
    String userName = widget._userName;
    String userPreferredPronoun = widget._userPreferredPronoun;
    ThemeData themeData = Theme.of(context);

    List<Widget> content = [];
    for (int i = 0; i < _wantToDoControllers.length; i++) {
      String personName = widget._persons[i];
      String question;
      if (personName == myself) {
        question =
            l10n.whatDoYouWantToDoFor_yourself(userName, userPreferredPronoun);
      } else {
        question = l10n.whatDoYouWantToDoFor_another(
            userName, userPreferredPronoun, personName);
      }

      content.add(SizedBox(height: 20));
      content.add(Text(
        question,
        style: themeData.textTheme.titleMedium,
      ));
      content.add(TextField(
        controller: _wantToDoControllers[i],
        decoration: InputDecoration(
          border: OutlineInputBorder(),
          hintText: l10n.exampleOfWantToDoForTmipiml,
          hintStyle: _getMyHintStyle(themeData),
        ),
        minLines: 5,
        maxLines: 7,
      ));
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
      body: SingleChildScrollView(
        padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: content,
        ),
      ),
    );
  }

  @override
  void dispose() {
    for (int i = 0; i < _wantToDoControllers.length; i++) {
      _wantToDoControllers[i].dispose();
    }

    super.dispose();
  }

  @override
  void initState() {
    super.initState();

    for (int i = 0; i < widget._persons.length; i++) {
      TextEditingController controller = TextEditingController();
      if (widget._initialAnswers != null &&
          i < widget._initialAnswers!.length) {
        controller.text = widget._initialAnswers![i];
      }
      _wantToDoControllers.add(controller);
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
  @override
  Widget getFirstRowChild(AppLocalizations l10n) {
    List<Widget> wantedToDoColumnChildren = [];
    ThemeData themeData = Theme.of(context);

    wantedToDoColumnChildren.add(
      Text(
        Messages.youWantedToDo(
          widget._diaryRecord,
          l10n,
          widget._userPreferredPronoun,
        ),
        style: TextStyle(
          color: themeData.disabledColor,
        ),
      ),
    );
    String? wantedToDo = widget._diaryRecord.wantToDo;
    if (wantedToDo != null) {
      wantedToDoColumnChildren.add(SizedBox(height: 10));
      wantedToDoColumnChildren.add(
        Text(
          wantedToDo,
          style: _getMyReferenceTextStyle(themeData),
        ),
      );
    }

    List<Widget> eafOnWantedToDoColumnChildren = [];
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

    return MultiSplitView(
      axis: Axis.horizontal,
      initialAreas: [
        Area(weight: 0.6, minimalSize: 40),
        Area(weight: 0.4, minimalSize: 40),
      ],
      children: [
        SingleChildScrollView(
          padding: EdgeInsets.only(right: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: wantedToDoColumnChildren,
          ),
        ),
        SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: eafOnWantedToDoColumnChildren,
          ),
        ),
      ],
    );
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
  late final TextEditingController _doneController;
  late final TextEditingController _emotionsAndFeelingsController;

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
          child: MultiSplitView(
            axis: Axis.vertical,
            initialAreas: [
              Area(
                weight: widget._firstRowInitialWeight,
                minimalSize: 40,
              ),
              Area(minimalSize: 40),
            ],
            children: [
              getFirstRowChild(l10n),
              MultiSplitView(
                axis: Axis.horizontal,
                initialAreas: [
                  Area(
                    weight: 0.6,
                    minimalSize: 40,
                  ),
                  Area(minimalSize: 40),
                ],
                children: [
                  Column(
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
                          minLines: 5,
                        ),
                      ),
                    ],
                  ),
                  Column(
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
                            hintText: l10n
                                .questionAboutCurrentEmotionsAndFeelingsHints(
                                    widget._userName,
                                    widget._userPreferredPronoun),
                            hintStyle: _getMyHintStyle(themeData),
                          ),
                          maxLines: null,
                          minLines: 5,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ],
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

    _doneController = TextEditingController();
    if (widget._diaryRecord.done != null) {
      _doneController.text = widget._diaryRecord.done!;
    }

    _emotionsAndFeelingsController = TextEditingController();
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
