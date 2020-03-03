import 'package:MyStudyBuddy2/exam_results/add_grade.dart';
import 'package:MyStudyBuddy2/model/module_informations.dart';
import 'package:MyStudyBuddy2/singleton/module_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter/services.dart';
import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:html/parser.dart' show parse;
import 'package:html/dom.dart' as dom;

import '../singleton/module_controller.dart';

class Module {
  int id;
  String code;
  String title;
  double grade;
  bool isDone;
  bool isSelected;
  String qsp;
  int cp;
  int semester;

  Module(this.id, this.code, this.title, this.grade, this.isDone,
      this.isSelected, this.qsp, this.cp, this.semester);

  factory Module.fromMap(Map<String, dynamic> map) {
    if (map["isDone"] == 0 || map["isDone"] == false) {
      map["isDone"] = false;
    } else {
      map["isDone"] = true;
    }
    if (map["isSelected"] == 0 || map["isSelected"] == false) {
      map["isSelected"] = false;
    } else {
      map["isSelected"] = true;
    }
    return Module(
        map["id"],
        map["code"],
        map["title"],
        map["grade"],
        map["isDone"],
        map["isSelected"],
        map["qsp"],
        map["cp"],
        map["semester"]);
  }

  Map<String, dynamic> toMap() => {
        "id": id,
        "code": code,
        "title": title,
        "grade": grade,
        "isDone": isDone,
        "isSelected": isSelected,
        "qsp": qsp,
        "cp": cp,
        "semester": semester,
      };

  String toString() => '''
  id: $id
  code: $title
  title: $title
  grade: $grade
  isDone: $isDone
  isSelected: $isSelected
  qsp: $qsp
  cp: $cp
  semester: $semester
  ''';

  Widget module() {
    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: Container(
        height: 80,
        width: 80,
        child: RaisedButton(
          shape: RoundedRectangleBorder(
            borderRadius: new BorderRadius.circular(15.0),
          ),
          color: Color(0xFF013D62),
          splashColor: Colors.orange,
          onPressed: () {
            if (title == "6. M") {
              Get.toNamed("/modulSelectionQSP");
            } else if (title == "7. M") {
              Get.toNamed("/modulSelectionWPF");
            } else {
              if (isSelected) {
                Get.dialog(AlertDialog(
                  contentPadding: EdgeInsets.fromLTRB(8, 8, 8, 8),
                  content: SingleChildScrollView(
                    child: ListBody(children: <Widget>[
                      Text(
                        this.title,
                        style: TextStyle(fontSize: 25),
                      ),
                      FlatButton(
                          child: Text("Modul Informationen"),
                          onPressed: () {
                            moduleInforations(this);
                          }),
                      FlatButton(
                        child: Text("Note Eintragen"),
                        onPressed: () {
                          addGrade(this);
                        },
                      ),
                      FlatButton(
                        child: Text("Modul abwählen"),
                        onPressed: () {
                          ModuleController().setModuleSelected(this, false);
                          Get.back();
                        },
                      ),
                    ]),
                  ),
                ));
              } else {
                Get.dialog(
                  AlertDialog(
                    contentPadding: EdgeInsets.fromLTRB(8, 8, 8, 8),
                    content: SingleChildScrollView(
                      child: ListBody(
                        children: <Widget>[
                          Text(
                            this.title,
                            style: TextStyle(fontSize: 25),
                          ),
                          FlatButton(
                              child: Text("Modul Informationen"),
                              onPressed: () {
                                moduleInforations(this);
                              }),
                          FlatButton(
                              child: Text("Note Eintragen"),
                              onPressed: () {
                                addGrade(this);
                              }),
                          FlatButton(
                            child: Text("Modul Wählen"),
                            onPressed: () {
                              ModuleController().setModuleSelected(this, true);
                              Get.back();
                            },
                          )
                        ],
                      ),
                    ),
                  ),
                );
              }
            }
          },
          child: Column(
            children: <Widget>[
              grade != null
                  ? Expanded(
                      flex: 3,
                      child: Padding(
                        padding: EdgeInsets.only(top: 24),
                        child: Align(
                            alignment: Alignment.center,
                            child: FittedBox(
                              fit: BoxFit.contain,
                              child: Text(code,
                                  style: TextStyle(
                                      fontSize: 16, color: Colors.white)),
                            )),
                      ),
                    )
                  : Expanded(
                      flex: 3,
                      child: Padding(
                        padding: EdgeInsets.only(top: 4),
                        child: Align(
                            alignment: Alignment.center,
                            child: FittedBox(
                              fit: BoxFit.contain,
                              child: Text(code,
                                  style: TextStyle(
                                      fontSize: 16, color: Colors.white)),
                            )),
                      ),
                    ),
              grade != null
                  ? Expanded(
                      child: Padding(
                        padding: EdgeInsets.only(bottom: 8),
                        child: Align(
                            alignment: Alignment.bottomLeft,
                            child: FittedBox(
                              fit: BoxFit.contain,
                              child: Text(grade.toString(),
                                  style: TextStyle(
                                      fontSize: 10, color: Colors.white)),
                            )),
                      ),
                    )
                  : Container(),
            ],
          ),
        ),
      ),
    );
  }

  //getter
  double getGrade() => grade;

  bool getIsDone() => isDone;

  bool getIsSelected() => isSelected;

  //setter
  void setGrade(double newGrade) {
    grade = newGrade;
  }

  void setIsDone(bool _isDone) {
    isDone = _isDone;
  }

  void setIsSelected(bool _isSelected) {
    isSelected = _isSelected;
  }
}

Future<void> getModulesFromFile() async {
  String contents = await rootBundle.loadString("assets/modules.json");
  ModuleController mc = ModuleController();

  List<dynamic> json = jsonDecode(contents);
  for (var moduleMap in json) {
    mc.addToAllModules(Module.fromMap(moduleMap));
  }
}

Future<int> getExamResultsFromLSFServer(
    String userName, String userPassword) async {
  http.Response postResponse;
  http.Client client = http.Client();

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
    List<dom.Element> degreeLinks =
        degreeDocument.querySelectorAll("li.treelist > a");

    List<Map<String, dynamic>> degreeMap = [];
    for (var link in degreeLinks) {
      degreeMap.add(
          {"title": link.attributes["title"], "href": link.attributes["href"]});
    }

    Map<String, dynamic> chosenLinkMap = degreeMap[degreeMap.indexWhere(
        (link) => link.containsValue(
            "Leistungen für Angewandte Informatik  (PO-Version 2018)  anzeigen"))];
    http.Response gradesResponse = await client.get(chosenLinkMap["href"]);
    var gradesDocument = parse(gradesResponse.body);

    List<dom.Element> gradeLines =
        gradesDocument.querySelectorAll('td[class*="tabelle1"]');
    var trimmedGradeLines = List<String>();

    for (var line in gradeLines) {
      trimmedGradeLines.add(line.innerHtml.trim());
    }

    for (var i = 0; i < gradeLines.length / 9; i++) {
      ModuleController mc = ModuleController();
      int index = mc.getAllModules().indexWhere(
          (module) => module.id == int.tryParse(trimmedGradeLines[0]));
      double _grade =
          double.tryParse(trimmedGradeLines[3].replaceAll(',', '.'));
      bool _passed;

      if (index == -1) {
        index = mc.getAllModules().indexWhere(
            (module) => module.title.contains(trimmedGradeLines[1]));
      }

      if (_grade >= 1.0 && _grade <= 4.0) {
        _passed = true;
      } else {
        _passed = false;
      }

      Module result = Module(
          mc.getAllModules()[index].id,
          mc.getAllModules()[index].code,
          mc.getAllModules()[index].title,
          _grade,
          _passed,
          mc.getAllModules()[index].isSelected,
          mc.getAllModules()[index].qsp,
          mc.getAllModules()[index].cp,
          mc.getAllModules()[index].semester);

      mc.addToAllModules(result);

      trimmedGradeLines.removeRange(0, 9);
    }
    return 0;
  } catch (err) {
    print(err);
    return 9;
  }
}

String _choseLink(http.Response response, String querySelector, String string) {
  var document = parse(response.body);

  List<dom.Element> links = document.querySelectorAll(querySelector);

  List<Map<String, dynamic>> linkMap = _createList(links);

  Map<String, dynamic> linkChosenMap =
      linkMap[linkMap.indexWhere((link) => link.containsValue(string))];
  return linkChosenMap["href"];
}

List<Map<String, dynamic>> _createList(List<dom.Element> links) {
  List<Map<String, dynamic>> linkMap = [];
  for (var link in links) {
    linkMap.add({
      'title': link.text,
      'href': link.attributes['href'],
    });
  }
  return linkMap;
}
