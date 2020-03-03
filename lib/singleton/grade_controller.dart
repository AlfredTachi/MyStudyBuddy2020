import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';

class GradeController {
  //Singleton

  GradeController._internal();
  factory GradeController() => _instance;

  //Instance
  static final GradeController _instance = GradeController._internal();

  //Controller
  TextEditingController _gradeCtrl = TextEditingController();


  //Getters
  TextEditingController getGradeController() => _gradeCtrl;


  void saveData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString("grade", _gradeCtrl.text);
  }

  void loadData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    _gradeCtrl.text = prefs.getString("grade");

  }
  void disposeData() async{
     _gradeCtrl.text ="";
  }
}