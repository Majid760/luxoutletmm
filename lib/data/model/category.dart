import 'dart:async';

class Category {
  int? id;
  String? name;
  String? image;
  String? creationDate;
  int? quantity;

  Category({this.id, this.name, this.image, this.creationDate, this.quantity});

  factory Category.fromJson(Map<String, dynamic> json) {
    return Category(
        id: json['id'],
        name: json['name'],
        image: json['image'],
        creationDate: json['createdDate'],
        quantity: json['quantity']);
  }
}

class CategoryList {
  List<Category> categoryList;
  CategoryList(this.categoryList);
  var completer = Completer<List<Category>>();

  //getter function to get the data from list
  List<Category> get getCateogries => categoryList;
  factory CategoryList.fromJson(dynamic data) {
    List parsedJson = data.toList();
    List<Category>? categoryList = [];
    categoryList = parsedJson.map((data) => Category.fromJson(data)).toList();
    return CategoryList(categoryList);
  }
}
