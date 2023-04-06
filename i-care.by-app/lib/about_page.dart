import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:url_launcher/url_launcher.dart';

class AboutPage extends StatelessWidget {
  AboutPage({
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
    tabsChildren[_howItWorksTabIndex] = _HowItWorks();

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

class _HistoryOfCreation extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    AppLocalizations l10n = AppLocalizations.of(context);
    TextStyle titleStyle = TextStyle(fontWeight: FontWeight.bold);

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
              TextSpan(
                text: l10n.aboutHistoryOfCreation_chapter_01_text,
              ),
              TextSpan(
                text: '\n\n---\nПрацяг будзе напісаны пазней.\n\n',
              ),
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
              TextSpan(
                text: l10n.aboutHistoryOfCreation_chapter_03_text,
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _HowItWorks extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    AppLocalizations l10n = AppLocalizations.of(context);

    return ListView(
      padding: const EdgeInsets.all(20),
      children: [
        Text(l10n.aboutHowItWorksText),
      ],
    );
  }
}

class _MyGratitude extends StatelessWidget {
  /// Builds [TextStyle] suitable to display gratitude to superhero's help.
  ///
  /// For a reference:
  ///
  /// [Typography.blackCupertino] is based on San Francisco (.SF UI Display).
  ///
  /// [Typography.blackHelsinki] is based on Roboto, with fallback fonts that are likely (but not guaranteed)
  /// to be installed on Linux ['Ubuntu', 'Cantarell', 'DejaVu Sans', 'Liberation Sans', 'Arial'].
  ///
  /// [Typography.blackMountainView] is based on Roboto.
  ///
  /// [Typography.blackRedmond] is based on Segoe UI.
  ///
  /// [Typography.blackRedwoodCity] is based on San Francisco (.AppleSystemUIFont)
  static TextStyle _getSuperheroTextStyle(BuildContext context) {
    TextStyle res = TextStyle(
      // fontFamily value depends on platform
      fontFamily: DefaultTextStyle.of(context).style.fontFamily,
      fontFamilyFallback: ['Noto Color Emoji'],
    );

    return res;
  }

  @override
  Widget build(BuildContext context) {
    AppLocalizations l10n = AppLocalizations.of(context);
    TextStyle titleStyle = TextStyle(fontWeight: FontWeight.bold);
    TextStyle gratitudeToSuperheroTextStyle = _getSuperheroTextStyle(context);

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

              // 2023-03
              TextSpan(
                text: l10n.aboutMyGratitude_2023_03_title,
                style: titleStyle,
              ),
              TextSpan(
                text: l10n.aboutMyGratitude_2023_03_06_02,
                style: gratitudeToSuperheroTextStyle,
              ),
              TextSpan(
                text: l10n.aboutMyGratitude_2023_03_06_01,
                style: gratitudeToSuperheroTextStyle,
              ),
              TextSpan(
                text: l10n.aboutMyGratitude_2023_03_05_02,
                style: gratitudeToSuperheroTextStyle,
              ),
              TextSpan(
                text: l10n.aboutMyGratitude_2023_03_05_01,
                style: gratitudeToSuperheroTextStyle,
              ),
              TextSpan(
                text: l10n.aboutMyGratitude_2023_03_04_01,
                style: gratitudeToSuperheroTextStyle,
              ),

              // 2023-02
              TextSpan(
                text: l10n.aboutMyGratitude_2023_02_title,
                style: titleStyle,
              ),
              TextSpan(
                text: l10n.aboutMyGratitude_2023_02_28_01,
                style: gratitudeToSuperheroTextStyle,
              ),
              TextSpan(
                text: l10n.aboutMyGratitude_2023_02_15_01,
                style: gratitudeToSuperheroTextStyle,
              ),

              // earlier
              TextSpan(
                text: l10n.aboutMyGratitude_earlier_title,
                style: titleStyle,
              ),
              TextSpan(text: l10n.aboutMyGratitude_earlier_text),
            ],
          ),
        ),
      ],
    );
  }
}

class _ShortAbout extends StatefulWidget {
  _ShortAbout({
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

  final TapGestureRecognizer _facebookUrlTapRecognizer = TapGestureRecognizer();
  final TapGestureRecognizer _instagramUrlTapRecognizer =
      TapGestureRecognizer();
  final TapGestureRecognizer _linkedInUrlTapRecognizer = TapGestureRecognizer();
  final TapGestureRecognizer _telegramUrlTapRecognizer = TapGestureRecognizer();
  final TapGestureRecognizer _tikTokUrlTapRecognizer = TapGestureRecognizer();
  final TapGestureRecognizer _twitterUrlTapRecognizer = TapGestureRecognizer();
  final TapGestureRecognizer _youTubeUrlTapRecognizer = TapGestureRecognizer();

  final Future<PackageInfo> packageInfoFuture = PackageInfo.fromPlatform();

  static const String _gitHubUrl =
      'https://github.com/mshurkaeu-public/i-care.by';

  static const String _facebookUrl = 'https://facebook.com/icare.by.page';
  static const String _instagramUrl = 'https://www.instagram.com/icare.by';
  static const String _linkedInUrl = 'https://linkedin.com/company/i-care-by';
  static const String _telegramUrl = 'https://t.me/icare_by_channel';
  static const String _tikTokUrl = 'https://www.tiktok.com/@icare.by';
  static const String _twitterUrl = 'https://twitter.com/icare_by';
  static const String _youTubeUrl = 'https://www.youtube.com/@i-care-by';

  void _launchFacebookUrl() {
    launchUrl(Uri.parse(_facebookUrl));
  }

  void _launchGitHubUrl() {
    launchUrl(Uri.parse(_gitHubUrl));
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
    const double textVerticalSeparation = 20;

    AppLocalizations l10n = AppLocalizations.of(context);
    String userPreferredPronoun = widget.userPreferredPronoun;

    TextStyle linkStyle = TextStyle(
      color: Colors.blue,
      decoration: TextDecoration.underline,
    );

    return ListView(
      padding: const EdgeInsets.all(20),
      children: [
        Text(
          l10n.appTitle,
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        FutureBuilder<PackageInfo>(
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
        SizedBox(height: textVerticalSeparation),
        Text.rich(
          TextSpan(
            text: l10n.aboutShortAuthor,
            children: [
              //my gratitude
              TextSpan(
                text: l10n.aboutShortMyGratitudePrefix(userPreferredPronoun),
              ),
              TextSpan(
                text: l10n.aboutMyGratitudeTabLabel,
                style: linkStyle,
                recognizer: _myGratitudeTapRecognizer,
              ),
              TextSpan(
                text: l10n.aboutShortMyGratitudePostfix(userPreferredPronoun),
              ),

              //support the project
              TextSpan(
                text: l10n
                    .aboutShortSupportTheProjectPrefix(userPreferredPronoun),
              ),
              TextSpan(
                text: l10n.aboutSupportTheProjectTabLabel,
                style: linkStyle,
                recognizer: _supportTheProjectTapRecognizer,
              ),
              TextSpan(
                text: l10n
                    .aboutShortSupportTheProjectPostfix(userPreferredPronoun),
              ),

              //the wby
              TextSpan(
                text: l10n.aboutShortTheWhyPrefix(userPreferredPronoun),
              ),
              TextSpan(
                text: l10n.aboutTheWhyTabLabel,
                style: linkStyle,
                recognizer: _theWhyTapRecognizer,
              ),
              TextSpan(
                text: l10n.aboutShortTheWhyPostfix(userPreferredPronoun),
              ),

              //how it works
              TextSpan(
                text: l10n.aboutShortHowItWorksPrefix(userPreferredPronoun),
              ),
              TextSpan(
                text: l10n.aboutHowItWorksTabLabel,
                style: linkStyle,
                recognizer: _howItWorksTapRecognizer,
              ),
              TextSpan(
                text: l10n.aboutShortHowItWorksPostfix(userPreferredPronoun),
              ),

              //history of creation
              TextSpan(
                text: l10n
                    .aboutShortHistoryOfCreationPrefix(userPreferredPronoun),
              ),
              TextSpan(
                text: l10n.aboutHistoryOfCreationTabLabel,
                style: linkStyle,
                recognizer: _historyOfCreationTapRecognizer,
              ),
              TextSpan(
                text: l10n
                    .aboutShortHistoryOfCreationPostfix(userPreferredPronoun),
              ),

              //components
              TextSpan(
                text: l10n.aboutShortShowLicensesPrefix(userPreferredPronoun),
              ),
              TextSpan(
                text: MaterialLocalizations.of(context).viewLicensesButtonLabel,
                style: linkStyle,
                recognizer: _showLicensesTapRecognizer,
              ),
              TextSpan(
                text: l10n.aboutShortShowLicensesPostfix(userPreferredPronoun),
              ),

              //link to GitHub
              TextSpan(
                text:
                    l10n.aboutShortLinkToRepositoryPrefix(userPreferredPronoun),
              ),
              TextSpan(
                text: _gitHubUrl,
                style: linkStyle,
                recognizer: _gitHubUrlTapRecognizer,
              ),
              TextSpan(
                text: l10n
                    .aboutShortLinkToRepositoryPostfix(userPreferredPronoun),
              ),
            ],
          ),
        ),
        SizedBox(height: textVerticalSeparation),
        Text(
          l10n.aboutShortFeedbackAndSocialNetworksParagraphTitle,
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        Text(
          l10n.aboutShortFeedbackAndSocialNetworksParagraph(
            userPreferredPronoun,
          ),
        ),
        Text.rich(
          TextSpan(
            style: TextStyle(
              height: 1.8,
            ),
            children: [
              //Facebook
              TextSpan(
                text: 'Facebook —',
                style: TextStyle(wordSpacing: 3),
              ),
              TextSpan(
                text: ' ',
              ),
              TextSpan(
                text: _facebookUrl,
                style: linkStyle,
                recognizer: _facebookUrlTapRecognizer,
              ),
              TextSpan(
                text: '\n',
              ),

              //Instagram
              TextSpan(
                text: 'Instagram —',
                style: TextStyle(wordSpacing: 0),
              ),
              TextSpan(
                text: ' ',
              ),
              TextSpan(
                text: _instagramUrl,
                style: linkStyle,
                recognizer: _instagramUrlTapRecognizer,
              ),
              TextSpan(
                text: '\n',
              ),

              //LinkedIn
              TextSpan(
                text: 'LinkedIn —',
                style: TextStyle(wordSpacing: 10),
              ),
              TextSpan(
                text: ' ',
              ),
              TextSpan(
                text: _linkedInUrl,
                style: linkStyle,
                recognizer: _linkedInUrlTapRecognizer,
              ),
              TextSpan(
                text: '\n',
              ),

              //Telegram
              TextSpan(
                text: 'Telegram —',
                style: TextStyle(wordSpacing: 4),
              ),
              TextSpan(
                text: ' ',
              ),
              TextSpan(
                text: _telegramUrl,
                style: linkStyle,
                recognizer: _telegramUrlTapRecognizer,
              ),
              TextSpan(
                text: '\n',
              ),

              //TikTok
              TextSpan(
                text: 'TikTok —',
                style: TextStyle(wordSpacing: 22),
              ),
              TextSpan(
                text: ' ',
              ),
              TextSpan(
                text: _tikTokUrl,
                style: linkStyle,
                recognizer: _tikTokUrlTapRecognizer,
              ),
              TextSpan(
                text: '\n',
              ),

              //Twitter
              TextSpan(
                text: 'Twitter —',
                style: TextStyle(wordSpacing: 18),
              ),
              TextSpan(
                text: ' ',
              ),
              TextSpan(
                text: _twitterUrl,
                style: linkStyle,
                recognizer: _twitterUrlTapRecognizer,
              ),
              TextSpan(
                text: '\n',
              ),

              //YouTube
              TextSpan(
                text: 'YouTube —',
                style: TextStyle(wordSpacing: 8),
              ),
              TextSpan(
                text: ' ',
              ),
              TextSpan(
                text: _youTubeUrl,
                style: linkStyle,
                recognizer: _youTubeUrlTapRecognizer,
              ),
              TextSpan(
                text: '\n',
              ),
            ],
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

    _facebookUrlTapRecognizer.dispose();
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

    _myGratitudeTapRecognizer.onTap = _showMyGratitudeTab;
    _showLicensesTapRecognizer.onTap = _showLicenses;
    _supportTheProjectTapRecognizer.onTap = _showSupportTheProjectTab;
    _theWhyTapRecognizer.onTap = _showTheWhyTab;
    _howItWorksTapRecognizer.onTap = _showHowItWorksTab;
    _historyOfCreationTapRecognizer.onTap = _showHistoryOfCreation;

    _gitHubUrlTapRecognizer.onTap = _launchGitHubUrl;

    _facebookUrlTapRecognizer.onTap = _launchFacebookUrl;
    _instagramUrlTapRecognizer.onTap = _launchInstagramUrl;
    _linkedInUrlTapRecognizer.onTap = _launchLinkedInUrl;
    _telegramUrlTapRecognizer.onTap = _launchTelegramUrl;
    _tikTokUrlTapRecognizer.onTap = _launchTikTokUrl;
    _twitterUrlTapRecognizer.onTap = _launchTwitterUrl;
    _youTubeUrlTapRecognizer.onTap = _launchYouTubeUrl;
  }
}

class _SupportTheProject extends StatelessWidget {
  _SupportTheProject({
    required this.userName,
    required this.userPreferredPronoun,
  });

  final String userName;
  final String userPreferredPronoun;

  @override
  Widget build(BuildContext context) {
    AppLocalizations l10n = AppLocalizations.of(context);
    TextStyle titleStyle = TextStyle(fontWeight: FontWeight.bold);
    TextStyle titleIconStyle = TextStyle(fontFamily: 'Noto Color Emoji');

    return ListView(
      padding: const EdgeInsets.all(20),
      children: [
        Text.rich(
          TextSpan(
            text: '',
            children: [
              TextSpan(
                text: '💸',
                style: titleIconStyle,
              ),
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
                text: '\n\n🗯️',
                style: titleIconStyle,
              ),
              TextSpan(
                text: l10n.aboutSupportTheProject_feedback_title,
                style: titleStyle,
              ),
              TextSpan(
                text: l10n.aboutSupportTheProject_feedback_text(
                  userName,
                  userPreferredPronoun,
                ),
              ),
              TextSpan(
                text: '\n\n👾',
                style: titleIconStyle,
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
              TextSpan(
                text: '\n\n✏️',
                style: titleIconStyle,
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
              TextSpan(
                text: '\n\n🌐',
                style: titleIconStyle,
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
                text: '\n\n🎇',
                style: titleIconStyle,
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
