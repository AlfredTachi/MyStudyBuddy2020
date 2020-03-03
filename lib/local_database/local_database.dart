import 'dart:async';
import 'dart:io';

import 'package:MyStudyBuddy2/singleton/module_controller.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

import 'package:MyStudyBuddy2/exam_results/exam_result.dart';
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
        await db.execute('''CREATE TABLE Exams (
        id INTEGER PRIMARY KEY,
        title TEXT,
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
        id INTEGER PRIMARY KEY,
        title TEXT
      )
      ''');
      });
    } catch (err) {
      print(err);
      rethrow;
    }
  }

  // CREATE

  newModule(Module newModule) async {
    final db = await database;
    try {
      var result = await db.insert("Modules", newModule.toMap(),
          conflictAlgorithm: ConflictAlgorithm.replace);
      return result;
    } catch (err) {
      print(err);
      rethrow;
    }
  }

  newExamResult(ExamResult newExamResult) async {
    final db = await database;
    try {
      var result = await db.insert("Exams", newExamResult.toMap(),
          conflictAlgorithm: ConflictAlgorithm.replace);
      return result;
    } catch (err) {
      print(err);
      rethrow;
    }
  }

  // READ

  Future<Module> getModule(int id) async {
    final db = await database;
    try {
      var result = await db.query("Modules", where: "id = ?", whereArgs: [id]);
      return result.isNotEmpty ? Module.fromMap(result.first) : null;
    } catch (err) {
      print(err);
      rethrow;
    }
  }

  Future<ExamResult> getExamResult(int id) async {
    final db = await database;
    try {
      var result = await db.query("Exams", where: "id = ?", whereArgs: [id]);
      return result.isNotEmpty ? ExamResult.fromMap(result.first) : null;
    } catch (err) {
      print(err);
      rethrow;
    }
  }

  Future<void> getAllModules() async {
    final db = await database;

    List<Map<String, dynamic>> result = await db.query('Modules');
    List<Map<String, dynamic>> resultList = new List<Map<String, dynamic>>();
    List<Module> list = List<Module>();

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

    return list;
  }

  Future<List<ExamResult>> getAllExamResults() async {
    final db = await database;
    try {
      var result = await db.query('Exams');
      List<Map<String, dynamic>> resultList =
          result.isNotEmpty ? result.toList() : null;
      var list = List<ExamResult>();
      if (resultList == null) {
        return null;
      }
      for (var map in resultList) {
        list.add(ExamResult.fromMap(map));
      }
      return list;
    } catch (err) {
      print(err);
      rethrow;
    }
  }

  Future<List<double>> getAllExamGrades() async {
    final db = await database;
    try {
      var result = await db.query('Exams', columns: ["grade"]);
      var gradeQueryList = result.toList();
      if (gradeQueryList.isEmpty) {
        return null;
      }
      var gradeList = List<double>();
      for (var grade in gradeQueryList) {
        gradeList.add(grade.values.first);
      }
      return gradeList;
    } catch (err) {
      print(err);
      rethrow;
    }
  }

  // UPDATE

  updateModule(Module newModule) async {
    final db = await database;
    try {
      var result = await db.update("Modules", newModule.toMap(),
          where: "id = ?", whereArgs: [newModule.id]);
      return result;
    } catch (err) {
      print(err);
      rethrow;
    }
  }

  updateExamResult(ExamResult newExamResult) async {
    final db = await database;
    try {
      var result = await db.update("Exams", newExamResult.toMap(),
          where: "id = ?", whereArgs: [newExamResult.id]);
      return result;
    } catch (err) {
      print(err);
      rethrow;
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
    final db = await database;
    try {
      db.delete("Modules", where: "id = ?", whereArgs: [id]);
    } catch (err) {
      print(err);
      rethrow;
    }
  }

  deleteAllModules() async {
    final db = await database;
    try {
      db.rawDelete("Delete * from Module");
    } catch (err) {
      print(err);
      rethrow;
    }
  }

  deleteExamResult(int id) async {
    final db = await database;
    try {
      db.delete("Exams", where: "id = ?", whereArgs: [id]);
    } catch (err) {
      print(err);
      rethrow;
    }
  }

  deleteAllExamResults() async {
    final db = await database;
    try {
      db.rawDelete("Delete * from Exams");
    } catch (err) {
      print(err);
      rethrow;
    }
  }

  Future<bool> examsAvailable() async {
    final db = await database;
    try {
      var result = await db.query('Exams');
      return result.isNotEmpty;
    } catch (err) {
      print(err);
      rethrow;
    }
  }

  Future<bool> modulesAvailable() async {
    final db = await database;
    try {
      var result = await db.query('Modules');
      return result.isNotEmpty;
    } catch (err) {
      print(err);
      rethrow;
    }
  }
}
