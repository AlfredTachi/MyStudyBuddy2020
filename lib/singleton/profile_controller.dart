import 'package:achievement_view/achievement_view.dart';
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

  void showAchievement(BuildContext context){
    String semesterAnzahl;
    String cry;
    if(getEarnedCP()<30){
       cry = "Hallo";
     }else{
       cry = "Yeaaah!";
     }

     if(getEarnedCP() >=30 && getEarnedCP()<60){
       semesterAnzahl = "Du bist im 2. Semester";
     }else if(getEarnedCP() >=60 && getEarnedCP()<90){
       semesterAnzahl = "Du bist im 3. Semester";
     }else if(getEarnedCP() >=90 && getEarnedCP()<120){
       semesterAnzahl = "Du bist im 4. Semester";
     }else if(getEarnedCP() >=120 && getEarnedCP()<150){
       semesterAnzahl = "Du bist im 5. Semester";
     }else if(getEarnedCP() >=150 && getEarnedCP()<180){
       semesterAnzahl = "Du bist im 6. Semester";
     }else if(getEarnedCP() >=180){
       semesterAnzahl = "Du bist im 7. Semester";
     }else if(getEarnedCP()<30){
       semesterAnzahl = "Du bist im 1. Semester";
     }

    AchievementView(
        context,
        title: cry,
        subTitle: semesterAnzahl,
        listener: (status){
          print(status);
        }
    )..show();
  }
}
