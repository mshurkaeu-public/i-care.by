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

  LicenseRegistry.addLicense(
    () async* {
      String license = await rootBundle.loadString(
        'assets/fonts/Roboto.LICENSE.txt',
      );
      yield LicenseEntryWithLineBreaks(['Roboto font'], license);
    },
  );

  LicenseRegistry.addLicense(() => Stream<LicenseEntry>.value(
    const LicenseEntryWithLineBreaks(<String>['scale-640.jpg'], '''
Image by Arek Socha (https://pixabay.com/users/qimono-1962238/) from Pixabay (https://pixabay.com).

-

Content License

* Free to use under the Content License

* No attribution required

-

Complete Content License description is available at https://pixabay.com/service/terms/.''',
    ),
  ));

  runApp(const ICareByApp());
}
