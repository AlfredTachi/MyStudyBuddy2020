import 'package:MyStudyBuddy2/singleton/module_controller.dart';
import 'package:flutter/material.dart';

class Module {
  int _id;
  String _title;
  bool _isSelected = false;

  Module(
    this._id,
    this._title,
    // Function myModules
  );

  set title(String title) {
    _title = title;
  }

  int get id => _id;

  String get title => _title;

  Widget module() {
    return MaterialButton(
      height: 90,
      minWidth: 150,
      onPressed: () {
        if (_isSelected) {
          ///Open Alert Dialog
        } else {
          ModuleController().addModule(this);
          _isSelected = true;
        }
      },
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15.0),
          color: Color(0xFF013D62),
        ),
        child: Center(
            child: Text(title,
                style: TextStyle(fontSize: 20, color: Colors.white))),
      ),
    );
  }
}
