import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:url_launcher/url_launcher.dart';

import 'my_photo_gallery.dart';
import 'text_utils.dart';

class AboutPage extends StatelessWidget {
  const AboutPage({
    required this.userName,
    required this.userPreferredPronoun,
  });

  final String userName;
  final String userPreferredPronoun;

  static const int _tabsNumber = 6;
  static const int _shortTabIndex = 0;
  static const int _myGratitudeTabIndex = 1;
  static const int _supportThePtojectTabIndex = 2;
  static const int _theWhyTabIndex = 3;
  static const int _howItWorksTabIndex = 4;
  static const int _historyOfCreationTabIndex = 5;

  @override
  Widget build(BuildContext context) {
    AppLocalizations l10n = AppLocalizations.of(context);
    MaterialLocalizations mL10n = MaterialLocalizations.of(context);

    List<Widget> tabs = List<Widget>.filled(_tabsNumber, const SizedBox());
    List<Widget> tabsChildren =
        List<Widget>.filled(_tabsNumber, const SizedBox());

    tabs[_shortTabIndex] = Text(l10n.aboutShortTabLabel);
    tabsChildren[_shortTabIndex] = _ShortAbout(
      userPreferredPronoun: userPreferredPronoun,
    );

    tabs[_myGratitudeTabIndex] = Text(l10n.aboutMyGratitudeTabLabel);
    tabsChildren[_myGratitudeTabIndex] = _MyGratitude();

    tabs[_supportThePtojectTabIndex] =
        Text(l10n.aboutSupportTheProjectTabLabel);
    tabsChildren[_supportThePtojectTabIndex] = _SupportTheProject(
      userName: userName,
      userPreferredPronoun: userPreferredPronoun,
    );

    tabs[_theWhyTabIndex] = Text(l10n.aboutTheWhyTabLabel);
    tabsChildren[_theWhyTabIndex] = _TheWhy();

    tabs[_howItWorksTabIndex] = Text(l10n.aboutHowItWorksTabLabel);
    tabsChildren[_howItWorksTabIndex] = _HowItWorks(
      userName: userName,
      userPreferredPronoun: userPreferredPronoun,
    );

    tabs[_historyOfCreationTabIndex] =
        Text(l10n.aboutHistoryOfCreationTabLabel);
    tabsChildren[_historyOfCreationTabIndex] = _HistoryOfCreation();

    return DefaultTabController(
      length: 6,
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            mL10n.aboutListTileTitle('i-care.by'),
          ),
          bottom: TabBar(
            isScrollable: true,
            tabs: tabs,
          ),
        ),
        body: TabBarView(
          children: tabsChildren,
        ),
      ),
    );
  }
}

class _FeedbackRequest extends StatefulWidget {
  const _FeedbackRequest({
    required this.userPreferredPronoun,
  });

  final String userPreferredPronoun;

  @override
  State<StatefulWidget> createState() => _FeedbackRequestState();
}

class _FeedbackRequestState extends State<_FeedbackRequest> {
  final TapGestureRecognizer _facebookUrlTapRecognizer = TapGestureRecognizer();
  final TapGestureRecognizer _gitHubCreateNewIssueUrlTapRecognizer =
      TapGestureRecognizer();
  final TapGestureRecognizer _gitHubDiscussionsUrlTapRecognizer =
      TapGestureRecognizer();
  final TapGestureRecognizer _instagramUrlTapRecognizer =
      TapGestureRecognizer();
  final TapGestureRecognizer _linkedInUrlTapRecognizer = TapGestureRecognizer();
  final TapGestureRecognizer _telegramUrlTapRecognizer = TapGestureRecognizer();
  final TapGestureRecognizer _tikTokUrlTapRecognizer = TapGestureRecognizer();
  final TapGestureRecognizer _twitterUrlTapRecognizer = TapGestureRecognizer();
  final TapGestureRecognizer _youTubeUrlTapRecognizer = TapGestureRecognizer();

  static const String _facebookUrl = 'https://facebook.com/icare.by.page';
  static const String _gitHubCreateNewIssueUrl =
      'https://github.com/mshurkaeu-public/i-care.by/issues/new';
  static const String _gitHubDiscussionsUrl =
      'https://github.com/mshurkaeu-public/i-care.by/discussions';
  static const String _instagramUrl = 'https://www.instagram.com/icare.by';
  static const String _linkedInUrl = 'https://linkedin.com/company/i-care-by';
  static const String _telegramUrl = 'https://t.me/icare_by';
  static const String _tikTokUrl = 'https://www.tiktok.com/@icare.by';
  static const String _twitterUrl = 'https://twitter.com/icare_by';
  static const String _youTubeUrl = 'https://www.youtube.com/@i-care-by';

  void _launchFacebookUrl() {
    launchUrl(Uri.parse(_facebookUrl));
  }

  void _launchGitHubCreateNewIssueUrl() {
    launchUrl(Uri.parse(_gitHubCreateNewIssueUrl));
  }

  void _launchGitHubDiscussionsUrl() {
    launchUrl(Uri.parse(_gitHubDiscussionsUrl));
  }

  void _launchInstagramUrl() {
    launchUrl(Uri.parse(_instagramUrl));
  }

  void _launchLinkedInUrl() {
    launchUrl(Uri.parse(_linkedInUrl));
  }

  void _launchTelegramUrl() {
    launchUrl(Uri.parse(_telegramUrl));
  }

  void _launchTikTokUrl() {
    launchUrl(Uri.parse(_tikTokUrl));
  }

  void _launchTwitterUrl() {
    launchUrl(Uri.parse(_twitterUrl));
  }

  void _launchYouTubeUrl() {
    launchUrl(Uri.parse(_youTubeUrl));
  }

  @override
  Widget build(BuildContext context) {
    AppLocalizations l10n = AppLocalizations.of(context);

    TextStyle linkStyle = const TextStyle(
      color: Colors.blue,
      decoration: TextDecoration.underline,
    );

    String paragraphText = l10n.feedbackRequestText(
      widget.userPreferredPronoun,
    );
    List<InlineSpan> paragraphSpans = TextUtils.buildSpansFromText(
      paragraphText,
      [
        MapEntry(
          '\$github_create_new_issue_url',
          TextSpan(
            text: _gitHubCreateNewIssueUrl,
            style: linkStyle,
            recognizer: _gitHubCreateNewIssueUrlTapRecognizer,
          ),
        ),
        MapEntry(
          '\$github_discussions_url',
          TextSpan(
            text: _gitHubDiscussionsUrl,
            style: linkStyle,
            recognizer: _gitHubDiscussionsUrlTapRecognizer,
          ),
        ),
      ],
    );

    return Text.rich(
      TextSpan(
        children: [
          TextSpan(
            text: l10n.feedbackRequestTitle,
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          ...paragraphSpans,
          TextSpan(
            style: const TextStyle(
              height: 1.8,
            ),
            children: [
              //Facebook
              const TextSpan(
                text: 'Facebook —',
                style: TextStyle(wordSpacing: 2.5),
              ),
              const TextSpan(
                text: ' ',
              ),
              TextSpan(
                text: _facebookUrl,
                style: linkStyle,
                recognizer: _facebookUrlTapRecognizer,
              ),
              const TextSpan(
                text: '\n',
              ),

              //Instagram
              const TextSpan(
                text: 'Instagram —',
                style: TextStyle(wordSpacing: 0),
              ),
              const TextSpan(
                text: ' ',
              ),
              TextSpan(
                text: _instagramUrl,
                style: linkStyle,
                recognizer: _instagramUrlTapRecognizer,
              ),
              const TextSpan(
                text: '\n',
              ),

              //LinkedIn
              const TextSpan(
                text: 'LinkedIn —',
                style: TextStyle(wordSpacing: 10.5),
              ),
              const TextSpan(
                text: ' ',
              ),
              TextSpan(
                text: _linkedInUrl,
                style: linkStyle,
                recognizer: _linkedInUrlTapRecognizer,
              ),
              const TextSpan(
                text: '\n',
              ),

              //Telegram
              const TextSpan(
                text: 'Telegram —',
                style: TextStyle(wordSpacing: 5),
              ),
              const TextSpan(
                text: ' ',
              ),
              TextSpan(
                text: _telegramUrl,
                style: linkStyle,
                recognizer: _telegramUrlTapRecognizer,
              ),
              const TextSpan(
                text: '\n',
              ),

              //TikTok
              const TextSpan(
                text: 'TikTok —',
                style: TextStyle(wordSpacing: 21.5),
              ),
              const TextSpan(
                text: ' ',
              ),
              TextSpan(
                text: _tikTokUrl,
                style: linkStyle,
                recognizer: _tikTokUrlTapRecognizer,
              ),
              const TextSpan(
                text: '\n',
              ),

              //Twitter
              const TextSpan(
                text: 'Twitter —',
                style: TextStyle(wordSpacing: 19.5),
              ),
              const TextSpan(
                text: ' ',
              ),
              TextSpan(
                text: _twitterUrl,
                style: linkStyle,
                recognizer: _twitterUrlTapRecognizer,
              ),
              const TextSpan(
                text: '\n',
              ),

              //YouTube
              const TextSpan(
                text: 'YouTube —',
                style: TextStyle(wordSpacing: 8.5),
              ),
              const TextSpan(
                text: ' ',
              ),
              TextSpan(
                text: _youTubeUrl,
                style: linkStyle,
                recognizer: _youTubeUrlTapRecognizer,
              ),
              const TextSpan(
                text: '\n',
              ),
            ],
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _facebookUrlTapRecognizer.dispose();
    _gitHubCreateNewIssueUrlTapRecognizer.dispose();
    _gitHubDiscussionsUrlTapRecognizer.dispose();
    _instagramUrlTapRecognizer.dispose();
    _linkedInUrlTapRecognizer.dispose();
    _telegramUrlTapRecognizer.dispose();
    _tikTokUrlTapRecognizer.dispose();
    _twitterUrlTapRecognizer.dispose();
    _youTubeUrlTapRecognizer.dispose();

    super.dispose();
  }

  @override
  void initState() {
    super.initState();

    _facebookUrlTapRecognizer.onTap = _launchFacebookUrl;
    _gitHubCreateNewIssueUrlTapRecognizer.onTap =
        _launchGitHubCreateNewIssueUrl;
    _gitHubDiscussionsUrlTapRecognizer.onTap = _launchGitHubDiscussionsUrl;
    _instagramUrlTapRecognizer.onTap = _launchInstagramUrl;
    _linkedInUrlTapRecognizer.onTap = _launchLinkedInUrl;
    _telegramUrlTapRecognizer.onTap = _launchTelegramUrl;
    _tikTokUrlTapRecognizer.onTap = _launchTikTokUrl;
    _twitterUrlTapRecognizer.onTap = _launchTwitterUrl;
    _youTubeUrlTapRecognizer.onTap = _launchYouTubeUrl;
  }
}

class _HistoryOfCreation extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    AppLocalizations l10n = AppLocalizations.of(context);
    TextStyle titleStyle = const TextStyle(fontWeight: FontWeight.bold);

    double maxWidth = MediaQuery.of(context).size.width - 20 * 2;
    double galleryWidth = (maxWidth > 1080) ? 1080 : maxWidth;

    List<InlineSpan> chapter01 = TextUtils.buildSpansFromText(
      l10n.aboutHistoryOfCreation_chapter_01_text,
      [
        MapEntry(
          '\$traffic_light',
          WidgetSpan(
            child: MyPhotoGallery(
              width: galleryWidth,
              assetsNames: [
                'assets/images/history-of-creation-2022-02-21-traffic-light.png',
              ],
            ),
          ),
        ),
        MapEntry(
          '\$issues',
          WidgetSpan(
            child: MyPhotoGallery(
              width: galleryWidth,
              assetsNames: [
                'assets/images/history-of-creation-2022-02-21-photo-1.png',
                'assets/images/history-of-creation-2022-02-21-photo-2.png',
                'assets/images/history-of-creation-2022-02-21-photo-3.png',
                'assets/images/history-of-creation-2022-02-21-photo-4.png',
              ],
            ),
          ),
        ),
      ],
    );

    List<InlineSpan> chapter03 = TextUtils.buildSpansFromText(
      l10n.aboutHistoryOfCreation_chapter_03_text,
      [
        MapEntry(
          '\$flashback',
          WidgetSpan(
            child: MyPhotoGallery(
              width: galleryWidth,
              assetsNames: [
                'assets/images/history-of-creation-2022-02-24-flashback-1.png',
                'assets/images/history-of-creation-2022-02-24-flashback-2.png',
                'assets/images/history-of-creation-2022-02-24-flashback-3.png',
                'assets/images/history-of-creation-2022-02-24-flashback-4.png',
                'assets/images/history-of-creation-2022-02-24-flashback-5.png',
                'assets/images/history-of-creation-2022-02-24-flashback-6.png',
                'assets/images/history-of-creation-2022-02-24-flashback-7.png',
                'assets/images/history-of-creation-2022-02-24-flashback-8.png',
              ],
            ),
          ),
        ),
      ],
    );

    const String officialStatisticsUrl =
        'https://rec.gov.by/uploads/folderForLinks/elect18.pdf';
    double copyIconSize = TextUtils.getTextSize('C', l10n).height;
    List<InlineSpan> chapter04 = TextUtils.buildSpansFromText(
      l10n.aboutHistoryOfCreation_chapter_04_text,
      [
        MapEntry(
          '\$official_statistics_image',
          WidgetSpan(
            child: MyPhotoGallery(
              width: galleryWidth,
              assetsNames: [
                'assets/images/history-of-creation-2022-02-27-official-statistics.png'
              ],
            ),
          ),
        ),
        MapEntry(
          '\$official_statistics_url',
          TextSpan(
            text: officialStatisticsUrl,
            children: [
              const WidgetSpan(child: SizedBox(width: 5)),
              WidgetSpan(
                // SizedBox here is to workaround bug https://github.com/flutter/flutter/issues/125756
                child: SizedBox(
                  height: copyIconSize,
                  width: copyIconSize,
                  child: TextButton(
                    style: TextButton.styleFrom(
                      padding: EdgeInsets.zero,
                      minimumSize: const Size(1, 1),
                    ),
                    child: Icon(
                      Icons.copy,
                      size: copyIconSize,
                    ),
                    onPressed: () {
                      Clipboard.setData(
                        const ClipboardData(text: officialStatisticsUrl),
                      ).then(
                        (_) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(l10n.messageWhenCopied),
                            ),
                          );
                        },
                      );
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );

    List<InlineSpan> chapter06 = TextUtils.buildSpansFromText(
      l10n.aboutHistoryOfCreation_chapter_06_text,
      [
        MapEntry(
          '\$was_became_examples',
          WidgetSpan(
            child: MyPhotoGallery(
              width: galleryWidth,
              assetsNames: [
                'assets/images/history-of-creation-2022-03-25-01.png',
                'assets/images/history-of-creation-2022-03-25-02.png',
              ],
            ),
          ),
        ),
      ],
    );

    return ListView(
      padding: const EdgeInsets.all(20),
      children: [
        Text.rich(
          TextSpan(
            children: [
              TextSpan(
                text: l10n.aboutHistoryOfCreation_chapter_00_title,
                style: titleStyle,
              ),
              TextSpan(
                text: l10n.aboutHistoryOfCreation_chapter_00_text,
              ),
              TextSpan(
                text: l10n.aboutHistoryOfCreation_chapter_01_title,
                style: titleStyle,
              ),
              ...chapter01,
              TextSpan(
                text: l10n.aboutHistoryOfCreation_chapter_02_title,
                style: titleStyle,
              ),
              TextSpan(
                text: l10n.aboutHistoryOfCreation_chapter_02_text,
              ),
              TextSpan(
                text: l10n.aboutHistoryOfCreation_chapter_03_title,
                style: titleStyle,
              ),
              ...chapter03,
              TextSpan(
                text: l10n.aboutHistoryOfCreation_chapter_04_title,
                style: titleStyle,
              ),
              ...chapter04,
              TextSpan(
                text: l10n.aboutHistoryOfCreation_chapter_05_title,
                style: titleStyle,
              ),
              TextSpan(
                text: l10n.aboutHistoryOfCreation_chapter_05_text,
              ),
              TextSpan(
                text: l10n.aboutHistoryOfCreation_chapter_06_title,
                style: titleStyle,
              ),
              ...chapter06,
              TextSpan(
                text: l10n.aboutHistoryOfCreation_chapter_07_title,
                style: titleStyle,
              ),
              TextSpan(
                text: l10n.aboutHistoryOfCreation_chapter_07_text,
              ),
              TextSpan(
                text: l10n.aboutHistoryOfCreation_chapter_08_title,
                style: titleStyle,
              ),
              TextSpan(
                text: l10n.aboutHistoryOfCreation_chapter_08_text,
              ),
              const TextSpan(
                text: '\n\n---\nПрацяг будзе напісаны пазней.\n\n',
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _HowItWorks extends StatelessWidget {
  const _HowItWorks({
    required this.userName,
    required this.userPreferredPronoun,
  });

  final String userName;
  final String userPreferredPronoun;

  @override
  Widget build(BuildContext context) {
    AppLocalizations l10n = AppLocalizations.of(context);

    return ListView(
      padding: const EdgeInsets.all(20),
      children: [
        Text(
          l10n.aboutHowItWorksText(userName, userPreferredPronoun),
        ),
      ],
    );
  }
}

class _MyGratitude extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    AppLocalizations l10n = AppLocalizations.of(context);
    TextStyle titleStyle = const TextStyle(fontWeight: FontWeight.bold);

    return ListView(
      padding: const EdgeInsets.all(20),
      children: [
        Text(
          l10n.aboutMyGratitudeTitle,
          style: titleStyle,
        ),
        Text.rich(
          TextSpan(
            text: l10n.aboutMyGratitudeIntroductory,
            children: [
              // 2023-05
              TextSpan(
                text: l10n.aboutMyGratitude_2023_05_title,
                style: titleStyle,
              ),
              TextSpan(
                text: l10n.aboutMyGratitude_2023_05_02_02,
              ),
              TextSpan(
                text: l10n.aboutMyGratitude_2023_05_02_01,
              ),

              // 2023-04
              TextSpan(
                text: l10n.aboutMyGratitude_2023_04_title,
                style: titleStyle,
              ),
              TextSpan(
                text: l10n.aboutMyGratitude_2023_04_27_02,
              ),
              TextSpan(
                text: l10n.aboutMyGratitude_2023_04_27_01,
              ),
              TextSpan(
                text: l10n.aboutMyGratitude_2023_04_21_02,
              ),
              TextSpan(
                text: l10n.aboutMyGratitude_2023_04_21_01,
              ),
              TextSpan(
                text: l10n.aboutMyGratitude_2023_04_20_01,
              ),
              TextSpan(
                text: l10n.aboutMyGratitude_2023_04_18_01,
              ),
              TextSpan(
                text: l10n.aboutMyGratitude_2023_04_13_01,
              ),
              TextSpan(
                text: l10n.aboutMyGratitude_2023_04_12_01,
              ),
              TextSpan(
                text: l10n.aboutMyGratitude_2023_04_08_01,
              ),
              TextSpan(
                text: l10n.aboutMyGratitude_2023_04_07_01,
              ),

              // 2023-03
              TextSpan(
                text: l10n.aboutMyGratitude_2023_03_title,
                style: titleStyle,
              ),
              TextSpan(
                text: l10n.aboutMyGratitude_2023_03_22_01,
              ),
              TextSpan(
                text: l10n.aboutMyGratitude_2023_03_10_02,
              ),
              TextSpan(
                text: l10n.aboutMyGratitude_2023_03_10_01,
              ),
              TextSpan(
                text: l10n.aboutMyGratitude_2023_03_06_02,
              ),
              TextSpan(
                text: l10n.aboutMyGratitude_2023_03_06_01,
              ),
              TextSpan(
                text: l10n.aboutMyGratitude_2023_03_05_02,
              ),
              TextSpan(
                text: l10n.aboutMyGratitude_2023_03_05_01,
              ),
              TextSpan(
                text: l10n.aboutMyGratitude_2023_03_04_01,
              ),

              // 2023-02
              TextSpan(
                text: l10n.aboutMyGratitude_2023_02_title,
                style: titleStyle,
              ),
              TextSpan(
                text: l10n.aboutMyGratitude_2023_02_28_01,
              ),
              TextSpan(
                text: l10n.aboutMyGratitude_2023_02_15_01,
              ),

              // 2022-03
              TextSpan(
                text: l10n.aboutMyGratitude_2022_03_title,
                style: titleStyle,
              ),
              TextSpan(
                text: l10n.aboutMyGratitude_2022_03_24_01,
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _ShortAbout extends StatefulWidget {
  const _ShortAbout({
    required this.userPreferredPronoun,
  });

  final String userPreferredPronoun;

  @override
  State<_ShortAbout> createState() => _ShortAboutState();
}

class _ShortAboutState extends State<_ShortAbout> {
  final TapGestureRecognizer _myGratitudeTapRecognizer = TapGestureRecognizer();
  final TapGestureRecognizer _showLicensesTapRecognizer =
      TapGestureRecognizer();
  final TapGestureRecognizer _supportTheProjectTapRecognizer =
      TapGestureRecognizer();
  final TapGestureRecognizer _theWhyTapRecognizer = TapGestureRecognizer();
  final TapGestureRecognizer _howItWorksTapRecognizer = TapGestureRecognizer();
  final TapGestureRecognizer _historyOfCreationTapRecognizer =
      TapGestureRecognizer();

  final TapGestureRecognizer _gitHubUrlTapRecognizer = TapGestureRecognizer();

  final Future<PackageInfo> packageInfoFuture = PackageInfo.fromPlatform();

  static const String _gitHubUrl =
      'https://github.com/mshurkaeu-public/i-care.by';

  void _launchGitHubUrl() {
    launchUrl(Uri.parse(_gitHubUrl));
  }

  void _showHistoryOfCreation() {
    DefaultTabController.of(context)
        .animateTo(AboutPage._historyOfCreationTabIndex);
  }

  void _showHowItWorksTab() {
    DefaultTabController.of(context).animateTo(AboutPage._howItWorksTabIndex);
  }

  void _showLicenses() {
    showLicensePage(context: context);
  }

  void _showMyGratitudeTab() {
    DefaultTabController.of(context).animateTo(AboutPage._myGratitudeTabIndex);
  }

  void _showSupportTheProjectTab() {
    DefaultTabController.of(context)
        .animateTo(AboutPage._supportThePtojectTabIndex);
  }

  void _showTheWhyTab() {
    DefaultTabController.of(context).animateTo(AboutPage._theWhyTabIndex);
  }

  @override
  Widget build(BuildContext context) {
    AppLocalizations l10n = AppLocalizations.of(context);
    String userPreferredPronoun = widget.userPreferredPronoun;

    TextStyle linkStyle = const TextStyle(
      color: Colors.blue,
      decoration: TextDecoration.underline,
    );

    List<InlineSpan> aboutShort = TextUtils.buildSpansFromText(
      l10n.aboutShort(userPreferredPronoun),
      [
        MapEntry(
          '\$app_title',
          TextSpan(
            text: l10n.appTitle,
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
        MapEntry(
          '\$app_version',
          WidgetSpan(
            child: FutureBuilder<PackageInfo>(
              future: packageInfoFuture,
              builder: (
                BuildContext context,
                AsyncSnapshot<PackageInfo> snapshot,
              ) {
                String txt;
                if (snapshot.hasData) {
                  PackageInfo packageInfo = snapshot.data!;
                  txt = '${packageInfo.version}.${packageInfo.buildNumber}';
                } else if (snapshot.hasError) {
                  txt = snapshot.error!.toString();
                } else {
                  txt = '';
                }

                return Text(txt);
              },
            ),
          ),
        ),
        MapEntry(
          '\$my_gratitude_link',
          TextSpan(
            text: l10n.aboutMyGratitudeTabLabel,
            style: linkStyle,
            recognizer: _myGratitudeTapRecognizer,
          ),
        ),
        MapEntry(
          '\$support_the_project_link',
          TextSpan(
            text: l10n.aboutSupportTheProjectTabLabel,
            style: linkStyle,
            recognizer: _supportTheProjectTapRecognizer,
          ),
        ),
        MapEntry(
          '\$the_why_link',
          TextSpan(
            text: l10n.aboutTheWhyTabLabel,
            style: linkStyle,
            recognizer: _theWhyTapRecognizer,
          ),
        ),
        MapEntry(
          '\$how_it_works_link',
          TextSpan(
            text: l10n.aboutHowItWorksTabLabel,
            style: linkStyle,
            recognizer: _howItWorksTapRecognizer,
          ),
        ),
        MapEntry(
          '\$history_of_creation_link',
          TextSpan(
            text: l10n.aboutHistoryOfCreationTabLabel,
            style: linkStyle,
            recognizer: _historyOfCreationTapRecognizer,
          ),
        ),
        MapEntry(
          '\$components_licenses_link',
          TextSpan(
            text: MaterialLocalizations.of(context).viewLicensesButtonLabel,
            style: linkStyle,
            recognizer: _showLicensesTapRecognizer,
          ),
        ),
        MapEntry(
          '\$GitHub_repository_link',
          TextSpan(
            text: _gitHubUrl,
            style: linkStyle,
            recognizer: _gitHubUrlTapRecognizer,
          ),
        ),
        MapEntry(
          '\$feedback_request',
          WidgetSpan(
            child: _FeedbackRequest(
              userPreferredPronoun: userPreferredPronoun,
            ),
          ),
        ),
      ],
    );

    return ListView(
      padding: const EdgeInsets.all(20),
      children: [
        Text.rich(
          TextSpan(
            children: aboutShort,
          ),
        ),
      ],
    );
  }

  @override
  void dispose() {
    _myGratitudeTapRecognizer.dispose();
    _showLicensesTapRecognizer.dispose();
    _supportTheProjectTapRecognizer.dispose();
    _theWhyTapRecognizer.dispose();
    _howItWorksTapRecognizer.dispose();
    _historyOfCreationTapRecognizer.dispose();

    _gitHubUrlTapRecognizer.dispose();

    super.dispose();
  }

  @override
  void initState() {
    super.initState();

    _myGratitudeTapRecognizer.onTap = _showMyGratitudeTab;
    _showLicensesTapRecognizer.onTap = _showLicenses;
    _supportTheProjectTapRecognizer.onTap = _showSupportTheProjectTab;
    _theWhyTapRecognizer.onTap = _showTheWhyTab;
    _howItWorksTapRecognizer.onTap = _showHowItWorksTab;
    _historyOfCreationTapRecognizer.onTap = _showHistoryOfCreation;

    _gitHubUrlTapRecognizer.onTap = _launchGitHubUrl;
  }
}

class _SupportTheProject extends StatelessWidget {
  const _SupportTheProject({
    required this.userName,
    required this.userPreferredPronoun,
  });

  final String userName;
  final String userPreferredPronoun;

  @override
  Widget build(BuildContext context) {
    AppLocalizations l10n = AppLocalizations.of(context);
    TextStyle titleStyle = const TextStyle(fontWeight: FontWeight.bold);

    return ListView(
      padding: const EdgeInsets.all(20),
      children: [
        Text.rich(
          TextSpan(
            children: [
              TextSpan(
                text: l10n.aboutSupportTheProject_financially_title,
                style: titleStyle,
              ),
              TextSpan(
                text: l10n.aboutSupportTheProject_financially_text(
                  userName,
                  userPreferredPronoun,
                ),
              ),
              TextSpan(
                text: l10n.aboutSupportTheProject_drawLogo_title,
                style: titleStyle,
              ),
              TextSpan(
                text: l10n.aboutSupportTheProject_drawLogo_text(
                  userName,
                  userPreferredPronoun,
                ),
              ),
              const TextSpan(
                text: '\n\n',
              ),
              WidgetSpan(
                child: _FeedbackRequest(
                  userPreferredPronoun: userPreferredPronoun,
                ),
              ),
              const TextSpan(
                text: '\n\n👾',
              ),
              TextSpan(
                text: l10n.aboutSupportTheProject_bugReport_title,
                style: titleStyle,
              ),
              TextSpan(
                text: l10n.aboutSupportTheProject_bugReport_text(
                  userName,
                  userPreferredPronoun,
                ),
              ),
              const TextSpan(
                text: '\n\n✏️',
              ),
              TextSpan(
                text: l10n.aboutSupportTheProject_checkSpelling_title,
                style: titleStyle,
              ),
              TextSpan(
                text: l10n.aboutSupportTheProject_checkSpelling_text(
                  userName,
                  userPreferredPronoun,
                ),
              ),
              const TextSpan(
                text: '\n\n🌐',
              ),
              TextSpan(
                text: l10n.aboutSupportTheProject_translation_title,
                style: titleStyle,
              ),
              TextSpan(
                text: l10n.aboutSupportTheProject_translation_text(
                  userName,
                  userPreferredPronoun,
                ),
              ),
              TextSpan(
                text: l10n.aboutSupportTheProject_backup_title,
                style: titleStyle,
              ),
              TextSpan(
                text: l10n.aboutSupportTheProject_backup_text(
                  userName,
                  userPreferredPronoun,
                ),
              ),
              const TextSpan(
                text: '\n\n🎇',
              ),
              TextSpan(
                text: l10n.aboutSupportTheProject_other_title,
                style: titleStyle,
              ),
              TextSpan(
                text: l10n.aboutSupportTheProject_other_text(
                  userName,
                  userPreferredPronoun,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _TheWhy extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    AppLocalizations l10n = AppLocalizations.of(context);

    return ListView(
      padding: const EdgeInsets.all(20),
      children: [
        Text(l10n.aboutTheWhyText),
      ],
    );
  }
}
