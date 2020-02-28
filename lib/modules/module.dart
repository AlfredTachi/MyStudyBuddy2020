import 'dart:async';

import 'package:flutter/services.dart';
import 'package:html/dom.dart';
import 'package:html/parser.dart';

import 'package:MyStudyBuddy2/local_database/local_database.dart';

class Module {
  int number;
  String name;

  Module({
    this.number,
    this.name,
  });

  factory Module.fromMap(Map<String, dynamic> map) => new Module(
    number: map["number"],
    name: map["name"],
      );

  Map<String, dynamic> toMap() => {
        "number": number,
        "name": name,
      };
  
  String toString() =>
    '''
    number: $number
    name: $name
    ''';
}

Future<void> getModulesFromFile() async {
  final db = DBProvider.db;
  var contents = await rootBundle.loadString("assets/modulhandbuch.html");

  var moduleHandbook = parse(contents);
  List<Element> modulesElementList = moduleHandbook.querySelectorAll("h4");
  List<Module> moduleList = List<Module>();
  for (var module in modulesElementList) {
    if (module.innerHtml.isEmpty) {
      continue;
    }
    final splitModule = module.innerHtml.split(":");
    final intRegex = RegExp(r'[^0-9]', multiLine: false);
    var moduleNumber = splitModule[0].replaceAll(intRegex, '');
    final modulesMap = Map<String, dynamic>();
    modulesMap["number"] = int.tryParse(moduleNumber);
    modulesMap["name"] = splitModule[1].trim();
    moduleList.add(Module.fromMap(modulesMap));
  }
  for (var module in moduleList) {
    db.newModule(module);
  }
}