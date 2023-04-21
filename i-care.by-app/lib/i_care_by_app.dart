import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'home_page.dart';

class ICareByApp extends StatelessWidget {
  const ICareByApp({super.key});

  String _onGenerateTitle(BuildContext context) {
    return AppLocalizations.of(context).appTitle;
  }

  @override
  Widget build(BuildContext context) {
    ThemeData darkTheme = ThemeData.dark();
    ThemeData lightTheme = ThemeData(
      brightness: Brightness.light,
    );

    return MaterialApp(
      darkTheme: darkTheme,
      home: HomePage(),
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      onGenerateTitle: _onGenerateTitle,
      supportedLocales: AppLocalizations.supportedLocales,
      theme: lightTheme,
      themeMode: ThemeMode.system,
    );
  }
}
