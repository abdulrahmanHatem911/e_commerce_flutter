import '../../../models/cart_model.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'dart:io' as io;

import '../../../models/product_model.dart';

class SqliteService {
// creating database table
  Future<Database> initializeDB() async {
    io.Directory directory = await getApplicationDocumentsDirectory();
    String path = join(directory.path, 'database.db');
    var db = await openDatabase(path, version: 1, onCreate: _onCreate);
    return db;
  }

  _onCreate(Database db, int version) async {
    await db.execute(
      "CREATE TABLE products (id INTEGER,name TEXT NOT NULL,description TEXT NOT NULL,imageUrl TEXT NOT NULL,price INTEGER,categoryId INTEGER)",
    );
    await db.execute(
      'CREATE TABLE cart(id INTEGER , productId VARCHAR,name TEXT,description TEXT,image TEXT,price INTEGER, quantity INTEGER)',
    );
  }

  Future<int> createItem(ProductModel product) async {
    final Database db = await initializeDB();
    final List<Map<String, dynamic>> maps = await db.query('products');
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
        'products',
        product.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
      return 1;
    }
  }

  //get all items
  Future<List<ProductModel>> getAllItems() async {
    final Database db = await initializeDB();
    final List<Map<String, dynamic>> maps = await db.query('products');
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
      'products',
      where: "id = ?",
      whereArgs: [id],
    );
  }

  //search item
  Future<int> searchItem(ProductModel model) async {
    final Database db = await initializeDB();
    final List<Map<String, dynamic>> maps = await db.query('products');
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

  //cart---------------------🔥🔥
  // inserting data into the table
  Future<int> insert(CartModel cart) async {
    var dbClient = await initializeDB();
    final List<Map<String, dynamic>> maps = await dbClient.query('cart');
    bool isExist = false;
    for (var item in maps) {
      if (item['id'] == cart.id) {
        print("item already exist🙂");
        isExist = true;
      }
    }
    if (isExist) {
      return 0;
    } else {
      await dbClient.insert('cart', cart.toMap()).then((value) {});
      return 1;
    }
  }

// getting all the items in the list from the database
  Future<List<CartModel>> getCartList() async {
    var dbClient = await initializeDB();
    final List<Map<String, Object?>> queryResult = await dbClient.query('cart');
    return queryResult.map((result) => CartModel.fromJson(result)).toList();
  }

  Future<int> updateQuantity(CartModel cart) async {
    var dbClient = await initializeDB();
    return await dbClient.update('cart', cart.toMap(),
        where: "productId = ?", whereArgs: [cart.productId]);
  }

// deleting an item from the cart screen
  Future<int> deleteCartItem(int id) async {
    var dbClient = await initializeDB();
    return await dbClient.delete('cart', where: 'id = ?', whereArgs: [id]);
  }
}
