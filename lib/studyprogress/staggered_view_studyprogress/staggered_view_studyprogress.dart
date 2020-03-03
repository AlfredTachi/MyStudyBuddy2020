import 'package:MyStudyBuddy2/local_database/local_database.dart';
import 'package:MyStudyBuddy2/singleton/module_controller.dart';
import 'package:flutter/material.dart';

class StaggeredView extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _StaggeredViewState();
  }
}

class _StaggeredViewState extends State<StaggeredView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: generateSemesterTiles(),
        ),
      ),
    );
  }

  List<Widget> generateSemesterTiles() {
    List<Widget> _semesterTiles = new List<Widget>();
    for (int i = 1; i <= 7; i++) {
      _semesterTiles.add(semester(i));
    }
    return _semesterTiles;
  }

  Widget semester(int titleIndex) {
    String title = titleIndex.toString() + ". Semester";
    return Padding(
      padding: const EdgeInsets.only(top: 5, bottom: 5, left: 3, right: 3),
      child: Material(
        elevation: 15,
        borderRadius: BorderRadius.circular(15.0),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Row(children: <Widget>[
                Align(
                  alignment: Alignment.topLeft,
                  child: Container(
                    child: Text(title,
                        style: TextStyle(
                          fontSize: 20,
                          color: Color(0xFF013D62),
                        )),
                  ),
                ),
                Expanded(
                  child: Container(
                      margin: const EdgeInsets.only(left: 10.0, right: 10.0),
                      child: Divider(
                        color: Color(0xFF013D62),
                        height: 36,
                        thickness: 1,
                      )),
                ),
              ]),
              FutureBuilder(
                future: DBProvider.db.readAllModules(),
                builder: (BuildContext context, AsyncSnapshot snapshot) {
                  if (snapshot.connectionState == ConnectionState.done) {
                    return new Center(
                        child: Wrap(
                      direction: Axis.horizontal,
                      runSpacing: 5,
                      children: ModuleController().getAllSemesterModulesWidgets(titleIndex),
                    ));
                  } else {
                    return new Text("Loading...");
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
