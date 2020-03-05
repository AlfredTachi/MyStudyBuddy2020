import 'package:MyStudyBuddy2/singleton/module_controller.dart';
import 'package:flutter/material.dart';

class GradesList extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return GradesListState();
  }
}

class GradesListState extends State<GradesList> {
  List<double> grades = ModuleController().getAllDoneGrades();
  List<String> doneModules = ModuleController().getAllDoneModulesNames();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text("Noten Liste")),
        body: ListView.builder(
            itemCount: grades.length,
            itemBuilder: (context, index) {
              return Container(
                decoration: BoxDecoration(border: Border(bottom: BorderSide())),
                child: ListTile(
                  title: Text('${doneModules[index]}',
                   ),
                  subtitle: Text('${grades[index]}'),
                ),
              );
            }));
  }
}
