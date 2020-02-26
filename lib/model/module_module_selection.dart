import 'package:MyStudyBuddy2/singleton/module_module_selection_controller.dart';
import 'package:flutter/material.dart';

class Module {
  int id;
  String title;
  bool _isSelected = false;

  Module(
    this.id,
    this.title,
  );

  Widget module() {
    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: Container(
        height: 80,
        width: 80,
        child: RaisedButton(
          shape: RoundedRectangleBorder(
            borderRadius: new BorderRadius.circular(15.0),
          ),
          color: Color(0xFF013D62),
          splashColor: Colors.orange,
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
