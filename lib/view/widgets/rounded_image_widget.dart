import 'package:flutter/material.dart';
import 'package:luxoutlet/utility/image_cache_utility.dart';

class RoundedImage extends StatelessWidget {
  final double? height;
  final double? width;
  final double? borderRadius;
  final String? imagePath;
  final int? borderColor;
  final int? bgColor;
  const RoundedImage(
      {Key? key,
      this.height = 45,
      this.width = 45,
      this.borderRadius = 8,
      this.borderColor,
      @required this.imagePath,
      this.bgColor = 0xFFC4C4C4})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: width,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(borderRadius!),
          color:
              borderColor == null ? Colors.transparent : Color(borderColor!)),
      child: Padding(
          padding: const EdgeInsets.all(1.0),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(borderRadius!),
            child: (imagePath!.contains('http') == true)
                ? cacheImage(imagePath!)
                : Image.asset(imagePath!, fit: BoxFit.fill),
          )),
    );
  }
}
