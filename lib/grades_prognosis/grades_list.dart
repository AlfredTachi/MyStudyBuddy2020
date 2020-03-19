import 'package:MyStudyBuddy2/singleton/module_controller.dart';
import 'package:flutter/material.dart';

class GradesList extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return GradesListState();
  }
}

class GradesListState extends State<GradesList> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: <Widget>[
            Container(
              color: Colors.orange,
              child: Row(
                children: <Widget>[
                  Align(
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
                   Align(
                      alignment: Alignment.topCenter,
                      child: Padding(
                          padding: const EdgeInsets.only(left:20, top: 3, bottom: 3),
                          child: Text("Notenliste",style: TextStyle(fontSize: 25),))),
                ],
              ),
            ),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: createList(),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  List<Widget> createList() {
    List<double> grades = ModuleController().getAllDoneGrades();
    List<String> doneModules = ModuleController().getAllDoneModulesNames();
    List<Widget> _items = new List<Widget>();
    for (int i = 0; i < grades.length; i++) {
      Widget _listItem = Container(
        decoration: BoxDecoration(border: Border(bottom: BorderSide())),
        child: ListTile(
          title: Text("${doneModules[i]}"),
          subtitle: Text("${grades[i]}"),
        ),
      );
      _items.add(_listItem);
    }
    return _items;
  }
}
