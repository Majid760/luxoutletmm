import 'dart:async';

class SubCategory {
  int? id;
  String? name;
  String? image;
  String? description;

  SubCategory({this.id, this.name, this.image, this.description});

  factory SubCategory.fromJson(Map<String, dynamic> json) {
    return SubCategory(
      id: json['id'],
      name: json['name'],
      image: json['image'],
      description: json['description'],
    );
  }
}

class SubCategoryList {
  List<SubCategory> categoryList;
  SubCategoryList(this.categoryList);

  // getter to get list of subcategories
  List<SubCategory> get getMenues => categoryList;

  var completer = Completer<List<SubCategory>>();
  factory SubCategoryList.fromJson(dynamic data) {
    List parsedJson = data.toList();
    List<SubCategory>? categoryList = [];
    categoryList =
        parsedJson.map((data) => SubCategory.fromJson(data)).toList();
    return SubCategoryList(categoryList);
  }
}
