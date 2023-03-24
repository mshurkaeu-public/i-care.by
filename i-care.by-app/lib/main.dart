import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;

import 'i_care_by_app.dart';

void main() {
  LicenseRegistry.addLicense(
    () async* {
      String license = await rootBundle.loadString(
        'assets/fonts/NotoColorEmoji.LICENSE.txt',
      );
      yield LicenseEntryWithLineBreaks(['Noto Color Emoji font'], license);
    },
  );

  runApp(const ICareByApp());
}
