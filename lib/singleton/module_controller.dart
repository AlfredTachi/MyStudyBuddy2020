import 'package:MyStudyBuddy2/local_database/local_database.dart';
import 'package:MyStudyBuddy2/model/module.dart';
import 'package:MyStudyBuddy2/singleton/profile_controller.dart';
import 'package:flutter/cupertino.dart';

import '../local_database/local_database.dart';
import '../model/module.dart';

class ModuleController {
  static final ModuleController _instance = ModuleController._internal();

  factory ModuleController() => _instance;

  ModuleController._internal();

  List<Module> _selectedModules = new List<Module>();
  List<Module> _replacedQSPModules = new List<Module>();
  Module _backupQSPPlaceHolder;
  List<Module> _replacedWPFModules = new List<Module>();
  Module _backupWPFPlaceHolder;
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
    return _widgets;
  }

//Get all Grades

  List<double> getAllDoneGrades() {
    List<double> _grades = new List<double>();
    List<Module> _modules = new List<Module>();
    _modules = ModuleController()
        .getAllModules()
        .where((test) => test.isDone == true)
        .toList();

    for (var i = 0; i < _modules.length; i++) {
      if (_modules[i].grade != 0.0) {
        _grades.add(_modules[i].grade);
      }
    }

    return _grades;
  }

  List<Module> getAllDoneModules() {
    List<Module> _modules = new List<Module>();
    _modules = ModuleController()
        .getAllModules()
        .where((test) => test.isDone == true)
        .toList();
    return _modules;
  }

  List<String> getAllDoneModulesNames() {
    List<String> _names = new List<String>();
    List<Module> _modules = new List<Module>();
    _modules = ModuleController()
        .getAllModules()
        .where((test) => test.isDone == true)
        .toList();
    for (var i = 0; i < _modules.length; i++) {
      _names.add(_modules[i].title);
    }
    return _names;
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

  int sumAllCP() {
    List<Module> _modules = getAllDoneModules();
    int sum = 0;
    for (int i = 0; i < _modules.length; i++) {
      if (_modules[i].getGrade() != 0.0) {
        sum += _modules[i].cp;
      }
    }
    return sum;
  }

  void replaceQSPPlaceholder(Module _module) {
    _module.semester = _backupQSPPlaceHolder.semester;
    removeFromAllModule(_backupQSPPlaceHolder);
  }

  void replaceQSP(Module _module) {
    int index = _replacedQSPModules
        .indexWhere((module) => module.semester == _module.semester);
    _allModules.add(_replacedQSPModules[index]);
    DBProvider.db.createModule(_replacedQSPModules[index]);
    _module.semester = null;
  }

  void replaceWPFPlaceholder(Module _module) {
    _module.semester = _backupWPFPlaceHolder.semester;
    removeFromAllModule(_backupWPFPlaceHolder);
  }

  void replaceWPF(Module _module) {
    int index = _replacedWPFModules
        .indexWhere((module) => module.semester == _module.semester);
    _allModules.add(_replacedWPFModules[index]);
    DBProvider.db.createModule(_replacedWPFModules[index]);
    _module.semester = null;
  }
  //Setter

  void setModulesFromDatabase() async {
    _allModules = await DBProvider.db.readAllModules();
    _selectedModules = await DBProvider.db.readSelectedModules();
    ProfileController().setEarnedCP(sumAllCP());
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
    int index = _allModules.indexWhere((module) => module.id == _module.id);
    _allModules.removeAt(index);
    DBProvider.db.deleteModule(_module.id);
  }

  void updateModule(Module _module) {
    int index = _allModules.indexWhere((module) => module.id == _module.id);
    _allModules[index] = _module;
    DBProvider.db.updateModule(_allModules[index]);
  }

  void addReplacedQSPModule(Module _module) {
    _replacedQSPModules.add(_module);
    _backupQSPPlaceHolder = _module;
  }

  void removeReplacedQSPModule() {
    _replacedQSPModules = null;
    _backupQSPPlaceHolder = null;
  }

  void addReplacedWPFModule(Module _module) {
    _replacedWPFModules.add(_module);
    _backupWPFPlaceHolder = _module;
  }

  void removeReplacedWPFModule() {
    _replacedWPFModules = null;
    _backupWPFPlaceHolder = null;
  }

  void addSelectedModule(Module _module) {
    _selectedModules.add(_module);
  }

  void removeSelectedModule(Module _module) {
    _selectedModules.remove(_module);
  }
}
