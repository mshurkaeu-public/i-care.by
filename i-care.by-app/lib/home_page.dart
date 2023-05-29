import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:intl/intl.dart';

import 'about_page.dart';
import 'diary_platform_interface.dart'
    if (dart.library.io) 'diary_io.dart'
    if (dart.library.html) 'diary_web.dart';
import 'diary_record.dart';
import 'display_diary_record.dart';
import 'edit_diary_record.dart';
import 'known_diary_states.dart';
import 'request_user_info.dart';
import 'scaffold_helpers.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late Future<void>? _asyncOperationFuture;
  final Diary _diary = Diary();
  KnownDiaryStates? _knownDiaryState;
  bool _needToRecordVisit = true;

  Widget _buildFullContent(BuildContext context, KnownDiaryStates? diaryState) {
    Widget? drawer;
    Widget? floatingActionButton;
    Widget pageContent;

    AppLocalizations l10n = AppLocalizations.of(context);

    switch (diaryState) {
      case null:
        //we don't know state of user's diary yet
        pageContent = _AsyncOperationIndicator(
            _asyncOperationFuture!,
            (BuildContext context) =>
                AppLocalizations.of(context).waitForDiaryCheck(''),
            (BuildContext context, Object error) => AppLocalizations.of(context)
                .errorDuringInitialDiaryCheck(error.toString()));
        break;

      case KnownDiaryStates.doesntExist:
      case KnownDiaryStates.absolutelyEmpty:
        pageContent = RequestUserInfo(
          introductoryTextProvider: l10n.firstMeetingIntroduction,
          onSubmitUserInfo: _onSubmitUserInfoTheVeryFirstTime,
          supportedPronounsProvider: () => l10n.pronounOptions_values,
        );
        break;

      case KnownDiaryStates.valid:
        if (_needToRecordVisit) {
          _asyncOperationFuture = _updateRecentVisitTimeOnceOnStart();
        }

        if (_asyncOperationFuture != null) {
          pageContent = _AsyncOperationIndicator(
            _asyncOperationFuture!,
            (BuildContext context) {
              AppLocalizations l10n = AppLocalizations.of(context);

              return l10n.waitForDiarySave(
                _diary.getNotEmptyUserName(l10n),
                _diary.userPreferredPronoun ?? '',
              );
            },
            (BuildContext context, Object error) => AppLocalizations.of(context)
                .errorDuringDiarySave(error.toString()),
          );
        } else {
          drawer = Drawer(
            child: ListView(
              children: [
                ListTile(
                  title: Text(_diary.getNotEmptyUserName(l10n)),
                  trailing: const Icon(Icons.edit),
                  onTap: _onUserInfoEdit,
                ),
                ScaffoldHelpers.buildViewBackupsListTile(context),
                // TODO: implement review of saved data
                ListTile(
                  title: const Text('Захаваныя дадзеныя'),
                  onTap: () {
                    Navigator.pop(context);
                    showAboutDialog(
                      context: context,
                      children: [
                        const Text(
                            'Функцыя прагляду захаваных дадзеных пакуль што не зроблена.'),
                      ],
                    );
                  },
                ),
                ListTile(
                  title: Text(
                    MaterialLocalizations.of(context)
                        .aboutListTileTitle('i-care.by'),
                  ),
                  onTap: () {
                    NavigatorState navigator = Navigator.of(context);
                    navigator.pop();
                    navigator.push(
                      MaterialPageRoute(
                        builder: (BuildContext context) => AboutPage(
                          userName: _diary.getNotEmptyUserName(l10n),
                          userPreferredPronoun:
                              _diary.userPreferredPronoun ?? '',
                        ),
                      ),
                    );
                  },
                ),
              ],
            ),
          );

          pageContent = _MainScreen(_diary);
          floatingActionButton = FloatingActionButton(
            onPressed: _editTodayRecord,
            tooltip: l10n.homePageFloatingActionButtonTooltip,
            child: const Icon(Icons.edit),
          );
        }
        break;
    }

    return ScaffoldHelpers.wrapIntoScaffold(
      context: context,
      pageContent: pageContent,
      drawer: drawer,
      floatingActionButton: floatingActionButton,
    );
  }

  Future<void> _checkDiaryState() async {
    KnownDiaryStates diaryState = await _diary.reloadState();
    setState(() {
      _knownDiaryState = diaryState;
      _asyncOperationFuture = null;
    });
  }

  void _editTodayRecord() {
    Navigator.of(context).push(MaterialPageRoute(
      builder: (BuildContext context) => EditDiaryRecord(
          _diary, _diary.getTodayRecord(), _onSubmitDiaryRecordChanges),
    ));
  }

  void _onSubmitDiaryRecordChanges(DiaryRecord diaryRecord) {
    setState(() {
      _asyncOperationFuture = _saveDiaryRecord(diaryRecord);
    });
    Navigator.of(context).popUntil((route) => route.isFirst);
  }

  void _onSubmitUserInfo(String userName, String preferredPronoun) {
    Navigator.pop(context);

    _diary.userName = userName;
    _diary.userPreferredPronoun = preferredPronoun;
    setState(() {
      _asyncOperationFuture = _saveDiary();
    });
  }

  void _onSubmitUserInfoTheVeryFirstTime(
    String userName,
    String preferredPronoun,
  ) {
    _diary.userName = userName;
    _diary.userPreferredPronoun = preferredPronoun;

    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (BuildContext context) => _ResponseToUserIntroduction(
          _diary,
          _onUserDecidedToTryTheApp,
        ),
      ),
    );
  }

  void _onUserDecidedToTryTheApp() {
    setState(() {
      _knownDiaryState = KnownDiaryStates.valid;
    });
    Navigator.of(context).pop();
  }

  void _onUserInfoEdit() {
    NavigatorState navigator = Navigator.of(context);
    navigator.pop();

    AppLocalizations l10n = AppLocalizations.of(context);
    navigator.push(MaterialPageRoute(
      builder: (BuildContext context) {
        return ScaffoldHelpers.wrapIntoScaffold(
          context: context,
          pageContent: RequestUserInfo(
            initialUserNameValue: _diary.userName ?? '',
            initialPreferredPronounValue: _diary.userPreferredPronoun,
            introductoryTextProvider: (String preferredPronoun) {
              return l10n.askUserToReviewAndEditUserInfo(
                  _diary.getNotEmptyUserName(l10n), preferredPronoun);
            },
            onSubmitUserInfo: _onSubmitUserInfo,
            supportedPronounsProvider: () => l10n.pronounOptions_values,
          ),
        );
      },
    ));
  }

  Future<void> _saveDiary() async {
    await _diary.saveModifications();
    setState(() {
      _asyncOperationFuture = null;
    });
  }

  Future<void> _saveDiaryRecord(DiaryRecord diaryRecord) async {
    await _diary.saveModifications(modifiedRecord: diaryRecord);
    setState(() {
      _asyncOperationFuture = null;
    });
  }

  Future<void> _updateRecentVisitTimeOnceOnStart() async {
    //await Future.delayed(Duration(seconds: 5));
    //throw UnimplementedError('error triggered just for test');

    _diary.updateRecentVisitTime();
    await _diary.saveModifications();
    setState(() {
      _needToRecordVisit = false;
      _asyncOperationFuture = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    return _buildFullContent(context, _knownDiaryState);
  }

  @override
  void initState() {
    super.initState();

    _asyncOperationFuture = _checkDiaryState();
  }
}

class _AsyncOperationIndicator extends StatelessWidget {
  const _AsyncOperationIndicator(
      Future<void> asyncOperationFuture,
      String Function(BuildContext) buildInProgressMessage,
      String Function(BuildContext, Object) buildErrorMessage)
      : _asyncOperationFuture = asyncOperationFuture,
        _buildInProgressMessage = buildInProgressMessage,
        _buildErrorMessage = buildErrorMessage;

  final Future<void> _asyncOperationFuture;
  final String Function(BuildContext, Object) _buildErrorMessage;
  final String Function(BuildContext) _buildInProgressMessage;

  Widget _myBuilder(BuildContext context, AsyncSnapshot<void> snapshot) {
    Widget aSign;
    String aMessage;

    if (snapshot.hasError) {
      aSign = const Icon(
        Icons.error_outline,
        color: Colors.red,
        size: 60,
      );
      aMessage = _buildErrorMessage(context, snapshot.error!);
    } else {
      aSign = const SizedBox(
        width: 60,
        height: 60,
        child: CircularProgressIndicator(),
      );
      aMessage = _buildInProgressMessage(context);
    }

    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          aSign,
          const SizedBox(height: 20),
          Text(aMessage),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<void>(
      future: _asyncOperationFuture,
      builder: _myBuilder,
    );
  }
}

class _MainScreen extends StatelessWidget {
  const _MainScreen(Diary diary) : _diary = diary;

  final Diary _diary;

  @override
  Widget build(BuildContext context) {
    AppLocalizations l10n = AppLocalizations.of(context);
    List<Widget> content = [];

    // possible situations:
    // 1. There are no records yet. In such case tell this to the user. And propose how to start diary usage.
    // 2. There are some records.
    //   2.1. The latest record is from 3 or more days ago, but there were visits to the app during that period. In such case ask the user if that was he/she
    //        and ask how is he/she.
    //   2.2. The latest record is from 3 or more days ago and there were no visits to the app since that moment. Then ask the user if anything happened and
    //        ask how is he/she.
    // 3. If records count is less than 8 then remind user what is on the screen and how it works.
    int recordsCount = _diary.getRecordsCount();
    String? latestRecordDateAsString = _diary.getLatestRecordDateAsString();
    int? daysSinceLatestRecord;
    int? daysBetweenPreviousVisitAndTheLatestRecord;
    DateTime? previousVisitDateTime =
        _diary.getTimeOfTheVisitBeforeTheLatestOne();

    if (latestRecordDateAsString != null) {
      DateTime latestRecordDate = DateTime.parse(latestRecordDateAsString);

      daysSinceLatestRecord =
          DateTime.now().difference(latestRecordDate).inDays;

      if (previousVisitDateTime != null) {
        daysBetweenPreviousVisitAndTheLatestRecord =
            DateUtils.dateOnly(previousVisitDateTime)
                .difference(latestRecordDate)
                .inDays;
      }
    }

    String welcomeMessage;
    String userName = _diary.getNotEmptyUserName(l10n);
    String userPreferredPronoun = _diary.userPreferredPronoun ?? '';
    if (recordsCount == 0) {
      welcomeMessage = l10n.welcomeMessageWhenThereAreNoRecordsInDiary(
          userName, userPreferredPronoun);
    } else if ((daysSinceLatestRecord != null) &&
        (daysSinceLatestRecord >= 3) &&
        (daysBetweenPreviousVisitAndTheLatestRecord != null) &&
        (daysBetweenPreviousVisitAndTheLatestRecord >= 1)) {
      // Latest record date is a date without time.
      // While previous visit is recorded with time.
      // I cannot ditinguish if it the user or somebody else using user's device.
      // But if there were visits *after* day of the latest record then let the user know about this.
      welcomeMessage = l10n
          .welcomeMessageWhenTheLatestRecordIsThreeDaysOrOlderAndThereWereVisitsAfterTheRecord(
              userName,
              userPreferredPronoun,
              // "daysSinceLatestRecord-1" because *full* empty days are required in fullEmptyDaysSinceLatestRecord
              daysSinceLatestRecord - 1,
              latestRecordDateAsString!,
              DateFormat('yyyy-MM-dd HH:mm:ss').format(previousVisitDateTime!));
    } else if ((daysSinceLatestRecord != null) &&
        (daysSinceLatestRecord >= 3)) {
      welcomeMessage = l10n.welcomeMessageWhenTheLatestRecordIsThreeDaysOrOlder(
          userName, userPreferredPronoun);
    } else if (recordsCount < 8) {
      welcomeMessage = l10n.welcomeMessageWhenProgramIsInUseLessThan8Days(
          userName, userPreferredPronoun);
    } else {
      welcomeMessage = l10n.welcomeMessage(userName, userPreferredPronoun);
    }

    content.add(Text(
      welcomeMessage,
      style: Theme.of(context).textTheme.titleMedium,
    ));

    if (recordsCount > 0) {
      List<dynamic> records = _diary.getRecords();
      for (dynamic record in records) {
        content.add(DisplayDiaryRecord(record, userPreferredPronoun));
      }
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: content,
    );
  }
}

class _ResponseToUserIntroduction extends StatelessWidget {
  const _ResponseToUserIntroduction(Diary diary, Function() onNext)
      : _diary = diary,
        _onNext = onNext;

  final Diary _diary;
  final Function() _onNext;

  @override
  Widget build(BuildContext context) {
    AppLocalizations l10n = AppLocalizations.of(context);

    String userName = _diary.getNotEmptyUserName(l10n);
    String userPreferredPronoun = _diary.userPreferredPronoun ?? '';

    List<InlineSpan> majorContent = [
      TextSpan(
        text: l10n.responseToUserIntroduction(
          userName,
          userPreferredPronoun,
          _diary.getBriefExplanationWhereToFindDiary(l10n),
        ),
      ),
    ];

    return ScaffoldHelpers.wrapIntoScaffold(
      context: context,
      pageContent: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text.rich(
            TextSpan(
              children: majorContent,
            ),
          ),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: _onNext,
            child: Text(l10n.yesLetsTryIt),
          ),
        ],
      ),
    );
  }
}
