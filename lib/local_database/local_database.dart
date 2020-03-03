import 'dart:async';
import 'dart:io';

import 'package:MyStudyBuddy2/singleton/module_controller.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

import 'package:MyStudyBuddy2/model/module.dart';

class DBProvider {
  DBProvider._();
  static final DBProvider db = DBProvider._();

  static Database _database;

  Future<Database> get database async {
    if (_database != null) {
      return _database;
    }

    _database = await initDB();
    return _database;
  }

  initDB() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, "MSBDB.db");
    try {
      return await openDatabase(path, version: 1, onOpen: (db) {},
          onCreate: (Database db, int version) async {
        await db.execute('''CREATE TABLE Modules (
        id INTEGER PRIMARY KEY,
        code TEXT,
        title TEXT,
        grade REAL,
        isDone INTEGER,
        isSelected INTEGER,
        qsp TEXT,
        cp REAL,
        semester INTEGER)
      ''');
      });
    } catch (err) {
      print(err);
    }
  }

  // CREATE

  createModule(Module newModule) async {
    final Database db = await database;
    try {
      int result = await db.insert("Modules", newModule.toMap(),
          conflictAlgorithm: ConflictAlgorithm.replace);
      return result;
    } catch (err) {
      print(err);
    }
  }

  // READ

  Future<Module> readModule(int id) async {
    final Database db = await database;
    List<Map<String, dynamic>> result;

    try {
      result =
          await db.query("Modules", where: "id = ?", whereArgs: [id]);
    } catch (err) {
      print(err);
    }
    return result.isNotEmpty ? Module.fromMap(result.first) : null;
  }

  Future<void> readAllModules() async {
    final Database db = await database;

    List<Map<String, dynamic>> result = await db.query('Modules');
    List<Map<String, dynamic>> resultList = new List<Map<String, dynamic>>();

    try {
      //Check if db is empty
      if (result.isNotEmpty) {
        resultList = result.toList();
      } else {
        return null;
      }

      ModuleController().resetAllModules();

      for (Map<String, dynamic> map in resultList) {
        ModuleController().addToAllModules(Module.fromMap(map));
      }
    } catch (err) {
      print(err);
    }
  }

  // UPDATE

  updateModule(Module newModule) async {
    final Database db = await database;
    try {
      int result = await db.update("Modules", newModule.toMap(),
          where: "id = ?", whereArgs: [newModule.id]);
      return result;
    } catch (err) {
      print(err);
    }
  }

  updateGradeManually(Module module) async {
    var databaseConnection = await database;
    String query =
        'UPDATE Exams SET grade=\'${module.getGrade()}\' WHERE id=\'${module.id}\'';

    await databaseConnection.transaction((transaction) async {
      return await transaction.rawQuery(query);
    });
  }

  // DELETE

  deleteModule(int id) async {
    final Database db = await database;
    try {
      db.delete("Modules", where: "id = ?", whereArgs: [id]);
    } catch (err) {
      print(err);
    }
  }

  deleteAllModules() async {
    final Database db = await database;
    try {
      db.rawDelete("Delete * from Module");
    } catch (err) {
      print(err);
    }
  }

  Future<bool> modulesAvailable() async {
    final Database db = await database;
    List<Map<String, dynamic>> result;
    try {
      result = await db.query('Modules');
    } catch (err) {
      print(err);
    }
      return result.isNotEmpty;
  }
}
