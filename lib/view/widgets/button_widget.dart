import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:luxoutlet/const/color.dart';

class ButtonWidget extends StatelessWidget {
  final double? height;
  final double? width;
  final double? borderRadius;
  final String? textOnButton;
  final VoidCallback? onPress;
  final int? bgColor;
  final double? fontSize;
  final int? fontColor;

  const ButtonWidget({
    Key? key,
    this.height = 35,
    this.width = 218,
    this.borderRadius = 5.0,
    this.bgColor = appBarGradientColor1,
    this.textOnButton = 'Add to cart',
    this.onPress,
    this.fontColor = whiteColor,
    this.fontSize = 15,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPress,
      child: Container(
          height: height,
          width: width,
          decoration: BoxDecoration(
              color: Color(bgColor!),
              borderRadius: BorderRadius.all(Radius.circular(borderRadius!))),
          child: Center(
            child: Text(textOnButton!,
                style: GoogleFonts.workSans(
                    color: Color(fontColor!),
                    fontSize: fontSize,
                    fontWeight: FontWeight.w500,
                    fontStyle: FontStyle.normal)),
          )),
    );
  }
}
