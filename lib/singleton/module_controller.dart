import 'package:MyStudyBuddy2/model/module.dart';
import 'package:flutter/cupertino.dart';

class ModuleController {
  static final ModuleController _instance = ModuleController._internal();
  static List<Module> _selectedModules = new List<Module>();
  static List<Module> _allModules = _generateModules();

  ModuleController._internal();

  factory ModuleController() => _instance;

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
  List<Widget> getAllModulesWidgets() {
    List<Widget> _widgets = new List<Widget>();
    for (int i = 0; i < _allModules.length; i++) {
      _widgets.add(_allModules[i].module());
    }
    return _widgets;
  }

  //Setter
  void addModule(Module _module) {
    _selectedModules.add(_module);
  }

  static List<Module> _generateModules() {
    List<Module> _modules = new List<Module>();
    for (int i = 1; i <= 7; i++) {
      _modules.add(Module(i, (i.toString() + ". M").toString()));
    }
    return _modules;
  }
}
