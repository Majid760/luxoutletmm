import 'package:flutter/material.dart';
import 'package:luxoutlet/const/color.dart';
import 'package:luxoutlet/view/widgets/bottom/gradient_icon_widget.dart';
import 'package:luxoutlet/view/widgets/bottom/gradient_text_widget.dart';

class BottomAppBarItem extends StatelessWidget {
  @required
  final IconData? iconData;
  @required
  final double? iconSize;
  @required
  final String? title;
  final TextStyle? textStyle;
  final VoidCallback? ontap;
  final int? index;
  const BottomAppBarItem(
      {Key? key,
      this.iconData,
      this.title,
      this.ontap,
      this.index,
      this.iconSize,
      this.textStyle})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
        onTap: ontap,
        child: Column(
          children: [
            GradientIcon(iconSize: iconSize, icon: iconData, navIndex: index),
            GradientText(title!,
                style: textStyle, navIndex: index, gradient: kLinearGradient)
          ],
        ));
  }
}
