import 'dart:async';
import 'package:luxoutlet/data/model/product.dart';

class CategoryMenuList {
  List<CategoryMenu> categoryMenuList;
  CategoryMenuList(this.categoryMenuList);
  var completer = Completer<List<CategoryMenu>>();
  List<CategoryMenu> get getCateogries => categoryMenuList;
  factory CategoryMenuList.fromJson(dynamic data) {
    List parsedJson = data.toList();
    List<CategoryMenu>? categoryList = [];
    categoryList =
        parsedJson.map((data) => CategoryMenu.fromJson(data)).toList();
    return CategoryMenuList(categoryList);
  }
}

class CategoryMenu {
  int? menuId;
  String? name;
  String? description;
  String? image;
  List<Products>? products;

  CategoryMenu(
      {this.menuId, this.name, this.description, this.image, this.products});

  CategoryMenu.fromJson(Map<String, dynamic> json) {
    menuId = json['menuId'];
    name = json['name'];
    description = json['description'];
    image = json['image'];
    products = json['products']
        .map<Products>((prod) => Products.fromJson(prod))
        .toList();
  }

  Map<String, dynamic> toJson() {
    // ignore: prefer_collection_literals
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['menuId'] = menuId;
    data['name'] = name;
    data['description'] = description;
    data['image'] = image;
    if (products != null) {
      data['products'] = products!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
