import 'package:MyStudyBuddy2/model/module.dart';
import 'package:MyStudyBuddy2/singleton/module_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:path/path.dart';

Future<Widget> addGrade(Module module) async {
  TextEditingController _gradeCtrl = TextEditingController();
  void disposeData() async {
    _gradeCtrl.text = "";
  }

  String grade;
  return Get.dialog(
    AlertDialog(
        title: const Text('Note eintragen!'),
        content: FractionallySizedBox(
          heightFactor: 0.55,
          child: Container(
            child: Column(
              children: [
                TextField(
                  onChanged: (_val) {
                    grade = _val;
                  },
                  controller: _gradeCtrl,
                  decoration: InputDecoration(counterText: ""),
                  maxLength: 3,
                  keyboardType: TextInputType.numberWithOptions(decimal: true),
                ),
                OutlineButton(
                    onPressed: () {
                      Get.back();
                    },
                    child: Text("Zurück")),
                OutlineButton(
                    onPressed: () {
                      if (double.parse(grade) > 4.0) {
                        Get.snackbar(
                            "Fehler", "Korrekte Note (bis 4.0) eintragen.");
                        disposeData();
                      } else
                        update(double.parse(grade), module);
                      disposeData();
                      Get.back();
                    },
                    child: Text("Speichern"))
              ],
            ),
          ),
        )),
  );
}

void update(double grade, Module module) {
  module.grade = grade;
  module.isDone = true;
  module.isSelected = false;
  ModuleController().removeSelectedModule(module);
  ModuleController().updateModule(module);
}
