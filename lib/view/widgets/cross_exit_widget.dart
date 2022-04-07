import 'package:flutter/material.dart';
import 'package:luxoutlet/const/color.dart';

class TransparenButtonWidget extends StatelessWidget {
  final VoidCallback? onPress;
  final IconData? iconData;
  final double? height;
  final double? width;
  final double? borderRadius;
  const TransparenButtonWidget(
      {Key? key,
      this.onPress,
      this.height = 30,
      this.width = 30,
      this.borderRadius = 20,
      required this.iconData})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPress,
      child: Container(
        height: height,
        width: width,
        decoration: BoxDecoration(
            color: const Color(greyColor).withOpacity(0.6),
            borderRadius: BorderRadius.all(Radius.circular(borderRadius!))),
        child: Center(
          child: Icon(
            iconData!,
            size: 18,
            color: const Color(whiteColor),
          ),
        ),
      ),
    );
  }
}
