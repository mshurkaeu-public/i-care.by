import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;

import 'i_care_by_app.dart';

String _buildLicenseTextForImageFromPixabay(String artistName, String artistProfileName) {
  String res = '''
Image by $artistName (https://pixabay.com/users/$artistProfileName/) from Pixabay (https://pixabay.com).

-

Content License

* Free to use under the Content License

* No attribution required

-

Complete Content License description is available at https://pixabay.com/service/terms/.''';

  return res;
}

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
        LicenseEntryWithLineBreaks(
          <String>['scale-640.jpg'],
          _buildLicenseTextForImageFromPixabay('Arek Socha', 'qimono-1962238'),
        ),
      ));

  LicenseRegistry.addLicense(() => Stream<LicenseEntry>.value(
        LicenseEntryWithLineBreaks(
          <String>['sound-wave-640.jpg'],
          _buildLicenseTextForImageFromPixabay(
            'Pete Linforth',
            'thedigitalartist-202249',
          ),
        ),
      ));

  runApp(const ICareByApp());
}
