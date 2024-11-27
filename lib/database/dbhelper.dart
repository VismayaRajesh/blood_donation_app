import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'model.dart';

class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper._internal();
  factory DatabaseHelper() => _instance;

  DatabaseHelper._internal();

  Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;
    // If _database is null, initialize it
    _database = await openDatabase(
      join(await getDatabasesPath(), "user.db"),
      version: 1,
      onCreate: (Database db, int version) {
        db.execute(""" 
          CREATE TABLE usertable(
            id INTEGER PRIMARY KEY AUTOINCREMENT, 
            name TEXT, 
            location TEXT, 
            bloodType TEXT, 
            phone TEXT
          )
        """);
      },
    );
    return _database!;
  }

  Future<int> insertUser(User user) async {
    final db = await database; // Ensure database is initialized
    return await db.insert("usertable", user.toMap());
  }

  Future<int> updateUser(User user) async {
    final db = await database; // Ensure database is initialized
    return await db.update("usertable", user.toMap(), where: 'id = ?', whereArgs: [user.id]);
  }

  Future<int> deleteUser(User user) async {
    final db = await database; // Ensure database is initialized
    return await db.delete("usertable", where: 'id = ?', whereArgs: [user.id]);
  }

  Future<List<User>?> getAll() async {
    final db = await database; // Ensure database is initialized
    List<Map<String, dynamic>> map = await db.query("usertable");
    return List.generate(map.length, (index) {
      return User(
        id: map[index]["id"],
        name: map[index]["name"],
        location: map[index]["location"],
        bloodType: map[index]["bloodType"],
        phone: map[index]["phone"]
      );
    });
  }
}