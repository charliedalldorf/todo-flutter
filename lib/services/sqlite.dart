import 'package:flutter/foundation.dart';
import 'package:sqflite/sqflite.dart' as sql;

class SQLite {
  static Future<void> createTable(sql.Database database) async {
    await database.execute("""CREATE TABLE events(
        id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
        name TEXT,
        description TEXT
      )
      """);
  }

  static Future<sql.Database> db() async {
    return sql.openDatabase('antelopes', version: 1,
        onCreate: (sql.Database database, int version) async {
      await createTable(database);
    });
  }

  // Get all Events
  static Future<List<Map<String, dynamic>>> getItems() async {
    final db = await SQLite.db();
    return db.query('events', orderBy: 'id');
  }

  // Create new Event
  static Future<int> createEvent(String name, String description) async {
    final db = await SQLite.db();

    final data = {'name': name, 'description': description};
    final id = await db.insert('events', data,
        conflictAlgorithm: sql.ConflictAlgorithm.replace);
    return id;
  }

  // Delete an Event
  static Future<void> deleteEvent(int id) async {
    final db = await SQLite.db();
    try {
      await db.delete('events', where: 'id = ?', whereArgs: [id]);
    } catch (err) {
      debugPrint("Could not delete item: $err");
    }
  }
}
