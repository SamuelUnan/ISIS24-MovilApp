import 'dart:io';

import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class LocalDbServices {
  static Database? _database;
  static final LocalDbServices db = LocalDbServices._();
  LocalDbServices._();

  Future<Database> get database async {
    if (_database != null) return _database!;

    _database = await initDB();

    return _database!;
  }

  Future<Database> initDB() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();

    final path = join(await getDatabasesPath(), 'AppDB.db');

    return await openDatabase(path, version: 1, onOpen: (db) {},
        onCreate: (Database db, int version) async {
      await db.execute('''
      CREATE TABLE Tbl_Shopping_Cart(
          id INTEGER PRIMARY KEY,
          Producto TEXT,
          Precio TEXT)
      ''');
    });
  }
}
