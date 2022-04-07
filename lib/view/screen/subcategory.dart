import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:luxoutlet/bloc/category/category_cubit.dart';
import 'package:luxoutlet/bloc/category/category_state.dart';
import 'package:luxoutlet/bloc/product/product_cubit.dart';
import 'package:luxoutlet/bloc/product/product_state.dart';
import 'package:luxoutlet/const/color.dart';
import 'package:luxoutlet/view/screen/categoryscreen.dart';
import 'package:luxoutlet/view/widgets/appbar/appbar_widget.dart';
import 'package:luxoutlet/view/widgets/bottom/bottom_navigation_widget.dart';
import 'package:luxoutlet/view/widgets/product_grid_view.dart';
import 'package:provider/provider.dart';

class SubCategoryScreen extends StatelessWidget {
  static const String routeName = '/subcategory_screen';
  const SubCategoryScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    int menuId = ModalRoute.of(context)!.settings.arguments as int;
    context.read<CategoryCubit>().getSubCategories((menuId));

    return Scaffold(
      appBar: AppBarWidget(
        leadingIconData: Icons.arrow_back,
        trailingIconData: Icons.tune_outlined,
        trailingPress: () {
          Navigator.pushNamed(
            context,
            CategoryScreen.routeName,
          );
        },
        title: "Clothing",
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
        color: const Color(lightGreyColor),
        child: SingleChildScrollView(
          child: Column(children: [
            SizedBox(
              height: 30.0,
              child: BlocConsumer<CategoryCubit, CategoryState>(
                // bloc:
                listener: (context, state) {
                  if (state.status!.isSuccess) {}
                },
                builder: (context, state) {
                  switch (state.status) {
                    case CategoryStatus.initial:
                      return const Center(child: CircularProgressIndicator());
                    case CategoryStatus.loading:
                      return const Center(child: CircularProgressIndicator());
                    case CategoryStatus.success:
                      return CategoryTextCarousel(
                        subCategoriesOfCategory: state.subCategoryList,
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
                },
              ),
            ),
            // total items section
            const ItemSortWidget(
              totalItems: 133,
            ),
            BlocConsumer<ProductCubit, ProductState>(
              listener: (context, state) {
                if (state.status!.isSuccess) {}
              },
              builder: (context, state) {
                switch (state.status) {
                  case ProductStatus.initial:
                    return const Center(child: CircularProgressIndicator());
                  case ProductStatus.loading:
                    return const Center(child: CircularProgressIndicator());
                  case ProductStatus.success:
                    return ProductGridView(
                      products: state.subCategoryProducts,
                    );
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
            ),
          ]),
        ),
      ),
      bottomNavigationBar: const CustomBottomNavigationBar(),
    );
  }
}

class ItemSortWidget extends StatelessWidget {
  final int? totalItems;
  const ItemSortWidget({
    Key? key,
    this.totalItems,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        height: 80,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(totalItems.toString() + 'Items',
                style: GoogleFonts.workSans(
                    fontSize: 16,
                    fontStyle: FontStyle.normal,
                    fontWeight: FontWeight.w600)),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Sort by:',
                    style: GoogleFonts.workSans(
                        fontSize: 12,
                        fontWeight: FontWeight.w700,
                        fontStyle: FontStyle.normal,
                        color: const Color(darkGreyColor))),
                Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                  Text('Featured ',
                      style: GoogleFonts.workSans(
                          fontSize: 12,
                          fontWeight: FontWeight.w700,
                          fontStyle: FontStyle.normal,
                          color: const Color(blackColor))),
                  const InkWell(
                    child: Icon(Icons.keyboard_arrow_down_rounded,
                        color: Color(blackColor)),
                  )
                ]),
              ],
            )
          ],
        ));
  }
}

class CategoryTextCarousel extends StatefulWidget {
  final List? subCategoriesOfCategory;
  const CategoryTextCarousel({
    Key? key,
    @required this.subCategoriesOfCategory,
  }) : super(key: key);
  @override
  State<CategoryTextCarousel> createState() => _CategoryTextCarouselState();
}

class _CategoryTextCarouselState extends State<CategoryTextCarousel> {
  _CategoryTextCarouselState();
  List? subCategories;
  int currentActivatedTab = 0;
  @override
  void initState() {
    super.initState();
    subCategories = widget.subCategoriesOfCategory;
    Provider.of<ProductCubit>(context, listen: false).getSubCategoryProducts(
        subCategories![currentActivatedTab]['category_id']);
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: ListView.builder(
          itemCount: subCategories!.length,
          scrollDirection: Axis.horizontal,
          shrinkWrap: true,
          itemBuilder: (BuildContext context, int index) {
            return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 5.0),
                child: InkWell(
                  onTap: () {
                    setState(() {
                      currentActivatedTab = index;
                    });
                    Provider.of<ProductCubit>(context, listen: false)
                        .getSubCategoryProducts(currentActivatedTab + 1);
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    height: 35,
                    decoration: BoxDecoration(
                      color: (currentActivatedTab == index)
                          ? const Color(yellowDarkColor)
                          : Colors.white,
                      borderRadius: BorderRadius.circular(40),
                      border: Border.all(color: Colors.white),
                    ),
                    child: Center(
                      child: Text(subCategories![index]['name'].toString(),
                          style: GoogleFonts.workSans(
                            fontSize: 13,
                            fontWeight: FontWeight.w400,
                            fontStyle: FontStyle.normal,
                            color: (currentActivatedTab == index)
                                ? Colors.white
                                : const Color(extraDarkGreyColor),
                          )),
                    ),
                  ),
                ));
          }),
    );
  }
}
