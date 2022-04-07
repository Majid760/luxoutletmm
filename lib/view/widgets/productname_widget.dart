import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ProductNameWidget extends StatelessWidget {
  final String? title;
  final double? fontSize;
  final double? width;
  final double? height;
  const ProductNameWidget(
      {Key? key,
      this.title,
      this.fontSize = 12.5,
      this.width = 158,
      this.height = 33})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        width: width,
        height: height,
        child: AutoSizeText(title!,
            maxLines: 2,
            style: GoogleFonts.workSans(
                color: const Color(0xFF464646),
                fontSize: fontSize,
                fontWeight: FontWeight.w400,
                fontStyle: FontStyle.normal)));
  }
}
