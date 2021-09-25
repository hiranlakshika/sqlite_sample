import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:sqlite_sample/user.dart';

import 'item.dart';

class DatabaseHelper {
  static const _databaseName = "saegis.db";
  static const _databaseVersion = 1;
  static const tableUser = 'user';
  static const tableItem = 'item';

  DatabaseHelper._privateConstructor();

  static final DatabaseHelper _instance = DatabaseHelper._privateConstructor();

  factory DatabaseHelper() {
    return _instance;
  }

  final String _userCreate = "CREATE TABLE $tableUser(id TEXT PRIMARY KEY, title TEXT NOT NULL, name TEXT NOT NULL, address TEXT, age REAL NOT NULL)";
  final String _itemCreate = "CREATE TABLE $tableItem(id TEXT PRIMARY KEY, name TEXT NOT NULL, price REAL NOT NULL, stock REAL NOT NULL)";

  static Database? _database;

  Future<Database> _initDatabase() async {
    String path = await getDatabasesPath();
    return openDatabase(join(path, _databaseName), onCreate: (database, version) async {
      await database.execute(_userCreate);
      await database.execute(_itemCreate);
    }, version: _databaseVersion);
  }

  Future<Database?> get database async {
    if (_database != null) return _database;
    // lazily instantiate the db the first time it is accessed
    _database = await _initDatabase();
    return _database;
  }

  Future<void> deleteLocalDatabase() async {
    final Database? db = await database;
    var databasesPath = await getDatabasesPath();
    var path = join(databasesPath, _databaseName);
    await db!.close();
    _database = null;
    await deleteDatabase(path);
  }

  Future<void> insert(String table, object) async {
    Database? db = await database;
    db!.insert(table, object.toMap(), conflictAlgorithm: ConflictAlgorithm.rollback);
  }

  Future<int> update(String table, object) async {
    Database? db = await database;
    return await db!.update(table, object.toMap(), where: 'id = ?', whereArgs: [object.id]);
  }

  Future<int> delete(String table, String id) async {
    Database? db = await database;
    return await db!.delete(table, where: 'id = ?', whereArgs: [id]);
  }

  Future<dynamic> selectByColumn(String table, String column, String where) async {
    Database? db = await database;
    List<Map<String, Object?>> maps = await db!.query(table, where: '$column = ?', whereArgs: [where]);
    if (maps.isNotEmpty) {
      switch (table) {
        case tableUser:
          return User.fromMap(maps.first);
        case tableItem:
          return Item.fromMap(maps.first);
      }
    }
    return null;
  }

  Future<List<dynamic>> retrieveAll(String table) async {
    Database? db = await database;
    final List<Map<String, Object?>> queryResult = await db!.query(table);
    return queryResult.map((e) {
      switch (table) {
        case tableUser:
          return User.fromMap(e);
        case tableItem:
          return Item.fromMap(e);
      }
    }).toList();
  }
}
