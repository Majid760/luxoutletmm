import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:luxoutlet/bloc/category/category_cubit.dart';
import 'package:luxoutlet/bloc/category/category_state.dart';
import 'package:luxoutlet/bloc/controllers/bottom_navigation_controller.dart';
import 'package:luxoutlet/bloc/product/product_cubit.dart';
import 'package:luxoutlet/bloc/product/product_state.dart';
import 'package:luxoutlet/bloc/ui/homescreen_cubit/home_screen_cubit.dart';
import 'package:luxoutlet/bloc/ui/homescreen_cubit/homescreen_state.dart';
import 'package:luxoutlet/const/color.dart';
import 'package:luxoutlet/view/screen/categoryscreen.dart';
import 'package:luxoutlet/view/widgets/appbar/appbar_widget.dart';
import 'package:luxoutlet/view/widgets/bottom/bottom_navigation_widget.dart';
import 'package:luxoutlet/view/widgets/gradient_rounded_image_widget.dart';
import 'package:luxoutlet/view/widgets/product_grid_view.dart';
import 'package:luxoutlet/view/widgets/slider_widget.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  static const String routeName = '/';

  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: const AppBarWidget(
          leadingIconData: Icons.sort_outlined,
          trailingIconData: Icons.notifications_outlined,
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15.0),
          child: SingleChildScrollView(
            child: Column(children: const [
              //slider section of homescreen
              HomeScreenSlider(),
              // product category  text titles
              HomeScreenCategoryTitleSection(),
              //  category carousel/slider
              HomeScreenProductCategorySliderSection(),
              //  fetured product listing
              HomeScreenProductListingSection()
            ]),
          ),
        ),
        bottomNavigationBar: const CustomBottomNavigationBar());
  }
}

//  fetured product listing section

class HomeScreenProductListingSection extends StatelessWidget {
  const HomeScreenProductListingSection({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    context.read<ProductCubit>().getProducts();
    return BlocConsumer<ProductCubit, ProductState>(
      listenWhen: (previous, current) {
        return (previous == current);
      },
      listener: (context, state) {
        if (state.status!.isSuccess) {}
      },
      builder: (context, state) {
        switch (state.status) {
          case ProductStatus.initial:
            return const Center(child: CircularProgressIndicator());
          case ProductStatus.loading:
            return const Padding(
              padding: EdgeInsets.only(top: 50.0),
              child: Center(child: CircularProgressIndicator()),
            );
          case ProductStatus.success:
            return Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 28.0, bottom: 18),
                    child: SizedBox(
                      height: 21,
                      width: 82,
                      child: Text(
                        'Featured',
                        style: GoogleFonts.workSans(
                            fontStyle: FontStyle.normal,
                            fontSize: 18,
                            fontWeight: FontWeight.w600),
                      ),
                    ),
                  ),
                  InkWell(
                      onTap: () {},
                      child: ProductGridView(products: state.productList!)),
                ]);
          case ProductStatus.failure:
          default:
            return Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: const [
                Text('🙈', style: TextStyle(fontSize: 64)),
                Text(
                  "Something went wrong!",
                ),
              ],
            );
        }
      },
    );
  }
}

//  category carousel/slider
class HomeScreenProductCategorySliderSection extends StatelessWidget {
  const HomeScreenProductCategorySliderSection({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    context.read<CategoryCubit>().getCategories();
    return BlocConsumer<CategoryCubit, CategoryState>(
        listener: (context, state) {},
        builder: (context, state) {
          switch (state.status) {
            case CategoryStatus.initial:
              return const Center(child: CircularProgressIndicator());
            case CategoryStatus.loading:
              return const Center(child: CircularProgressIndicator());
            case CategoryStatus.success:
              return Padding(
                padding: const EdgeInsets.only(top: 17.0),
                child: SizedBox(
                  height: 88,
                  child: ListView.builder(
                      itemCount: state.categoryList!.length,
                      scrollDirection: Axis.horizontal,
                      shrinkWrap: true,
                      itemBuilder: (BuildContext context, int index) => Padding(
                            padding: const EdgeInsets.only(right: 22.0),
                            child: GradientRoundedImageContainer(
                                textData: state.categoryList![index].name,
                                imageUrl: state.categoryList![index].image),
                          )),
                ),
              );
            case CategoryStatus.failure:
            default:
              return Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: const [
                  Text('🙈', style: TextStyle(fontSize: 64)),
                  Text(
                    "Something went wrong!",
                  ),
                ],
              );
          }
        });
  }
}

// product category  text titles section
class HomeScreenCategoryTitleSection extends StatelessWidget {
  const HomeScreenCategoryTitleSection({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 29.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SizedBox(
            height: 21,
            width: 97,
            child: Text(
              'Categories',
              style: GoogleFonts.workSans(
                  fontStyle: FontStyle.normal,
                  fontSize: 18,
                  fontWeight: FontWeight.w600),
            ),
          ),
          Consumer<BottomNavigationController>(
            builder: (context, bottomNavigationController, _) => InkWell(
              onTap: () {
                bottomNavigationController.changeNavigationIndex(1);
                Navigator.pushNamed(context, CategoryScreen.routeName);
              },
              child: SizedBox(
                height: 14,
                width: 65,
                child: Text(
                  'View All >',
                  style: GoogleFonts.workSans(
                      fontStyle: FontStyle.normal,
                      fontSize: 12,
                      color: const Color(darkGreyColor),
                      fontWeight: FontWeight.w600),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}

//slider section of homescreen section
class HomeScreenSlider extends StatelessWidget {
  const HomeScreenSlider({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final homeCubit = Provider.of<HomeScreenCubit>(context);
    homeCubit.getSliderImages();
    return BlocBuilder<HomeScreenCubit, HomeScreenState>(
      builder: (context, state) => SliderWidget(
          dotHeight: 2,
          dotWidth: 60,
          dotSpacing: 3,
          dotRadius: 8,
          height: 115,
          width: 335,
          intColor: 0xFFF3F3F3,
          titleOnSlider: "Flash Sale",
          subtitleOnSlider: "view more >",
          sliderImageList: state.sliderImages,
          totalDot: state.sliderImages!.length),
    );
  }
}
