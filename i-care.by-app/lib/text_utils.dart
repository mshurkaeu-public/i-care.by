import 'package:flutter/material.dart';

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
}
