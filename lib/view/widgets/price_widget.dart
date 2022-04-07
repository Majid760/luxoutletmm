import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:luxoutlet/const/color.dart';
import 'package:luxoutlet/utility/currency_symbol_utility.dart';

class PriceWidget extends StatelessWidget {
  final double? price;
  final double? height;
  final double? width;
  final double? oldPriceFontSize;
  final double? fontSize;
  final int fontColor;
  final double? oldPrice;
  const PriceWidget(
      {Key? key,
      this.price,
      this.oldPrice,
      this.height = 14,
      this.width = 70,
      this.fontSize = 13.5,
      this.fontColor = 0xFFD40000,
      this.oldPriceFontSize = 9})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      width: width,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.end,
        mainAxisSize: MainAxisSize.max,
        children: [
          Text('${currency(context)}' + price!.toString(),
              style: GoogleFonts.sen(
                  color: Color(fontColor),
                  fontSize: fontSize,
                  fontStyle: FontStyle.normal,
                  fontWeight: FontWeight.w700)),
          Padding(
            padding: const EdgeInsets.only(left: 4.0),
            child: (oldPrice == null)
                ? const SizedBox()
                : Text('${currency(context)}' + oldPrice!.toStringAsFixed(1),
                    style: GoogleFonts.sen(
                        color: const Color(darkGreyColor),
                        fontSize: oldPriceFontSize,
                        decoration: TextDecoration.lineThrough,
                        fontStyle: FontStyle.normal,
                        fontWeight: FontWeight.w400)),
          )
        ],
      ),
    );
  }
}
