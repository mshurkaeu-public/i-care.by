import 'package:flutter/material.dart';

class AssetImageWithCaption extends StatelessWidget {
  const AssetImageWithCaption({
    super.key,
    required this.assetName,
    required this.caption,
  });

  final String assetName;
  final String caption;

  @override
  Widget build(BuildContext context) {
    ThemeData themeData = Theme.of(context);
    TextStyle imageCreditsStyle =
        themeData.textTheme.bodySmall ?? const TextStyle();
    imageCreditsStyle = imageCreditsStyle.merge(
      TextStyle(color: themeData.disabledColor),
    );

    return Center(
      child: Column(
        children: [
          Image.asset(
            assetName,
            filterQuality: FilterQuality.medium,
          ),
          Text(
            caption,
            style: imageCreditsStyle,
          ),
        ],
      ),
    );
  }
}
