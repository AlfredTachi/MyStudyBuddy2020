import 'package:MyStudyBuddy2/local_database/local_database.dart';
import 'package:MyStudyBuddy2/model/module.dart';
import 'package:flutter/cupertino.dart';

class ModuleController {
  static final ModuleController _instance = ModuleController._internal();

  factory ModuleController() => _instance;

  ModuleController._internal();

  List<Module> _selectedModules;
  List<Module> _allModules;

  //Getter

  List<Module> getSelectedModules() => _selectedModules;
  List<Module> getAllModules() => _allModules;

  //Returns all Widgets from _selectedModules
  List<Widget> getSelectedModulesWidgets() {
    List<Widget> _widgets = new List<Widget>();
    for (int i = 0; i < _selectedModules.length; i++) {
      _widgets.add(_selectedModules[i].module());
    }
    return _widgets;
  }

  //Returns all Widgets from _allModules
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
    _selectedModules.remove(_module);
    DBProvider.db.deleteModule(_module.id);
  }

  void addSelectedModule(Module _module) {
    _selectedModules.add(_module);
  }

  void removeSelectedModule(Module _module) {
    _selectedModules.remove(_module);
  }
}
