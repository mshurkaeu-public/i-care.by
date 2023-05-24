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

String _buildLicenseTextForPhotoFromUnsplash(
  String photographerName,
  String photographerProfileName,
) {
  String res = '''
Photo by $photographerName (https://unsplash.com/$photographerProfileName) on Unsplash (https://unsplash.com).

-

Free to use under the Unsplash License

Unsplash grants you an irrevocable, nonexclusive, worldwide copyright license to download, copy, modify,
distribute, perform, and use photos from Unsplash for free, including for commercial purposes, without
permission from or attributing the photographer or Unsplash, but this license does not include the right
to compile photos from Unsplash to replicate a similar or competing service.

-

Complete Unsplash License description is available at https://unsplash.com/terms/.''';

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
          <String>['fireplace-640.jpg'],
          _buildLicenseTextForPhotoFromUnsplash(
            'Annie Spratt',
            '@anniespratt',
          ),
        ),
      ));

  LicenseRegistry.addLicense(() => Stream<LicenseEntry>.value(
        LicenseEntryWithLineBreaks(
          <String>['long-pond-640.jpg'],
          _buildLicenseTextForPhotoFromUnsplash(
            'Mick Haupt',
            '@rocinante_11',
          ),
        ),
      ));

  LicenseRegistry.addLicense(() => Stream<LicenseEntry>.value(
        LicenseEntryWithLineBreaks(
          <String>[
            'doors-640.jpg',
            'scale-640.jpg',
          ],
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

  LicenseRegistry.addLicense(() => Stream<LicenseEntry>.value(
        LicenseEntryWithLineBreaks(
          <String>['graph-640.jpg'],
          _buildLicenseTextForImageFromPixabay(
            'Mediamodifier',
            'mediamodifier-1567646',
          ),
        ),
      ));

  LicenseRegistry.addLicense(() => Stream<LicenseEntry>.value(
        LicenseEntryWithLineBreaks(
          <String>['colores-a-medida-640.jpg'],
          _buildLicenseTextForPhotoFromUnsplash(
            'Patricia Serna',
            '@sernarial',
          ),
        ),
      ));

  LicenseRegistry.addLicense(() => Stream<LicenseEntry>.value(
        LicenseEntryWithLineBreaks(
          <String>['time-640.jpg'],
          _buildLicenseTextForImageFromPixabay(
            'Gerd Altmann',
            'geralt-9301',
          ),
        ),
      ));

  LicenseRegistry.addLicense(() => Stream<LicenseEntry>.value(
        LicenseEntryWithLineBreaks(
          <String>['aircraft-640.jpg'],
          _buildLicenseTextForImageFromPixabay(
            'Nel Botha',
            'nel_botha-nz-1267169',
          ),
        ),
      ));

  LicenseRegistry.addLicense(() => Stream<LicenseEntry>.value(
        LicenseEntryWithLineBreaks(
          <String>['submarine-640.jpg'],
          _buildLicenseTextForImageFromPixabay(
            'Achim Scholty',
            'scholty1970-7596740',
          ),
        ),
      ));

  runApp(const ICareByApp());
}
