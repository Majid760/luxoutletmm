import 'package:flutter/material.dart';

class BottomNavigationController extends ChangeNotifier {
  int index = 0;

  int get getCurrentIndex => index;

  void changeNavigationIndex(int i) {
    index = i;
    notifyListeners();
  }
}
