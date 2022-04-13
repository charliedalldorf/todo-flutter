import 'package:flutter/foundation.dart';
import 'package:sqflite/sqflite.dart' as sql;

class SQLite {
  static Future<void> createTables(sql.Database database) async {
    String createProductsTable = """CREATE TABLE events(
        id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
        eventName TEXT,
        venueName TEXT,
        city TEXT,
        state TEXT,
        description TEXT,
        isActive INTEGER
      )""";

    String createContactsTable = """CREATE TABLE contacts(
        id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
        contactName TEXT,
        phoneNumber TEXT,
        companyName TEXT,
        notes TEXT
      )""";

    await database.execute(createProductsTable);
    await database.execute(createContactsTable);
  }

  static Future<sql.Database> db() async {
    return sql.openDatabase('antelopes', version: 1,
        onCreate: (sql.Database database, int version) async {
      await createTables(database);
    });
  }

  // Get all Events
  static Future<List<Map<String, dynamic>>> getItems() async {
    final db = await SQLite.db();
    return db.query('events', orderBy: 'id');
  }

  // Get Event by Id
  static Future<List<Map<String, dynamic>>> getItem(int id) async {
    final db = await SQLite.db();
    return db.query('events', where: "id = ?", whereArgs: [id], limit: 1);
  }

  // Create new Event
  static Future<int> createEvent(String name, String venue, String city,
      String state, String description, int isActive) async {
    final db = await SQLite.db();

    final data = {
      'eventName': name,
      'venueName': venue,
      'city': city,
      'state': state,
      'description': description,
      'isActive': isActive
    };
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
