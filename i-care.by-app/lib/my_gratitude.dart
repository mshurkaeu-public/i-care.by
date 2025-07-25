import 'package:flutter/material.dart';

import 'l10n/generated/app_localizations.dart';
import 'scaffold_helpers.dart';

class MyGratitude extends StatelessWidget {
  const MyGratitude({super.key});

  @override
  Widget build(BuildContext context) {
    AppLocalizations l10n = AppLocalizations.of(context);
    TextStyle titleStyle = const TextStyle(fontWeight: FontWeight.bold);

    return ListView(
      padding: ScaffoldHelpers.defaultBodyPadding,
      children: [
        Text(
          l10n.aboutMyGratitudeTitle,
          style: titleStyle,
        ),
        Text.rich(
          TextSpan(
            text: l10n.aboutMyGratitudeIntroductory,
            children: [
              // 2025-07
              TextSpan(
                text: l10n.aboutMyGratitude_2025_07_title,
                style: titleStyle,
              ),
              TextSpan(
                text: l10n.aboutMyGratitude_2025_07_26_01,
              ),
              TextSpan(
                text: l10n.aboutMyGratitude_2025_07_25_01,
              ),
              TextSpan(
                text: l10n.aboutMyGratitude_2025_07_24_01,
              ),
              TextSpan(
                text: l10n.aboutMyGratitude_2025_07_19_01,
              ),
              TextSpan(
                text: l10n.aboutMyGratitude_2025_07_17_02,
              ),
              TextSpan(
                text: l10n.aboutMyGratitude_2025_07_17_01,
              ),
              TextSpan(
                text: l10n.aboutMyGratitude_2025_07_16_01,
              ),
              TextSpan(
                text: l10n.aboutMyGratitude_2025_07_12_03,
              ),
              TextSpan(
                text: l10n.aboutMyGratitude_2025_07_12_02,
              ),
              TextSpan(
                text: l10n.aboutMyGratitude_2025_07_12_01,
              ),
              TextSpan(
                text: l10n.aboutMyGratitude_2025_07_11_02,
              ),
              TextSpan(
                text: l10n.aboutMyGratitude_2025_07_11_01,
              ),
              TextSpan(
                text: l10n.aboutMyGratitude_2025_07_10_01,
              ),
              TextSpan(
                text: l10n.aboutMyGratitude_2025_07_02_01,
              ),

              // 2025-06
              TextSpan(
                text: l10n.aboutMyGratitude_2025_06_title,
                style: titleStyle,
              ),
              TextSpan(
                text: l10n.aboutMyGratitude_2025_06_28_01,
              ),
              TextSpan(
                text: l10n.aboutMyGratitude_2025_06_20_02,
              ),
              TextSpan(
                text: l10n.aboutMyGratitude_2025_06_20_01,
              ),
              TextSpan(
                text: l10n.aboutMyGratitude_2025_06_13_03,
              ),
              TextSpan(
                text: l10n.aboutMyGratitude_2025_06_13_02,
              ),
              TextSpan(
                text: l10n.aboutMyGratitude_2025_06_13_01,
              ),
              TextSpan(
                text: l10n.aboutMyGratitude_2025_06_07_04,
              ),
              TextSpan(
                text: l10n.aboutMyGratitude_2025_06_07_03,
              ),
              TextSpan(
                text: l10n.aboutMyGratitude_2025_06_07_02,
              ),
              TextSpan(
                text: l10n.aboutMyGratitude_2025_06_07_01,
              ),

              // 2025-05
              TextSpan(
                text: l10n.aboutMyGratitude_2025_05_title,
                style: titleStyle,
              ),
              TextSpan(
                text: l10n.aboutMyGratitude_2025_05_31_02,
              ),
              TextSpan(
                text: l10n.aboutMyGratitude_2025_05_31_01,
              ),
              TextSpan(
                text: l10n.aboutMyGratitude_2025_05_30_01,
              ),
              TextSpan(
                text: l10n.aboutMyGratitude_2025_05_24_02,
              ),
              TextSpan(
                text: l10n.aboutMyGratitude_2025_05_24_01,
              ),
              TextSpan(
                text: l10n.aboutMyGratitude_2025_05_21_01,
              ),
              TextSpan(
                text: l10n.aboutMyGratitude_2025_05_17_02,
              ),
              TextSpan(
                text: l10n.aboutMyGratitude_2025_05_17_01,
              ),
              TextSpan(
                text: l10n.aboutMyGratitude_2025_05_14_02,
              ),
              TextSpan(
                text: l10n.aboutMyGratitude_2025_05_14_01,
              ),
              TextSpan(
                text: l10n.aboutMyGratitude_2025_05_10_02,
              ),
              TextSpan(
                text: l10n.aboutMyGratitude_2025_05_10_01,
              ),

              // 2025-04
              TextSpan(
                text: l10n.aboutMyGratitude_2025_04_title,
                style: titleStyle,
              ),
              TextSpan(
                text: l10n.aboutMyGratitude_2025_04_22_02,
              ),
              TextSpan(
                text: l10n.aboutMyGratitude_2025_04_22_01,
              ),
              TextSpan(
                text: l10n.aboutMyGratitude_2025_04_19_01,
              ),
              TextSpan(
                text: l10n.aboutMyGratitude_2025_04_18_02,
              ),
              TextSpan(
                text: l10n.aboutMyGratitude_2025_04_18_01,
              ),
              TextSpan(
                text: l10n.aboutMyGratitude_2025_04_12_02,
              ),
              TextSpan(
                text: l10n.aboutMyGratitude_2025_04_12_01,
              ),
              TextSpan(
                text: l10n.aboutMyGratitude_2025_04_05_01,
              ),
              TextSpan(
                text: l10n.aboutMyGratitude_2025_04_04_02,
              ),
              TextSpan(
                text: l10n.aboutMyGratitude_2025_04_04_01,
              ),

              // 2025-03
              TextSpan(
                text: l10n.aboutMyGratitude_2025_03_title,
                style: titleStyle,
              ),
              TextSpan(
                text: l10n.aboutMyGratitude_2025_03_29_01,
              ),
              TextSpan(
                text: l10n.aboutMyGratitude_2025_03_26_01,
              ),
              TextSpan(
                text: l10n.aboutMyGratitude_2025_03_22_01,
              ),
              TextSpan(
                text: l10n.aboutMyGratitude_2025_03_15_01,
              ),
              TextSpan(
                text: l10n.aboutMyGratitude_2025_03_08_02,
              ),
              TextSpan(
                text: l10n.aboutMyGratitude_2025_03_08_01,
              ),

              // 2025-02
              TextSpan(
                text: l10n.aboutMyGratitude_2025_02_title,
                style: titleStyle,
              ),
              TextSpan(
                text: l10n.aboutMyGratitude_2025_02_28_02,
              ),
              TextSpan(
                text: l10n.aboutMyGratitude_2025_02_28_01,
              ),
              TextSpan(
                text: l10n.aboutMyGratitude_2025_02_22_01,
              ),
              TextSpan(
                text: l10n.aboutMyGratitude_2025_02_19_01,
              ),
              TextSpan(
                text: l10n.aboutMyGratitude_2025_02_15_01,
              ),
              TextSpan(
                text: l10n.aboutMyGratitude_2025_02_14_01,
              ),
              TextSpan(
                text: l10n.aboutMyGratitude_2025_02_13_02,
              ),
              TextSpan(
                text: l10n.aboutMyGratitude_2025_02_13_01,
              ),
              TextSpan(
                text: l10n.aboutMyGratitude_2025_02_12_01,
              ),
              TextSpan(
                text: l10n.aboutMyGratitude_2025_02_11_03,
              ),
              TextSpan(
                text: l10n.aboutMyGratitude_2025_02_11_02,
              ),
              TextSpan(
                text: l10n.aboutMyGratitude_2025_02_11_01,
              ),
              TextSpan(
                text: l10n.aboutMyGratitude_2025_02_08_02,
              ),
              TextSpan(
                text: l10n.aboutMyGratitude_2025_02_08_01,
              ),
              TextSpan(
                text: l10n.aboutMyGratitude_2025_02_05_01,
              ),
              TextSpan(
                text: l10n.aboutMyGratitude_2025_02_04_02,
              ),
              TextSpan(
                text: l10n.aboutMyGratitude_2025_02_04_01,
              ),

              // 2025-01
              TextSpan(
                text: l10n.aboutMyGratitude_2025_01_title,
                style: titleStyle,
              ),
              TextSpan(
                text: l10n.aboutMyGratitude_2025_01_31_01,
              ),
              TextSpan(
                text: l10n.aboutMyGratitude_2025_01_30_02,
              ),
              TextSpan(
                text: l10n.aboutMyGratitude_2025_01_30_01,
              ),
              TextSpan(
                text: l10n.aboutMyGratitude_2025_01_25_02,
              ),
              TextSpan(
                text: l10n.aboutMyGratitude_2025_01_25_01,
              ),
              TextSpan(
                text: l10n.aboutMyGratitude_2025_01_17_01,
              ),
              TextSpan(
                text: l10n.aboutMyGratitude_2025_01_16_04,
              ),
              TextSpan(
                text: l10n.aboutMyGratitude_2025_01_16_03,
              ),
              TextSpan(
                text: l10n.aboutMyGratitude_2025_01_16_02,
              ),
              TextSpan(
                text: l10n.aboutMyGratitude_2025_01_16_01,
              ),
              TextSpan(
                text: l10n.aboutMyGratitude_2025_01_10_01,
              ),
              TextSpan(
                text: l10n.aboutMyGratitude_2025_01_07_01,
              ),
              TextSpan(
                text: l10n.aboutMyGratitude_2025_01_05_01,
              ),

              // 2024-12
              TextSpan(
                text: l10n.aboutMyGratitude_2024_12_title,
                style: titleStyle,
              ),
              TextSpan(
                text: l10n.aboutMyGratitude_2024_12_20_01,
              ),
              TextSpan(
                text: l10n.aboutMyGratitude_2024_12_19_01,
              ),
              TextSpan(
                text: l10n.aboutMyGratitude_2024_12_17_01,
              ),
              TextSpan(
                text: l10n.aboutMyGratitude_2024_12_15_01,
              ),
              TextSpan(
                text: l10n.aboutMyGratitude_2024_12_13_03,
              ),
              TextSpan(
                text: l10n.aboutMyGratitude_2024_12_13_02,
              ),
              TextSpan(
                text: l10n.aboutMyGratitude_2024_12_13_01,
              ),
              TextSpan(
                text: l10n.aboutMyGratitude_2024_12_06_02,
              ),
              TextSpan(
                text: l10n.aboutMyGratitude_2024_12_06_01,
              ),
              TextSpan(
                text: l10n.aboutMyGratitude_2024_12_05_02,
              ),
              TextSpan(
                text: l10n.aboutMyGratitude_2024_12_05_01,
              ),

              // 2024-11
              TextSpan(
                text: l10n.aboutMyGratitude_2024_11_title,
                style: titleStyle,
              ),
              TextSpan(
                text: l10n.aboutMyGratitude_2024_11_29_02,
              ),
              TextSpan(
                text: l10n.aboutMyGratitude_2024_11_29_01,
              ),
              TextSpan(
                text: l10n.aboutMyGratitude_2024_11_26_02,
              ),
              TextSpan(
                text: l10n.aboutMyGratitude_2024_11_26_01,
              ),
              TextSpan(
                text: l10n.aboutMyGratitude_2024_11_23_01,
              ),
              TextSpan(
                text: l10n.aboutMyGratitude_2024_11_22_01,
              ),
              TextSpan(
                text: l10n.aboutMyGratitude_2024_11_17_01,
              ),
              TextSpan(
                text: l10n.aboutMyGratitude_2024_11_16_05,
              ),
              TextSpan(
                text: l10n.aboutMyGratitude_2024_11_16_04,
              ),
              TextSpan(
                text: l10n.aboutMyGratitude_2024_11_16_03,
              ),
              TextSpan(
                text: l10n.aboutMyGratitude_2024_11_16_02,
              ),
              TextSpan(
                text: l10n.aboutMyGratitude_2024_11_16_01,
              ),
              TextSpan(
                text: l10n.aboutMyGratitude_2024_11_08_05,
              ),
              TextSpan(
                text: l10n.aboutMyGratitude_2024_11_08_04,
              ),
              TextSpan(
                text: l10n.aboutMyGratitude_2024_11_08_03,
              ),
              TextSpan(
                text: l10n.aboutMyGratitude_2024_11_08_02,
              ),
              TextSpan(
                text: l10n.aboutMyGratitude_2024_11_08_01,
              ),

              // 2024-10
              TextSpan(
                text: l10n.aboutMyGratitude_2024_10_title,
                style: titleStyle,
              ),
              TextSpan(
                text: l10n.aboutMyGratitude_2024_10_30_04,
              ),
              TextSpan(
                text: l10n.aboutMyGratitude_2024_10_30_03,
              ),
              TextSpan(
                text: l10n.aboutMyGratitude_2024_10_30_02,
              ),
              TextSpan(
                text: l10n.aboutMyGratitude_2024_10_30_01,
              ),
              TextSpan(
                text: l10n.aboutMyGratitude_2024_10_26_02,
              ),
              TextSpan(
                text: l10n.aboutMyGratitude_2024_10_26_01,
              ),
              TextSpan(
                text: l10n.aboutMyGratitude_2024_10_18_02,
              ),
              TextSpan(
                text: l10n.aboutMyGratitude_2024_10_18_01,
              ),
              TextSpan(
                text: l10n.aboutMyGratitude_2024_10_12_01,
              ),
              TextSpan(
                text: l10n.aboutMyGratitude_2024_10_10_02,
              ),
              TextSpan(
                text: l10n.aboutMyGratitude_2024_10_10_01,
              ),
              TextSpan(
                text: l10n.aboutMyGratitude_2024_10_09_01,
              ),
              TextSpan(
                text: l10n.aboutMyGratitude_2024_10_05_01,
              ),
              TextSpan(
                text: l10n.aboutMyGratitude_2024_10_02_01,
              ),

              // 2024-09
              TextSpan(
                text: l10n.aboutMyGratitude_2024_09_title,
                style: titleStyle,
              ),
              TextSpan(
                text: l10n.aboutMyGratitude_2024_09_28_01,
              ),
              TextSpan(
                text: l10n.aboutMyGratitude_2024_09_25_02,
              ),
              TextSpan(
                text: l10n.aboutMyGratitude_2024_09_25_01,
              ),
              TextSpan(
                text: l10n.aboutMyGratitude_2024_09_22_02,
              ),
              TextSpan(
                text: l10n.aboutMyGratitude_2024_09_22_01,
              ),
              TextSpan(
                text: l10n.aboutMyGratitude_2024_09_15_01,
              ),
              TextSpan(
                text: l10n.aboutMyGratitude_2024_09_13_02,
              ),
              TextSpan(
                text: l10n.aboutMyGratitude_2024_09_13_01,
              ),
              TextSpan(
                text: l10n.aboutMyGratitude_2024_09_12_01,
              ),
              TextSpan(
                text: l10n.aboutMyGratitude_2024_09_11_01,
              ),
              TextSpan(
                text: l10n.aboutMyGratitude_2024_09_06_02,
              ),
              TextSpan(
                text: l10n.aboutMyGratitude_2024_09_06_01,
              ),
              TextSpan(
                text: l10n.aboutMyGratitude_2024_09_05_01,
              ),
              TextSpan(
                text: l10n.aboutMyGratitude_2024_09_04_01,
              ),

              // 2024-08
              TextSpan(
                text: l10n.aboutMyGratitude_2024_08_title,
                style: titleStyle,
              ),
              TextSpan(
                text: l10n.aboutMyGratitude_2024_08_29_02,
              ),
              TextSpan(
                text: l10n.aboutMyGratitude_2024_08_29_01,
              ),
              TextSpan(
                text: l10n.aboutMyGratitude_2024_08_24_01,
              ),
              TextSpan(
                text: l10n.aboutMyGratitude_2024_08_20_02,
              ),
              TextSpan(
                text: l10n.aboutMyGratitude_2024_08_20_01,
              ),
              TextSpan(
                text: l10n.aboutMyGratitude_2024_08_10_01,
              ),
              TextSpan(
                text: l10n.aboutMyGratitude_2024_08_09_03,
              ),
              TextSpan(
                text: l10n.aboutMyGratitude_2024_08_09_02,
              ),
              TextSpan(
                text: l10n.aboutMyGratitude_2024_08_09_01,
              ),
              TextSpan(
                text: l10n.aboutMyGratitude_2024_08_07_01,
              ),
              TextSpan(
                text: l10n.aboutMyGratitude_2024_08_03_01,
              ),

              // 2024-07
              TextSpan(
                text: l10n.aboutMyGratitude_2024_07_title,
                style: titleStyle,
              ),
              TextSpan(
                text: l10n.aboutMyGratitude_2024_07_31_03,
              ),
              TextSpan(
                text: l10n.aboutMyGratitude_2024_07_31_02,
              ),
              TextSpan(
                text: l10n.aboutMyGratitude_2024_07_31_01,
              ),
              TextSpan(
                text: l10n.aboutMyGratitude_2024_07_30_01,
              ),
              TextSpan(
                text: l10n.aboutMyGratitude_2024_07_27_01,
              ),
              TextSpan(
                text: l10n.aboutMyGratitude_2024_07_26_01,
              ),
              TextSpan(
                text: l10n.aboutMyGratitude_2024_07_24_01,
              ),
              TextSpan(
                text: l10n.aboutMyGratitude_2024_07_23_01,
              ),
              TextSpan(
                text: l10n.aboutMyGratitude_2024_07_20_02,
              ),
              TextSpan(
                text: l10n.aboutMyGratitude_2024_07_20_01,
              ),
              TextSpan(
                text: l10n.aboutMyGratitude_2024_07_18_01,
              ),
              TextSpan(
                text: l10n.aboutMyGratitude_2024_07_17_01,
              ),
              TextSpan(
                text: l10n.aboutMyGratitude_2024_07_12_03,
              ),
              TextSpan(
                text: l10n.aboutMyGratitude_2024_07_12_02,
              ),
              TextSpan(
                text: l10n.aboutMyGratitude_2024_07_12_01,
              ),

              // 2024-06
              TextSpan(
                text: l10n.aboutMyGratitude_2024_06_title,
                style: titleStyle,
              ),
              TextSpan(
                text: l10n.aboutMyGratitude_2024_06_30_01,
              ),
              TextSpan(
                text: l10n.aboutMyGratitude_2024_06_26_01,
              ),
              TextSpan(
                text: l10n.aboutMyGratitude_2024_06_23_03,
              ),
              TextSpan(
                text: l10n.aboutMyGratitude_2024_06_23_02,
              ),
              TextSpan(
                text: l10n.aboutMyGratitude_2024_06_23_01,
              ),
              TextSpan(
                text: l10n.aboutMyGratitude_2024_06_22_02,
              ),
              TextSpan(
                text: l10n.aboutMyGratitude_2024_06_22_01,
              ),
              TextSpan(
                text: l10n.aboutMyGratitude_2024_06_18_01,
              ),
              TextSpan(
                text: l10n.aboutMyGratitude_2024_06_14_01,
              ),
              TextSpan(
                text: l10n.aboutMyGratitude_2024_06_13_01,
              ),
              TextSpan(
                text: l10n.aboutMyGratitude_2024_06_12_02,
              ),
              TextSpan(
                text: l10n.aboutMyGratitude_2024_06_12_01,
              ),
              TextSpan(
                text: l10n.aboutMyGratitude_2024_06_10_02,
              ),
              TextSpan(
                text: l10n.aboutMyGratitude_2024_06_10_01,
              ),
              TextSpan(
                text: l10n.aboutMyGratitude_2024_06_09_01,
              ),
              TextSpan(
                text: l10n.aboutMyGratitude_2024_06_08_01,
              ),
              TextSpan(
                text: l10n.aboutMyGratitude_2024_06_07_02,
              ),
              TextSpan(
                text: l10n.aboutMyGratitude_2024_06_07_01,
              ),
              TextSpan(
                text: l10n.aboutMyGratitude_2024_06_06_01,
              ),
              TextSpan(
                text: l10n.aboutMyGratitude_2024_06_05_01,
              ),

              // 2024-05
              TextSpan(
                text: l10n.aboutMyGratitude_2024_05_title,
                style: titleStyle,
              ),
              TextSpan(
                text: l10n.aboutMyGratitude_2024_05_30_01,
              ),
              TextSpan(
                text: l10n.aboutMyGratitude_2024_05_29_01,
              ),
              TextSpan(
                text: l10n.aboutMyGratitude_2024_05_28_01,
              ),
              TextSpan(
                text: l10n.aboutMyGratitude_2024_05_24_01,
              ),
              TextSpan(
                text: l10n.aboutMyGratitude_2024_05_23_01,
              ),
              TextSpan(
                text: l10n.aboutMyGratitude_2024_05_22_03,
              ),
              TextSpan(
                text: l10n.aboutMyGratitude_2024_05_22_02,
              ),
              TextSpan(
                text: l10n.aboutMyGratitude_2024_05_22_01,
              ),
              TextSpan(
                text: l10n.aboutMyGratitude_2024_05_21_01,
              ),
              TextSpan(
                text: l10n.aboutMyGratitude_2024_05_17_01,
              ),
              TextSpan(
                text: l10n.aboutMyGratitude_2024_05_16_01,
              ),
              TextSpan(
                text: l10n.aboutMyGratitude_2024_05_12_01,
              ),
              TextSpan(
                text: l10n.aboutMyGratitude_2024_05_10_01,
              ),
              TextSpan(
                text: l10n.aboutMyGratitude_2024_05_03_02,
              ),
              TextSpan(
                text: l10n.aboutMyGratitude_2024_05_03_01,
              ),

              // 2024-04
              TextSpan(
                text: l10n.aboutMyGratitude_2024_04_title,
                style: titleStyle,
              ),
              TextSpan(
                text: l10n.aboutMyGratitude_2024_04_30_03,
              ),
              TextSpan(
                text: l10n.aboutMyGratitude_2024_04_30_02,
              ),
              TextSpan(
                text: l10n.aboutMyGratitude_2024_04_30_01,
              ),
              TextSpan(
                text: l10n.aboutMyGratitude_2024_04_20_01,
              ),
              TextSpan(
                text: l10n.aboutMyGratitude_2024_04_18_02,
              ),
              TextSpan(
                text: l10n.aboutMyGratitude_2024_04_18_01,
              ),
              TextSpan(
                text: l10n.aboutMyGratitude_2024_04_17_02,
              ),
              TextSpan(
                text: l10n.aboutMyGratitude_2024_04_17_01,
              ),
              TextSpan(
                text: l10n.aboutMyGratitude_2024_04_14_03,
              ),
              TextSpan(
                text: l10n.aboutMyGratitude_2024_04_14_02,
              ),
              TextSpan(
                text: l10n.aboutMyGratitude_2024_04_14_01,
              ),
              TextSpan(
                text: l10n.aboutMyGratitude_2024_04_13_05,
              ),
              TextSpan(
                text: l10n.aboutMyGratitude_2024_04_13_04,
              ),
              TextSpan(
                text: l10n.aboutMyGratitude_2024_04_13_03,
              ),
              TextSpan(
                text: l10n.aboutMyGratitude_2024_04_13_02,
              ),
              TextSpan(
                text: l10n.aboutMyGratitude_2024_04_13_01,
              ),

              // 2024-03
              TextSpan(
                text: l10n.aboutMyGratitude_2024_03_title,
                style: titleStyle,
              ),
              TextSpan(
                text: l10n.aboutMyGratitude_2024_03_31_01,
              ),
              TextSpan(
                text: l10n.aboutMyGratitude_2024_03_30_07,
              ),
              TextSpan(
                text: l10n.aboutMyGratitude_2024_03_30_06,
              ),
              TextSpan(
                text: l10n.aboutMyGratitude_2024_03_30_05,
              ),
              TextSpan(
                text: l10n.aboutMyGratitude_2024_03_30_04,
              ),
              TextSpan(
                text: l10n.aboutMyGratitude_2024_03_30_03,
              ),
              TextSpan(
                text: l10n.aboutMyGratitude_2024_03_30_02,
              ),
              TextSpan(
                text: l10n.aboutMyGratitude_2024_03_30_01,
              ),
              TextSpan(
                text: l10n.aboutMyGratitude_2024_03_18_04,
              ),
              TextSpan(
                text: l10n.aboutMyGratitude_2024_03_18_03,
              ),
              TextSpan(
                text: l10n.aboutMyGratitude_2024_03_18_02,
              ),
              TextSpan(
                text: l10n.aboutMyGratitude_2024_03_18_01,
              ),
              TextSpan(
                text: l10n.aboutMyGratitude_2024_03_13_01,
              ),
              TextSpan(
                text: l10n.aboutMyGratitude_2024_03_11_04,
              ),
              TextSpan(
                text: l10n.aboutMyGratitude_2024_03_11_03,
              ),
              TextSpan(
                text: l10n.aboutMyGratitude_2024_03_11_02,
              ),
              TextSpan(
                text: l10n.aboutMyGratitude_2024_03_11_01,
              ),
              TextSpan(
                text: l10n.aboutMyGratitude_2024_03_07_01,
              ),

              // 2024-02
              TextSpan(
                text: l10n.aboutMyGratitude_2024_02_title,
                style: titleStyle,
              ),
              TextSpan(
                text: l10n.aboutMyGratitude_2024_02_29_06,
              ),
              TextSpan(
                text: l10n.aboutMyGratitude_2024_02_29_05,
              ),
              TextSpan(
                text: l10n.aboutMyGratitude_2024_02_29_04,
              ),
              TextSpan(
                text: l10n.aboutMyGratitude_2024_02_29_03,
              ),
              TextSpan(
                text: l10n.aboutMyGratitude_2024_02_29_02,
              ),
              TextSpan(
                text: l10n.aboutMyGratitude_2024_02_29_01,
              ),
              TextSpan(
                text: l10n.aboutMyGratitude_2024_02_22_01,
              ),
              TextSpan(
                text: l10n.aboutMyGratitude_2024_02_18_02,
              ),
              TextSpan(
                text: l10n.aboutMyGratitude_2024_02_18_01,
              ),
              TextSpan(
                text: l10n.aboutMyGratitude_2024_02_16_01,
              ),
              TextSpan(
                text: l10n.aboutMyGratitude_2024_02_08_02,
              ),
              TextSpan(
                text: l10n.aboutMyGratitude_2024_02_08_01,
              ),
              TextSpan(
                text: l10n.aboutMyGratitude_2024_02_04_04,
              ),
              TextSpan(
                text: l10n.aboutMyGratitude_2024_02_04_03,
              ),
              TextSpan(
                text: l10n.aboutMyGratitude_2024_02_04_02,
              ),
              TextSpan(
                text: l10n.aboutMyGratitude_2024_02_04_01,
              ),
              TextSpan(
                text: l10n.aboutMyGratitude_2024_02_02_01,
              ),

              // 2024-01
              TextSpan(
                text: l10n.aboutMyGratitude_2024_01_title,
                style: titleStyle,
              ),
              TextSpan(
                text: l10n.aboutMyGratitude_2024_01_31_02,
              ),
              TextSpan(
                text: l10n.aboutMyGratitude_2024_01_31_01,
              ),
              TextSpan(
                text: l10n.aboutMyGratitude_2024_01_28_11,
              ),
              TextSpan(
                text: l10n.aboutMyGratitude_2024_01_28_10,
              ),
              TextSpan(
                text: l10n.aboutMyGratitude_2024_01_28_09,
              ),
              TextSpan(
                text: l10n.aboutMyGratitude_2024_01_28_08,
              ),
              TextSpan(
                text: l10n.aboutMyGratitude_2024_01_28_07,
              ),
              TextSpan(
                text: l10n.aboutMyGratitude_2024_01_28_06,
              ),
              TextSpan(
                text: l10n.aboutMyGratitude_2024_01_28_05,
              ),
              TextSpan(
                text: l10n.aboutMyGratitude_2024_01_28_04,
              ),
              TextSpan(
                text: l10n.aboutMyGratitude_2024_01_28_03,
              ),
              TextSpan(
                text: l10n.aboutMyGratitude_2024_01_28_02,
              ),
              TextSpan(
                text: l10n.aboutMyGratitude_2024_01_28_01,
              ),
              TextSpan(
                text: l10n.aboutMyGratitude_2024_01_26_01,
              ),
              TextSpan(
                text: l10n.aboutMyGratitude_2024_01_25_02,
              ),
              TextSpan(
                text: l10n.aboutMyGratitude_2024_01_25_01,
              ),
              TextSpan(
                text: l10n.aboutMyGratitude_2024_01_21_05,
              ),
              TextSpan(
                text: l10n.aboutMyGratitude_2024_01_21_04,
              ),
              TextSpan(
                text: l10n.aboutMyGratitude_2024_01_21_03,
              ),
              TextSpan(
                text: l10n.aboutMyGratitude_2024_01_21_02,
              ),
              TextSpan(
                text: l10n.aboutMyGratitude_2024_01_21_01,
              ),
              TextSpan(
                text: l10n.aboutMyGratitude_2024_01_01_02,
              ),
              TextSpan(
                text: l10n.aboutMyGratitude_2024_01_01_01,
              ),

              // 2023-12
              TextSpan(
                text: l10n.aboutMyGratitude_2023_12_title,
                style: titleStyle,
              ),
              TextSpan(
                text: l10n.aboutMyGratitude_2023_12_14_04,
              ),
              TextSpan(
                text: l10n.aboutMyGratitude_2023_12_14_03,
              ),
              TextSpan(
                text: l10n.aboutMyGratitude_2023_12_14_02,
              ),
              TextSpan(
                text: l10n.aboutMyGratitude_2023_12_14_01,
              ),
              TextSpan(
                text: l10n.aboutMyGratitude_2023_12_13_01,
              ),

              // 2023-11
              TextSpan(
                text: l10n.aboutMyGratitude_2023_11_title,
                style: titleStyle,
              ),
              TextSpan(
                text: l10n.aboutMyGratitude_2023_11_27_01,
              ),
              TextSpan(
                text: l10n.aboutMyGratitude_2023_11_18_03,
              ),
              TextSpan(
                text: l10n.aboutMyGratitude_2023_11_18_02,
              ),
              TextSpan(
                text: l10n.aboutMyGratitude_2023_11_18_01,
              ),
              TextSpan(
                text: l10n.aboutMyGratitude_2023_11_15_01,
              ),
              TextSpan(
                text: l10n.aboutMyGratitude_2023_11_14_01,
              ),

              // 2023-10
              TextSpan(
                text: l10n.aboutMyGratitude_2023_10_title,
                style: titleStyle,
              ),
              TextSpan(
                text: l10n.aboutMyGratitude_2023_10_24_01,
              ),

              // 2023-09
              TextSpan(
                text: l10n.aboutMyGratitude_2023_09_title,
                style: titleStyle,
              ),
              TextSpan(
                text: l10n.aboutMyGratitude_2023_09_25_02,
              ),
              TextSpan(
                text: l10n.aboutMyGratitude_2023_09_25_01,
              ),
              TextSpan(
                text: l10n.aboutMyGratitude_2023_09_19_02,
              ),
              TextSpan(
                text: l10n.aboutMyGratitude_2023_09_19_01,
              ),
              TextSpan(
                text: l10n.aboutMyGratitude_2023_09_10_01,
              ),
              TextSpan(
                text: l10n.aboutMyGratitude_2023_09_01_01,
              ),

              // 2023-08
              TextSpan(
                text: l10n.aboutMyGratitude_2023_08_title,
                style: titleStyle,
              ),
              TextSpan(
                text: l10n.aboutMyGratitude_2023_08_15_01,
              ),
              TextSpan(
                text: l10n.aboutMyGratitude_2023_08_12_01,
              ),
              TextSpan(
                text: l10n.aboutMyGratitude_2023_08_08_01,
              ),
              TextSpan(
                text: l10n.aboutMyGratitude_2023_08_06_02,
              ),
              TextSpan(
                text: l10n.aboutMyGratitude_2023_08_06_01,
              ),

              // 2023-07
              TextSpan(
                text: l10n.aboutMyGratitude_2023_07_title,
                style: titleStyle,
              ),
              TextSpan(
                text: l10n.aboutMyGratitude_2023_07_29_02,
              ),
              TextSpan(
                text: l10n.aboutMyGratitude_2023_07_29_01,
              ),

              // 2023-05
              TextSpan(
                text: l10n.aboutMyGratitude_2023_05_title,
                style: titleStyle,
              ),
              TextSpan(
                text: l10n.aboutMyGratitude_2023_05_30_02,
              ),
              TextSpan(
                text: l10n.aboutMyGratitude_2023_05_30_01,
              ),
              TextSpan(
                text: l10n.aboutMyGratitude_2023_05_28_01,
              ),
              TextSpan(
                text: l10n.aboutMyGratitude_2023_05_24_05,
              ),
              TextSpan(
                text: l10n.aboutMyGratitude_2023_05_24_04,
              ),
              TextSpan(
                text: l10n.aboutMyGratitude_2023_05_24_03,
              ),
              TextSpan(
                text: l10n.aboutMyGratitude_2023_05_24_02,
              ),
              TextSpan(
                text: l10n.aboutMyGratitude_2023_05_24_01,
              ),
              TextSpan(
                text: l10n.aboutMyGratitude_2023_05_23_01,
              ),
              TextSpan(
                text: l10n.aboutMyGratitude_2023_05_20_02,
              ),
              TextSpan(
                text: l10n.aboutMyGratitude_2023_05_20_01,
              ),
              TextSpan(
                text: l10n.aboutMyGratitude_2023_05_17_01,
              ),
              TextSpan(
                text: l10n.aboutMyGratitude_2023_05_16_01,
              ),
              TextSpan(
                text: l10n.aboutMyGratitude_2023_05_13_01,
              ),
              TextSpan(
                text: l10n.aboutMyGratitude_2023_05_12_04,
              ),
              TextSpan(
                text: l10n.aboutMyGratitude_2023_05_12_03,
              ),
              TextSpan(
                text: l10n.aboutMyGratitude_2023_05_12_02,
              ),
              TextSpan(
                text: l10n.aboutMyGratitude_2023_05_12_01,
              ),
              TextSpan(
                text: l10n.aboutMyGratitude_2023_05_09_05,
              ),
              TextSpan(
                text: l10n.aboutMyGratitude_2023_05_09_04,
              ),
              TextSpan(
                text: l10n.aboutMyGratitude_2023_05_09_03,
              ),
              TextSpan(
                text: l10n.aboutMyGratitude_2023_05_09_02,
              ),
              TextSpan(
                text: l10n.aboutMyGratitude_2023_05_09_01,
              ),
              TextSpan(
                text: l10n.aboutMyGratitude_2023_05_08_02,
              ),
              TextSpan(
                text: l10n.aboutMyGratitude_2023_05_08_01,
              ),
              TextSpan(
                text: l10n.aboutMyGratitude_2023_05_07_02,
              ),
              TextSpan(
                text: l10n.aboutMyGratitude_2023_05_07_01,
              ),
              TextSpan(
                text: l10n.aboutMyGratitude_2023_05_06_04,
              ),
              TextSpan(
                text: l10n.aboutMyGratitude_2023_05_06_03,
              ),
              TextSpan(
                text: l10n.aboutMyGratitude_2023_05_06_02,
              ),
              TextSpan(
                text: l10n.aboutMyGratitude_2023_05_06_01,
              ),
              TextSpan(
                text: l10n.aboutMyGratitude_2023_05_05_01,
              ),
              TextSpan(
                text: l10n.aboutMyGratitude_2023_05_02_02,
              ),
              TextSpan(
                text: l10n.aboutMyGratitude_2023_05_02_01,
              ),

              // 2023-04
              TextSpan(
                text: l10n.aboutMyGratitude_2023_04_title,
                style: titleStyle,
              ),
              TextSpan(
                text: l10n.aboutMyGratitude_2023_04_27_02,
              ),
              TextSpan(
                text: l10n.aboutMyGratitude_2023_04_27_01,
              ),
              TextSpan(
                text: l10n.aboutMyGratitude_2023_04_21_02,
              ),
              TextSpan(
                text: l10n.aboutMyGratitude_2023_04_21_01,
              ),
              TextSpan(
                text: l10n.aboutMyGratitude_2023_04_20_01,
              ),
              TextSpan(
                text: l10n.aboutMyGratitude_2023_04_18_01,
              ),
              TextSpan(
                text: l10n.aboutMyGratitude_2023_04_13_01,
              ),
              TextSpan(
                text: l10n.aboutMyGratitude_2023_04_12_01,
              ),
              TextSpan(
                text: l10n.aboutMyGratitude_2023_04_08_01,
              ),
              TextSpan(
                text: l10n.aboutMyGratitude_2023_04_07_01,
              ),

              // 2023-03
              TextSpan(
                text: l10n.aboutMyGratitude_2023_03_title,
                style: titleStyle,
              ),
              TextSpan(
                text: l10n.aboutMyGratitude_2023_03_22_01,
              ),
              TextSpan(
                text: l10n.aboutMyGratitude_2023_03_10_02,
              ),
              TextSpan(
                text: l10n.aboutMyGratitude_2023_03_10_01,
              ),
              TextSpan(
                text: l10n.aboutMyGratitude_2023_03_06_02,
              ),
              TextSpan(
                text: l10n.aboutMyGratitude_2023_03_06_01,
              ),
              TextSpan(
                text: l10n.aboutMyGratitude_2023_03_05_02,
              ),
              TextSpan(
                text: l10n.aboutMyGratitude_2023_03_05_01,
              ),
              TextSpan(
                text: l10n.aboutMyGratitude_2023_03_04_01,
              ),

              // 2023-02
              TextSpan(
                text: l10n.aboutMyGratitude_2023_02_title,
                style: titleStyle,
              ),
              TextSpan(
                text: l10n.aboutMyGratitude_2023_02_28_01,
              ),
              TextSpan(
                text: l10n.aboutMyGratitude_2023_02_15_01,
              ),

              // 2022-03
              TextSpan(
                text: l10n.aboutMyGratitude_2022_03_title,
                style: titleStyle,
              ),
              TextSpan(
                text: l10n.aboutMyGratitude_2022_03_24_01,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
