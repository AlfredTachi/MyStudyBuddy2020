import 'package:MyStudyBuddy2/dashboard/profile_page/achievement/achievement.dart';
import 'package:MyStudyBuddy2/model/module.dart';
import 'package:MyStudyBuddy2/singleton/module_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfileController {
  //Singleton

  ProfileController._internal();
  factory ProfileController() => _instance;

  //Instance
  static final ProfileController _instance = ProfileController._internal();

  //Controller
  TextEditingController _infCtrl = TextEditingController();
  TextEditingController _matrikelCtrl = TextEditingController();
  TextEditingController _qspCtrl = TextEditingController();
  TextEditingController _dualStudyCtrl = TextEditingController();

  int _earnedCreditPoints = 0;
  int _maxCreditPoints = 180;
  int _studyTypeIndex = 0;

  int _sed = 0;
  int _vc = 0;
  int _nc = 0;

  //Getters
  TextEditingController getInfNumberController() => _infCtrl;
  TextEditingController getMatrikelController() => _matrikelCtrl;
  TextEditingController getQSPController() => _qspCtrl;
  TextEditingController getDualStudyController() => _dualStudyCtrl;

  int getEarnedCP() => _earnedCreditPoints;
  int getMaxCP() {
    return _maxCreditPoints;
  }

  int getStudyTypeIndex() => _studyTypeIndex;

  int getSED() => _sed;
  int getVC() => _vc;
  int getNC() => _nc;

  String getProgressText() =>
      _earnedCreditPoints.toString() +
      " / " +
      _maxCreditPoints.toString() +
      " CP";

  double getCPForLiquidProgressBar() {
    return ProfileController().getEarnedCP() / ProfileController().getMaxCP();
  }

  void setStudyType(int type) {
    if (type == 0) {
      _dualStudyCtrl.text = "Ohne Praxissemester (6. Semester)";
    } else if (type == 1) {
      _dualStudyCtrl.text = "Mit Praxissemester (7. Semester)";
    } else {
      _dualStudyCtrl.text = "Duales Studium";
    }
    if (type != null) {
      _studyTypeIndex = type;
    }
  }

  void addEarnedCP(int _cp) {
    _earnedCreditPoints += _cp;
    setAchievements();
  }

  void setEarnedCP(int _cp) {
    _earnedCreditPoints = _cp;
  }

  void setSED(int _val) {
    _sed = _val;
  }

  void setVC(int _val) {
    _vc = _val;
  }

  void setNC(int _val) {
    _nc = _val;
  }

  void adjustMaxCP() {
    if (_studyTypeIndex == 0) {
      _maxCreditPoints = 180;
    } else if (_studyTypeIndex > 0) {
      _maxCreditPoints = 210;
    }
  }

  void setAchievements() {
    if (_earnedCreditPoints >= 30 && _earnedCreditPoints < 60) {
      Achievement().showAchievement(ModuleController().key.currentContext, 1);
    }
    if (_earnedCreditPoints >= 60 && _earnedCreditPoints < 90) {
      Achievement().setAchievementToDoneByID(1);
      Achievement().showAchievement(ModuleController().key.currentContext, 2);
    }
    if (_earnedCreditPoints >= 90 && _earnedCreditPoints < 120) {
      Achievement().setAchievementToDoneByID(1);
      Achievement().setAchievementToDoneByID(2);
      Achievement().showAchievement(ModuleController().key.currentContext, 3);
    }
    if (_earnedCreditPoints >= 120 && _earnedCreditPoints < 150) {
      Achievement().setAchievementToDoneByID(1);
      Achievement().setAchievementToDoneByID(2);
      Achievement().setAchievementToDoneByID(3);
      Achievement().showAchievement(ModuleController().key.currentContext, 4);
    }
    if (_earnedCreditPoints >= 150 && _earnedCreditPoints < 180) {
      Achievement().setAchievementToDoneByID(1);
      Achievement().setAchievementToDoneByID(2);
      Achievement().setAchievementToDoneByID(3);
      Achievement().setAchievementToDoneByID(4);
      Achievement().showAchievement(ModuleController().key.currentContext, 5);
    }
    if (_earnedCreditPoints >= 180 && _earnedCreditPoints < 210) {
      Achievement().setAchievementToDoneByID(1);
      Achievement().setAchievementToDoneByID(2);
      Achievement().setAchievementToDoneByID(3);
      Achievement().setAchievementToDoneByID(4);
      Achievement().setAchievementToDoneByID(5);
      Achievement().showAchievement(ModuleController().key.currentContext, 6);
    }
    if (_earnedCreditPoints >= 210) {
      Achievement().setAchievementToDoneByID(1);
      Achievement().setAchievementToDoneByID(2);
      Achievement().setAchievementToDoneByID(3);
      Achievement().setAchievementToDoneByID(4);
      Achievement().setAchievementToDoneByID(5);
      Achievement().setAchievementToDoneByID(6);
      Achievement().showAchievement(ModuleController().key.currentContext, 7);
    }
  }

  void sumAllCP() {
    List<Module> _modules = ModuleController().getAllDoneModules();
    int sum = 0;
    for (int i = 0; i < _modules.length; i++) {
      if (_modules[i].getGrade() != 0.0) {
        sum += _modules[i].properties.cp;
      }
    }
    setEarnedCP(sum);
    setAchievements();
  }

  void saveData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString("infNummer", _infCtrl.text);
    prefs.setString("matrikelNummer", _matrikelCtrl.text);
    prefs.setString("qsp", _qspCtrl.text);
    prefs.setString("studyType", _dualStudyCtrl.text);
    prefs.setInt("studyTypeIndex", _studyTypeIndex);
  }

  void loadData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    _infCtrl.text = prefs.getString("infNummer");
    _matrikelCtrl.text = prefs.getString("matrikelNummer");
    _qspCtrl.text = prefs.getString("qsp");
    _dualStudyCtrl.text = prefs.getString("studyType");
    _studyTypeIndex = prefs.getInt("studyTypeIndex");
    if (_studyTypeIndex == null) {
      _studyTypeIndex = 0;
      setStudyType(_studyTypeIndex);
      saveData();
    }
    adjustMaxCP();
  }
}
