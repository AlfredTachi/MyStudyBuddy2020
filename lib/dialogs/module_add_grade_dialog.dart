import 'dart:io';
import 'package:MyStudyBuddy2/model/module.dart';
import 'package:MyStudyBuddy2/singleton/module_controller.dart';
import 'package:MyStudyBuddy2/theme/styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class ModuleAddGradeDialog extends StatefulWidget {
  final Module module;

  ModuleAddGradeDialog(this.module);

  @override
  State<StatefulWidget> createState() => ModuleAddGradeDialogState();
}

class ModuleAddGradeDialogState extends State<ModuleAddGradeDialog> {
  TextEditingController _gradeCtrl = TextEditingController();
  String grade = "";
  String errorMessage = "";

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(
        'Note eintragen!',
        style: (Platform.isIOS) ? Styles.alertDialogTitleText : null,
      ),
      content: Wrap(
        children: [
          TextField(
            onChanged: (_val) {
              grade = _val;
            },
            controller: _gradeCtrl,
            decoration: InputDecoration(
              counterText: "",
              hintText: "Note zwischen 1.0 und 4.0",
            ),
            maxLength: 3,
            keyboardType: TextInputType.numberWithOptions(decimal: true),
          ),
          (errorMessage.isNotEmpty)
              ? Padding(
                  padding: const EdgeInsets.only(top: 4),
                  child: Text(
                    errorMessage,
                    style: TextStyle(color: Colors.red, fontSize: 10),
                  ),
                )
              : Container(),
          Align(
            alignment: Alignment.bottomRight,
            child: OutlineButton(
              onPressed: () {
                if (grade.isNotEmpty) {
                  grade = grade.replaceAll(",", ".");
                  try {
                    if (double.tryParse(grade) >= 1.0 &&
                        double.tryParse(grade) <= 4.0) {
                      update(double.parse(grade), widget.module);
                      errorMessage = "";
                      Navigator.of(context).pop();
                    } else {
                      setState(() {
                        errorMessage =
                            "Die Eingegebene Note war nicht gültig.\nVersuche es nochmal.";
                      });
                    }
                    _gradeCtrl.text = "";
                  } catch (ex) {
                    setState(() {
                      _gradeCtrl.text = "";
                      errorMessage = "Ein ungültiges Zeichen wurde verwendet.";
                      print("Eingabe war nicht korrekt!");
                    });
                  }
                }
              },
              child: Text("Speichern"),
            ),
          ),
        ],
      ),
    );
  }

  void update(double grade, Module module) {
    module.properties.grade = grade;
    module.properties.isDone = true;
    module.properties.isSelected = false;
    ModuleController().removeSelectedModule(module);
    ModuleController().updateModule(module);
  }
}
