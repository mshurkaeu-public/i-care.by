import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'l10n/generated/app_localizations.dart';
import 'home_page.dart';

class ICareByApp extends StatelessWidget {
  const ICareByApp({super.key});

  String _onGenerateTitle(BuildContext context) {
    return AppLocalizations.of(context).appTitle;
  }

  @override
  Widget build(BuildContext context) {
    String roboto = GoogleFonts.roboto().fontFamily!;
    String notoColorEmoji = GoogleFonts.notoColorEmoji().fontFamily!;

    ThemeData darkTheme = ThemeData(
      brightness: Brightness.dark,
      fontFamily: roboto,
      fontFamilyFallback: [notoColorEmoji],
    );
    ThemeData lightTheme = ThemeData(
      brightness: Brightness.light,
      fontFamily: roboto,
      fontFamilyFallback: [notoColorEmoji],
    );

    return MaterialApp(
      darkTheme: darkTheme,
      home: const HomePage(),
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      onGenerateTitle: _onGenerateTitle,
      supportedLocales: AppLocalizations.supportedLocales,
      theme: lightTheme,
      themeMode: ThemeMode.system,
    );
  }
}
