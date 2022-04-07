import 'package:flutter/material.dart';
import 'package:luxoutlet/utility/image_cache_utility.dart';

class PageViewWidget extends StatelessWidget {
  final List<dynamic>? pageViewImageList;
  final PageController? pageController;
  PageViewWidget(
      {Key? key,
      @required this.pageController,
      @required this.pageViewImageList})
      : super(key: key);
  final List<String> images = [];
  @override
  Widget build(BuildContext context) {
    return PageView.builder(
      controller: pageController,
      itemCount: pageViewImageList!.length,
      itemBuilder: (context, position) {
        return Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
            ),
            child: (pageViewImageList![position].contains('http') == true)
                ? cacheImage(pageViewImageList![position])
                : Image.asset(pageViewImageList![position], fit: BoxFit.fill));
      },
    );
  }
}
