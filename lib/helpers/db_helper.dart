import 'package:sqflite/sqflite.dart' as sql;
import 'package:path/path.dart' as path;

class DBHelper {
  static sql.Database _db;

  static Future<void> initDb() async {
    if (_db == null) {
      final dbPath = await sql.getDatabasesPath();

      _db = await sql.openDatabase(path.join(dbPath, 'places.db'),
          onCreate: (db, version) {
        return db.execute(
            'CREATE TABLE user_places(id TEXT PRIMARY KEY, title TEXT, image TEXT)');
      }, version: 1);
    }
  }

  static Future<int> insert(String table, Map<String, Object> data) async {
    await DBHelper.initDb();

    final int rowId = await _db.insert(table, data,
        conflictAlgorithm: sql.ConflictAlgorithm.replace);

    return rowId;
  }

  static Future<List<Map<String, dynamic>>> getData(String table) async {
    await DBHelper.initDb();

    print("Fetching data..");

    return _db.query(table);
  }
}
