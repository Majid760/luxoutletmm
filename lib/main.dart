import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:luxoutlet/bloc/cart/cart_cubit.dart';
import 'package:luxoutlet/bloc/category/category_cubit.dart';
import 'package:luxoutlet/bloc/controllers/bottom_navigation_controller.dart';
import 'package:luxoutlet/bloc/product/product_cubit.dart';
import 'package:luxoutlet/bloc/ui/homescreen_cubit/home_screen_cubit.dart';
import 'package:luxoutlet/config/theme/customtheme.dart';
import 'package:luxoutlet/data/repository/category_repository.dart';
import 'package:luxoutlet/data/repository/product_repository.dart';
import 'package:luxoutlet/view/screen/categoryscreen.dart';
import 'package:luxoutlet/view/screen/detailscreen.dart';
import 'package:luxoutlet/view/screen/homescreen.dart';
import 'package:luxoutlet/view/screen/subcategory.dart';
import 'package:provider/provider.dart';

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}

void main() async {
  HttpOverrides.global = MyHttpOverrides();
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider<BottomNavigationController>(
              create: (context) => BottomNavigationController()),
        ],
        child: MultiBlocProvider(
            providers: [
              BlocProvider<ProductCubit>(
                create: (context) =>
                    ProductCubit(productRepository: ProductRepository()),
              ),
              BlocProvider<CartCubit>(create: (_) => CartCubit()),
              // BlocProvider<SubCategoryBloc>(
              //     create: (BuildContext context) =>
              //         SubCategoryBloc(categoryRepository: CategoryRepository())),
              BlocProvider<CategoryCubit>(
                  create: (context) =>
                      CategoryCubit(categoryRepository: CategoryRepository())),
              BlocProvider<HomeScreenCubit>(
                  create: (context) => HomeScreenCubit()),
            ],
            child: MaterialApp(
              debugShowCheckedModeBanner: false,
              title: 'LuxOutlet',
              theme: CustomTheme.lightTheme,
              initialRoute: HomeScreen.routeName,
              routes: {
                HomeScreen.routeName: (context) => const HomeScreen(),
                CategoryScreen.routeName: (context) => const CategoryScreen(),
                SubCategoryScreen.routeName: (context) =>
                    const SubCategoryScreen(),
                DetailScreen.routeName: (context) => const DetailScreen(),
              },
            )));
  }
}
