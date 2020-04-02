import 'package:MyStudyBuddy2/local_database/local_database.dart';
import 'package:MyStudyBuddy2/model/module.dart';
import 'package:MyStudyBuddy2/singleton/profile_controller.dart';
import 'package:flutter/cupertino.dart';

import '../local_database/local_database.dart';
import '../model/module.dart';

class ModuleController {
  static final ModuleController _instance = ModuleController._internal();
  GlobalKey key;
  GlobalKey moduleSelectionKey;
  GlobalKey studyProgressKey;

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
        .where((test) => test.properties.isSelected == true)
        .toList();
    for (int i = 0; i < _modules.length; i++) {
      _widgets.add(_modules[i]);
    }
    return _widgets;
  }

//Get all Grades

  List<double> getAllDoneGrades() {
    List<double> _grades = new List<double>();
    List<Module> _modules = new List<Module>();
    _modules = ModuleController()
        .getAllModules()
        .where((test) => test.properties.isDone == true)
        .toList();

    for (int i = 0; i < _modules.length; i++) {
      if (_modules[i].properties.grade != 0.0) {
        _grades.add(_modules[i].properties.grade);
      }
    }

    return _grades;
  }

  List<Module> getAllDoneModules() {
    List<Module> _modules = new List<Module>();
    _modules = ModuleController()
        .getAllModules()
        .where((test) => test.properties.isDone == true)
        .toList();
    return _modules;
  }

  List<String> getAllDoneModulesNames() {
    List<String> _names = new List<String>();
    List<Module> _modules = new List<Module>();
    _modules = ModuleController()
        .getAllModules()
        .where((test) => test.properties.isDone == true)
        .toList();
    for (int i = 0; i < _modules.length; i++) {
      _names.add(_modules[i].properties.title);
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
          .where((test) =>
              test.properties.qsp.contains("SN") &&
              test.properties.isDone == false)
          .toList();
    } else if (title == "Visual Computing") {
      _modules = ModuleController()
          .getAllModules()
          .where((test) =>
              test.properties.qsp.contains("VC") &&
              test.properties.isDone == false)
          .toList();
    } else if (title == "Software Engineering and Development") {
      _modules = ModuleController()
          .getAllModules()
          .where((test) =>
              test.properties.qsp.contains("SED") &&
              test.properties.isDone == false)
          .toList();
    }
    for (int i = 0; i < _modules.length; i++) {
      _widgets.add(_modules[i]);
    }
    return _widgets;
  }

  //Returns QSP Widgets
  List<Widget> getWPFModulesWidgets() {
    List<Widget> _widgets = new List<Widget>();
    List<Module> _modules = new List<Module>();
    _modules = ModuleController()
        .getAllModules()
        .where((test) =>
            test.properties.qsp.contains("WPF") &&
            test.properties.isDone == false)
        .toList();
    for (int i = 0; i < _modules.length; i++) {
      _widgets.add(_modules[i]);
    }
    return _widgets;
  }

  //Returns only not done Widgets for all Semester
  List<Widget> getOnlyNotDoneSemesterModulesWidgets(int index) {
    List<Widget> _widgets = new List<Widget>();
    List<Module> _modules = new List<Module>();
    _modules = ModuleController()
        .getAllModules()
        .where((test) =>
            test.properties.semester == index &&
            test.properties.isDone == false)
        .toList();
    for (int i = 0; i < _modules.length; i++) {
      _widgets.add(_modules[i]);
    }

    return _widgets;
  }

  //Returns all Widgets for all Semester
  List<Widget> getAllSemesterModulesWidgets(int index) {
    List<Widget> _widgets = new List<Widget>();
    List<Module> _modules = new List<Module>();
    List<Module> _qspmodules = new List<Module>();

    _qspmodules = ModuleController()
        .getAllModules()
        .where((test) =>
            test.properties.qsp.contains("SED") ||
            test.properties.qsp.contains("VC") ||
            test.properties.qsp.contains("SN") ||
            test.properties.qsp.contains("WPF"))
        .toList();

    for (int i = 0; i < _qspmodules.length; i++) {
      if (_qspmodules[i].properties.id > 200 &&
          _qspmodules[i].properties.id < 400 &&
          _qspmodules[i].properties.grade != null &&
          _qspmodules[i].properties.isDone == true) {
        _qspmodules[i].properties.semester = 3;
        updateModule(_qspmodules[i]);
      } else if (_qspmodules[i].properties.id > 400 &&
          _qspmodules[i].properties.id < 500 &&
          _qspmodules[i].properties.grade != null &&
          _qspmodules[i].properties.isDone == true) {
        _qspmodules[i].properties.semester = 4;
        updateModule(_qspmodules[i]);
      } else if (_qspmodules[i].properties.id > 500 &&
          _qspmodules[i].properties.id < 600 &&
          _qspmodules[i].properties.grade != null &&
          _qspmodules[i].properties.isDone == true) {
        _qspmodules[i].properties.semester = 5;
        updateModule(_qspmodules[i]);
      }
    }

    _modules = ModuleController()
        .getAllModules()
        .where((test) => test.properties.semester == index)
        .toList();

    if (_modules.length > 6) {
      for (int i = 0; i < _modules.length; i++) {
        _modules.removeWhere((test) => test.properties.qsp.contains("QSPLA"));
        _modules.removeWhere((test) => test.properties.qsp.contains("WPLA"));
      }
    }

    for (int i = 0; i < _modules.length; i++) {
      _widgets.add(_modules[i]);
    }

    return _widgets;
  }

  void updateStudyTypeModules(int index) {
    if (index == 0) {
      if (_allModules == null) {
        return;
      } else {
        for (int i = 0; i < _allModules.length; i++) {
          if (_allModules[i].properties.id == 161) {
            _allModules[i].properties.semester = null;
            updateModule(_allModules[i]);
          }
          if (_allModules[i].properties.id == 171) {
            _allModules[i].properties.semester = null;
            updateModule(_allModules[i]);
          }
          if (_allModules[i].properties.id == 172) {
            _allModules[i].properties.semester = null;
            updateModule(_allModules[i]);
          }
          if (_allModules[i].properties.id == 173) {
            _allModules[i].properties.semester = 6;
            updateModule(_allModules[i]);
          }
          if (_allModules[i].properties.id == 601) {
            _allModules[i].properties.semester = null;
            updateModule(_allModules[i]);
          }
          if (_allModules[i].properties.id == 602) {
            _allModules[i].properties.semester = null;
            updateModule(_allModules[i]);
          }
          if (_allModules[i].properties.id == 603) {
            _allModules[i].properties.semester = null;
            updateModule(_allModules[i]);
          }
          if (_allModules[i].properties.id == 604) {
            _allModules[i].properties.semester = null;
            updateModule(_allModules[i]);
          }
          if (_allModules[i].properties.id == 605) {
            _allModules[i].properties.semester = null;
            updateModule(_allModules[i]);
          }
          if (_allModules[i].properties.id == 203) {
            _allModules[i].properties.semester = null;
            updateModule(_allModules[i]);
          }
          if (_allModules[i].properties.id == 204) {
            _allModules[i].properties.semester = null;
            updateModule(_allModules[i]);
          }
          if (_allModules[i].properties.id == 10007) {
            _allModules[i].properties.semester = 4;
            updateModule(_allModules[i]);
          }
          if (_allModules[i].properties.id == 10008) {
            _allModules[i].properties.semester = 5;
            updateModule(_allModules[i]);
          }
        }
      }
    } else if (index == 1) {
      if (_allModules == null) {
        return;
      } else {
        for (int i = 0; i < _allModules.length; i++) {
          if (_allModules[i].properties.id == 161) {
            _allModules[i].properties.semester = 6;
            updateModule(_allModules[i]);
          }
          if (_allModules[i].properties.id == 171) {
            _allModules[i].properties.semester = 6;
            updateModule(_allModules[i]);
          }
          if (_allModules[i].properties.id == 172) {
            _allModules[i].properties.semester = 6;
            updateModule(_allModules[i]);
          }
          if (_allModules[i].properties.id == 173) {
            _allModules[i].properties.semester = 7;
            updateModule(_allModules[i]);
          }
          if (_allModules[i].properties.id == 601) {
            _allModules[i].properties.semester = null;
            updateModule(_allModules[i]);
          }
          if (_allModules[i].properties.id == 602) {
            _allModules[i].properties.semester = null;
            updateModule(_allModules[i]);
          }
          if (_allModules[i].properties.id == 603) {
            _allModules[i].properties.semester = null;
            updateModule(_allModules[i]);
          }
          if (_allModules[i].properties.id == 604) {
            _allModules[i].properties.semester = null;
            updateModule(_allModules[i]);
          }
          if (_allModules[i].properties.id == 605) {
            _allModules[i].properties.semester = null;
            updateModule(_allModules[i]);
          }
          if (_allModules[i].properties.id == 203) {
            _allModules[i].properties.semester = null;
            updateModule(_allModules[i]);
          }
          if (_allModules[i].properties.id == 204) {
            _allModules[i].properties.semester = null;
            updateModule(_allModules[i]);
          }
          if (_allModules[i].properties.id == 10007) {
            _allModules[i].properties.semester = 4;
            updateModule(_allModules[i]);
          }
          if (_allModules[i].properties.id == 10008) {
            _allModules[i].properties.semester = 5;
            updateModule(_allModules[i]);
          }
        }
      }
    } else {
      if (_allModules == null) {
        return;
      } else {
        for (int i = 0; i < _allModules.length; i++) {
          if (_allModules[i].properties.id == 161) {
            _allModules[i].properties.semester = 6;
            updateModule(_allModules[i]);
          }
          if (_allModules[i].properties.id == 171) {
            _allModules[i].properties.semester = null;
            updateModule(_allModules[i]);
          }
          if (_allModules[i].properties.id == 172) {
            _allModules[i].properties.semester = null;
            updateModule(_allModules[i]);
          }
          if (_allModules[i].properties.id == 173) {
            _allModules[i].properties.semester = 6;
            updateModule(_allModules[i]);
          }
          if (_allModules[i].properties.id == 601) {
            _allModules[i].properties.semester = 1;
            updateModule(_allModules[i]);
          }
          if (_allModules[i].properties.id == 602) {
            _allModules[i].properties.semester = 2;
            updateModule(_allModules[i]);
          }
          if (_allModules[i].properties.id == 603) {
            _allModules[i].properties.semester = 3;
            updateModule(_allModules[i]);
          }
          if (_allModules[i].properties.id == 604) {
            _allModules[i].properties.semester = 4;
            updateModule(_allModules[i]);
          }
          if (_allModules[i].properties.id == 605) {
            _allModules[i].properties.semester = 6;
            updateModule(_allModules[i]);
          }
          if (_allModules[i].properties.id == 203) {
            _allModules[i].properties.semester = 4;
            updateModule(_allModules[i]);
          }
          if (_allModules[i].properties.id == 204) {
            _allModules[i].properties.semester = 5;
            updateModule(_allModules[i]);
          }
          if (_allModules[i].properties.id == 10007) {
            _allModules[i].properties.semester = null;
            updateModule(_allModules[i]);
          }
          if (_allModules[i].properties.id == 10008) {
            _allModules[i].properties.semester = null;
            updateModule(_allModules[i]);
          }
        }
      }
    }
  }

  //Returns all Widgets from _allModules
  List<Widget> getAllModulesWidgets() {
    List<Widget> _widgets = new List<Widget>();
    for (int i = 0; i < _allModules.length; i++) {
      _widgets.add(_allModules[i]);
    }
    return _widgets;
  }

  //Returns modules that are done
  List<Module> getDoneSemesterModules() {
    List<Module> _modules = new List<Module>();

    _modules = ModuleController()
        .getAllModules()
        .where((test) => test.properties.isDone == true)
        .toList();
    return _modules;
  }

  void replaceQSPPlaceholder(Module _module) {
    _module.properties.semester = _backupQSPPlaceHolder.properties.semester;
    removeFromAllModule(_backupQSPPlaceHolder);
  }

  void replaceQSP(Module _module) {
    int index = _replacedQSPModules.indexWhere(
        (module) => module.properties.semester == _module.properties.semester);
    _allModules.add(_replacedQSPModules[index]);
    DBProvider.db.createModule(_replacedQSPModules[index]);
    _module.properties.semester = null;
  }

  void replaceWPFPlaceholder(Module _module) {
    _module.properties.semester = _backupWPFPlaceHolder.properties.semester;
    removeFromAllModule(_backupWPFPlaceHolder);
  }

  void replaceWPF(Module _module) {
    int index = _replacedWPFModules.indexWhere(
        (module) => module.properties.semester == _module.properties.semester);
    _allModules.add(_replacedWPFModules[index]);
    DBProvider.db.createModule(_replacedWPFModules[index]);
    _module.properties.semester = null;
  }
  //Setter

  void setModulesFromDatabase() async {
    _allModules = await DBProvider.db.readAllModules();
    _selectedModules = await DBProvider.db.readSelectedModules();
    ProfileController().sumAllCP();
  }

  void addToAllModules(Module _module) {
    int index = _allModules
        .indexWhere((module) => module.properties.id == _module.properties.id);
    if (index == -1) {
      _allModules.add(_module);
      DBProvider.db.createModule(_module);
    } else {
      _allModules[index] = _module;
      DBProvider.db.updateModule(_module);
    }
  }

  void removeFromAllModule(Module _module) {
    int index = _allModules
        .indexWhere((module) => module.properties.id == _module.properties.id);
    _allModules.removeAt(index);
    DBProvider.db.deleteModule(_module.properties.id);
  }

  void updateModule(Module _module) {
    int index = _allModules
        .indexWhere((module) => module.properties.id == _module.properties.id);
    _allModules[index] = _module;
    DBProvider.db.updateModule(_allModules[index]);
  }

  void addReplacedQSPModule(Module _module) {
    _replacedQSPModules.add(_module);
    _backupQSPPlaceHolder = _module;
  }

  void removeReplacedQSPModule(Module _module) {
    int index = _allModules.indexWhere(
        (module) => module.properties.semester == _module.properties.semester);
    _allModules.removeAt(index);
  }

  void addReplacedWPFModule(Module _module) {
    _replacedWPFModules.add(_module);
    _backupWPFPlaceHolder = _module;
  }

  void removeReplacedWPFModule(Module _module) {
    int index = _allModules.indexWhere(
        (module) => module.properties.semester == _module.properties.semester);
    _allModules.removeAt(index);
  }

  void addSelectedModule(Module _module) {
    _selectedModules.add(_module);
  }

  void removeSelectedModule(Module _module) {
    _selectedModules.remove(_module);
  }
}
