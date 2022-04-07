import 'package:flutter/material.dart';

class DetailPageController extends ChangeNotifier {
  int colorIndex = 0;
  int sizeIndex = 0;
  List<String> imagesOfColors = [
    'assets/images/color1.png',
    'assets/images/color2.png',
    'assets/images/color3.png',
    'assets/images/color4.png',
    'assets/images/color5.png',
    'assets/images/color6.png',
  ];
  List<String> productSizes = ['XXS', 'XS', 'S', 'M', 'L', 'XL'];

  List get getImagesOfColors => imagesOfColors;
  List get getProductSize => productSizes;
  int get getColorIndex => colorIndex;
  int get getSizeIndex => sizeIndex;
  void changeColorIndex(int index) {
    colorIndex = index % 6;
    notifyListeners();
  }

  void changeSizeIndex(int index) {
    sizeIndex = index % 6;
    notifyListeners();
  }
}
