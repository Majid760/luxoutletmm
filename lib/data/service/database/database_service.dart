import 'dart:io';
import 'package:intl/intl.dart';
import 'package:luxoutlet/config/database/database_config.dart';
import 'package:luxoutlet/data/model/category.dart';
import 'package:luxoutlet/data/model/product.dart';
import 'package:luxoutlet/data/model/sub_category_product.dart';
import 'package:luxoutlet/data/service/api/api_service.dart';
import 'package:luxoutlet/data/service/database/database_tables.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseService {
  // creating the private constructor(act like singleton)
  static final DatabaseService instance = DatabaseService._init();
  DatabaseService._init();
  static Database? _database;

  Future<Database?> get database async {
    if (_database != null) return _database;
    _database = await _initDatabase();
    return _database;
  }

  // initializing the database
  _initDatabase() async {
    Directory documentdirectory = await getApplicationDocumentsDirectory();
    String path = join(documentdirectory.path, DatabaseConfig.databaseName);
    return await openDatabase(path,
        version: DatabaseConfig.databaseVersion, onCreate: _onCreate);
  }

  // creating the talbles
  Future _onCreate(Database db, int version) async {
    await db.execute(DataBaseTable.tables[0]);
    await db.execute(DataBaseTable.tables[1]);
    await db.execute(DataBaseTable.tables[2]);
  }

  // closign the database connection
  Future close() async {
    final db = await instance.database;
    db!.close();
  }

  // get the path of database
  Future<String> getPath() async {
    return await getDatabasesPath();
  }

  Future<bool> firstTimeInsertion() async {
    ApiService apiSrvc = ApiService();
    CategoryList categoryList = await apiSrvc.getCategories();
    List catList = categoryList.categoryList;
    for (var catModel in catList) {
      Map<String, dynamic>? row = {
        'id': catModel!.id,
        'categoryName': catModel!.name,
        'categoryImage': catModel!.image,
        'creationDate': catModel!.creationDate,
        'quantity': catModel!.quantity
      };
      insertIntoTable('category', row);
      CategoryMenuList menuList = await apiSrvc.getCategoryMenu(catModel.id);
      for (dynamic categoryMenu in menuList.categoryMenuList) {
        Map<String, dynamic>? subCatRow = {
          'name': categoryMenu.name,
          'description': categoryMenu.description,
          'image': categoryMenu.image,
          'category_id': catModel.id,
        };
        insertIntoTable('sub_category', subCatRow);
        for (dynamic product in categoryMenu.products) {
          Map<String, dynamic>? subCatProductRow = {
            'name': product.name,
            'price': product.price,
            'old_price': product.oldPrice,
            'rating': product.rating,
            'images': product.images.toString(),
            'product_category_id': categoryMenu.menuId,
          };
          insertIntoTable('product', subCatProductRow);
        }
      }
    }
    return true;
  }

  // insert the data into correspondent table
  void insertIntoTable(String table, Map<String, dynamic> data) async {
    Database? db = await instance.database;
    Batch batch = db!.batch();
    batch.insert(
      table,
      data,
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
    await batch.commit(noResult: true);
  }

  // retrive the category
  Future<List<Category>> getCategoryListFromList() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db!.query('category');
    return List.generate(maps.length, (i) {
      return Category(
          id: maps[i]['id'],
          name: maps[i]['categoryName'],
          image: maps[i]['categoryImage'],
          creationDate: DateFormat("yyyy-MM-dd").format(DateTime.now()),
          quantity: 45);
    });
  }

  // retrive the all products
  Future<List<Products>> getProducts() async {
    try {
      final db = await database;
      final List<Map<String, dynamic>> maps = await db!.query('product');
      List<Products>? list;
      list = maps.map((e) => Products.fromJson(e)).toList();
      return list;
    } catch (e) {
      return [];
    }
  }

  // retrive the all products of subcategory
  Future<List<Products>> getSubCategoryProducts(int subCatId) async {
    try {
      final db = await database;
      const String tableName = 'product';
      final List<Map<String, dynamic>> maps = await db!.query(tableName,
          where: 'product_category_id=?', whereArgs: [subCatId]);
      List<Products>? list;
      list = maps.map((e) => Products.fromJson(e)).toList();
      return list;
    } catch (e) {
      return [];
    }
  }

  // get the subcategories of category
  Future<List> getSubCategories(int parentCatId) async {
    final db = await database;
    final List<Map> subCat = await db!
        .rawQuery('SELECT * FROM sub_category WHERE category_id=$parentCatId');
    return subCat;
  }

  // delete the whole database
  Future<bool> deleteDb() async {
    bool databaseDeleted = false;
    try {
      Directory documentsDirectory = await getApplicationDocumentsDirectory();
      String path = join(documentsDirectory.path, DatabaseConfig.databaseName);
      await deleteDatabase(path).whenComplete(() {
        databaseDeleted = true;
      }).catchError((onError) {
        databaseDeleted = false;
      });
    } on DatabaseException catch (error) {
      throw Exception(error.toString());
    } catch (error) {
      // print(error);
    }
    return databaseDeleted;
  }
}
