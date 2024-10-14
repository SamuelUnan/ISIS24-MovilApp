import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import '../models/product_model.dart';

class CartDatabase {
  static final CartDatabase instance = CartDatabase._init();
  static Database? _database;

  CartDatabase._init();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB('cart.db');
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);

    return await openDatabase(
      path,
      version: 1,
      onCreate: _createDB,
    );
  }

  Future _createDB(Database db, int version) async {
    await db.execute('''
    CREATE TABLE cart (
      id INTEGER PRIMARY KEY,
      name TEXT NOT NULL,
      price REAL NOT NULL,
      quantity INTEGER NOT NULL
    )
    ''');
  }

  Future<void> insertProduct(Product product) async {
    final db = await instance.database;
    await db.insert('cart', product.toMap(), conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future<List<Product>> fetchCart() async {
    final db = await instance.database;
    final result = await db.query('cart');

    return result.map((map) => Product.fromMap(map)).toList();
  }

  Future<void> updateProduct(Product product) async {
    final db = await instance.database;
    await db.update('cart', product.toMap(), where: 'id = ?', whereArgs: [product.id]);
  }

  Future<Product?> getProductById(int id) async {
    final db = await instance.database;

    final maps = await db.query(
      'cart',
      columns: ['id', 'name', 'price', 'quantity'],
      where: 'id = ?',
      whereArgs: [id],
    );

    if (maps.isNotEmpty) {
      return Product.fromMap(maps.first);
    } else {
      return null;
    }
  }

  Future<int> updateProductQuantity(int id, int newQuantity) async {
    final db = await instance.database;

    return await db.update(
      'cart',
      {'quantity': newQuantity},
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  Future<void> deleteProduct(int id) async {
    final db = await instance.database;
    await db.delete('cart', where: 'id = ?', whereArgs: [id]);
  }

  Future<void> clearCart() async {
    final db = await instance.database;
    await db.delete('cart');
  }
}
