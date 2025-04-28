import 'package:flutter/material.dart';

import 'l10n/generated/app_localizations.dart';
import 'about_page.dart';

class ScaffoldHelpers {
  static const double defaultPaddingSide = 20;
  static const EdgeInsetsGeometry defaultBodyPadding =
      EdgeInsets.all(defaultPaddingSide);

  static Widget buildAboutTheApplicationListTile({
    required BuildContext context,
    required String userName,
    required String userPreferredPronoun,
  }) {
    return ListTile(
      title: Text(
        MaterialLocalizations.of(context).aboutListTileTitle('i-care.by'),
      ),
      onTap: () {
        NavigatorState navigator = Navigator.of(context);
        navigator.pop();
        navigator.push(
          MaterialPageRoute(
            builder: (BuildContext context) => AboutPage(
              userName: userName,
              userPreferredPronoun: userPreferredPronoun,
            ),
          ),
        );
      },
    );
  }

  static Widget buildViewBackupsListTile(BuildContext context) {
    // TODO: implement backups review
    return ListTile(
      title: const Text('Рэзервовыя копіі'),
      onTap: () {
        Navigator.pop(context);
        showAboutDialog(
          context: context,
          children: [
            const Text(
                'Функцыя прагляду рэзервовых копій пакуль што не зроблена.'),
          ],
        );
      },
    );
  }

  static Widget wrapIntoScaffold(
      {required BuildContext context,
      required Widget pageContent,
      Widget? drawer,
      Widget? floatingActionButton}) {
    AppLocalizations l10n = AppLocalizations.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.appTitle),
      ),
      body: SingleChildScrollView(
        padding: ScaffoldHelpers.defaultBodyPadding,
        child: pageContent,
      ),
      drawer: drawer,
      floatingActionButton: floatingActionButton,
    );
  }
}
