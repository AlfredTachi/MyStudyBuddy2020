import 'package:MyStudyBuddy2/model/module.dart';
import 'package:flutter/material.dart';

class ModuleInformationDialog extends StatefulWidget {
  final Module module;

  ModuleInformationDialog(this.module);

  @override
  State<StatefulWidget> createState() => ModuleInformationDialogState();
}

class ModuleInformationDialogState extends State<ModuleInformationDialog> {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text("Informationen"),
      content: Wrap(crossAxisAlignment: WrapCrossAlignment.start, children: [
        Wrap(
          direction: Axis.vertical,
          children: <Widget>[
            Text(
              "Name",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            Text(widget.module.properties.title)
          ],
        ),
        Divider(),
        Wrap(
          direction: Axis.vertical,
          children: <Widget>[
            Text(
              "Modul ID",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            Text(widget.module.properties.id.toString())
          ],
        ),
        Divider(),
        Wrap(
          direction: Axis.vertical,
          children: <Widget>[
            Text(
              "Credit Points",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            Text(widget.module.properties.cp.toString())
          ],
        ),
        Divider(),
        Wrap(
          direction: Axis.vertical,
          children: <Widget>[
            Text(
              "Note",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            Text(getGradeText())
          ],
        ),
      ]),
    );
  }

  String getGradeText() {
    String gradeText;
    if (widget.module.properties.grade == null) {
      gradeText = "Keine Note vorhanden";
    } else if (widget.module.properties.grade == 0) {
      gradeText = "Note ausstehend";
    } else {
      gradeText = widget.module.properties.grade.toString();
    }
    return gradeText;
  }
}
