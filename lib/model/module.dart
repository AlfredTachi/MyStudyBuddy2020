import 'package:MyStudyBuddy2/singleton/module_controller.dart';
import 'package:flutter/material.dart';

class Module {
  int id;
  String title;
  bool _isSelected = false;

  Module(
    this.id,
    this.title,
    // Function myModules
  );

  Widget module() {
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: RaisedButton(
          color: Color(0xFF013D62),
          onPressed: () {
            if (_isSelected) {
              ///Open Alert Dialog
            } else {
              ModuleController().addModule(this);
              _isSelected = true;
            }
          },
          child: Center(
              child: Text(title,
                  style: TextStyle(fontSize: 20, color: Colors.white))),
        ),
      ),
    );
  }
}
