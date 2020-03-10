import 'dart:async';
import 'dart:io';
import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

import 'package:MyStudyBuddy2/model/module.dart';
import 'package:MyStudyBuddy2/singleton/module_controller.dart';

class DBProvider {
  DBProvider._();
  static final DBProvider db = DBProvider._();

  static Database _database;

  Future<Database> get database async {
    return _database;
  }

  initDB() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, "MSBDB.db");
    try {
      _database = await openDatabase(
        path,
        version: 1,
        onOpen: (db) {},
        onCreate: (Database db, int version) async {
          await db.execute('''CREATE TABLE Modules (
        id INTEGER PRIMARY KEY,
        code TEXT,
        title TEXT,
        grade REAL,
        isDone INTEGER,
        isSelected INTEGER,
        qsp TEXT,
        cp INTEGER,
        semester INTEGER)
      ''');
          try {
            String contents =
                await rootBundle.loadString("assets/modules.json");
            List<dynamic> json = jsonDecode(contents);

            for (var moduleMap in json) {
              db.insert("Modules", Module.fromMap(moduleMap).toMap());
            }
          } catch (err) {
            print(err);
          }
        },
      );
    } catch (err) {
      print(err);
    }
    ModuleController().setModulesFromDatabase();
  }

  // CREATE

  Future<void> createModule(Module newModule) async {
    final Database db = await database;
    try {
      await db.insert("Modules", newModule.toMap(),
          conflictAlgorithm: ConflictAlgorithm.replace);
    } catch (err) {
      print(err);
    }
  }

  // READ

  Future<Module> readModule(int id) async {
    final Database db = await database;
    List<Map<String, dynamic>> maps;

    try {
      maps = await db.query("Modules", where: "id = ?", whereArgs: [id]);
    } catch (err) {
      print(err);
    }
    return Module.fromMap(maps[0]);
  }

  Future<List<Module>> readAllModules() async {
    final Database db = await database;
    List<Map<String, dynamic>> maps;

    try {
      maps = await db.query('Modules');
    } catch (err) {
      print(err);
    }

    return List.generate(maps.length, (i) {
      return Module.fromMap(maps[i]);
    });
  }

  Future<List<Module>> readSelectedModules() async {
    final Database db = await database;
    List<Map<String, dynamic>> maps;

    try {
      maps = await db.query("Modules", where: "isSelected = ?", whereArgs: [1]);
    } catch (err) {
      print(err);
    }

    return List.generate(maps.length, (i) {
      return Module.fromMap(maps[i]);
    });
  }

  // UPDATE

  Future<void> updateModule(Module newModule) async {
    final Database db = await database;

    try {
      await db.update(
        "Modules",
        newModule.toMap(),
        where: "id = ?",
        whereArgs: [newModule.properties.id],
      );
    } catch (err) {
      print(err);
    }
  }

  // DELETE

  Future<void> deleteModule(int id) async {
    final Database db = await database;
    try {
      await db.delete(
        "Modules",
        where: "id = ?",
        whereArgs: [id],
      );
    } catch (err) {
      print(err);
    }
  }

  deleteAllModules() async {
    final Database db = await database;
    try {
      await db.delete("Modules");
    } catch (err) {
      print(err);
    }
  }

  Future<bool> modulesAvailable() async {
    final Database db = await database;
    List<Map<String, dynamic>> maps;

    try {
      maps = await db.query('Modules');
    } catch (err) {
      print(err);
    }
    return maps.isNotEmpty;
  }
}
