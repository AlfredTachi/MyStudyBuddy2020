import 'package:MyStudyBuddy2/local_database/local_database.dart';
import 'package:MyStudyBuddy2/model/module.dart';
import 'package:MyStudyBuddy2/singleton/grade_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

Future<Widget> addGrade(Module module) async {
  String grade;
  return Get.dialog(
    AlertDialog(
        title: const Text('Note eintragen!'),
        content: Column(
          children: [
            TextField(
              onChanged: (_val) {
                grade = _val;
              },
              controller: GradeController().getGradeController(),
              keyboardType: TextInputType.numberWithOptions(decimal: true),
            ),
            OutlineButton(
                onPressed: () {
                  Get.back();
                },
                child: Text("Zurück")),
            OutlineButton(
                onPressed: () {
                  update(double.parse(grade), module);
                },
                child: Text("Speichern"))
          ],
        )),
  );
}

void update(double grade, Module module) {
  
  GradeController().disposeData();
  module.setGrade(grade);

  DBProvider.db.updateGradeManually(module);
}
