import 'package:MyStudyBuddy2/model/module.dart';
import 'package:MyStudyBuddy2/singleton/module_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

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
                  decoration: InputDecoration(counterText: "",hintText:"Note zwischen 1.0 und 4.0"),
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
                        disposeData();
                      } else if (double.parse(grade) < 1.0) {
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
  module.properties.grade = grade;
  module.properties.isDone = true;
  module.properties.isSelected = false;
  ModuleController().removeSelectedModule(module);
  ModuleController().updateModule(module);
}
