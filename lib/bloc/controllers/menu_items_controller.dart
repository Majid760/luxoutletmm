import 'dart:async';

import 'package:flutter/material.dart';
import 'package:luxoutlet/data/model/product.dart';
import 'package:luxoutlet/data/model/sub_category_product.dart';
import 'package:luxoutlet/data/service/api/api_service.dart';

class MenuItemController extends ChangeNotifier {
  Future<CategoryMenuList>? categoryMenuList;
  List<Products>? products = [];

  // getting the subcategories of parent category
  Future<CategoryMenuList> getCategoryMenuList(int id) {
    var completer = Completer<CategoryMenuList>();
    if (categoryMenuList == null) {
      return categoryMenuList = ApiService().getCategoryMenu(id);
    }
    completer.complete(categoryMenuList);
    return completer.future;
  }

  // filltering  the subcategories products
  void filterMenuProducts([int menuId = 1]) async {
    categoryMenuList ??= ApiService().getCategoryMenu(menuId);
    CategoryMenuList? catMenuListObj = await categoryMenuList;
    List<CategoryMenu> categoryMenues = catMenuListObj!.getCateogries;
    products = categoryMenues[menuId].products;
    notifyListeners();
  }

  List<Products>? get getMenuProducts => products;
}
