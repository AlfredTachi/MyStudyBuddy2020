import 'package:flutter/material.dart';

class Module {
  int _id;
  String _title;

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

  Material module() {
    return Material(
        color: Color(0xFF013D62),
        elevation: 3.0,
        shadowColor: Colors.black,
        borderRadius: BorderRadius.circular(12.0),
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
        ));
  }

}
