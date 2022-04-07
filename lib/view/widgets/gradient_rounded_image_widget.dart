import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:luxoutlet/const/color.dart';
import 'package:luxoutlet/view/widgets/rounded_image_widget.dart';

class GradientRoundedImageContainer extends StatelessWidget {
  final VoidCallback? onpressed;
  final String? textData;
  final double? height;
  final double? width;
  final String? imageUrl;
  const GradientRoundedImageContainer(
      {Key? key,
      this.textData,
      this.imageUrl,
      this.onpressed,
      this.height = 88,
      this.width = 88})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: AlignmentDirectional.center,
      children: [
        RoundedImage(
          imagePath: imageUrl!,
          width: width,
          height: height,
          borderRadius: 8,
        ),
        Container(
          height: height,
          width: width,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              gradient: LinearGradient(
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                  colors: [
                    const Color(0xFFFF5C00).withOpacity(0.13),
                    const Color(blackColor).withOpacity(0.24)
                  ])),
          child: InkWell(
            onTap: onpressed,
            child: Align(
                alignment: Alignment.center,
                child: SizedBox(
                  height: 50,
                  // width: 75,
                  child: (textData != null)
                      ? textData!.split(" ").length < 2
                          ? Center(
                              child: AutoSizeText(textData!,
                                  maxLines: 1,
                                  style: GoogleFonts.workSans(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w600,
                                    fontSize: 15,
                                  )),
                            )
                          : Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                AutoSizeText(textData!.split(" ")[0],
                                    maxLines: 1,
                                    style: GoogleFonts.workSans(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w600,
                                      fontSize: 15,
                                    )),
                                AutoSizeText(textData!.split(" ")[1],
                                    maxLines: 1,
                                    style: GoogleFonts.workSans(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w600,
                                      fontSize: 15,
                                    )),
                              ],
                            )
                      : const SizedBox(height: 88, width: 88),
                )),
          ),
        )
      ],
    );
  }
}
