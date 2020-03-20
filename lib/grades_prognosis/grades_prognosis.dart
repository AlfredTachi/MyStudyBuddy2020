import 'package:MyStudyBuddy2/local_database/local_database.dart';
import 'package:MyStudyBuddy2/singleton/module_controller.dart';
import 'package:MyStudyBuddy2/theme/styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'dart:io';

class GradesPrognosis extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _GradesPrognosisState();
  }
}

class _GradesPrognosisState extends State<GradesPrognosis> {
  final db = DBProvider.db;
  @override
  Widget build(BuildContext context) {
    void gradeListButtonPressed() {
      Navigator.of(context).pushNamed("/gradesList");
    }

    List<Widget> getColumnChildren() {
      List<Widget> _list = List<Widget>();
      if (!Platform.isIOS) {
        _list.add(Container(
          color: Colors.orange,
          child: Row(
            children: <Widget>[
              Expanded(
                child: Align(
                  alignment: Alignment.topLeft,
                  child: OutlineButton(
                      child: Padding(
                        padding: const EdgeInsets.only(top: 3, bottom: 3),
                        child: Icon(
                          Icons.arrow_back,
                          size: 36,
                        ),
                      ),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.only(
                        topRight: Radius.circular(15),
                        bottomRight: Radius.circular(15),
                      )),
                      onPressed: () {
                        Navigator.of(context).pop();
                      }),
                ),
              ),
              Align(
                  alignment: Alignment.topCenter,
                  child: Padding(
                      padding: const EdgeInsets.only(
                          left: 10, top: 3, bottom: 3, right: 10),
                      child: Text(
                        "Notenrechner",
                        style: TextStyle(fontSize: 25),
                      ))),
              Expanded(
                child: Align(
                  alignment: Alignment.topRight,
                  child: OutlineButton(
                      child: Padding(
                        padding: const EdgeInsets.only(top: 3, bottom: 3),
                        child: Icon(
                          Icons.format_list_numbered,
                          size: 36,
                        ),
                      ),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(15),
                        bottomLeft: Radius.circular(15),
                      )),
                      onPressed: () {
                        gradeListButtonPressed();
                      }),
                ),
              ),
            ],
          ),
        ));
      }
      _list.add(
        Expanded(
          flex: 4,
          child: (Platform.isIOS)
              ? Padding(
                  padding:
                      EdgeInsets.symmetric(vertical: 10.0, horizontal: 15.0),
                  child: PhysicalModel(
                      shape: BoxShape.rectangle,
                      borderRadius: BorderRadius.circular(15),
                      color: CupertinoColors.white,
                      child: Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Padding(
                                  padding: const EdgeInsets.only(bottom: 20),
                                  child: Text("Durchschnitt:",
                                      style: Styles.detailsTitleText),
                                ),
                                Text(
                                  average().toString(),
                                  style: Styles.detailsDescriptionText,
                                )
                              ],
                            ),
                          ))))
              : Container(
                  child: Padding(
                  padding: const EdgeInsets.only(top: 40.0),
                  child: Center(
                    child: Column(children: [
                      Text("Durchschnitt:", style: TextStyle(fontSize: 25)),
                      Text(average().toString(), style: TextStyle(fontSize: 25))
                    ]),
                  ),
                )),
        ),
      );
      _list.add(
        Expanded(
          flex: 6,
          child: (Platform.isIOS)
              ? Padding(
                  padding: EdgeInsets.only(
                      left: 15.0, right: 15.0, top: 10.0, bottom: 25.0),
                  child: PhysicalModel(
                    shape: BoxShape.rectangle,
                    borderRadius: BorderRadius.circular(15),
                    color: CupertinoColors.systemOrange,
                    child: Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Padding(
                                padding: const EdgeInsets.only(bottom: 20.0),
                                child: Text("Worst Case:",
                                    style: Styles.detailsTitleText),
                              ),
                              Text(
                                worstCase().toString(),
                                style: Styles.detailsDescriptionText,
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 20.0),
                                child: Text("Best Case:",
                                    style: Styles.detailsTitleText),
                              ),
                              Text(
                                bestCase().toString(),
                                style: Styles.detailsDescriptionText,
                              )
                            ],
                          ),
                        )),
                  ),
                )
              : Container(
                  decoration: BoxDecoration(
                      borderRadius:
                          BorderRadius.vertical(top: Radius.circular(30)),
                      gradient: LinearGradient(
                        begin: Alignment.topRight,
                        end: Alignment.bottomLeft,
                        colors: [
                          Colors.orange,
                          Colors.deepOrange,
                        ],
                      )),
                  child: Center(
                    child: Column(
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.only(top: 10.0),
                          child: Text("Worst Case:",
                              style: TextStyle(fontSize: 20)),
                        ),
                        Text(worstCase().toString(),
                            style: TextStyle(fontSize: 20)),
                        Padding(
                          padding: const EdgeInsets.only(top: 20),
                          child: Text("Best Case:",
                              style: TextStyle(fontSize: 20)),
                        ),
                        Text(bestCase().toString(),
                            style: TextStyle(fontSize: 20))
                      ],
                    ),
                  )),
        ),
      );
      return _list;
    }

    return (Platform.isIOS)
        ? Scaffold(
            appBar: CupertinoNavigationBar(
              actionsForegroundColor: CupertinoColors.activeOrange,
              middle: Text(
                "Notenrechner",
                style: Styles.navBarTitle,
              ),
              trailing: Builder(
                builder: (BuildContext context) {
                  return CupertinoButton(
                    padding: EdgeInsets.zero,
                    child: Icon(
                      IconData(
                        0xf453,
                        fontFamily: CupertinoIcons.iconFont,
                        fontPackage: CupertinoIcons.iconFontPackage,
                      ),
                      color: CupertinoColors.activeOrange,
                      size: 30,
                    ),
                    onPressed: () {
                      gradeListButtonPressed();
                    },
                  );
                },
              ),
            ),
            body: Column(
              children: getColumnChildren(),
            ),
          )
        : SafeArea(
            child: Scaffold(
                body: Column(
              children: getColumnChildren(),
            )),
          );
  }

  double average() {
    double myAverage = 0;
    double temp;
    double temp1;
    List<double> allGrades = new List<double>();
    allGrades = ModuleController().getAllDoneGrades();

    try {
      temp = allGrades.reduce((a, b) => a + b);
      temp1 = temp / allGrades.length;
      myAverage = double.parse(temp1.toStringAsFixed(2));
    } catch (err) {
      print(err);
    }

    return myAverage;
  }

  double bestCase() {
    double myBestCase = 0;
    int selectedModules = 0;
    List<double> allGrades = new List<double>();
    allGrades = ModuleController().getAllDoneGrades();
    double temp;
    double selectedModuleAverage;
    try {
      selectedModules =
          ModuleController().getAllSelectedModulesWidgets().length;
      selectedModuleAverage = selectedModules * 1 / selectedModules;

      temp = ((average() * allGrades.length) +
              (selectedModuleAverage * selectedModules)) /
          (allGrades.length + selectedModules);
      myBestCase = double.parse(temp.toStringAsFixed(2));
    } catch (err) {
      print(err);
      return 0.0;
    }
    if (myBestCase.isNaN) {
      return 0.0;
    } else
      return myBestCase;
  }

  double worstCase() {
    double myWorstCase = 0;
    int selectedModules = 0;
    double temp;
    List<double> allGrades = new List<double>();
    allGrades = ModuleController().getAllDoneGrades();
    double selectedModuleAverage;
    try {
      selectedModules =
          ModuleController().getAllSelectedModulesWidgets().length;
      selectedModuleAverage = selectedModules * 4 / selectedModules;
      temp = ((average() * allGrades.length) +
              (selectedModuleAverage * selectedModules)) /
          (allGrades.length + selectedModules);
      myWorstCase = double.parse(temp.toStringAsFixed(2));
    } catch (err) {
      print(err);
      return 0.0;
    }
    if (myWorstCase.isNaN) {
      return 0.0;
    } else
      return myWorstCase;
  }
}
