import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:luxoutlet/const/color.dart';

class DiscountWidget extends StatelessWidget {
  final double? discount;
  const DiscountWidget({Key? key, this.discount}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 23,
        width: 43,
        decoration: const BoxDecoration(
            gradient: kLinearGradient,
            borderRadius: BorderRadius.only(
                topRight: Radius.circular(20),
                bottomRight: Radius.circular(20))),
        child: Center(
            child: AutoSizeText('-' + discount.toString() + '%',
                maxLines: 1,
                style: GoogleFonts.sen(
                    fontWeight: FontWeight.w700,
                    fontStyle: FontStyle.normal,
                    color: Colors.white,
                    fontSize: 10.5))));
  }
}
