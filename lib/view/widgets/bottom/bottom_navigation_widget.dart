import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:luxoutlet/const/color.dart';
import 'package:luxoutlet/bloc/controllers/bottom_navigation_controller.dart';
import 'package:luxoutlet/view/screen/categoryscreen.dart';
import 'package:luxoutlet/view/screen/homescreen.dart';
import 'package:luxoutlet/view/widgets/bottom/bottombar_item_widget.dart';
import 'package:luxoutlet/view/widgets/bottom/payment_cart_widget.dart';
import 'package:provider/provider.dart';

class CustomBottomNavigationBar extends StatelessWidget {
  const CustomBottomNavigationBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 68,
      width: 315,
      color: const Color(lightGreyColor),
      child: Container(
          height: double.infinity,
          width: double.infinity,
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
                topRight: Radius.circular(24), topLeft: Radius.circular(24)),
          ),
          child: Stack(
              alignment: AlignmentDirectional.topEnd,
              clipBehavior: Clip.none,
              children: const [
                Positioned(top: 22, left: 20, child: NavigationItemsList()),
                Positioned(bottom: 28, child: FloatingPaymentCarWidget())
              ])),
    );
  }
}

class NavigationItemsList extends StatelessWidget {
  const NavigationItemsList({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        width: 233,
        child: Consumer<BottomNavigationController>(
          builder: (context, navController, _) => Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            mainAxisSize: MainAxisSize.max,
            children: [
              InkWell(
                onTap: () {
                  navController.changeNavigationIndex(0);
                  Navigator.pushNamed(context, HomeScreen.routeName);
                },
                child: BottomAppBarItem(
                    iconData: Icons.home_outlined,
                    iconSize: 19,
                    title: "Home",
                    textStyle: GoogleFonts.workSans(
                      fontWeight: FontWeight.w600,
                      fontSize: 12,
                      fontStyle: FontStyle.normal,
                    ),
                    index: 0),
              ),
              InkWell(
                onTap: () {
                  navController.changeNavigationIndex(1);
                  Navigator.pushNamed(context, CategoryScreen.routeName);
                },
                child: BottomAppBarItem(
                    iconData: Icons.grid_view,
                    iconSize: 19,
                    title: "Categories",
                    textStyle: GoogleFonts.workSans(
                      fontWeight: FontWeight.w600,
                      fontSize: 12,
                      fontStyle: FontStyle.normal,
                    ),
                    index: 1),
              ),
              BottomAppBarItem(
                  iconData: Icons.favorite_border_outlined,
                  iconSize: 19,
                  title: "Liked",
                  textStyle: GoogleFonts.workSans(
                    fontWeight: FontWeight.w600,
                    fontSize: 12,
                    fontStyle: FontStyle.normal,
                  ),
                  index: 2),
              BottomAppBarItem(
                  iconData: Icons.person_outline_rounded,
                  iconSize: 19,
                  title: "Account",
                  textStyle: GoogleFonts.workSans(
                    fontWeight: FontWeight.w600,
                    fontSize: 12,
                    fontStyle: FontStyle.normal,
                  ),
                  index: 3),
            ],
          ),
        ));
  }
}
