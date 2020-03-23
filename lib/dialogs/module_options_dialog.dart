import 'dart:io';

import 'package:MyStudyBuddy2/theme/styles.dart';
import 'package:MyStudyBuddy2/dashboard/profile_page/achievement/achievement.dart';
import 'package:MyStudyBuddy2/dialogs/module_add_grade_dialog.dart';
import 'package:MyStudyBuddy2/dialogs/module_informations.dart';
import 'package:MyStudyBuddy2/model/module.dart';
import 'package:MyStudyBuddy2/singleton/module_controller.dart';
import 'package:MyStudyBuddy2/studyprogress/studyprogress.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

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
    if (widget.module.properties.isSelected) {
      _selectModuleText = "Modul abwählen";
    } else {
      _selectModuleText = "Modul wählen";
    }
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
                style: (Platform.isIOS)
                    ? Styles.alertDialogTitleText
                    : TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
              ),
            ),
          ),
          (Platform.isIOS)
              ? CupertinoButton(
                  child: Text(
                    "Modul Informationen",
                    style: TextStyle(color: CupertinoColors.activeOrange),
                  ),
                  onPressed: () {
                    return showDialog(
                      context: context,
                      child: ModuleInformationDialog(widget.module),
                    );
                  })
              : FlatButton(
                  child: Text("Modul Informationen"),
                  onPressed: () {
                    return showDialog(
                      context: context,
                      child: ModuleInformationDialog(widget.module),
                    );
                  }),
          (Platform.isIOS)
              ? CupertinoButton(
                  child: Text(
                    _gradeText,
                    style: TextStyle(color: CupertinoColors.activeOrange),
                  ),
                  onPressed: () async {
                    if (widget.module.properties.grade != 0 &&
                        widget.module.properties.grade != null) {
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
                  })
              : FlatButton(
                  child: Text(_gradeText),
                  onPressed: () async {
                    if (widget.module.properties.grade != 0 &&
                        widget.module.properties.grade != null) {
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
          (Platform.isIOS)
              ? CupertinoButton(
                  child: Text(
                    _selectModuleText,
                    style: TextStyle(color: CupertinoColors.activeOrange),
                  ),
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
                      if (ModuleController().moduleSelectionKey != null) {
                        State s =
                            ModuleController().moduleSelectionKey.currentState;
                        try {
                          s.setState(() {});
                        } catch (ex) {
                          print(
                              "Es konnte kein SetState in ModuleSelection ausgeführt werden.");
                        }
                      }
                      if (ModuleController().studyProgressKey != null) {
                        StudyprogressState s =
                            ModuleController().studyProgressKey.currentState;
                        try {
                          s.update();
                        } catch (ex) {
                          print(
                              "Es konnte kein SetState in StudyProgress ausgeführt werden.");
                        }
                      }
                    } else {
                      widget.module.properties.isSelected = true;
                      if (ModuleController().key.currentContext != null) {
                        WidgetsBinding.instance.addPostFrameCallback((_) {
                          Achievement().showAchievement(
                              ModuleController().key.currentContext, 9);
                        });
                      }
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
                  })
              : FlatButton(
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
                      if (ModuleController().moduleSelectionKey != null) {
                        State s =
                            ModuleController().moduleSelectionKey.currentState;
                        try {
                          s.setState(() {});
                        } catch (ex) {
                          print(
                              "Es konnte kein SetState in ModuleSelection ausgeführt werden.");
                        }
                      }
                      if (ModuleController().studyProgressKey != null) {
                        StudyprogressState s =
                            ModuleController().studyProgressKey.currentState;
                        try {
                          s.update();
                        } catch (ex) {
                          print(
                              "Es konnte kein SetState in StudyProgress ausgeführt werden.");
                        }
                      }
                    } else {
                      widget.module.properties.isSelected = true;
                      if (ModuleController().key.currentContext != null) {
                        WidgetsBinding.instance.addPostFrameCallback((_) {
                          Achievement().showAchievement(
                              ModuleController().key.currentContext, 9);
                        });
                      }
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
