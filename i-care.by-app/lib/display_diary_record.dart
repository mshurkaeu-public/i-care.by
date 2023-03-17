import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'diary_record.dart';
import 'messages.dart';
import 'the_most_important_person_in_my_life.dart';
import 'tmipiml_is_child.dart';
import 'tmipiml_is_grandparent.dart';
import 'tmipiml_is_parent.dart';
import 'tmipiml_is_spouce_or_partner.dart';

class DisplayDiaryRecord extends StatelessWidget {
  DisplayDiaryRecord(dynamic data, String userPreferredPronoun)
      : _diaryRecord = DiaryRecord(data),
        _userPreferredPronoun = userPreferredPronoun;

  final DiaryRecord _diaryRecord;
  final String _userPreferredPronoun;

  void _appendContentForOnePerson({
    required List<Widget> dayContent,
    required String? done,
    required String? emotionsAndFeelingsOnDone,
    required String? emotionsAndFeelingsOnWantedToDo,
    required AppLocalizations l10n,
    required ThemeData themeData,
    required String? wantedToDo,
    required String youDidLabelText,
    required String youWantedToDoLabelText,
  }) {
    dayContent.add(SizedBox(height: 10));
    dayContent.add(Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          flex: 1,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                youWantedToDoLabelText,
                style: TextStyle(
                  color: themeData.disabledColor,
                ),
              ),
              Text(wantedToDo ?? ''),
              Container(height: 10),
              Text(
                l10n.yourEmotionsAndFeelingsLabel(_userPreferredPronoun),
                style: TextStyle(
                  color: themeData.disabledColor,
                ),
              ),
              Text(emotionsAndFeelingsOnWantedToDo ?? ''),
            ],
          ),
        ),
        Expanded(
          flex: 1,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                youDidLabelText,
                style: TextStyle(
                  color: themeData.disabledColor,
                ),
              ),
              Text(done ?? ''),
              Container(height: 10),
              Text(
                l10n.yourEmotionsAndFeelingsLabel(_userPreferredPronoun),
                style: TextStyle(
                  color: themeData.disabledColor,
                ),
              ),
              Text(emotionsAndFeelingsOnDone ?? ''),
            ],
          ),
        ),
      ],
    ));
  }

  String _getWhoDescription(AppLocalizations l10n) {
    TheMostImportantPersonInMyLife? who = _diaryRecord.who;

    String res;
    switch (who) {
      case null:
        res = l10n.thereIsNoData;
        break;

      case TheMostImportantPersonInMyLife.absent:
        res = l10n.theMipiylOption_absent;
        break;

      case TheMostImportantPersonInMyLife.another:
        res = _diaryRecord.whoName ?? l10n.thereIsNoData;
        break;

      case TheMostImportantPersonInMyLife.child:
        switch (_diaryRecord.whoSubclass as TmipimlIsChild?) {
          case null:
            res = l10n.theMipiylOption_child;
            break;

          case TmipimlIsChild.daughter:
            res = l10n.childOption_daughter;
            break;

          case TmipimlIsChild.son:
            res = l10n.childOption_son;
            break;
        }
        break;

      case TheMostImportantPersonInMyLife.dontKnow:
        res = l10n.theMipiylOption_dontKnow;
        break;

      case TheMostImportantPersonInMyLife.grandparent:
        switch (_diaryRecord.whoSubclass as TmipimlIsGrandparent?) {
          case null:
            res = l10n.theMipiylOption_grandparent;
            break;

          case TmipimlIsGrandparent.grandfather:
            res = l10n.grandparentOption_grandfather;
            break;

          case TmipimlIsGrandparent.grandmother:
            res = l10n.grandparentOption_grandmother;
            break;
        }
        break;

      case TheMostImportantPersonInMyLife.me:
        res = '';
        break;

      case TheMostImportantPersonInMyLife.parent:
        switch (_diaryRecord.whoSubclass as TmipimlIsParent?) {
          case null:
            res = l10n.theMipiylOption_parent;
            break;

          case TmipimlIsParent.father:
            res = l10n.parentOption_father;
            break;

          case TmipimlIsParent.mother:
            res = l10n.parentOption_mother;
            break;
        }
        break;

      case TheMostImportantPersonInMyLife.several:
        res = (_diaryRecord.whoNames == null)
            ? l10n.thereIsNoData
            : _diaryRecord.whoNames!.join(l10n.separatorForNamesListInLabel);
        break;

      case TheMostImportantPersonInMyLife.spouseOrPartner:
        switch (_diaryRecord.whoSubclass as TmipimlIsSpouceOrPartner?) {
          case null:
            res = l10n.theMipiylOption_spouseOrPartner;
            break;

          case TmipimlIsSpouceOrPartner.boyfriend:
            res = l10n.spouseOrPartnerOption_boyfriend;
            break;

          case TmipimlIsSpouceOrPartner.girlfriend:
            res = l10n.spouseOrPartnerOption_girlfriend;
            break;

          case TmipimlIsSpouceOrPartner.husband:
            res = l10n.spouseOrPartnerOption_husband;
            break;

          case TmipimlIsSpouceOrPartner.wife:
            res = l10n.spouseOrPartnerOption_wife;
            break;
        }
        break;
    }

    return res;
  }

  @override
  Widget build(BuildContext context) {
    AppLocalizations l10n = AppLocalizations.of(context);
    ThemeData themeData = Theme.of(context);

    String date = _diaryRecord.dateAsString ?? l10n.thereIsNoData;
    List<Widget> dayTitleContent = [
      Text(
        date,
        style: themeData.textTheme.titleMedium,
      ),
    ];

    String whoDescription = _getWhoDescription(l10n);
    if (whoDescription.isNotEmpty) {
      dayTitleContent.add(
        Text(
          ': ',
          style: themeData.textTheme.titleMedium,
        ),
      );
      dayTitleContent.add(
        Text(
          whoDescription,
          style: themeData.textTheme.titleMedium,
        ),
      );
    }

    List<Widget> dayContent = [
      Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: dayTitleContent,
      ),
    ];

    TheMostImportantPersonInMyLife? who = _diaryRecord.who;
    switch (who) {
      case TheMostImportantPersonInMyLife.several:
        if (_diaryRecord.whoNames == null) {
          dayContent.add(Text(l10n.thereIsNoData));
          break;
        }

        List<String> persons = _diaryRecord.whoNames!;
        List<String> wantToDoForSeveral = _diaryRecord.wantToDoForSeveral ?? [];
        List<String> emotionsAndFeelingsOnWantToDoForSeveral =
            _diaryRecord.emotionsAndFeelingsOnWantToDoForSeveral ?? [];
        for (int i = 0; i < persons.length; i++) {
          String personName = persons[i];

          String? wantToDoDescription;
          if (i < wantToDoForSeveral.length) {
            wantToDoDescription = wantToDoForSeveral[i];
          } else {
            wantToDoDescription = null;
          }

          String? emotionsAndFeelingsOnWantedToDo;
          if (i < emotionsAndFeelingsOnWantToDoForSeveral.length) {
            emotionsAndFeelingsOnWantedToDo =
                emotionsAndFeelingsOnWantToDoForSeveral[i];
          } else {
            emotionsAndFeelingsOnWantedToDo = null;
          }

          _appendContentForOnePerson(
            dayContent: dayContent,
            done: null,
            emotionsAndFeelingsOnDone: null,
            emotionsAndFeelingsOnWantedToDo: emotionsAndFeelingsOnWantedToDo,
            l10n: l10n,
            themeData: themeData,
            wantedToDo: wantToDoDescription,
            youDidLabelText: Messages.youDid(
              _diaryRecord,
              l10n,
              _userPreferredPronoun,
              personName: personName,
            ),
            youWantedToDoLabelText: Messages.youWantedToDo(
              _diaryRecord,
              l10n,
              _userPreferredPronoun,
              personName: personName,
            ),
          );
        }
        break;

      default:
        _appendContentForOnePerson(
          dayContent: dayContent,
          done: _diaryRecord.done,
          emotionsAndFeelingsOnDone: _diaryRecord.emotionsAndFeelingsOnDone,
          emotionsAndFeelingsOnWantedToDo:
              _diaryRecord.emotionsAndFeelingsOnWantToDo,
          l10n: l10n,
          themeData: themeData,
          wantedToDo: _diaryRecord.wantToDo,
          youDidLabelText: Messages.youDid(
            _diaryRecord,
            l10n,
            _userPreferredPronoun,
          ),
          youWantedToDoLabelText: Messages.youWantedToDo(
            _diaryRecord,
            l10n,
            _userPreferredPronoun,
          ),
        );
        break;
    }

    return Container(
      decoration: BoxDecoration(
        border: BorderDirectional(
          top: BorderSide(
            style: BorderStyle.solid,
            color: themeData.dividerColor,
          ),
        ),
      ),
      margin: EdgeInsets.only(top: 20),
      padding: EdgeInsets.only(top: 10),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: dayContent,
            ),
          ),
        ],
      ),
    );
  }
}
