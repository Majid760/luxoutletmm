import 'package:flutter/material.dart';
import 'package:luxoutlet/const/color.dart';

class CustomTheme {
  static ThemeData get lightTheme {
    return ThemeData(
        // sets the background color of the `BottomNavigationBar`
        canvasColor: const Color(greyColor),
        bottomSheetTheme:
            const BottomSheetThemeData(backgroundColor: Colors.white),
        primaryColor: Colors.grey.shade300,
        // primarySwatch: Colors.white,
        scaffoldBackgroundColor: Colors.white,
        textTheme: textTheme());
  }

  // text theme configuration
  static TextTheme textTheme() {
    return const TextTheme(
      headline1: TextStyle(
          fontFamily: 'Roboto',
          fontSize: 96,
          fontWeight: FontWeight.w300,
          letterSpacing: -1.5),
      headline2: TextStyle(
          fontFamily: 'Roboto',
          fontSize: 60,
          fontWeight: FontWeight.w300,
          letterSpacing: -0.5),
      headline3: TextStyle(
          fontFamily: 'Roboto', fontSize: 48, fontWeight: FontWeight.w400),
      headline4: TextStyle(
          fontFamily: 'Roboto',
          fontSize: 34,
          fontWeight: FontWeight.w400,
          letterSpacing: 0.25),
      headline5: TextStyle(
          fontFamily: 'Roboto', fontSize: 24, fontWeight: FontWeight.w400),
      headline6: TextStyle(
          fontFamily: 'Roboto',
          fontSize: 20,
          fontWeight: FontWeight.w500,
          letterSpacing: 0.15),
      subtitle1: TextStyle(
          fontFamily: 'Roboto',
          fontSize: 16,
          fontWeight: FontWeight.w400,
          letterSpacing: 0.15),
      subtitle2: TextStyle(
          fontFamily: 'Roboto',
          fontSize: 14,
          fontWeight: FontWeight.w500,
          letterSpacing: 0.1),
      bodyText1: TextStyle(
          fontFamily: 'Roboto',
          fontSize: 16,
          fontWeight: FontWeight.w400,
          letterSpacing: 0.5),
      bodyText2: TextStyle(
          fontFamily: 'Roboto',
          fontSize: 14,
          fontWeight: FontWeight.w400,
          letterSpacing: 0.25),
      button: TextStyle(
        fontFamily: 'Roboto',
        fontSize: 14,
        fontWeight: FontWeight.w500,
        letterSpacing: 1.25,
      ),
      caption: TextStyle(
          fontFamily: 'Roboto',
          fontSize: 12,
          fontWeight: FontWeight.w400,
          letterSpacing: 0.4),
      overline: TextStyle(
          fontSize: 10, fontWeight: FontWeight.w400, letterSpacing: 1.5),
    );
  }
}
