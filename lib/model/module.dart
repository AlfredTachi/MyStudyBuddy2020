import 'package:MyStudyBuddy2/singleton/module_controller.dart';
import 'package:MyStudyBuddy2/local_database/local_database.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter/services.dart';
import 'package:html/dom.dart' as html;
import 'package:html/parser.dart';
import 'dart:async';

class Module {
  int id;
  String title;
  bool _isSelected = false;
  Module({
    this.id,
    this.title,
  });

  factory Module.fromMap(Map<String, dynamic> map) => Module(
    id: map["id"],
    title: map["title"],
  );

  Map<String, dynamic> toMap() => {
    "id" : id,
    "title" : title,
  };

  String toString() =>
  '''
  id: $id
  title: $title
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
              if (_isSelected) {
                Get.dialog(AlertDialog(
                    contentPadding: EdgeInsets.fromLTRB(8, 8, 8, 8),
                    content: SingleChildScrollView(
                        child: ListBody(children: <Widget>[
                      Text(
                        'Modulname',
                        style: TextStyle(fontSize: 25),
                      ),
                      FlatButton(
                          child: Text("Modul Informationen"), onPressed: () {}),
                      FlatButton(
                        child: Text("Note Eintragen"),
                        onPressed: () {},
                      ),
                      FlatButton(
                          child: Text("Modul Abwählen"),
                          onPressed: () {
                            ModuleController().removeModule(this);
                            _isSelected = false;
                            Get.back();
                          })
                    ]))));
              } else {
                Get.dialog(AlertDialog(
                    contentPadding: EdgeInsets.fromLTRB(8, 8, 8, 8),
                    content: SingleChildScrollView(
                      child: ListBody(
                        children: <Widget>[
                          Text(
                            'Modulname',
                            style: TextStyle(fontSize: 25),
                          ),
                          FlatButton(
                              child: Text("Modul Informationen"),
                              onPressed: () {}),
                          FlatButton(
                              child: Text("Note Eintragen"), onPressed: () {}),
                          FlatButton(
                              child: Text("Modul Wählen"),
                              onPressed: () {
                                ModuleController().addModule(this);
                                _isSelected = true;
                                Get.back();
                              })
                        ],
                      ),
                    )));
              }
            }
          },
          child: Center(
              child: Text(title,
                  style: TextStyle(fontSize: 20, color: Colors.white))),
        ),
      ),
    );
  }
}

Future<void> getModulesFromFile() async {
  final db = DBProvider.db;
  var contents = await rootBundle.loadString("assets/modulhandbuch.html");

  var moduleHandbook = parse(contents);
  List<html.Element> modulesElementList = moduleHandbook.querySelectorAll("h4");
  List<Module> moduleList = List<Module>();
  for (var module in modulesElementList) {
    if (module.innerHtml.isEmpty) {
      continue;
    }
    final splitModule = module.innerHtml.split(":");
    final intRegex = RegExp(r'[^0-9]', multiLine: false);
    var moduleNumber = splitModule[0].replaceAll(intRegex, '');
    final modulesMap = Map<String, dynamic>();
    modulesMap["id"] = int.tryParse(moduleNumber);
    modulesMap["title"] = splitModule[1].trim();
    moduleList.add(Module.fromMap(modulesMap));
  }
  for (var module in moduleList) {
    db.newModule(module);
  }
}