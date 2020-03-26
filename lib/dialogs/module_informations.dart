import 'package:MyStudyBuddy2/theme/styles.dart';
import 'package:MyStudyBuddy2/model/module.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'dart:io';

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
      title: Text(
        "Informationen",
        style: (Platform.isIOS) ? Styles.alertDialogTitleText : null,
      ),
      content: Wrap(crossAxisAlignment: WrapCrossAlignment.start, children: [
        Wrap(
          direction: Axis.vertical,
          children: <Widget>[
            Text(
              "Name",
              style: (Platform.isIOS)
                  ? Styles.moduleInformationTitle
                  : TextStyle(fontWeight: FontWeight.bold),
            ),
            Text(
              widget.module.properties.title,
              style: (Platform.isIOS) ? Styles.moduleInformationText : null,
            )
          ],
        ),
        Divider(),
        Wrap(
          direction: Axis.vertical,
          children: <Widget>[
            Text(
              "Modul ID",
              style: (Platform.isIOS)
                  ? Styles.moduleInformationTitle
                  : TextStyle(fontWeight: FontWeight.bold),
            ),
            Text(
              widget.module.properties.id.toString(),
              style: (Platform.isIOS) ? Styles.moduleInformationText : null,
            )
          ],
        ),
        Divider(),
        Wrap(
          direction: Axis.vertical,
          children: <Widget>[
            Text(
              "Credit Points",
              style: (Platform.isIOS)
                  ? Styles.moduleInformationTitle
                  : TextStyle(fontWeight: FontWeight.bold),
            ),
            Text(
              widget.module.properties.cp.toString(),
              style: (Platform.isIOS) ? Styles.moduleInformationText : null,
            )
          ],
        ),
        Divider(),
        Wrap(
          direction: Axis.vertical,
          children: <Widget>[
            Text(
              "Note",
              style: (Platform.isIOS)
                  ? Styles.moduleInformationTitle
                  : TextStyle(fontWeight: FontWeight.bold),
            ),
            Text(
              getGradeText(),
              style: (Platform.isIOS) ? Styles.moduleInformationText : null,
            )
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
