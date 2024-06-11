import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart' as sql;
import 'package:path/path.dart';

class DBHelper {
  static Future<void> createTables(sql.Database database) async {
    await database.execute("""CREATE TABLE tblTimbanganDigital(
        id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
        date TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
        weight TEXT
      )
      """);
  }

  static Future<sql.Database> db() async {
    return await sql.openDatabase(
      join(await sql.getDatabasesPath(), 'timbanganDigital.db'),
      version: 1,
      onCreate: (sql.Database database, int version) async {
        await createTables(database);
      },
    );
  }

  static Future<int> createItem(String? weight) async {
    final db = await DBHelper.db();

    final data = {'weight': weight};
    final id = await db.insert('tblTimbanganDigital', data,
        conflictAlgorithm: sql.ConflictAlgorithm.replace);
    return id;
  }

  static Future<List<Map<String, dynamic>>> getItems() async {
    final db = await DBHelper.db();
    return db.query('tblTimbanganDigital', orderBy: "id");
  }

  // static Future<int> updateItem(
  //     int id, String title, String? descrption) async {
  //   final db = await DBHelper.db();

  //   final data = {
  //     'title': title,
  //     'description': descrption,
  //     'createdAt': DateTime.now().toString()
  //   };

  //   final result =
  //       await db.update('items', data, where: "id = ?", whereArgs: [id]);
  //   return result;
  // }

  static Future<void> deleteItem(int id) async {
    final db = await DBHelper.db();
    try {
      await db.delete("tblTimbanganDigital", where: "id = ?", whereArgs: [id]);
    } catch (err) {
      debugPrint("Something went wrong when deleting an item: $err");
    }
  }

  static Future<void> deleteAll() async {
    final db = await DBHelper.db();
    try {
      await db.delete("tblTimbanganDigital");
    } catch (err) {
      debugPrint("Something went wrong when deleting an item: $err");
    }
  }
}
