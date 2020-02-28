import 'dart:async';
import 'dart:io';

import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

import 'package:MyStudyBuddy2/exam_results/exam_result.dart';
import 'package:MyStudyBuddy2/modules/module.dart';

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
    return await openDatabase(path, version: 1, onOpen: (db) {},
        onCreate: (Database db, int version) async {
      await db.execute('''CREATE TABLE Exams (
        number INTEGER PRIMARY KEY,
        name TEXT,
        term TEXT,
        grade REAL,
        passed TEXT,
        credits REAL,
        note TEXT,
        numberOfTries INTEGER,
        date TEXT)
      ''');
      await db.execute('''
      CREATE TABLE Modules (
        number INTEGER PRIMARY KEY,
        name TEXT
      )
      ''');
    });
  }

  // CREATE

  newModule(Module newModule) async {
    final db = await database;
    var result = await db.insert("Modules", newModule.toMap(), conflictAlgorithm: ConflictAlgorithm.replace);
    return result;
  }

  newExamResult(ExamResult newExamResult) async {
    final db = await database;
    var result = await db.insert("Exams", newExamResult.toMap(), conflictAlgorithm: ConflictAlgorithm.replace);
    return result;
  }

  // READ

  getModule(int number) async {
    final db = await database;
    var result = await db.query("Modules", where: "number = ?", whereArgs: [number]);
    return result.isNotEmpty ? Module.fromMap(result.first) : null;
  }

  getExamResult(int number) async {
    final db = await database;
    var result = await db.query("Exams", where: "number = ?", whereArgs: [number]);
    return result.isNotEmpty ? ExamResult.fromMap(result.first) : null;
  }

  getAllModules() async {
    final db = await database;
    var result = await db.query('Modules');
    List<Map<String, dynamic>> resultList = result.isNotEmpty ? result.toList(): null;
    var list = List<Module>();
    if (resultList == null) {
      return null;
    }
    for (var map in resultList) {
      list.add(Module.fromMap(map));
    }
    return list;
  }

  getAllExamResults() async {
    final db = await database;
    var result = await db.query('Exams');
    List<Map<String, dynamic>> resultList = result.isNotEmpty ? result.toList(): null;
    var list = List<ExamResult>();
    if (resultList == null) {
      return null;
    }
    for (var map in resultList) {
      list.add(ExamResult.fromMap(map));
    }
    return list;
  }

  // UPDATE

  updateModule(Module newModule) async {
    final db = await database;
    var result = await db.update("Modules", newModule.toMap(), where: "number = ?", whereArgs: [newModule.number]);
    return result;
  }

  updateExamResult(ExamResult newExamResult) async {
    final db = await database;
    var result = await db.update("Exams", newExamResult.toMap(), where: "number = ?", whereArgs: [newExamResult.number]);
    return result;
  }

  // DELETE

  deleteModule(int number) async {
    final db = await database;
    db.delete("Modules", where: "number = ?", whereArgs: [number]);
  }

  deleteAllModules() async {
    final db = await database;
    db.rawDelete("Delete * from Module");
  }

  deleteExamResult(int number) async {
    final db = await database;
    db.delete("Exams", where: "number = ?", whereArgs: [number]);
  }

  deleteAllExamResults() async {
    final db = await database;
    db.rawDelete("Delete * from Exams");
  }
}
