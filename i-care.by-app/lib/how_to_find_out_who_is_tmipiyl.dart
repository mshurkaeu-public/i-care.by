import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'text_utils.dart';

class HowToFindOutWhoIsTmipiyl extends StatelessWidget {
  const HowToFindOutWhoIsTmipiyl({
    required this.userName,
    required this.userPreferredPronoun,
  });

  final String userName;
  final String userPreferredPronoun;

  @override
  Widget build(BuildContext context) {
    AppLocalizations l10n = AppLocalizations.of(context);

    ThemeData themeData = Theme.of(context);
    TextStyle titleStyle = TextStyle(fontWeight: FontWeight.bold);
    TextStyle imageCreditsStyle = themeData.textTheme.bodySmall ?? const TextStyle();
    imageCreditsStyle = imageCreditsStyle.merge(
      TextStyle(color: themeData.disabledColor),
    );

    List<InlineSpan> chapter00 = TextUtils.buildSpansFromText(
      l10n.howToFindOutWhoIsTmipiyl_chapter00_text(
        userName,
        userPreferredPronoun,
      ),
      [
        MapEntry(
          '\$in_doubt_image',
          WidgetSpan(
            child: Center(
              child: Image.asset(
                'assets/images/how-to-find-out-who-is-tmipiyl-scale-640.jpg',
                filterQuality: FilterQuality.medium,
              ),
            ),
          ),
        ),
      ],
    );

    List<InlineSpan> chapter02 = TextUtils.buildSpansFromText(
      l10n.howToFindOutWhoIsTmipiyl_chapter02_text(
        userName,
        userPreferredPronoun,
      ),
      [
        MapEntry(
          '\$graph_example',
          WidgetSpan(
            child: Center(
              child: Column(
                children: [
                  Image.asset(
                    'assets/images/how-to-find-out-who-is-tmipiyl-sound-wave-640.jpg',
                    filterQuality: FilterQuality.medium,
                  ),
                  Text(
                    'Image by Pete Linforth from Pixabay',
                    style: imageCreditsStyle,
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );

    return Scaffold(
      appBar: AppBar(
        title: Text(
          l10n.howToFindOutWhoIsTmipiyl_title(userPreferredPronoun),
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          Text.rich(
            TextSpan(
              children: [
                TextSpan(
                  text: l10n.howToFindOutWhoIsTmipiyl_chapter00_title,
                  style: titleStyle,
                ),
                ...chapter00,
                TextSpan(
                  text: l10n.howToFindOutWhoIsTmipiyl_chapter01_title,
                  style: titleStyle,
                ),
                TextSpan(
                  text: l10n.howToFindOutWhoIsTmipiyl_chapter01_text(
                    userName,
                    userPreferredPronoun,
                  ),
                ),
                TextSpan(
                  text: l10n.howToFindOutWhoIsTmipiyl_chapter02_title(
                    userPreferredPronoun,
                  ),
                  style: titleStyle,
                ),
                ...chapter02,
              ],
            ),
          ),
        ],
      ),
    );
  }
}
