import 'package:MyStudyBuddy2/local_database/local_database.dart';
import 'package:MyStudyBuddy2/model/module.dart';
import 'package:flutter/cupertino.dart';

import '../local_database/local_database.dart';
import '../model/module.dart';

class ModuleController {
  static final ModuleController _instance = ModuleController._internal();

  factory ModuleController() => _instance;

  ModuleController._internal();

  List<Module> _selectedModules = new List<Module>();
  Module _replacedModules;
  List<Module> _allModules;

  //Getter

  List<Module> getSelectedModules() => _selectedModules;
  List<Module> getAllModules() => _allModules;

  //Returns all selected Widgets
  List<Widget> getAllSelectedModulesWidgets() {
    List<Widget> _widgets = new List<Widget>();
    List<Module> _modules = new List<Module>();
    _modules = ModuleController()
        .getAllModules()
        .where((test) => test.isSelected == true)
        .toList();
    for (var i = 0; i < _modules.length; i++) {
      _widgets.add(_modules[i].module());
    }
    print(_widgets);
    return _widgets;
  }

  //Returns QSP Widgets
  List<Widget> getQSPModulesWidgets(String title) {
    List<Widget> _widgets = new List<Widget>();
    List<Module> _modules = new List<Module>();
    if (title == "Security and Network") {
      _modules = ModuleController()
          .getAllModules()
          .where((test) => test.qsp.contains("SN") && test.isDone == false)
          .toList();
    } else if (title == "Visual Computing") {
      _modules = ModuleController()
          .getAllModules()
          .where((test) => test.qsp.contains("VC") && test.isDone == false)
          .toList();
    } else if (title == "Software Engineering and Development") {
      _modules = ModuleController()
          .getAllModules()
          .where((test) => test.qsp.contains("SED") && test.isDone == false)
          .toList();
    }
    for (var i = 0; i < _modules.length; i++) {
      _widgets.add(_modules[i].module());
    }
    return _widgets;
  }

  //Returns QSP Widgets
  List<Widget> getWPFModulesWidgets() {
    List<Widget> _widgets = new List<Widget>();
    List<Module> _modules = new List<Module>();
    _modules = ModuleController()
        .getAllModules()
        .where((test) => test.qsp.contains("WPF") && test.isDone == false)
        .toList();
    for (var i = 0; i < _modules.length; i++) {
      _widgets.add(_modules[i].module());
    }
    return _widgets;
  }

  //Returns only not done Widgets for all Semester
  List<Widget> getOnlyNotDoneSemesterModulesWidgets(int index) {
    List<Widget> _widgets = new List<Widget>();
    List<Module> _modules = new List<Module>();
    _modules = ModuleController()
        .getAllModules()
        .where((test) => test.semester == index && test.isDone == false)
        .toList();
    for (var i = 0; i < _modules.length; i++) {
      _widgets.add(_modules[i].module());
    }

    return _widgets;
  }

  //Returns all Widgets for all Semester
  List<Widget> getAllSemesterModulesWidgets(int index) {
    List<Widget> _widgets = new List<Widget>();
    List<Module> _modules = new List<Module>();
    _modules = ModuleController()
        .getAllModules()
        .where((test) => test.semester == index)
        .toList();
    for (var i = 0; i < _modules.length; i++) {
      _widgets.add(_modules[i].module());
    }

    return _widgets;
  }

  //Returns all Widgets from _allModules
  List<Widget> getAllModulesWidgets() {
    List<Widget> _widgets = new List<Widget>();
    for (int i = 0; i < _allModules.length; i++) {
      _widgets.add(_allModules[i].module());
    }
    return _widgets;
  }

  //Returns modules that are done
  List<Module> getDoneSemesterModules() {
    List<Module> _modules = new List<Module>();

    _modules = ModuleController()
        .getAllModules()
        .where((test) => test.isDone == true)
        .toList();
    return _modules;
  }

  void replacePlaceholder(Module _module) {
    _replacedModules.id = _module.id;
    _replacedModules.title = _module.title;
    _replacedModules.code = _module.code;
    _replacedModules.grade = _module.grade;
    _replacedModules.isDone = _module.isDone;
    _replacedModules.isSelected = _module.isSelected;
    _replacedModules.qsp = _module.qsp;
    _replacedModules.cp = _module.cp;
    updateModule(_replacedModules);
  }

  //Setter

  void setModulesFromDatabase() async {
    _allModules = await DBProvider.db.readAllModules();
  }

  void addToAllModules(Module _module) {
    int index = _allModules.indexWhere((module) => module.id == _module.id);
    if (index == -1) {
      _allModules.add(_module);
      DBProvider.db.createModule(_module);
    } else {
      _allModules[index] = _module;
      DBProvider.db.updateModule(_module);
    }
  }

  void removeFromAllModule(Module _module) {
    DBProvider.db.deleteModule(_module.id);
  }

  void updateModule(Module _module) {
    int index = _allModules.indexWhere((module) => module.id == _module.id);
    _allModules[index] = _module;
    DBProvider.db.updateModule(_allModules[index]);
  }

  void addReplacedModule(Module _module) {
    _replacedModules = _module;
  }

  void removeReplacedModule(Module _module) {
    _replacedModules = _module;
  }

  void addSelectedModule(Module _module) {
    _selectedModules.add(_module);
  }

  void removeSelectedModule(Module _module) {
    _selectedModules.remove(_module);
  }
}
