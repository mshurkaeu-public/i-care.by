import 'package:carousel_slider/carousel_slider.dart';
import 'package:expandable_text/expandable_text.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:url_launcher/url_launcher.dart';

import 'asset_image_with_caption.dart';
import 'text_utils.dart';

class HowToFindOutWhoIsTmipiyl extends StatefulWidget {
  const HowToFindOutWhoIsTmipiyl({
    required this.userName,
    required this.userPreferredPronoun,
  });

  final String userName;
  final String userPreferredPronoun;

  @override
  State<HowToFindOutWhoIsTmipiyl> createState() =>
      _HowToFindOutWhoIsTmipiylState();
}

class _HowToFindOutWhoIsTmipiylState extends State<HowToFindOutWhoIsTmipiyl> {
  final TapGestureRecognizer _resetUserResponseOnQuestion01TapRecognizer =
      TapGestureRecognizer();
  final TapGestureRecognizer _telegramPollUrlBYTapRecognizer =
      TapGestureRecognizer();

  static const String _telegramPollUrlBY = 'https://t.me/icare_by/3';
  static _UserResponseAboutParticipationInThePoll _userResponseOnQuestion01 =
      _UserResponseAboutParticipationInThePoll.unknown;

  InlineSpan _buildDialogFragment(
    AppLocalizations l10n,
    String fragmentTemplate,
    InlineSpan changeAnswerArea,
  ) {
    List<InlineSpan> dialogFragmentContent = TextUtils.buildSpansFromText(
      fragmentTemplate,
      [
        MapEntry(
          '\$oops_correct_the_answer',
          changeAnswerArea,
        ),
      ],
    );

    InlineSpan res = TextSpan(
      children: dialogFragmentContent,
    );
    return res;
  }

  void _launchPollUrlBY() {
    launchUrl(Uri.parse(_telegramPollUrlBY));
  }

  void _resetUserResponseOnQuestion01() {
    setState(() {
      _userResponseOnQuestion01 =
          _UserResponseAboutParticipationInThePoll.unknown;
    });
  }

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

    TextStyle linkStyle = const TextStyle(
      color: Colors.blue,
      decoration: TextDecoration.underline,
    );
    TextStyle changeAnswerStyle = TextStyle(
      color: themeData.disabledColor,
      decoration: TextDecoration.underline,
    );

    List<InlineSpan> dialogContent = [];

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

    TextSpan q01Stub = const TextSpan(text: 'Question 01 stub');

    List<InlineSpan> chapter00 = TextUtils.buildSpansFromText(
      l10n.howToFindOutWhoIsTmipiyl_chapter00_text(
        widget.userName,
        widget.userPreferredPronoun,
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
                const AssetImageWithCaption(
                  assetName:
                      'assets/images/how-to-find-out-who-is-tmipiyl-lake-640.jpg',
                  caption: 'Photo by Vladimir Zuhovitsky on Unsplash',
                ),
                const AssetImageWithCaption(
                  assetName:
                      'assets/images/how-to-find-out-who-is-tmipiyl-sea-beach-640.jpg',
                  caption: 'Photo by Arnaud Marchais on Unsplash',
                ),
                _DisplayImageFromUrl(
                  userPreferredPronoun: widget.userPreferredPronoun,
                ),
              ],
            ),
          ),
        ),
        MapEntry(
          '\$BY_who_is_tmipiyl_poll_url',
          TextSpan(
            text: _telegramPollUrlBY,
            recognizer: _telegramPollUrlBYTapRecognizer,
            style: linkStyle,
          ),
        ),
        MapEntry(
          '\$user_response_about_participation_in_the_poll',
          q01Stub,
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

    for (int i = 0; i < chapter00.length; i++) {
      if (chapter00[i] == q01Stub) {
        InlineSpan stubReplacement;

        InlineSpan changeAnswerButton = TextSpan(
          text: l10n.userWantsToCorrectAChoice,
          style: changeAnswerStyle,
          recognizer: _resetUserResponseOnQuestion01TapRecognizer,
        );

        switch (_userResponseOnQuestion01) {
          case _UserResponseAboutParticipationInThePoll.unknown:
            stubReplacement = TextSpan(
              children: [
                // якія могуць быць прычыны, каб чалавек не адказаў у апытанні:
                // не ведаў, што трэба адказаць;
                // ведаў, але не ўмеў адказваць;
                // ведаў, умеў, але не мог адказаць;
                // ведаў, умеў, мог, але не жадаў адказваць.
                WidgetSpan(
                  child: OutlinedButton(
                    onPressed: () {
                      setState(() {
                        _userResponseOnQuestion01 =
                            _UserResponseAboutParticipationInThePoll
                                .participated;
                      });
                    },
                    child: Text(
                      l10n.userResponseAboutParticipationInThePoll_participated(
                        widget.userPreferredPronoun,
                      ),
                    ),
                  ),
                ),
                WidgetSpan(
                  child: OutlinedButton(
                    onPressed: () {
                      setState(() {
                        _userResponseOnQuestion01 =
                            _UserResponseAboutParticipationInThePoll
                                .cannotParticipate;
                      });
                    },
                    child: Text(
                      l10n.userResponseAboutParticipationInThePoll_cannotParticipate(
                        widget.userPreferredPronoun,
                      ),
                    ),
                  ),
                ),
                WidgetSpan(
                  child: OutlinedButton(
                    onPressed: () {
                      setState(() {
                        _userResponseOnQuestion01 =
                            _UserResponseAboutParticipationInThePoll
                                .doesntWantToParticipate;
                      });
                    },
                    child: Text(
                      l10n.userResponseAboutParticipationInThePoll_doesntWantToParticipate(
                        widget.userPreferredPronoun,
                      ),
                    ),
                  ),
                ),
              ],
            );
            if (i < chapter00.length - 1) {
              chapter00.removeRange(i + 1, chapter00.length);
            }
            break;

          case _UserResponseAboutParticipationInThePoll.participated:
            stubReplacement = _buildDialogFragment(
              l10n,
              l10n.dialogWhenUserParticipatedInTheTelegramPoll(
                widget.userName,
                widget.userPreferredPronoun,
              ),
              changeAnswerButton,
            );
            break;

          case _UserResponseAboutParticipationInThePoll.cannotParticipate:
            stubReplacement = _buildDialogFragment(
              l10n,
              l10n.dialogWhenUserCannotParticipateInTheTelegramPoll(
                widget.userName,
                widget.userPreferredPronoun,
              ),
              changeAnswerButton,
            );
            break;

          case _UserResponseAboutParticipationInThePoll.doesntWantToParticipate:
            stubReplacement = _buildDialogFragment(
              l10n,
              l10n.dialogWhenUserDoesntWantToParticipateInTheTelegramPoll(
                widget.userName,
                widget.userPreferredPronoun,
              ),
              changeAnswerButton,
            );
            break;
        }

        chapter00[i] = stubReplacement;

        break; // exit the for
      }
    }

    dialogContent.add(
      TextSpan(
        text: l10n.howToFindOutWhoIsTmipiyl_chapter00_title,
        style: titleStyle,
      ),
    );
    dialogContent.addAll(chapter00);

    if (_userResponseOnQuestion01 !=
        _UserResponseAboutParticipationInThePoll.unknown) {

      List<InlineSpan> chapter01 = TextUtils.buildSpansFromText(
        l10n.howToFindOutWhoIsTmipiyl_chapter01_text(
          widget.userName,
          widget.userPreferredPronoun,
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
                    widget.userPreferredPronoun,
                  ),
                  expandText: l10n.showMoreText,
                  collapseText: l10n.showLessText,
                ),
              ),
            ),
          ),
        ],
      );

      dialogContent.add(
        TextSpan(
          text: l10n.howToFindOutWhoIsTmipiyl_chapter01_title,
          style: titleStyle,
        ),
      );
      dialogContent.addAll(chapter01);

      List<InlineSpan> chapter02 = TextUtils.buildSpansFromText(
        l10n.howToFindOutWhoIsTmipiyl_chapter02_text(
          widget.userName,
          widget.userPreferredPronoun,
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

      dialogContent.add(
        TextSpan(
          text: l10n.howToFindOutWhoIsTmipiyl_chapter02_title(
            widget.userPreferredPronoun,
          ),
          style: titleStyle,
        ),
      );
      dialogContent.addAll(chapter02);

      List<InlineSpan> chapter03 = TextUtils.buildSpansFromText(
        l10n.howToFindOutWhoIsTmipiyl_chapter03_text(
          widget.userName,
          widget.userPreferredPronoun,
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

      dialogContent.add(
        TextSpan(
          text: l10n.howToFindOutWhoIsTmipiyl_chapter03_title(
            widget.userPreferredPronoun,
          ),
          style: titleStyle,
        ),
      );
      dialogContent.addAll(chapter03);

      List<InlineSpan> chapter04 = TextUtils.buildSpansFromText(
        l10n.howToFindOutWhoIsTmipiyl_chapter04_text(
          widget.userName,
          widget.userPreferredPronoun,
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

      dialogContent.add(
        TextSpan(
          text: l10n.howToFindOutWhoIsTmipiyl_chapter04_title,
          style: titleStyle,
        ),
      );
      dialogContent.addAll(chapter04);
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(
          l10n.howToFindOutWhoIsTmipiyl_title(widget.userPreferredPronoun),
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          Text.rich(
            TextSpan(
              children: dialogContent,
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _resetUserResponseOnQuestion01TapRecognizer.dispose();
    _telegramPollUrlBYTapRecognizer.dispose();

    super.dispose();
  }

  @override
  void initState() {
    _resetUserResponseOnQuestion01TapRecognizer.onTap =
        _resetUserResponseOnQuestion01;

    _telegramPollUrlBYTapRecognizer.onTap = _launchPollUrlBY;

    super.initState();
  }
}

class _DisplayImageFromUrl extends StatefulWidget {
  const _DisplayImageFromUrl({
    required this.userPreferredPronoun,
  });

  final String userPreferredPronoun;

  @override
  State<_DisplayImageFromUrl> createState() => _DisplayImageFromUrlState();
}

class _DisplayImageFromUrlState extends State<_DisplayImageFromUrl> {
  final TextEditingController _controller = TextEditingController();
  static String _imageUrl = '';

  void _onDownloadPress() {
    setState(_updateImageUrl);
  }

  void _updateImageUrl() {
    _imageUrl = _controller.text;
  }

  @override
  Widget build(BuildContext context) {
    AppLocalizations l10n = AppLocalizations.of(context);

    List<Widget> children = [];
    if (_imageUrl.isNotEmpty) {
      children.add(
        Expanded(
          child: Image.network(
            _imageUrl,
            filterQuality: FilterQuality.medium,
          ),
        ),
      );
    }

    children.add(
      Container(
        padding: const EdgeInsets.symmetric(horizontal: 32),
        child: TextFormField(
          controller: _controller,
          decoration: InputDecoration(
            labelText: l10n.howToFindOutWhoIsTmipiyl_chapter00_customUrlLabel(
              widget.userPreferredPronoun,
            ),
            floatingLabelBehavior: FloatingLabelBehavior.always,
            suffixIcon: IconButton(
              onPressed: _onDownloadPress,
              icon: const Icon(Icons.download),
            ),
          ),
          onFieldSubmitted: (value) {
            _onDownloadPress();
          },
        ),
      ),
    );

    return Column(
      children: children,
    );
  }

  @override
  void dispose() {
    _controller.dispose();

    super.dispose();
  }

  @override
  void initState() {
    super.initState();

    _controller.text = _imageUrl;
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

    List<Widget> hintAboutSwipe;
    if (widget.places.length > 1) {
      ThemeData themeData = Theme.of(context);
      TextStyle hintAboutSwipeStyle =
          themeData.textTheme.bodyMedium ?? const TextStyle();
      hintAboutSwipeStyle = hintAboutSwipeStyle.merge(
        TextStyle(
          color: themeData.disabledColor,
        ),
      );

      String hintText = l10n.hintToViewTheNextPhoto;
      const double sideButtonPadding = 8;

      ButtonStyle swipeButtonStyle = TextButton.styleFrom(
        minimumSize: const Size(1, 1),
        padding: const EdgeInsets.symmetric(horizontal: sideButtonPadding),
      );
      Size hintSize = TextUtils.getTextSize(
        hintText,
        l10n,
        style: hintAboutSwipeStyle,
      );

      double swipeIconSize = hintSize.height;
      double maxHintWidthRequired = hintSize.width;
      double swipeButtonWidth =
          sideButtonPadding + swipeIconSize + sideButtonPadding;

      hintAboutSwipe = [
        LayoutBuilder(
          builder: (BuildContext context, BoxConstraints constraints) {
            double hintWidth = constraints.maxWidth - swipeButtonWidth * 2;
            if (hintWidth < 0) {
              hintWidth = 0;
            } else if (hintWidth > maxHintWidthRequired) {
              hintWidth = maxHintWidthRequired;
            }

            return Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // SizedBox here is to workaround bug https://github.com/flutter/flutter/issues/125756
                SizedBox(
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
                SizedBox(
                  width: hintWidth,
                  child: Text(
                    hintText,
                    style: hintAboutSwipeStyle,
                    textAlign: TextAlign.center,
                  ),
                ),
                // SizedBox here is to workaround bug https://github.com/flutter/flutter/issues/125756
                SizedBox(
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
              ],
            );
          },
        ),
      ];
    } else {
      hintAboutSwipe = [];
    }

    return Column(
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
        ...hintAboutSwipe,
      ],
    );
  }
}

enum _UserResponseAboutParticipationInThePoll {
  unknown,
  participated,
  cannotParticipate,
  doesntWantToParticipate,
  ;
}
