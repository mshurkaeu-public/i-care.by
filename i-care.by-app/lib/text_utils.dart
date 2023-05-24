import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:intl/intl.dart' as intl;

class TextUtils {
  static List<InlineSpan> buildSpansFromText(
    String text,
    List<MapEntry<String, InlineSpan>> mapEntryList,
  ) {
    if (mapEntryList.isEmpty) {
      return [TextSpan(text: text)];
    }

    MapEntry<String, InlineSpan> mapEntry = mapEntryList[0];
    List<MapEntry<String, InlineSpan>> reducedMapEntryList =
        mapEntryList.sublist(1);

    List<InlineSpan> res = [];
    List<String> textChunks = text.split(mapEntry.key);
    for (int i = 0; i < textChunks.length; i++) {
      String textChunk = textChunks[i];
      res.addAll(buildSpansFromText(textChunk, reducedMapEntryList));
      if (i < textChunks.length - 1) {
        res.add(mapEntry.value);
      }
    }

    return res;
  }

  static Size getTextSize(
    String text,
    AppLocalizations l10n, {
    TextStyle? style,
  }) {
    Size res;

    TextPainter hintPainter = TextPainter(
      text: TextSpan(
        text: text,
        style: style,
      ),
      maxLines: 1,
      textDirection: intl.Bidi.isRtlLanguage(l10n.localeName)
          ? TextDirection.rtl
          : TextDirection.ltr,
    );
    try {
      hintPainter.layout();
      res = hintPainter.size;
    } finally {
      hintPainter.dispose();
    }

    return res;
  }
}
