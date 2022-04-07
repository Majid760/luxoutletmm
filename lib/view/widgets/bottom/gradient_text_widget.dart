import 'package:flutter/material.dart';
import 'package:luxoutlet/bloc/controllers/bottom_navigation_controller.dart';
import 'package:provider/provider.dart';

class GradientText extends StatelessWidget {
  // ignore: use_key_in_widget_constructors
  const GradientText(
    this.text, {
    required this.gradient,
    this.style,
    this.navIndex,
  });

  final String text;
  final int? navIndex;
  final TextStyle? style;
  final Gradient gradient;

  @override
  Widget build(BuildContext context) {
    return Consumer<BottomNavigationController>(
        builder: (context, navController, _) {
      return (navController.getCurrentIndex == navIndex)
          ? ShaderMask(
              blendMode: BlendMode.srcIn,
              shaderCallback: (bounds) => gradient.createShader(
                Rect.fromLTWH(0, 0, bounds.width, bounds.height),
              ),
              child: Text(text, style: style),
            )
          : Text(text, style: style);
    });
  }
}
