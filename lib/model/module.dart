import 'package:MyStudyBuddy2/dialogs/module_options_dialog.dart';
import 'package:MyStudyBuddy2/singleton/module_controller.dart';
import 'package:MyStudyBuddy2/singleton/profile_controller.dart';
import 'package:flutter/material.dart';
import 'dart:async';

import 'package:http/http.dart' as http;
import 'package:html/parser.dart' show parse;
import 'package:html/dom.dart' as dom;

import '../local_database/local_database.dart';
import '../singleton/module_controller.dart';

class ModuleProperties {
  int id;
  String code;
  String title;
  double grade;
  bool isDone;
  bool isSelected;
  String qsp;
  int cp;
  int semester;

  ModuleProperties(this.id, this.code, this.title, this.grade, this.isDone,
      this.isSelected, this.qsp, this.cp, this.semester);
}

class Module extends StatefulWidget {
  final ModuleProperties properties;
  Module(this.properties);

  factory Module.fromMap(Map<String, dynamic> map) {
    bool _isDone;
    bool _isSelected;
    if (map["isDone"] == 0 || map["isDone"] == false) {
      _isDone = false;
    } else {
      _isDone = true;
    }
    if (map["isSelected"] == 0 || map["isSelected"] == false) {
      _isSelected = false;
    } else {
      _isSelected = true;
    }
    return Module(ModuleProperties(
        map["id"],
        map["code"],
        map["title"],
        map["grade"],
        _isDone,
        _isSelected,
        map["qsp"],
        map["cp"],
        map["semester"]));
  }

  Map<String, dynamic> toMap() => {
        "id": properties.id,
        "code": properties.code,
        "title": properties.title,
        "grade": properties.grade,
        "isDone": properties.isDone,
        "isSelected": properties.isSelected,
        "qsp": properties.qsp,
        "cp": properties.cp,
        "semester": properties.semester,
      };

  //setter
  void setGrade(double newGrade) {
    properties.grade = newGrade;
  }

  void setIsDone(bool _isDone) {
    properties.isDone = _isDone;
  }

  void setIsSelected(bool _isSelected) {
    properties.isSelected = _isSelected;
  }

  @override
  State<StatefulWidget> createState() => ModuleState();
}

class ModuleState extends State<Module> {
  @override
  Widget build(BuildContext context) {
    return module();
  }

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
          onPressed: () async {
            if (widget.properties.code == "QSP") {
              ModuleController().addReplacedQSPModule(widget);
              await DBProvider.db.deleteModule(widget.properties.id);
              Navigator.of(context).pushNamed("/modulSelectionQSP");
            } else if (widget.properties.code == "WPF") {
              ModuleController().addReplacedWPFModule(widget);
              await DBProvider.db.deleteModule(widget.properties.id);
              Navigator.of(context).pushNamed("/modulSelectionWPF");
            } else {
              return showDialog(
                context: context,
                child: ModuleOptionsDialog(widget),
              ).whenComplete(() {
                setState(() {
                  if (ModuleController().key == null) {
                    print("Key was null");
                  } else {
                    State<StatefulWidget> state =
                        ModuleController().key.currentState;
                    if (state != null) {
                      state.setState(() {
                        if (widget.properties.isDone) {
                          ProfileController().addEarnedCP(widget.properties.cp);
                        }
                      });
                    }
                  }
                });
              });
            }
          },
          child: Column(
            children: <Widget>[
              (widget.properties.grade != null && widget.properties.grade != 0)
                  ? Expanded(
                      flex: 3,
                      child: Padding(
                        padding: EdgeInsets.only(top: 24),
                        child: Align(
                            alignment: Alignment.center,
                            child: FittedBox(
                              fit: BoxFit.contain,
                              child: Text(widget.properties.code,
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
                              child: Text(widget.properties.code,
                                  style: TextStyle(
                                      fontSize: 16, color: Colors.white)),
                            )),
                      ),
                    ),
              (widget.properties.grade != null && widget.properties.grade != 0)
                  ? Expanded(
                      child: Padding(
                        padding: EdgeInsets.only(bottom: 8),
                        child: Align(
                            alignment: Alignment.bottomLeft,
                            child: FittedBox(
                              fit: BoxFit.contain,
                              child: Text(widget.properties.grade.toString(),
                                  style: (widget.properties.grade < 5.0)
                                      ? TextStyle(
                                          fontSize: 10,
                                          color: Colors.lightGreen)
                                      : TextStyle(
                                          fontSize: 10,
                                          color: Colors.red)),
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
        degreeMap.add({
          "title": link.attributes["title"],
          "href": link.attributes["href"]
        });
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
        if (trimmedGradeLines[0] == "1") {
          trimmedGradeLines.removeRange(0, 9);
          continue;
        }
        List<Module> allModuleList = ModuleController().getAllModules();
        int index = allModuleList.indexWhere((module) =>
            module.properties.id == int.tryParse(trimmedGradeLines[0]));
        double _grade =
            double.tryParse(trimmedGradeLines[3].replaceAll(',', '.'));
        bool _passed;
        bool _selected;

        if (index == -1) {
          index = ModuleController().getAllModules().indexWhere((module) =>
              module.properties.title.contains(trimmedGradeLines[1]));
        }
        if (_grade == null) {
          _grade = 0.0;
          _selected = false;
          _passed = false;
        } else if (_grade >= 1.0 && _grade <= 4.0) {
          _passed = true;
          _selected = false;
        } else {
          _grade = 5.0;
          _selected = true;
          _passed = false;
        }

        ModuleProperties _properties = new ModuleProperties(
            ModuleController().getAllModules()[index].properties.id,
            ModuleController().getAllModules()[index].properties.code,
            ModuleController().getAllModules()[index].properties.title,
            _grade,
            _passed,
            _selected,
            ModuleController().getAllModules()[index].properties.qsp,
            ModuleController().getAllModules()[index].properties.cp,
            ModuleController().getAllModules()[index].properties.semester);

        Module result = Module(_properties);

        ModuleController().addToAllModules(result);

        trimmedGradeLines.removeRange(0, 9);
      }
      return 0;
    } catch (err) {
      print(err);
      return 9;
    }
  }

  String _choseLink(
      http.Response response, String querySelector, String string) {
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
}
