import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:icare_by_app/asset_image_with_caption.dart';

import 'diary_platform_interface.dart'
    if (dart.library.io) 'diary_io.dart'
    if (dart.library.html) 'diary_web.dart';
import 'scaffold_helpers.dart';
import 'text_utils.dart';

class SecondIntroductoryScreen extends StatefulWidget {
  const SecondIntroductoryScreen(
    Diary diary,
    Function() onNext, {
    super.key,
  })  : _diary = diary,
        _onNext = onNext;

  final Diary _diary;
  final Function() _onNext;

  @override
  State<SecondIntroductoryScreen> createState() =>
      _SecondIntroductoryScreenState();
}

class _SecondIntroductoryScreenState extends State<SecondIntroductoryScreen> {
  final TapGestureRecognizer _backToCorrectTheNameTapRecognizer =
      TapGestureRecognizer();

  void _backToCorrectTheName() {
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    AppLocalizations l10n = AppLocalizations.of(context);

    String userName = widget._diary.getNotEmptyUserName(l10n);
    String userPreferredPronoun = widget._diary.userPreferredPronoun ?? '';

    ThemeData themeData = Theme.of(context);
    TextStyle changeAnswerStyle = TextStyle(
      color: themeData.disabledColor,
      decoration: TextDecoration.underline,
    );

    List<InlineSpan> majorContent = TextUtils.buildSpansFromText(
      l10n.secondIntroductoryScreen_text(
        userName,
        userPreferredPronoun,
        widget._diary.getBriefExplanationWhereToFindDiary(l10n),
      ),
      [
        MapEntry(
          '\$back_to_correct_the_name',
          TextSpan(
            text: l10n.secondIntroductoryScreen_backToCorrectTheName,
            recognizer: _backToCorrectTheNameTapRecognizer,
            style: changeAnswerStyle,
          ),
        ),
        MapEntry(
          '\$powerful_flow',
          WidgetSpan(
            child: AssetImageWithCaption(
              assetName:
                  'assets/images/second-introductory-screen-flood-uk-2015-640.jpg',
              caption:
                  'Photo by Chris Gallagher on Unsplash\n\n${l10n.secondIntroductoryScreen_powerfulFlowComment}',
            ),
          ),
        ),
      ],
    );

    return ScaffoldHelpers.wrapIntoScaffold(
      context: context,
      drawer: Drawer(
        child: ListView(
          children: [
            ScaffoldHelpers.buildViewBackupsListTile(context),
            ScaffoldHelpers.buildAboutTheApplicationListTile(
              context: context,
              userName: userName,
              userPreferredPronoun: userPreferredPronoun,
            ),
          ],
        ),
      ),
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
            onPressed: widget._onNext,
            child: Text(l10n.yesLetsTryIt),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _backToCorrectTheNameTapRecognizer.dispose();

    super.dispose();
  }

  @override
  void initState() {
    super.initState();

    _backToCorrectTheNameTapRecognizer.onTap = _backToCorrectTheName;
  }
}
