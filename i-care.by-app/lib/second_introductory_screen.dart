import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'diary_platform_interface.dart'
    if (dart.library.io) 'diary_io.dart'
    if (dart.library.html) 'diary_web.dart';
import 'scaffold_helpers.dart';
import 'text_utils.dart';

class SecondIntroductoryScreen extends StatelessWidget {
  const SecondIntroductoryScreen(
    Diary diary,
    Function() onNext, {
    super.key,
  })  : _diary = diary,
        _onNext = onNext;

  final Diary _diary;
  final Function() _onNext;

  @override
  Widget build(BuildContext context) {
    AppLocalizations l10n = AppLocalizations.of(context);

    String userName = _diary.getNotEmptyUserName(l10n);
    String userPreferredPronoun = _diary.userPreferredPronoun ?? '';

    List<InlineSpan> majorContent = TextUtils.buildSpansFromText(
      l10n.responseToUserIntroduction(
        userName,
        userPreferredPronoun,
        _diary.getBriefExplanationWhereToFindDiary(l10n),
      ),
      [],
    );

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
