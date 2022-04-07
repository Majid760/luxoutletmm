import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:luxoutlet/const/color.dart';
import 'package:luxoutlet/view/widgets/cross_exit_widget.dart';
import 'package:luxoutlet/view/widgets/pageview_widget.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

// ignore: must_be_immutable
class SliderWidget extends StatelessWidget {
  final int? totalDot;
  final double? dotRadius;
  final double? dotWidth;
  final double? dotSpacing;
  final double? activeDotWidth;
  final double? activeDotHeight;
  final double? activeDotRadius;
  final double? dotHeight;
  final List<dynamic>? sliderImageList;
  final String? titleOnSlider;
  final String? subtitleOnSlider;
  final double? height;
  final double? width;
  final int? intColor;

  PageController pageController = PageController(initialPage: 0);
  SliderWidget({
    Key? key,
    this.height,
    this.width,
    this.intColor,
    @required this.sliderImageList,
    this.titleOnSlider,
    this.subtitleOnSlider,
    this.dotWidth = 60,
    this.dotHeight = 2,
    this.dotSpacing = 3,
    this.totalDot = 3,
    this.dotRadius = 8,
    this.activeDotWidth = 60,
    this.activeDotHeight = 2,
    this.activeDotRadius = 8,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        showImageFocusSlider(context, pageController, sliderImageList);
      },
      child: Container(
          height: height,
          width: width,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            color: Color(intColor!),
          ),
          child: LayoutBuilder(
              builder: (context, constraints) => Stack(
                      alignment: AlignmentDirectional.bottomCenter,
                      children: [
                        // page view widget (user sliding images)
                        PageViewWidget(
                            pageController: pageController,
                            pageViewImageList: sliderImageList),

                        //  text on slider( text on pageviewwidget) conditionally renderring
                        (titleOnSlider != null)
                            ? Positioned(
                                top: constraints.maxHeight -
                                    MediaQuery.of(context).size.height * .15,
                                left: 7,
                                child: TextOnSlider(
                                  titleOnSlider: titleOnSlider,
                                  subtitleOnSlider: subtitleOnSlider,
                                ),
                              )
                            : const SizedBox(),

                        // page indication section
                        Positioned(
                          bottom: 14,
                          child: PageIndicator(
                              pageController: pageController,
                              totalDot: totalDot,
                              activeDotWidth: activeDotWidth,
                              activeDotHeight: activeDotHeight,
                              activeDotRadius: activeDotRadius,
                              dotWidth: dotWidth,
                              dotHeight: dotHeight,
                              dotRadius: dotRadius,
                              dotSpacing: dotSpacing),
                        )
                      ]))),
    );
  }
}

void showImageFocusSlider(
    BuildContext context, PageController controller, sliderImages) {
  showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      // shape: RoundedRectangleBorder(
      //   borderRadius: BorderRadius.circular(24.0),
      // ),
      backgroundColor: const Color(greyColor),
      builder: (BuildContext bc) {
        return Container(
          color: Colors.transparent,
          child: Container(
              height: MediaQuery.of(context).size.height * 1,
              width: MediaQuery.of(context).size.width * 1,
              decoration: const BoxDecoration(
                color: Color(greyColor),
                //   borderRadius: BorderRadius.only(
                //       topRight: Radius.circular(24),
                //       topLeft: Radius.circular(24)),
              ),
              child: Stack(
                alignment: Alignment.bottomCenter,
                children: [
                  PageViewWidget(
                      pageController: controller,
                      pageViewImageList: sliderImages),
                  Positioned(
                    top: (40.0),
                    left: 10,
                    right: 10,
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          TransparenButtonWidget(
                            iconData: Icons.close_outlined,
                            onPress: () {
                              Navigator.pop(context);
                            },
                          ),
                          TransparenButtonWidget(
                            iconData: Icons.share,
                            onPress: () {},
                          )
                        ]),
                  ),
                ],
              )),
        );
      });
}

class TextOnSlider extends StatelessWidget {
  const TextOnSlider({
    Key? key,
    required this.titleOnSlider,
    required this.subtitleOnSlider,
  }) : super(key: key);

  final String? titleOnSlider;
  final String? subtitleOnSlider;

  @override
  Widget build(BuildContext context) {
    return Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // showing the text on slider
          SizedBox(
              width: 126,
              height: 28,
              child: Text(
                titleOnSlider!,
                style: GoogleFonts.workSans(
                    fontWeight: FontWeight.w500,
                    fontStyle: FontStyle.normal,
                    fontSize: 24,
                    color: Colors.white),
              )),
          Padding(
              padding: const EdgeInsets.only(top: 3),
              child: SizedBox(
                width: 110,
                height: 19,
                child: Text('View More >',
                    style: GoogleFonts.workSans(
                        fontWeight: FontWeight.w500,
                        fontStyle: FontStyle.normal,
                        fontSize: 16,
                        color: const Color(yellowDarkColor))),
              ))
        ]);
  }
}

class PageIndicator extends StatelessWidget {
  const PageIndicator({
    Key? key,
    required this.pageController,
    required this.totalDot,
    required this.activeDotWidth,
    required this.activeDotHeight,
    required this.activeDotRadius,
    required this.dotWidth,
    required this.dotHeight,
    required this.dotRadius,
    required this.dotSpacing,
  }) : super(key: key);

  final PageController pageController;
  final int? totalDot;
  final double? activeDotWidth;
  final double? activeDotHeight;
  final double? activeDotRadius;
  final double? dotWidth;
  final double? dotHeight;
  final double? dotRadius;
  final double? dotSpacing;

  @override
  Widget build(BuildContext context) {
    return SmoothPageIndicator(
      controller: pageController,
      count: totalDot!,
      effect: CustomizableEffect(
        activeDotDecoration: DotDecoration(
          width: activeDotWidth!,
          height: activeDotHeight!,
          color: Colors.white,
          borderRadius: BorderRadius.circular(activeDotRadius!),
        ),
        dotDecoration: DotDecoration(
          width: dotWidth!,
          height: dotHeight!,
          color: const Color(greyColor),
          borderRadius: BorderRadius.circular(dotRadius!),
          verticalOffset: 0,
        ),
        spacing: dotSpacing!,
      ),
    );
  }
}
