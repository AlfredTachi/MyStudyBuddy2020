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

  int _earnedCreditPoints = 0;
  int _maxCreditPoints = 210;

  int _sed = 0;
  int _vc = 0;
  int _nc = 0;

  //Getters
  TextEditingController getInfNumberController() => _infCtrl;
  TextEditingController getMatrikelController() => _matrikelCtrl;
  TextEditingController getQSPController() => _qspCtrl;

  int getEarnedCP() => _earnedCreditPoints;
  int getMaxCP() => _maxCreditPoints;

  int getSED() => _sed;
  int getVC() => _vc;
  int getNC() => _nc;

  String getProgressText() {
    return _earnedCreditPoints.toString() +
        " / " +
        _maxCreditPoints.toString() +
        " CP";
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

  void saveData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString("infNummer", _infCtrl.text);
    prefs.setString("matrikelNummer", _matrikelCtrl.text);
    prefs.setString("qsp", _qspCtrl.text);
  }

  void loadData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    _infCtrl.text = prefs.getString("infNummer");
    _matrikelCtrl.text = prefs.getString("matrikelNummer");
    _qspCtrl.text = prefs.getString("qsp");
  }
}
