import 'package:MyStudyBuddy2/local_database/local_database.dart';
import 'package:MyStudyBuddy2/singleton/module_controller.dart';
import 'package:flutter/material.dart';

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
    return SafeArea(
          child: Scaffold(
          /*appBar: AppBar(
            title: Text("Noten Rechner"),
            actions: <Widget>[
              IconButton(
                  icon: Icon(Icons.format_list_numbered),
                  onPressed: () {
                    Navigator.of(context).pushNamed("/gradesList");
                  })
            ],
          ),*/
          body: Column(
        children: <Widget>[
          Row(
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
                        topRight: Radius.circular(15),
                        bottomRight: Radius.circular(15),
                      )),
                      onPressed: () {
                        Navigator.of(context).pushNamed("/gradesList");
                      }),
                ),
              ),
            ],
          ),
          Expanded(
            flex: 4,
            child: Container(
                child: Padding(
              padding: const EdgeInsets.only(top: 40.0),
              child: Center(
                child: Column(children: [
                  Text("Durchschnitt:", style: TextStyle(fontSize: 25)),
                  Text(average().toString())
                ]),
              ),
            )),
          ),
          Expanded(
            flex: 6,
            child: Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
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
                        child: Text("Worst Case:"),
                      ),
                      Text(worstCase().toString()),
                      Padding(
                        padding: const EdgeInsets.only(top: 20),
                        child: Text("Best Case:"),
                      ),
                      Text(bestCase().toString())
                    ],
                  ),
                )),
          ),
        ],
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
