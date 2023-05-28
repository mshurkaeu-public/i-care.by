import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ScaffoldHelpers {
  static const double defaultPaddingSide = 20;
  static const EdgeInsetsGeometry defaultBodyPadding =
      EdgeInsets.all(defaultPaddingSide);

  static Widget wrapIntoScaffold(
      {required AppLocalizations l10n,
      required Widget pageContent,
      Widget? drawer,
      Widget? floatingActionButton}) {
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
