import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ScaffoldHelpers {
  static const double defaultPaddingSide = 20;
  static const EdgeInsetsGeometry defaultBodyPadding =
      EdgeInsets.all(defaultPaddingSide);

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
