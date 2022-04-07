import 'dart:async';

class Products {
  String? name;
  double? price;
  double? oldPrice;
  double? discount;
  double? rating;
  List<dynamic>? images;

  Products(
      {this.name,
      this.price,
      this.oldPrice,
      this.discount,
      this.rating,
      this.images});

  Products.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    price = (json['price']);
    oldPrice = (json['oldPrice']);
    discount = (json['discount']);
    rating = (json['rating']);
    images = json['images'] is String
        ? json['images']
            .substring(1, json['images'].length - 1)
            .trim()
            .split(',')
            .toList()
        : json['images'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['price'] = price;
    data['oldPrice'] = oldPrice;
    data['discount'] = discount;
    data['rating'] = rating;
    data['images'] = images;
    return data;
  }
}

class ProductList {
  List<Products>? productList;
  ProductList(this.productList);
  var completer = Completer<List<Products>>();
  // List<Products>? get getMenues => productList;
  factory ProductList.fromJson(dynamic data) {
    List parsedJson = data.toList();
    List<Products>? prodList = [];
    prodList = parsedJson.map((data) => Products.fromJson(data)).toList();
    return ProductList(prodList);
  }
}
