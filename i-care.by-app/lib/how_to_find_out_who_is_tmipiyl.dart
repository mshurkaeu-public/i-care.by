import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'asset_image_with_caption.dart';
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
            child: AssetImageWithCaption(
              assetName:
                  'assets/images/how-to-find-out-who-is-tmipiyl-scale-640.jpg',
              caption: 'Image by Arek Socha from Pixabay',
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
            child: AssetImageWithCaption(
              assetName:
                  'assets/images/how-to-find-out-who-is-tmipiyl-sound-wave-640.jpg',
              caption: 'Image by Pete Linforth from Pixabay',
            ),
          ),
        ),
        MapEntry(
          '\$several_people_graph_example',
          WidgetSpan(
            child: AssetImageWithCaption(
              assetName:
                  'assets/images/how-to-find-out-who-is-tmipiyl-graph-640.jpg',
              caption: 'Image by Mediamodifier from Pixabay',
            ),
          ),
        ),
      ],
    );

    List<InlineSpan> chapter03 = TextUtils.buildSpansFromText(
      l10n.howToFindOutWhoIsTmipiyl_chapter03_text(
        userName,
        userPreferredPronoun,
      ),
      [
        MapEntry(
          '\$emotions_measures',
          WidgetSpan(
            child: AssetImageWithCaption(
              assetName:
                  'assets/images/how-to-find-out-who-is-tmipiyl-colores-a-medida-640.jpg',
              caption: 'Photo by Patricia Serna on Unsplash',
            ),
          ),
        ),
        MapEntry(
          '\$time_measures',
          WidgetSpan(
            child: AssetImageWithCaption(
              assetName:
                  'assets/images/how-to-find-out-who-is-tmipiyl-time-640.jpg',
              caption: 'Image by Gerd Altmann from Pixabay',
            ),
          ),
        ),
        MapEntry(
          '\$aircraft_gauges',
          WidgetSpan(
            child: AssetImageWithCaption(
              assetName:
                  'assets/images/how-to-find-out-who-is-tmipiyl-aircraft-640.jpg',
              caption: 'Image by Nel Botha from Pixabay',
            ),
          ),
        ),
        MapEntry(
          '\$submarine_gauges',
          WidgetSpan(
            child: AssetImageWithCaption(
              assetName:
                  'assets/images/how-to-find-out-who-is-tmipiyl-submarine-640.jpg',
              caption: 'Image by Achim Scholty from Pixabay',
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
                TextSpan(
                  text: l10n.howToFindOutWhoIsTmipiyl_chapter03_title(
                    userPreferredPronoun,
                  ),
                  style: titleStyle,
                ),
                ...chapter03,
              ],
            ),
          ),
        ],
      ),
    );
  }
}
