import 'package:MyStudyBuddy2/singleton/module_controller.dart';
import 'package:flutter/material.dart';

class Module {
  int id;
  String title;

  Module(
    this.id,
    this.title,
    // Function myModules
  );

  Widget module() {
    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: Container(
        height: 80,
        width: 80,
        child: Padding(
          padding: EdgeInsets.all(12),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Row(children: <Widget>[
                Align(
                  alignment: Alignment.center,
                  child: Container(
                    child: Center(
                      child: Text(title,
                          style: TextStyle(fontSize: 20, color: Colors.white)),
                    ),
                  ),
                ),
              ]),
            ],
          ),
        )));
  }
}
