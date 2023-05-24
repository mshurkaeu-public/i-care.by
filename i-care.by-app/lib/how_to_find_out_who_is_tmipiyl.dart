import 'package:carousel_slider/carousel_slider.dart';
import 'package:expandable_text/expandable_text.dart';
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
    TextStyle titleStyle = const TextStyle(fontWeight: FontWeight.bold);
    TextStyle imageCreditsStyle =
        themeData.textTheme.bodySmall ?? const TextStyle();
    imageCreditsStyle = imageCreditsStyle.merge(
      TextStyle(color: themeData.disabledColor),
    );

    const double photoWidth = 640;
    double photoHeight = 426;
    double photoAspectRatio = photoWidth / photoHeight;
    double maxWidth = MediaQuery.of(context).size.width - 20 * 2;
    double csWidth = (maxWidth > photoWidth) ? photoWidth : maxWidth;
    double scHeight = csWidth / photoAspectRatio +
        TextUtils.getTextSize(
          'P',
          l10n,
          style: themeData.textTheme.bodySmall,
        ).height +
        1;

    List<InlineSpan> chapter00 = TextUtils.buildSpansFromText(
      l10n.howToFindOutWhoIsTmipiyl_chapter00_text(
        userName,
        userPreferredPronoun,
      ),
      [
        MapEntry(
          '\$select_a_place_to_talk',
          WidgetSpan(
            child: _PlaceToTalkSelector(
              aspectRatio: csWidth / scHeight,
              height: scHeight,
              places: [
                const AssetImageWithCaption(
                  assetName:
                      'assets/images/how-to-find-out-who-is-tmipiyl-fireplace-640.jpg',
                  caption: 'Photo by Annie Spratt on Unsplash',
                ),
                const AssetImageWithCaption(
                  assetName:
                      'assets/images/how-to-find-out-who-is-tmipiyl-long-pond-640.jpg',
                  caption: 'Photo by Mick Haupt on Unsplash',
                ),
                const AssetImageWithCaption(
                  assetName:
                      'assets/images/how-to-find-out-who-is-tmipiyl-terrace-640.jpg',
                  caption: 'Photo by Alen Rojnic on Unsplash',
                ),
              ],
            ),
          ),
        ),
        const MapEntry(
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

    List<InlineSpan> chapter01 = TextUtils.buildSpansFromText(
      l10n.howToFindOutWhoIsTmipiyl_chapter01_text(
        userName,
        userPreferredPronoun,
      ),
      [
        MapEntry(
          '\$vocabularies_description',
          WidgetSpan(
            child: InputDecorator(
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                enabled: false,
              ),
              child: ExpandableText(
                l10n.howToFindOutWhoIsTmipiyl_chapter01_vocabularies_description(
                  userPreferredPronoun,
                ),
                expandText: l10n.showMoreText,
                collapseText: l10n.showLessText,
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
        const MapEntry(
          '\$graph_example',
          WidgetSpan(
            child: AssetImageWithCaption(
              assetName:
                  'assets/images/how-to-find-out-who-is-tmipiyl-sound-wave-640.jpg',
              caption: 'Image by Pete Linforth from Pixabay',
            ),
          ),
        ),
        const MapEntry(
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
        const MapEntry(
          '\$emotions_measures',
          WidgetSpan(
            child: AssetImageWithCaption(
              assetName:
                  'assets/images/how-to-find-out-who-is-tmipiyl-colores-a-medida-640.jpg',
              caption: 'Photo by Patricia Serna on Unsplash',
            ),
          ),
        ),
        const MapEntry(
          '\$time_measures',
          WidgetSpan(
            child: AssetImageWithCaption(
              assetName:
                  'assets/images/how-to-find-out-who-is-tmipiyl-time-640.jpg',
              caption: 'Image by Gerd Altmann from Pixabay',
            ),
          ),
        ),
        const MapEntry(
          '\$aircraft_gauges',
          WidgetSpan(
            child: AssetImageWithCaption(
              assetName:
                  'assets/images/how-to-find-out-who-is-tmipiyl-aircraft-640.jpg',
              caption: 'Photo by Nel Botha from Pixabay',
            ),
          ),
        ),
        const MapEntry(
          '\$submarine_gauges',
          WidgetSpan(
            child: AssetImageWithCaption(
              assetName:
                  'assets/images/how-to-find-out-who-is-tmipiyl-submarine-640.jpg',
              caption: 'Photo by Achim Scholty from Pixabay',
            ),
          ),
        ),
      ],
    );

    List<InlineSpan> chapter04 = TextUtils.buildSpansFromText(
      l10n.howToFindOutWhoIsTmipiyl_chapter04_text(
        userName,
        userPreferredPronoun,
      ),
      [
        const MapEntry(
          '\$infinite_number_of_choices',
          WidgetSpan(
            child: AssetImageWithCaption(
              assetName:
                  'assets/images/how-to-find-out-who-is-tmipiyl-doors-640.jpg',
              caption: 'Image by Arek Socha from Pixabay',
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
                ...chapter01,
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
                TextSpan(
                  text: l10n.howToFindOutWhoIsTmipiyl_chapter04_title,
                  style: titleStyle,
                ),
                ...chapter04,
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _PlaceToTalkSelector extends StatefulWidget {
  const _PlaceToTalkSelector({
    required this.aspectRatio,
    required this.height,
    required this.places,
  });

  final double aspectRatio;
  final double height;
  final List<Widget> places;

  @override
  State<_PlaceToTalkSelector> createState() => _PlaceToTalkSelectorState();
}

class _PlaceToTalkSelectorState extends State<_PlaceToTalkSelector> {
  final CarouselController _controller = CarouselController();

  void _toNextPlace() {
    _controller.nextPage();
  }

  void _toPreviousPlace() {
    _controller.previousPage();
  }

  @override
  Widget build(BuildContext context) {
    AppLocalizations l10n = AppLocalizations.of(context);
    ThemeData themeData = Theme.of(context);

    const double sideButtonPadding = 8;
    ButtonStyle swipeButtonStyle = TextButton.styleFrom(
      minimumSize: const Size(1, 1),
      padding: const EdgeInsets.symmetric(horizontal: sideButtonPadding),
    );
    Size hintSize = TextUtils.getTextSize(
      'S',
      l10n,
      style: themeData.textTheme.bodySmall,
    );

    double swipeIconSize = hintSize.height;
    double swipeButtonWidth =
        sideButtonPadding + swipeIconSize + sideButtonPadding;

    return Stack(
      children: [
        CarouselSlider(
          carouselController: _controller,
          items: widget.places,
          options: CarouselOptions(
            aspectRatio: widget.aspectRatio,
            height: widget.height,
            viewportFraction: 1.0,
          ),
        ),
        Positioned(
          bottom: 0,
          left: 0,
          // SizedBox here is to workaround bug https://github.com/flutter/flutter/issues/125756
          child: SizedBox(
            height: swipeIconSize,
            width: swipeButtonWidth,
            child: TextButton(
              style: swipeButtonStyle,
              onPressed: _toPreviousPlace,
              child: Icon(
                Icons.swipe_right,
                size: swipeIconSize,
              ),
            ),
          ),
        ),
        Positioned(
          bottom: 0,
          right: 0,
          // SizedBox here is to workaround bug https://github.com/flutter/flutter/issues/125756
          child: SizedBox(
            height: swipeIconSize,
            width: swipeButtonWidth,
            child: TextButton(
              style: swipeButtonStyle,
              onPressed: _toNextPlace,
              child: Icon(
                Icons.swipe_left,
                size: swipeIconSize,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
