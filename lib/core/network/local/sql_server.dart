import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

import '../../../models/product_model.dart';

class SqliteService {
  Future<Database> initializeDB() async {
    String path = await getDatabasesPath();
    return openDatabase(
      join(path, 'database.db'),
      onCreate: (database, version) async {
        await database.execute(
          "CREATE TABLE Products (id INTEGER,name TEXT NOT NULL,description TEXT NOT NULL,imageUrl TEXT NOT NULL,price INTEGER,categoryId INTEGER)",
        );
      },
      version: 1,
    );
  }

  Future<int> createItem(ProductModel product) async {
    final Database db = await initializeDB();
    final List<Map<String, dynamic>> maps = await db.query('Products');
    bool isExist = false;
    for (var item in maps) {
      if (item['id'] == product.id) {
        isExist = true;
        deleteItem(product.id);
        break;
      }
    }
    if (isExist) {
      return 0;
    } else {
      await db.insert(
        'Products',
        product.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
      return 1;
    }
  }

  //get all items
  Future<List<ProductModel>> getAllItems() async {
    final Database db = await initializeDB();
    final List<Map<String, dynamic>> maps = await db.query('Products');
    return List.generate(maps.length, (index) {
      return ProductModel(
        id: maps[index]['id'],
        name: maps[index]['name'],
        description: maps[index]['description'],
        imageUrl: maps[index]['imageUrl'],
        price: maps[index]['price'].toDouble(),
        categoryId: maps[index]['categoryId'],
      );
    });
  }

  //delete item
  Future<int> deleteItem(int id) async {
    final Database db = await initializeDB();
    return await db.delete(
      'Products',
      where: "id = ?",
      whereArgs: [id],
    );
  }

  //search item
  Future<int> searchItem(ProductModel model) async {
    final Database db = await initializeDB();
    final List<Map<String, dynamic>> maps = await db.query('Products');
    bool isExist = false;
    for (var item in maps) {
      if (item['id'] == model.id) {
        isExist = true;
        break;
      }
    }
    if (isExist) {
      return 1;
    } else {
      return 0;
    }
  }
}
