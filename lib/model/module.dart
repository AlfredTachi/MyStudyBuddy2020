import 'package:MyStudyBuddy2/singleton/module_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

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
      padding: const EdgeInsets.all(5.0),
      child: Container(
        height: 80,
        width: 80,
        child: RaisedButton(
          shape: RoundedRectangleBorder(
            borderRadius: new BorderRadius.circular(15.0),
          ),
          color: Color(0xFF013D62),
          onPressed: () {
            if (_isSelected) {
              Get.dialog(AlertDialog(
                  contentPadding: EdgeInsets.fromLTRB(8, 8, 8, 8),
                  content: SingleChildScrollView(
                      child: ListBody(children: <Widget>[
                    Text(
                      'Modulname',
                      style: TextStyle(fontSize: 25),
                    ),
                    FlatButton(
                        child: Text("Modul Informationen"), onPressed: () {}),
                    FlatButton(
                      child: Text("Note Eintragen"),
                      onPressed: () {},
                    )
                  ]))));
            } else {
              Get.dialog(AlertDialog(
                  contentPadding: EdgeInsets.fromLTRB(8, 8, 8, 8),
                  content: SingleChildScrollView(
                    child: ListBody(
                      children: <Widget>[
                        Text(
                          'Modulname',
                          style: TextStyle(fontSize: 25),
                        ),
                        FlatButton(
                            child: Text("Modul Informationen"),
                            onPressed: () {}),
                        FlatButton(
                            child: Text("Note Eintragen"), onPressed: () {}),
                        FlatButton(
                            child: Text("Modul Wählen"),
                            onPressed: () {
                              ModuleController().addModule(this);
                              _isSelected = true;
                              Get.back();
                            })
                      ],
                    ),
                  )));
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
