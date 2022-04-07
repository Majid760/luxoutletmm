import 'package:luxoutlet/data/model/category.dart';
import 'package:luxoutlet/data/service/database/database_service.dart';

class CategoryRepository {
  final _db = DatabaseService.instance;
  List<Category>? listOfCategories;
  // List<Sub

  // fetched the categories from local database
  Future<List<Category>>? getCategoriesFromDB() async {
    return listOfCategories ??= await _db.getCategoryListFromList();
  }

  // fetched the subcategories of category(id)

  Future<List>? getSubCategoriesFromDB(id) async {
    return _db.getSubCategories(id);
  }
}
