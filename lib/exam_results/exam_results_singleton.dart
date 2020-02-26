import 'dart:io';
import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart';
import 'package:html/parser.dart' show parse;
import 'package:html/dom.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import 'package:MyStudyBuddy2/exam_results/exam_result.dart';

class ExamResults {
  // Singleton
  static final ExamResults _singleton = new ExamResults._internal();

  // External Contructor
  factory ExamResults() => _singleton;

  // Internal Constructor
  ExamResults._internal() {
    this.results = List<ExamResult>();
    _createDatabase();
    _getData();
  }

  // Variables
  List<ExamResult> results;
  String userName = "inf2795";
  String userPassword = "Oggersheim97";
  Future<Database> database;

  // Methods
  void _createDatabase() async {
      database = openDatabase(
        join(await getDatabasesPath(), 'exam_results_database.db'),
        onCreate: (db, version) {
          return db.execute(
              "CREATE TABLE examResults(examNumber INTEGER PRIMARY KEY, examName TEXT, term TEXT, grade REAL, passed TEXT, credits REAL, note TEXT, numberOfTries INTEGER, date TEXT)",);
        },
        version: 1,
      );
  }

  void _getData() async {
    try {
      final result = await InternetAddress.lookup('lsf.hs-worms.de');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        // connected
        _fetchDataFromLSFServer();
      }
    } on SocketException {
      // not connected
    }
  }

  void _fetchDataFromLSFServer() async {
    // TODO: Implement and call LSF login screen

    Response postResponse;
    var client = Client();

    try {
      postResponse = await client.post(
          'https://lsf.hs-worms.de/qisserver/rds?state=user&type=1&category=auth.login&startpage=portal.vm&breadCrumbSource=portal&asdf=$userName&fdsa=$userPassword');
    } on SocketException catch (err) {
      if (err.message.contains("Failed host lookup")) {
        print("SocketException: No internet connction");
        throw SocketException("No internet connection");
      } else if (err.osError.message.contains("timed out")) {
        print("OSError: Connection to " + err.address.host + " timed out");
        throw TimeoutException(
            "Connection to " + err.address.host + " timed out");
      } else {
        print(err);
        rethrow;
      }
    }
    try {
      if (!postResponse.headers.keys.first.contains('location')) {
        print(postResponse.headers.keys.first);
        throw Exception("Invalid login data");
      }
      final homeScreenResponse =
          await client.get(postResponse.headers.values.first);
      final examAdministrationResponse = await client.get(_choseLink(
          homeScreenResponse, "li > a.auflistung", "Prüfungsverwaltung"));
      final examExtractResponse = await client.get(_choseLink(
          examAdministrationResponse, "li > a.auflistung", "Notenspiegel"));
      final degreeResponse = await client.get(_choseLink(examExtractResponse,
          "li > a.regular", "Abschluss 05 Bachelor of Science"));

      var degreeDocument = parse(degreeResponse.body);
      List<Element> degreeLinks =
          degreeDocument.querySelectorAll("li.treelist > a");

      List<Map<String, dynamic>> degreeMap = [];
      for (var link in degreeLinks) {
        degreeMap.add({
          "title": link.attributes["title"],
          "href": link.attributes["href"]
        });
      }

      Map<String, dynamic> chosenLinkMap = degreeMap[degreeMap.indexWhere(
          (link) => link.containsValue(
              "Leistungen für Angewandte Informatik  (PO-Version 2018)  anzeigen"))];
      Response gradesResponse = await client.get(chosenLinkMap["href"]);
      var gradesDocument = parse(gradesResponse.body);

      List<Element> gradeLines =
          gradesDocument.querySelectorAll('td[class*="tabelle1"]');
      var trimmedGradeLines = List<String>();

      for (var line in gradeLines) {
        trimmedGradeLines.add(line.innerHtml.trim());
      }

      for (var i = 0; i < gradeLines.length / 9; i++) {
        if (trimmedGradeLines[8].isNotEmpty) {
          trimmedGradeLines[8] = trimmedGradeLines[8].substring(6, 10) +
              trimmedGradeLines[8].substring(3, 5) +
              trimmedGradeLines[8].substring(0, 2);
        }

        ExamResult result = ExamResult(
            int.tryParse(trimmedGradeLines[0]),
            trimmedGradeLines[1],
            trimmedGradeLines[2],
            double.tryParse(trimmedGradeLines[3].replaceAll(',', '.')),
            trimmedGradeLines[4],
            double.tryParse(trimmedGradeLines[5].replaceAll(',', '.')),
            trimmedGradeLines[6],
            int.tryParse(trimmedGradeLines[7]),
            trimmedGradeLines[8]);
        results.add(result);
        trimmedGradeLines.removeRange(0, 9);
      }

      for (var exam in results) {
        await insertExamResultToDatabase(exam);
      }

      final resultsFromDatabase = await getExamResultsFromDatabase();

      for (var result in resultsFromDatabase) {
        print(result.toString());
      }

    } catch (err) {
      print(err);
      rethrow;
    }
  }

  Future<void> insertExamResultToDatabase(ExamResult examResult) async {
    final Database db = await database;

    await db.insert('examResults', examResult.toMap(), conflictAlgorithm: ConflictAlgorithm.replace,);
  }

  Future<List<ExamResult>> getExamResultsFromDatabase() async {
    final Database db = await database;

    final List<Map<String, dynamic>> maps = await db.query('examResults');

    return List.generate(maps.length, (i) {
      return ExamResult(
        maps[i]['examNumber'],
        maps[i]['examName'],
        maps[i]['term'],
        maps[i]['grade'],
        maps[i]['passed'],
        maps[i]['credits'],
        maps[i]['note'],
        maps[i]['numberOfTries'],
        maps[i]['date']
      );
    });
  }

  String _choseLink(Response response, String querySelector, String string) {
    var document = parse(response.body);

    List<Element> links = document.querySelectorAll(querySelector);

    List<Map<String, dynamic>> linkMap = _createList(links);

    Map<String, dynamic> linkChosenMap =
        linkMap[linkMap.indexWhere((link) => link.containsValue(string))];
    return linkChosenMap["href"];
  }

  List<Map<String, dynamic>> _createList(List<Element> links) {
    List<Map<String, dynamic>> linkMap = [];
    for (var link in links) {
      linkMap.add({
        'title': link.text,
        'href': link.attributes['href'],
      });
    }
    return linkMap;
  }
}