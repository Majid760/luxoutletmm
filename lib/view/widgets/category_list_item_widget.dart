import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:luxoutlet/const/color.dart';
import 'package:luxoutlet/view/widgets/gradient_rounded_image_widget.dart';

class CategoryListItemWidget extends StatelessWidget {
  final String? title;
  final String? imageUrl;
  const CategoryListItemWidget({Key? key, this.title, this.imageUrl})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16),
      child: Container(
          height: 88,
          width: 335,
          decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(Radius.circular(8))),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                  height: 26,
                  width: 200,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 15.0),
                    child: Text(title!,
                        style: GoogleFonts.workSans(
                            fontSize: 22,
                            fontWeight: FontWeight.w500,
                            color: const Color(blackColor),
                            fontStyle: FontStyle.normal)),
                  )),
              GradientRoundedImageContainer(
                imageUrl: imageUrl,
                onpressed: () {},
              ),
            ],
          )),
    );
  }
}
