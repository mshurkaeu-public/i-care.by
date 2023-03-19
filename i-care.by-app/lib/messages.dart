import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'diary_record.dart';
import 'the_most_important_person_in_my_life.dart';
import 'tmipiml_is_child.dart';
import 'tmipiml_is_grandparent.dart';
import 'tmipiml_is_parent.dart';
import 'tmipiml_is_spouce_or_partner.dart';

class Messages {
  static String whatDidYouDoToday(
    DiaryRecord diaryRecord,
    AppLocalizations l10n,
    String userName,
    String userPreferredPronoun, {
    String personName = '',
  }) {
    String res;
    switch (diaryRecord.who) {
      case null:
        res = l10n.whatDidYouDoForYourselfToday(userName, userPreferredPronoun);
        break;

      case TheMostImportantPersonInMyLife.absent:
        res = l10n.whatDidYouDoForYourselfToday(userName, userPreferredPronoun);
        break;

      case TheMostImportantPersonInMyLife.another:
        res = l10n.whatDidYouDoForThePersonToday(
          userName,
          userPreferredPronoun,
          diaryRecord.whoName ?? l10n.thereIsNoData,
        );
        break;

      case TheMostImportantPersonInMyLife.child:
        switch (diaryRecord.whoSubclass as TmipimlIsChild?) {
          case null:
            res = l10n.whatDidYouDoForYourChildToday(
              userName,
              userPreferredPronoun,
            );
            break;

          case TmipimlIsChild.daughter:
            res = l10n.whatDidYouDoForYourDaughterToday(
              userName,
              userPreferredPronoun,
            );
            break;

          case TmipimlIsChild.son:
            res = l10n.whatDidYouDoForYourSonToday(
              userName,
              userPreferredPronoun,
            );
            break;
        }
        break;

      case TheMostImportantPersonInMyLife.dontKnow:
        res = l10n.whatDidYouDoForYourselfToday(userName, userPreferredPronoun);
        break;

      case TheMostImportantPersonInMyLife.grandparent:
        switch (diaryRecord.whoSubclass as TmipimlIsGrandparent?) {
          case null:
            res = l10n.whatDidYouDoForYourGrandparentToday(
              userName,
              userPreferredPronoun,
            );
            break;

          case TmipimlIsGrandparent.grandfather:
            res = l10n.whatDidYouDoForYourGrandfatherToday(
              userName,
              userPreferredPronoun,
            );
            break;

          case TmipimlIsGrandparent.grandmother:
            res = l10n.whatDidYouDoForYourGrandmotherToday(
              userName,
              userPreferredPronoun,
            );
            break;
        }
        break;

      case TheMostImportantPersonInMyLife.me:
        res = l10n.whatDidYouDoForYourselfToday(userName, userPreferredPronoun);
        break;

      case TheMostImportantPersonInMyLife.parent:
        switch (diaryRecord.whoSubclass as TmipimlIsParent?) {
          case null:
            res = l10n.whatDidYouDoForYourParentToday(
              userName,
              userPreferredPronoun,
            );
            break;

          case TmipimlIsParent.father:
            res = l10n.whatDidYouDoForYourFatherToday(
              userName,
              userPreferredPronoun,
            );
            break;

          case TmipimlIsParent.mother:
            res = l10n.whatDidYouDoForYourMotherToday(
              userName,
              userPreferredPronoun,
            );
            break;
        }
        break;

      case TheMostImportantPersonInMyLife.several:
        if (personName == l10n.theMipiylOption_you) {
          res = l10n.whatDidYouDoForYourselfToday(
            userName,
            userPreferredPronoun,
          );
        } else {
          res = l10n.whatDidYouDoForThePersonToday(
            userName,
            userPreferredPronoun,
            personName,
          );
        }
        break;

      case TheMostImportantPersonInMyLife.spouseOrPartner:
        switch (diaryRecord.whoSubclass as TmipimlIsSpouceOrPartner?) {
          case null:
            res = l10n.whatDidYouDoForYourSpouseOrPartnerToday(
              userName,
              userPreferredPronoun,
            );
            break;

          case TmipimlIsSpouceOrPartner.boyfriend:
            res = l10n.whatDidYouDoForYourBoyfriendToday(
              userName,
              userPreferredPronoun,
            );
            break;

          case TmipimlIsSpouceOrPartner.girlfriend:
            res = l10n.whatDidYouDoForYourGirlfriendToday(
              userName,
              userPreferredPronoun,
            );
            break;

          case TmipimlIsSpouceOrPartner.husband:
            res = l10n.whatDidYouDoForYourHusbandToday(
              userName,
              userPreferredPronoun,
            );
            break;

          case TmipimlIsSpouceOrPartner.wife:
            res = l10n.whatDidYouDoForYourWifeToday(
              userName,
              userPreferredPronoun,
            );
            break;
        }
        break;
    }
    return res;
  }

  static String whatDoYouWantToDo(
    DiaryRecord diaryRecord,
    AppLocalizations l10n,
    String userName,
    String userPreferredPronoun, {
    String personName = '',
  }) {
    String res;
    switch (diaryRecord.who) {
      case null:
      case TheMostImportantPersonInMyLife.absent:
      case TheMostImportantPersonInMyLife.dontKnow:
        throw UnimplementedError();

      case TheMostImportantPersonInMyLife.another:
        res = l10n.whatDoYouWantToDoFor_another(
          userName,
          userPreferredPronoun,
          diaryRecord.whoName ?? l10n.thereIsNoData,
        );
        break;

      case TheMostImportantPersonInMyLife.child:
        switch (diaryRecord.whoSubclass as TmipimlIsChild?) {
          case null:
            throw UnimplementedError();

          case TmipimlIsChild.daughter:
            res = l10n.whatDoYouWantToDoFor_child_daughter(
              userName,
              userPreferredPronoun,
            );
            break;

          case TmipimlIsChild.son:
            res = l10n.whatDoYouWantToDoFor_child_son(
              userName,
              userPreferredPronoun,
            );
            break;
        }
        break;

      case TheMostImportantPersonInMyLife.grandparent:
        switch (diaryRecord.whoSubclass as TmipimlIsGrandparent?) {
          case null:
            throw UnimplementedError();

          case TmipimlIsGrandparent.grandfather:
            res = l10n.whatDoYouWantToDoFor_grandparent_grandfather(
              userName,
              userPreferredPronoun,
            );
            break;

          case TmipimlIsGrandparent.grandmother:
            res = l10n.whatDoYouWantToDoFor_grandparent_grandmother(
              userName,
              userPreferredPronoun,
            );
            break;
        }
        break;

      case TheMostImportantPersonInMyLife.me:
        res =
            l10n.whatDoYouWantToDoFor_yourself(userName, userPreferredPronoun);
        break;

      case TheMostImportantPersonInMyLife.parent:
        switch (diaryRecord.whoSubclass as TmipimlIsParent?) {
          case null:
            throw UnimplementedError();

          case TmipimlIsParent.father:
            res = l10n.whatDoYouWantToDoFor_parent_father(
              userName,
              userPreferredPronoun,
            );
            break;

          case TmipimlIsParent.mother:
            res = l10n.whatDoYouWantToDoFor_parent_mother(
              userName,
              userPreferredPronoun,
            );
            break;
        }
        break;

      case TheMostImportantPersonInMyLife.several:
        if (personName == l10n.theMipiylOption_you) {
          res = l10n.whatDoYouWantToDoFor_yourself(
            userName,
            userPreferredPronoun,
          );
        } else {
          res = l10n.whatDoYouWantToDoFor_another(
            userName,
            userPreferredPronoun,
            personName,
          );
        }
        break;

      case TheMostImportantPersonInMyLife.spouseOrPartner:
        switch (diaryRecord.whoSubclass as TmipimlIsSpouceOrPartner?) {
          case null:
            throw UnimplementedError();

          case TmipimlIsSpouceOrPartner.boyfriend:
            res = l10n.whatDoYouWantToDoFor_spouseOrPartner_boyfriend(
              userName,
              userPreferredPronoun,
            );
            break;

          case TmipimlIsSpouceOrPartner.girlfriend:
            res = l10n.whatDoYouWantToDoFor_spouseOrPartner_girlfriend(
              userName,
              userPreferredPronoun,
            );
            break;

          case TmipimlIsSpouceOrPartner.husband:
            res = l10n.whatDoYouWantToDoFor_spouseOrPartner_husband(
              userName,
              userPreferredPronoun,
            );
            break;

          case TmipimlIsSpouceOrPartner.wife:
            res = l10n.whatDoYouWantToDoFor_spouseOrPartner_wife(
              userName,
              userPreferredPronoun,
            );
            break;
        }
        break;
    }
    return res;
  }

  static String youAnsweredThatTmipiylWas(
    DiaryRecord diaryRecord,
    AppLocalizations l10n,
    String userName,
    String userPreferredPronoun,
  ) {
    String res;
    switch (diaryRecord.who) {
      case TheMostImportantPersonInMyLife.absent:
        res = l10n.youAnsweredThatTmipiylWas_absent(
          userName,
          userPreferredPronoun,
        );
        break;

      case TheMostImportantPersonInMyLife.dontKnow:
        res = l10n.youAnsweredThatTmipiylWas_dontKnow(
          userName,
          userPreferredPronoun,
        );
        break;

      default:
        throw UnimplementedError();
    }

    return res;
  }

  static String youDid(
    DiaryRecord diaryRecord,
    AppLocalizations l10n,
    String userPreferredPronoun, {
    String personName = '',
  }) {
    String res;
    switch (diaryRecord.who) {
      case null:
        res = l10n.youDid(userPreferredPronoun);
        break;

      case TheMostImportantPersonInMyLife.absent:
        res = l10n.youDidForYourself(userPreferredPronoun);
        break;

      case TheMostImportantPersonInMyLife.another:
        res = l10n.youDidForThePerson(
          userPreferredPronoun,
          diaryRecord.whoName ?? l10n.thereIsNoData,
        );
        break;

      case TheMostImportantPersonInMyLife.child:
        switch (diaryRecord.whoSubclass as TmipimlIsChild?) {
          case null:
            res = l10n.youDidForYourChild(userPreferredPronoun);
            break;

          case TmipimlIsChild.daughter:
            res = l10n.youDidForYourDaughter(userPreferredPronoun);
            break;

          case TmipimlIsChild.son:
            res = l10n.youDidForYourSon(userPreferredPronoun);
            break;
        }
        break;

      case TheMostImportantPersonInMyLife.dontKnow:
        res = l10n.youDidForYourself(userPreferredPronoun);
        break;

      case TheMostImportantPersonInMyLife.grandparent:
        switch (diaryRecord.whoSubclass as TmipimlIsGrandparent?) {
          case null:
            res = l10n.youDidForYourGrandparent(userPreferredPronoun);
            break;

          case TmipimlIsGrandparent.grandfather:
            res = l10n.youDidForYourGrandfather(userPreferredPronoun);
            break;

          case TmipimlIsGrandparent.grandmother:
            res = l10n.youDidForYourGrandmother(userPreferredPronoun);
            break;
        }
        break;

      case TheMostImportantPersonInMyLife.me:
        res = l10n.youDid(userPreferredPronoun);
        break;

      case TheMostImportantPersonInMyLife.parent:
        switch (diaryRecord.whoSubclass as TmipimlIsParent?) {
          case null:
            res = l10n.youDidForYourParent(userPreferredPronoun);
            break;

          case TmipimlIsParent.father:
            res = l10n.youDidForYourFather(userPreferredPronoun);
            break;

          case TmipimlIsParent.mother:
            res = l10n.youDidForYourMother(userPreferredPronoun);
            break;
        }
        break;

      case TheMostImportantPersonInMyLife.several:
        if (personName == l10n.theMipiylOption_you) {
          res = l10n.youDidForYourself(userPreferredPronoun);
        } else {
          res = l10n.youDidForThePerson(userPreferredPronoun, personName);
        }
        break;

      case TheMostImportantPersonInMyLife.spouseOrPartner:
        switch (diaryRecord.whoSubclass as TmipimlIsSpouceOrPartner?) {
          case null:
            res = l10n.youDidForYourSpouseOrPartner(userPreferredPronoun);
            break;

          case TmipimlIsSpouceOrPartner.boyfriend:
            res = l10n.youDidForYourBoyfriend(userPreferredPronoun);
            break;

          case TmipimlIsSpouceOrPartner.girlfriend:
            res = l10n.youDidForYourGirlfriend(userPreferredPronoun);
            break;

          case TmipimlIsSpouceOrPartner.husband:
            res = l10n.youDidForYourHusband(userPreferredPronoun);
            break;

          case TmipimlIsSpouceOrPartner.wife:
            res = l10n.youDidForYourWife(userPreferredPronoun);
            break;
        }
        break;
    }

    return res;
  }

  static String youWantedToDo(
    DiaryRecord diaryRecord,
    AppLocalizations l10n,
    String userPreferredPronoun, {
    String personName = '',
  }) {
    String res;
    switch (diaryRecord.who) {
      case null:
        res = l10n.youWantedToDo(userPreferredPronoun);
        break;

      case TheMostImportantPersonInMyLife.absent:
        res = l10n.youWantedToDo(userPreferredPronoun);
        break;

      case TheMostImportantPersonInMyLife.another:
        res = l10n.youWantedToDoForThePerson(
          userPreferredPronoun,
          diaryRecord.whoName ?? l10n.thereIsNoData,
        );
        break;

      case TheMostImportantPersonInMyLife.child:
        switch (diaryRecord.whoSubclass as TmipimlIsChild?) {
          case null:
            res = l10n.youWantedToDoForYourChild(userPreferredPronoun);
            break;

          case TmipimlIsChild.daughter:
            res = l10n.youWantedToDoForYourDaughter(userPreferredPronoun);
            break;

          case TmipimlIsChild.son:
            res = l10n.youWantedToDoForYourSon(userPreferredPronoun);
            break;
        }
        break;

      case TheMostImportantPersonInMyLife.dontKnow:
        res = l10n.youWantedToDo(userPreferredPronoun);
        break;

      case TheMostImportantPersonInMyLife.grandparent:
        switch (diaryRecord.whoSubclass as TmipimlIsGrandparent?) {
          case null:
            res = l10n.youWantedToDoForYourGrandparent(userPreferredPronoun);
            break;

          case TmipimlIsGrandparent.grandfather:
            res = l10n.youWantedToDoForYourGrandfather(userPreferredPronoun);
            break;

          case TmipimlIsGrandparent.grandmother:
            res = l10n.youWantedToDoForYourGrandmother(userPreferredPronoun);
            break;
        }
        break;

      case TheMostImportantPersonInMyLife.me:
        res = l10n.youWantedToDo(userPreferredPronoun);
        break;

      case TheMostImportantPersonInMyLife.parent:
        switch (diaryRecord.whoSubclass as TmipimlIsParent?) {
          case null:
            res = l10n.youWantedToDoForYourParent(userPreferredPronoun);
            break;

          case TmipimlIsParent.father:
            res = l10n.youWantedToDoForYourFather(userPreferredPronoun);
            break;

          case TmipimlIsParent.mother:
            res = l10n.youWantedToDoForYourMother(userPreferredPronoun);
            break;
        }
        break;

      case TheMostImportantPersonInMyLife.several:
        if (personName == l10n.theMipiylOption_you) {
          res = l10n.youWantedToDoForYourself(userPreferredPronoun);
        } else {
          res = l10n.youWantedToDoForThePerson(
            userPreferredPronoun,
            personName,
          );
        }
        break;

      case TheMostImportantPersonInMyLife.spouseOrPartner:
        switch (diaryRecord.whoSubclass as TmipimlIsSpouceOrPartner?) {
          case null:
            res =
                l10n.youWantedToDoForYourSpouseOrPartner(userPreferredPronoun);
            break;

          case TmipimlIsSpouceOrPartner.boyfriend:
            res = l10n.youWantedToDoForYourBoyfriend(userPreferredPronoun);
            break;

          case TmipimlIsSpouceOrPartner.girlfriend:
            res = l10n.youWantedToDoForYourGirlfriend(userPreferredPronoun);
            break;

          case TmipimlIsSpouceOrPartner.husband:
            res = l10n.youWantedToDoForYourHusband(userPreferredPronoun);
            break;

          case TmipimlIsSpouceOrPartner.wife:
            res = l10n.youWantedToDoForYourWife(userPreferredPronoun);
            break;
        }
        break;
    }

    return res;
  }
}
