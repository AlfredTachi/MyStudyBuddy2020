import 'package:MyStudyBuddy2/dialogs/module_add_grade_dialog.dart';
import 'package:MyStudyBuddy2/dialogs/module_informations.dart';
import 'package:MyStudyBuddy2/model/module.dart';
import 'package:MyStudyBuddy2/singleton/module_controller.dart';
import 'package:flutter/material.dart';

class ModuleOptionsDialog extends StatefulWidget {
  final Module module;

  ModuleOptionsDialog(this.module);

  @override
  State<StatefulWidget> createState() => ModuleOptionsDialogState();
}

class ModuleOptionsDialogState extends State<ModuleOptionsDialog> {
  String btnText;

  @override
  void initState() {
    super.initState();
    if (widget.module.properties.isSelected)
      btnText = "Modul abwählen";
    else
      btnText = "Modul wählen";
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      contentPadding: EdgeInsets.all(8),
      content: SingleChildScrollView(
        child: ListBody(children: <Widget>[
          Text(
            widget.module.properties.title,
            style: TextStyle(fontSize: 25),
          ),
          FlatButton(
              child: Text("Modul Informationen"),
              onPressed: () {
                ModuleInformationDialog(widget.module);
              }),
          FlatButton(
            child: Text("Note Eintragen"),
            onPressed: () {
              return showDialog(
                context: context,
                child: ModuleAddGradeDialog(widget.module),
              );
            },
          ),
          FlatButton(
            child: Text(btnText),
            onPressed: () {
              if (widget.module.properties.isSelected) {
                widget.module.properties.isSelected = false;
                if (widget.module.properties.qsp.contains("SN") ||
                    widget.module.properties.qsp.contains("VC") ||
                    widget.module.properties.qsp.contains("SED")) {
                  ModuleController().replaceQSP(widget.module);
                  ModuleController().removeSelectedModule(widget.module);
                  ModuleController().removeReplacedQSPModule(widget.module);
                  ModuleController().updateModule(widget.module);
                } else if (widget.module.properties.qsp.contains("WPF")) {
                  ModuleController().replaceWPF(widget.module);
                  ModuleController().removeSelectedModule(widget.module);
                  ModuleController().removeReplacedWPFModule(widget.module);
                  ModuleController().updateModule(widget.module);
                } else {
                  ModuleController().removeSelectedModule(widget.module);
                  ModuleController().updateModule(widget.module);
                }
              } else {
                widget.module.properties.isSelected = true;
                if (widget.module.properties.qsp.contains("SN") ||
                    widget.module.properties.qsp.contains("VC") ||
                    widget.module.properties.qsp.contains("SED")) {
                  ModuleController().replaceQSPPlaceholder(widget.module);
                  ModuleController().addSelectedModule(widget.module);
                  ModuleController().updateModule(widget.module);
                } else if (widget.module.properties.qsp.contains("WPF")) {
                  ModuleController().replaceWPFPlaceholder(widget.module);
                  ModuleController().addSelectedModule(widget.module);
                  ModuleController().updateModule(widget.module);
                } else {
                  ModuleController().addSelectedModule(widget.module);
                  ModuleController().updateModule(widget.module);
                }
              }
              Navigator.of(context).pop();
            },
          ),
        ]),
      ),
    );
  }
}
