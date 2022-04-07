import 'package:luxoutlet/data/model/product.dart';
import 'package:luxoutlet/data/service/database/database_service.dart';

class ProductRepository {
  final _db = DatabaseService.instance;
  List<Products>? listOfProduct;
  List<Products>? listOfSubCategoryProducts;

  Future<List<Products>> getProducts() async {
    return listOfProduct ??= await _db.getProducts();
  }

  Future<List<Products>>? getListOfSubCategoryProducts(int id) async {
    return listOfSubCategoryProducts ??= await _db.getSubCategoryProducts(id);
  }
}
