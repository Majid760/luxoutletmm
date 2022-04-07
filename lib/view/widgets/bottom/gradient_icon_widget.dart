import 'package:flutter/material.dart';
import 'package:luxoutlet/const/color.dart';
import 'package:luxoutlet/bloc/controllers/bottom_navigation_controller.dart';
import 'dart:ui' as ui;

import 'package:provider/provider.dart';

class GradientIcon extends StatelessWidget {
  const GradientIcon({
    Key? key,
    this.icon,
    required this.iconSize,
    this.navIndex,
  }) : super(key: key);

  final IconData? icon;
  final int? navIndex;
  final double? iconSize;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        height: 22,
        width: 22,
        child: Consumer<BottomNavigationController>(
            builder: (context, navController, _) {
          return (navController.getCurrentIndex == navIndex)
              ? ShaderMask(
                  blendMode: BlendMode.srcIn,
                  shaderCallback: (Rect bounds) {
                    return ui.Gradient.linear(
                      const Offset(5, 15),
                      const Offset(15, 15),
                      [
                        const Color(appBarGradientColor1),
                        const Color(appBarGradientColor2),
                      ],
                    );
                  },
                  child: Icon(icon))
              : Icon(icon);
        }));
  }
}
