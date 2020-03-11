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
  String _selectModuleText;
  String _gradeText;

  @override
  void initState() {
    super.initState();
    _setSelectedModuleText();
    _setGradeString();
  }

  void _setSelectedModuleText() {
    if (widget.module.properties.isSelected)
      _selectModuleText = "Modul abwählen";
    else
      _selectModuleText = "Modul wählen";
  }

  void _setGradeString() {
    if (widget.module.properties.grade != 0 &&
        widget.module.properties.grade != null)
      _gradeText = "Note löschen";
    else
      _gradeText = "Note eintragen";
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      contentPadding: EdgeInsets.all(8),
      content: SingleChildScrollView(
        child: ListBody(children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: FittedBox(
              fit: BoxFit.scaleDown,
              child: Text(
                widget.module.properties.title,
                style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
              ),
            ),
          ),
          FlatButton(
              child: Text("Modul Informationen"),
              onPressed: () {
                return showDialog(
                  context: context,
                  child: ModuleInformationDialog(widget.module),
                );
              }),
          FlatButton(
            child: Text(_gradeText),
            onPressed: () async {
              if (widget.module.properties.grade != 0) {
                setState(() {
                  widget.module.properties.grade = 0;
                  ModuleController().updateModule(widget.module);
                  _setGradeString();
                });
              } else {
                return showDialog(
                  context: context,
                  child: ModuleAddGradeDialog(widget.module),
                ).whenComplete(() {
                  setState(() {
                    _setGradeString();
                  });
                });
              }
            },
          ),
          FlatButton(
            child: Text(_selectModuleText),
            onPressed: () {
              if (widget.module.properties.isSelected) {
                widget.module.properties.isSelected = false;
                if (widget.module.properties.qsp.contains("SN") ||
                    widget.module.properties.qsp.contains("VC") ||
                    widget.module.properties.qsp.contains("SED")) {
                  ModuleController().replaceQSP(widget.module);
                  removeInModuleController(widget.module);
                } else if (widget.module.properties.qsp.contains("WPF")) {
                  ModuleController().replaceWPF(widget.module);
                  removeInModuleController(widget.module);
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
                } else if (widget.module.properties.qsp.contains("WPF")) {
                  ModuleController().replaceWPFPlaceholder(widget.module);
                }
                addInModuleController(widget.module);
              }
              Navigator.of(context).pop();
            },
          ),
        ]),
      ),
    );
  }

  void addInModuleController(Module module) {
    ModuleController().addSelectedModule(widget.module);
    ModuleController().updateModule(widget.module);
  }

  void removeInModuleController(Module module) {
    ModuleController().removeSelectedModule(widget.module);
    ModuleController().removeReplacedQSPModule(widget.module);
    ModuleController().updateModule(widget.module);
  }
}
