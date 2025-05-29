import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:photo_view/photo_view_gallery.dart';

import 'text_utils.dart';

class MyPhotoGallery extends StatefulWidget {
  const MyPhotoGallery({
    super.key,
    required this.assetsNames,
    required this.width,
  });

  final List<String> assetsNames;
  final double width;

  @override
  State<StatefulWidget> createState() => _MyPhotoGalleryState();
}

class _MyPhotoGalleryState extends State<MyPhotoGallery> {
  final PageController _pageController = PageController();

  void _toNextPhoto() {
    int currentPage = _pageController.page!.toInt();

    if (currentPage == widget.assetsNames.length - 1) {
      _pageController.jumpToPage(0);
    } else {
      _pageController.nextPage(
        duration: const Duration(seconds: 1),
        curve: Curves.linear,
      );
    }
  }

  void _toPreviousPhoto() {
    int currentPage = _pageController.page!.toInt();

    if (currentPage == 0) {
      _pageController.jumpToPage(widget.assetsNames.length - 1);
    } else {
      _pageController.previousPage(
        duration: const Duration(seconds: 1),
        curve: Curves.linear,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    AppLocalizations l10n = AppLocalizations.of(context);
    TextStyle photoHintStyle =
        TextStyle(color: Theme.of(context).disabledColor);

    List<PhotoViewGalleryPageOptions> pageOptions = [];
    for (String assetName in widget.assetsNames) {
      pageOptions.add(
        PhotoViewGalleryPageOptions(
          imageProvider: AssetImage(assetName),
        ),
      );
    }

    List<Widget> secondHint;
    if (pageOptions.length > 1) {
      String hintText = l10n.hintToViewTheNextPhoto;
      const double sideButtonPadding = 8;

      ButtonStyle swipeButtonStyle = TextButton.styleFrom(
        minimumSize: const Size(1, 1),
        padding: const EdgeInsets.symmetric(horizontal: sideButtonPadding),
      );
      Size hintSize = TextUtils.getTextSize(hintText, l10n);

      double swipeIconSize = hintSize.height;
      double maxHintWidthRequired = hintSize.width;
      double swipeButtonWidth =
          sideButtonPadding + swipeIconSize + sideButtonPadding;

      secondHint = [
        LayoutBuilder(
          builder: (BuildContext context, BoxConstraints constraints) {
            double hintWidth = constraints.maxWidth - swipeButtonWidth * 2;
            if (hintWidth < 0) {
              hintWidth = 0;
            } else if (hintWidth > maxHintWidthRequired) {
              hintWidth = maxHintWidthRequired;
            }

            return Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // SizedBox here is to workaround bug https://github.com/flutter/flutter/issues/125756
                SizedBox(
                  height: swipeIconSize,
                  width: swipeButtonWidth,
                  child: TextButton(
                    style: swipeButtonStyle,
                    onPressed: _toPreviousPhoto,
                    child: Icon(
                      Icons.swipe_right,
                      size: swipeIconSize,
                    ),
                  ),
                ),
                SizedBox(
                  width: hintWidth,
                  child: Text(
                    hintText,
                    style: photoHintStyle,
                    textAlign: TextAlign.center,
                  ),
                ),
                // SizedBox here is to workaround bug https://github.com/flutter/flutter/issues/125756
                SizedBox(
                  height: swipeIconSize,
                  width: swipeButtonWidth,
                  child: TextButton(
                    style: swipeButtonStyle,
                    onPressed: _toNextPhoto,
                    child: Icon(
                      Icons.swipe_left,
                      size: swipeIconSize,
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ];
    } else {
      secondHint = [];
    }

    return Column(
      children: [
        Text(
          l10n.hintToEnlargePhoto,
          style: photoHintStyle,
          textAlign: TextAlign.center,
        ),
        ...secondHint,
        SizedBox(
          height: widget.width,
          child: PhotoViewGallery(
            pageController: _pageController,
            pageOptions: pageOptions,
            backgroundDecoration: const BoxDecoration(color: Colors.transparent),
          ),
        ),
      ],
    );
  }

  @override
  void dispose() {
    _pageController.dispose();

    super.dispose();
  }
}