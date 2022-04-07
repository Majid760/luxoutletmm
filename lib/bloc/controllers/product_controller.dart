import 'package:flutter/material.dart';
import 'package:luxoutlet/data/model/product.dart';
import 'package:luxoutlet/data/service/api/api_service.dart';

class ProductController extends ChangeNotifier {
// product categories

  List<Map> productCategories = [
    {
      'name': 'All Women',
      'image_path': 'assets/images/cat5.png',
    },
    {'name': 'New Collection', 'image_path': 'assets/images/cat3.png'},
    {
      'name': 'Activewear',
      'image_path': 'assets/images/cat4.png',
    },
    {'name': 'Luxury', 'image_path': 'assets/images/cat2.png'},
    {'name': 'Swimmer', 'image_path': 'assets/images/cat1.png'}
  ];

// all products data
  List<Map> allProducts = [
    {
      "name": "DKNY t-shirt - colour block front logo",
      "productPath": "assets/images/product1.png",
      "discount": 60.0,
      "price": 19.0,
      "oldPrice": 69.0,
      "rating": 5.0
    },
    {
      "name": "Tommy Hilfiger padded jackets - black with...",
      "productPath": "assets/images/product2.png",
      "discount": 50.0,
      "price": 55.0,
      "oldPrice": 110.0,
      "rating": 5.0
    },
    {
      "name": "Midi dress with buttons short sleeve - pink",
      "productPath": "assets/images/product3.png",
      "discount": 60.0,
      "price": 35.0,
      "oldPrice": 69.0,
      "rating": 5.0
    },
    {
      "name": "Blazer dress with buttons long sleeve..",
      "productPath": "assets/images/product4.png",
      "discount": 50.0,
      "price": 59.0,
      "oldPrice": 120.0,
      "rating": 5.0
    },
    {
      "name": "Blazer dress with buttons long sleeve..",
      "productPath": "assets/images/product5.png",
      "discount": 50.0,
      "price": 59.0,
      "oldPrice": 120.0,
      "rating": 5.0
    },
    {
      "name": "DKNY t-shirt - colour block front logo",
      "productPath": "assets/images/product1.png",
      "discount": 60.0,
      "price": 19.0,
      "oldPrice": 69.0,
      "rating": 5.0
    },
    {
      "name": "Tommy Hilfiger padded jackets - black with...",
      "productPath": "assets/images/product2.png",
      "discount": 50.0,
      "price": 55.0,
      "oldPrice": 110.0,
      "rating": 5.0
    },
    {
      "name": "Midi dress with buttons short sleeve - pink",
      "productPath": "assets/images/product3.png",
      "discount": 60.0,
      "price": 35.0,
      "oldPrice": 69.0,
      "rating": 5.0
    },
    {
      "name": "Blazer dress with buttons long sleeve..",
      "productPath": "assets/images/product4.png",
      "discount": 50.0,
      "price": 59.0,
      "oldPrice": 120.0,
      "rating": 5.0
    },
    {
      "name": "Blazer dress with buttons long sleeve..",
      "productPath": "assets/images/product5.png",
      "discount": 50.0,
      "price": 59.0,
      "oldPrice": 120.0,
      "rating": 5.0
    }
  ];

  // favorite product
  final List<Products> favorites = [];
  List get getFavorites => favorites;

  void favoriteProduct(Products product) {
    if (favorites.contains(product) == false) {
      favorites.add(product);
      notifyListeners();
    } else {
      favorites.remove(product);
      notifyListeners();
    }
  }

  bool isFavoriteContains(product) {
    return favorites.contains(product);
  }

  // get all products
  Future<ProductList> getProducts() async {
    ProductList? productList;
    if (productList == null) {
      return productList = await ApiService().getAllProducts();
    }
    return productList;
  }
}
