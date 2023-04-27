import 'dart:io';

import 'package:hive/hive.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

import '../../../models/cart_model.dart';
import '../../../models/product_model.dart';

abstract class LocalDatabaseService {
  Future<List<ProductModel>> getAllFavoritesItems();
  Future<int> createItem(ProductModel product);
  Future<int> deleteItem(int id);

  //
  Future<List<CartModel>> getAllCartItems();
  Future<int> insertCartItem(CartModel cart);
  Future<int> updateQuantity(CartModel cart);
  Future<int> deleteCartItem(int id);
}

class SqliteServiceDatabase implements LocalDatabaseService {
  static const String tableName = 'products';
  static Database? _database;

  Future<Database> get database async {
    if (_database != null) {
      return _database!;
    }

    _database = await initializeDB();
    return _database!;
  }

  Future<Database> initializeDB() async {
    final Directory directory = await getApplicationDocumentsDirectory();
    final String path = join(directory.path, 'database.db');
    return await openDatabase(path, version: 1, onCreate: _onCreate);
  }

  void _onCreate(Database db, int version) async {
    await db.execute(
      "CREATE TABLE $tableName (id INTEGER PRIMARY KEY,name TEXT NOT NULL,description TEXT NOT NULL,imageUrl TEXT NOT NULL,price INTEGER,categoryId INTEGER)",
    );
    await db.execute(
      'CREATE TABLE cart(id INTEGER , productId VARCHAR,name TEXT,description TEXT,image TEXT,price INTEGER, quantity INTEGER)',
    );
  }

  @override
  Future<int> createItem(ProductModel product) async {
    final Database db = await database;
    final List<Map<String, dynamic>> maps = await db.query(tableName);
    bool isExist = false;
    for (var item in maps) {
      if (item['id'] == product.id) {
        isExist = true;
        await deleteItem(product.id);
        break;
      }
    }
    if (isExist) {
      return 0;
    } else {
      await db.insert(
        tableName,
        product.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
      return 1;
    }
  }

  @override
  Future<List<ProductModel>> getAllFavoritesItems() async {
    final Database db = await database;
    final List<Map<String, dynamic>> maps = await db.query(tableName);
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

  @override
  Future<int> deleteItem(int id) async {
    final Database db = await database;
    return await db.delete(
      tableName,
      where: "id = ?",
      whereArgs: [id],
    );
  }

  @override
  Future<List<CartModel>> getAllCartItems() async {
    var dbClient = await initializeDB();
    final List<Map<String, Object?>> queryResult = await dbClient.query('cart');
    return queryResult.map((result) => CartModel.fromJson(result)).toList();
  }

  @override
  Future<int> insertCartItem(CartModel cart) async {
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

  @override
  Future<int> updateQuantity(CartModel cart) async {
    var dbClient = await initializeDB();
    return await dbClient.update('cart', cart.toMap(),
        where: "productId = ?", whereArgs: [cart.productId]);
  }

  @override
  Future<int> deleteCartItem(int id) async {
    var dbClient = await initializeDB();
    return await dbClient.delete('cart', where: 'id = ?', whereArgs: [id]);
  }
}

class HiveService implements LocalDatabaseService {
  late Box<ProductModel> _productBox;

  Future<void> _init() async {
    final directory = await getApplicationDocumentsDirectory();
    Hive.init(directory.path);
    Hive.registerAdapter(ProductModelAdapter());
    _productBox = await Hive.openBox<ProductModel>('products');
  }

  @override
  Future<int> createItem(ProductModel product) async {
    await _init();
    final item = _productBox.get(product.id);
    if (item != null) {
      await _productBox.delete(product.id);
    }
    await _productBox.put(product.id, product);
    return 1;
  }

  @override
  Future<List<ProductModel>> getAllFavoritesItems() async {
    await _init();
    return _productBox.values.toList();
  }

  @override
  Future<int> deleteItem(int id) async {
    await _init();
    await _productBox.delete(id);
    return 1;
  }

  @override
  Future<List<CartModel>> getAllCartItems() async {
    return [];
  }

  @override
  Future<int> updateQuantity(CartModel cart) {
    throw UnimplementedError();
  }

  @override
  Future<int> deleteCartItem(int id) {
    // TODO: implement deleteCartItem
    throw UnimplementedError();
  }

  @override
  Future<int> insertCartItem(CartModel cart) {
    throw UnimplementedError();
  }
}

class ProductModelAdapter extends TypeAdapter<ProductModel> {
  @override
  final int typeId = 0;

  @override
  ProductModel read(BinaryReader reader) {
    final id = reader.readInt();
    final name = reader.readString();
    final description = reader.readString();
    final imageUrl = reader.readString();
    final price = reader.readDouble();
    final categoryId = reader.readInt();
    return ProductModel(
      id: id,
      name: name,
      description: description,
      imageUrl: imageUrl,
      price: price,
      categoryId: categoryId,
    );
  }

  @override
  void write(BinaryWriter writer, ProductModel obj) {
    writer.writeInt(obj.id);
    writer.writeString(obj.name);
    writer.writeString(obj.description);
    writer.writeString(obj.imageUrl);
    writer.writeDouble(obj.price);
    writer.writeInt(obj.categoryId);
  }
}

// class SqliteService {
//   //search item
//   // Future<int> searchItem(ProductModel model) async {
//   //   final Database db = await initializeDB();
//   //   final List<Map<String, dynamic>> maps = await db.query('products');
//   //   bool isExist = false;
//   //   for (var item in maps) {
//   //     if (item['id'] == model.id) {
//   //       isExist = true;
//   //       break;
//   //     }
//   //   }
//   //   if (isExist) {
//   //     return 1;
//   //   } else {
//   //     return 0;
//   //   }
//   // }
// }
