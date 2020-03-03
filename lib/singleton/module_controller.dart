import 'package:MyStudyBuddy2/local_database/local_database.dart';
import 'package:MyStudyBuddy2/model/module.dart';
import 'package:flutter/cupertino.dart';

import '../local_database/local_database.dart';

class ModuleController {
  static final ModuleController _instance = ModuleController._internal();
  static List<Module> _selectedModules = new List<Module>();
  static List<Module> _allModules = new List<Module>();

  ModuleController._internal();

  factory ModuleController() => _instance;

  //Getter

  List<Module> getSelectedModules() => _selectedModules;
  List<Module> getAllModules() => _allModules;

  //Returns all Widgets from _selectedModules
  /*List<Widget> getSelectedModulesWidgets() {
    List<Widget> _widgets = new List<Widget>();
    for (int i = 0; i < _selectedModules.length; i++) {
      _widgets.add(_selectedModules[i].module());
    }
    return _widgets;
  }*/

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

  //Setter

  void addToAllModules(Module _module) {
    int index = _allModules.indexWhere((module) => module.id == _module.id);

    if (index != -1) {
      Module module = Module(
          _module.id,
          _module.code,
          _module.title,
          _allModules[index].grade,
          _allModules[index].isDone,
          _allModules[index].isSelected,
          _module.qsp,
          _module.cp,
          _module.semester);
      _allModules[index] = module;
      DBProvider.db.updateModule(_allModules[index]);
    } else {
      _allModules.add(_module);
      DBProvider.db.createModule(_module);
    }
  }

  void removeFromAllModule(Module _module) {
    DBProvider.db.deleteModule(_module.id);
  }

  void setModuleSelected(Module _module, bool isSelected) {
    _module.setIsSelected(isSelected);
    DBProvider.db.updateModule(_module);
  }

  void setModuleDone(Module _module) {
    _module.setIsDone(true);
    DBProvider.db.updateModule(_module);
  }

  void removeSelectedModule(Module _module) {
    _selectedModules.remove(_module);
  }
}
