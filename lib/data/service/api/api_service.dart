import 'dart:async';
import 'package:dio/dio.dart';
import 'package:luxoutlet/data/model/category.dart';
import 'package:luxoutlet/data/model/product.dart';
import 'package:luxoutlet/data/model/sub_category_product.dart';
import 'package:luxoutlet/data/service/api/api_config.dart';
import 'package:luxoutlet/data/service/api/api_exception_handling.dart';

class ApiService {
  final Dio _dio = Dio(BaseOptions(
      baseUrl: Config.baseUrl, connectTimeout: 15000, receiveTimeout: 5000));
  CategoryList? categoryListData;

  // get all categories of products
  Future<CategoryList> getCategories() async {
    var completer = Completer<CategoryList>();
    if (categoryListData == null) {
      try {
        final response = await _dio.get(
          Config.categoryUrl,
        );
        if (response.statusCode == 200) {
          categoryListData = CategoryList.fromJson(response.data);
        }
      } on DioError catch (e) {
        throw Exception(e);
      } catch (e) {
        throw Exception(e);
      }
    }
    completer.complete(categoryListData);
    return completer.future;
  }

  // subcategory of category
  Future<CategoryMenuList> getCategoryMenu(int id) async {
    CategoryMenuList? categoryMenuListdata;
    var completer = Completer<CategoryMenuList>();
    try {
      final response = await _dio.get('/menu/$id');
      if (response.statusCode == 200) {
        categoryMenuListdata = CategoryMenuList.fromJson(response.data);
      }
    } on DioError catch (e) {
      ExceptionHandling().onErrorCheck(e);
    } catch (e) {
      throw Exception(e);
    }
    completer.complete(categoryMenuListdata);
    return completer.future;
  }

  // all products
  Future<ProductList> getAllProducts() async {
    ProductList? productList;
    var completer = Completer<ProductList>();
    try {
      final response = await _dio.get('/products');
      if (response.statusCode == 200) {
        productList = ProductList.fromJson(response.data);
      }
    } on DioError catch (e) {
      throw Exception(e);
    } catch (e) {
      throw Exception(e);
    }
    completer.complete(productList);
    return completer.future;
  }
}
