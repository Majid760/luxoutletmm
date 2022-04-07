class DataBaseTable {
  static String tableCategory = '''
      CREATE TABLE IF NOT EXISTS category(
        id INTEGER PRIMARY KEY NOT NULL ,
        categoryName TEXT NOT NULL ,
        categoryImage TEXT,
        creationDate TEXT,
        quantity INTEGER
      )
      ''';
  static String tableSubCategory = '''
      CREATE TABLE IF NOT EXISTS sub_category(
        id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
        name TEXT ,
        description TEXT,
        image TEXT,
        category_id INTEGER ,
        FOREIGN KEY(category_id) REFERENCES category(id) ON DELETE NO ACTION ON UPDATE NO ACTION
      )
      ''';
  static const tableSubCategoryProduct = '''
      CREATE TABLE IF NOT EXISTS product(
        id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
        name TEXT,
        price REAL,
        old_price REAL,
        rating REAL,
        images TEXT,
        product_category_id INTEGER,
        FOREIGN KEY(product_category_id) REFERENCES sub_category(id) ON DELETE NO ACTION ON UPDATE NO ACTION
      )
      ''';

  static List<String> tables = [
    tableCategory,
    tableSubCategory,
    tableSubCategoryProduct,
    // tableProductImage
  ];
}
