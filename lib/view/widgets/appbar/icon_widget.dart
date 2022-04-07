import 'package:flutter/material.dart';

class IconWidget extends StatelessWidget {
  final VoidCallback? onPressed;
  final double? height;
  final double? width;
  final IconData? icon;
  final Color? iconColor;
  final double? iconSize;

  const IconWidget({
    Key? key,
    this.onPressed,
    this.height,
    this.width,
    @required this.icon,
    this.iconColor,
    this.iconSize,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      width: width,
      child: Icon(icon, color: iconColor, size: iconSize),
    );
  }
}
