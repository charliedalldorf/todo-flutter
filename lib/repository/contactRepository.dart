import 'dart:async';
import 'package:flutter/material.dart';
import 'package:todo/models/contact.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

void contactRepository() async {
  final database = openDatabase(join(await getDatabasesPath(), 'contacts.db'),
      onCreate: (db, version) {
    return db.execute(
        'CREATE TABLE contacts (id INTEGER PRIMARY KEY, name TEXT, phone TEXT)');
  }, version: 1);

  Future<void> insertContact(Contact contact) async {
    final db = await database;

    await db.insert('contacts', contact.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future<List<Contact>> getContacts() async {
    final db = await database;

    final List<Map<String, dynamic>> maps = await db.query('contacts');

    return List.generate(maps.length, (index) {
      return Contact(
          id: maps[index]['id'],
          name: maps[index]['name'],
          phone: maps[index]['phone']);
    });
  }
}
