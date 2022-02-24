import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import '../Model/user_data_model.dart';

class DatabaseHelper {
  static final DatabaseHelper _databaseHelper = DatabaseHelper._();

  DatabaseHelper._();

  late Database db;

  factory DatabaseHelper() {
    return _databaseHelper;
  }

  Future<void> initDB() async {
    String path = await getDatabasesPath();
    db = await openDatabase(
      join(path, 'users_demo.db'),
      onCreate: (database, version) async {
        await database.execute(
          """
            CREATE TABLE Post (
              id INTEGER PRIMARY KEY AUTOINCREMENT, 
              userId INTEGER NOT NULL,
              title TEXT,
              body TEXT
            )
          """,
        );
      },
      version: 1,
    );
  }

  // Insert employee on database
  createEmployee(UserDataModel newEmployee) async {
    final res = await db.insert('Post', newEmployee.toJson());
    return res;
  }

  // Delete all employees
  Future<int> deleteAllEmployees() async {
    final res = await db.rawDelete('DELETE FROM Post');

    return res;
  }

  Future<List<UserDataModel>> getAllEmployees() async {
    final res = await db.rawQuery("SELECT * FROM Post");

    List<UserDataModel> list = res.isNotEmpty
        ? res.map((c) => UserDataModel.fromJson(c)).toList()
        : [];

    return list;
  }

  Future<int> insert(UserDataModel newClient) async {
    var res = await db.insert("Post", newClient.toMap());
    return res;
  }

  Future<void> delete(int id) async {
    db.delete("Post", where: "id = ?", whereArgs: [id]);
  }
}
