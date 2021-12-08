import 'package:flutter/material.dart';
import 'package:q4_todo_flutter/user.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'dart:async';

class DbHelper with ChangeNotifier {

  Future<Database> initDB() async {
    String path = await getDatabasesPath();
    return openDatabase(
      join(path, 'users.db'),
      onCreate: (database, version) async {
        await database.execute(
          "CREATE TABLE users(id INTEGER PRIMARY KEY AUTOINCREMENT, name TEXT NOT NULL,age INTEGER NOT NULL, email TEXT NOT NULL)",
        );
      },
      version: 1,
    );
  }

  Future<List<User>> getAllUser() async {
    Database db = await initDB();
    final List<Map<String, Object?>> queryResult = await db.query('users');
    return queryResult.map((e) => User.fromMap(e)).toList();
  }

  Future<void> deleteUser(int id) async {
    Database db = await initDB();
    await db.delete("users", where: "id = ?", whereArgs: [id]);
    notifyListeners();
  }

  Future insertUser(User user) async {
    final Database db = await initDB();
    await db.insert('users', user.toMap());
    notifyListeners();
  }
}
