import 'dart:io';
import 'dart:async';

import 'package:MyStudyBuddy2/local_database/local_database.dart';
import 'package:http/http.dart';
import 'package:html/parser.dart' show parse;
import 'package:html/dom.dart';

class ExamResult {
  int id;
  String title;
  String term;
  double grade;
  String passed;
  double credits;
  String note;
  int numberOfTries;
  String date;

  ExamResult(
      {this.id,
      this.title,
      this.term,
      this.grade,
      this.passed,
      this.credits,
      this.note,
      this.numberOfTries,
      this.date});

  factory ExamResult.fromMap(Map<String, dynamic> map) => new ExamResult(
        id: map["id"],
        title: map["title"],
        term: map["term"],
        grade: map["grade"],
        passed: map["passed"],
        credits: map["credits"],
        note: map["note"],
        numberOfTries: map["number_of_tries"],
        date: map["date"],
      );

  Map<String, dynamic> toMap() => {
        'id': id,
        'title': title,
        'term': term,
        'grade': grade,
        'passed': passed,
        'credits': credits,
        'note': note,
        'numberOfTries': numberOfTries,
        'date': date
      };

  String toString() => '''
    id: $id
    title: $title
    grade: $grade
    passed: $passed
    credits: $credits
    note: $note
    numberOfTries: $numberOfTries
    date: $date
    ''';
}

// 0 = success
// 1 = wrong login data
// 2 = no internet connection
// 3 = time out
// 9 = unknown error
Future<int> getExamResultsFromLSFServer(String userName, String userPassword) async {
  final DBProvider db = DBProvider.db;
  Response postResponse;
  Client client = Client();

  try {
    postResponse = await client.post(
        'https://lsf.hs-worms.de/qisserver/rds?state=user&type=1&category=auth.login&startpage=portal.vm&breadCrumbSource=portal&asdf=$userName&fdsa=$userPassword');
    
    if (!postResponse.headers.keys.first.contains('location')) {
      print(postResponse.headers.keys.first);
      return 1;
    }
  } catch (err) {
    if (err.message.contains("Failed host lookup")) {
      print("SocketException: No internet connction");
      return 2;
    } else if (err.osError.message.contains("timed out")) {
      print("OSError: Connection to " + err.address.host + " timed out");
      return 3;
    } else {
      print(err);
      return 9;
    }
  }


  try {
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
      degreeMap.add(
          {"title": link.attributes["title"], "href": link.attributes["href"]});
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
      ExamResult result = ExamResult(
          id: int.tryParse(trimmedGradeLines[0]),
          title: trimmedGradeLines[1],
          term: trimmedGradeLines[2],
          grade: double.tryParse(trimmedGradeLines[3].replaceAll(',', '.')),
          passed: trimmedGradeLines[4],
          credits: double.tryParse(trimmedGradeLines[5].replaceAll(',', '.')),
          note: trimmedGradeLines[6],
          numberOfTries: int.tryParse(trimmedGradeLines[7]),
          date: trimmedGradeLines[8]);
      db.newExamResult(result);
      trimmedGradeLines.removeRange(0, 9);
    }
    return 0;
  } catch (err) {
    print(err);
    return 9;
  }
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
