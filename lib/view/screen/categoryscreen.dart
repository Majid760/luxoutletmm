import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:luxoutlet/bloc/category/category_cubit.dart';
import 'package:luxoutlet/bloc/category/category_state.dart';
import 'package:luxoutlet/bloc/controllers/bottom_navigation_controller.dart';
import 'package:luxoutlet/const/color.dart';
import 'package:luxoutlet/data/model/category.dart';
import 'package:luxoutlet/data/model/product.dart';
import 'package:luxoutlet/view/screen/homescreen.dart';
import 'package:luxoutlet/view/screen/subcategory.dart';
import 'package:luxoutlet/view/widgets/appbar/appbar_widget.dart';
import 'package:luxoutlet/view/widgets/bottom/bottom_navigation_widget.dart';
import 'package:luxoutlet/view/widgets/category_list_item_widget.dart';
import 'package:provider/provider.dart';

class CategoryScreen extends StatefulWidget {
  static const String routeName = '/categor_screen';
  const CategoryScreen({Key? key}) : super(key: key);

  @override
  State<CategoryScreen> createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {
  CategoryCubit? _categoryCubit;
  @override
  void initState() {
    super.initState();
    _categoryCubit = BlocProvider.of<CategoryCubit>(context);
    _categoryCubit!.getCategories();
  }

  @override
  void dispose() {
    super.dispose();
    _categoryCubit!.close();
  }

  @override
  Widget build(BuildContext context) {
    var bottomNavControll = Provider.of<BottomNavigationController>(context);
    return Scaffold(
      // appbar
      appBar: AppBarWidget(
        leadingIconData: Icons.arrow_back,
        trailingPress: () {
          bottomNavControll.changeNavigationIndex(0);
          Navigator.pushNamed(
            context,
            HomeScreen.routeName,
          );
        },
        title: "Categories",
      ),

      // body section of category page
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        color: const Color(lightGreyColor),
        child: BlocConsumer<CategoryCubit, CategoryState>(
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
                return CategoryBuilder(categories: state.categoryList);
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

      // bottom navigationbar section of category page
      bottomNavigationBar: const CustomBottomNavigationBar(),
    );
  }
}

class CategoryBuilder extends StatelessWidget {
  final List<Category>? categories;
  const CategoryBuilder({Key? key, this.categories}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: categories!.length,
        itemBuilder: (BuildContext context, index) => InkWell(
              onTap: () {
                Navigator.pushNamed(
                  context,
                  SubCategoryScreen.routeName,
                  arguments: categories![index].id!,
                );
                // displayModalBottomSheet(
                //   context,
                //   products[index]['category'],
                // );
              },
              child: CategoryListItemWidget(
                  title: categories![index].name.toString(),
                  imageUrl: categories![index].image.toString()),
            ));
  }
}

// bottom sheet
void displayModalBottomSheet(context, Products product) {
  showModalBottomSheet(
      context: context,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(24.0),
      ),
      backgroundColor: Colors.white,
      builder: (BuildContext bc) {
        return Container(
          color: Colors.transparent,
          child: Container(
              height: 422,
              width: 375,
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                    topRight: Radius.circular(24),
                    topLeft: Radius.circular(24)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Center(
                      child: Padding(
                    padding: const EdgeInsets.only(top: 31),
                    child: Text(product.name.toString(),
                        style: GoogleFonts.workSans(
                            fontSize: 22,
                            fontStyle: FontStyle.normal,
                            fontWeight: FontWeight.w700)),
                  )),
                  Padding(
                    padding: const EdgeInsets.only(left: 38.0),
                    child: BlocConsumer<CategoryCubit, CategoryState>(
                      listener: (context, state) {},
                      builder: (context, state) {
                        switch (state.status) {
                          case CategoryStatus.initial:
                            return const Center(
                                child: CircularProgressIndicator());
                          case CategoryStatus.loading:
                            return const Center(
                                child: CircularProgressIndicator());
                          case CategoryStatus.success:
                          // return Column(
                          //     // mainAxisAlignment: MainAxisAlignment.start,
                          //     crossAxisAlignment: CrossAxisAlignment.start,
                          //     children: state.categoryList
                          //         .map((subCategory) => InkWell(
                          //               onTap: () {
                          //                 Navigator.pushNamed(
                          //                   context,
                          //                   SubCategoryScreen.routeName,
                          //                   arguments: 1,
                          //                 );
                          //               },
                          //               child: Padding(
                          //                 padding: const EdgeInsets.symmetric(
                          //                     vertical: 3),
                          //                 child: Text(subCategory['category'],
                          //                     style: GoogleFonts.workSans(
                          //                         fontSize: 13.5,
                          //                         fontWeight: FontWeight.w400,
                          //                         fontStyle:
                          //                             FontStyle.normal)),
                          //               ),
                          //             ))
                          //         .toList());

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
                ],
              )),
        );
      });
}
