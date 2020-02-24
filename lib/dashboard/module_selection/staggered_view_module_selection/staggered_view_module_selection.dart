import 'package:MyStudyBuddy2/singleton/module_controller.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
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
      body: StaggeredGridView.count(
        padding: EdgeInsets.all(8.0),
        crossAxisCount: 2,
        crossAxisSpacing: 5,
        mainAxisSpacing: 5,
        children: mySemester(),
        staggeredTiles: mySemesterTiles(context),
      ),
    );
  }

  List<Widget> mySemester() {
    List<Widget> list = new List();
    for (int i = 1; i <= 5; i++) {
      list.add(semester(i));
    }
    return list;
  }

  List<StaggeredTile> mySemesterTiles(context) {
    List<StaggeredTile> list = new List();
    double screenHeight = MediaQuery.of(context).size.height / 2.5;
    for (int i = 1; i <= 5; i++) {
      list.add(StaggeredTile.extent(2, screenHeight));
    }
    return list;
  }

  Widget semester(int titleIndex) {
    String title = titleIndex.toString() + ". Semester";
    return Padding(
      padding: EdgeInsets.all(3),
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
              child: new Container(
                  margin: const EdgeInsets.only(left: 10.0, right: 10.0),
                  child: Divider(
                    color: Color(0xFF013D62),
                    height: 36,
                    thickness: 1,
                  )),
            ),
          ]),
          Expanded(
            child: new Container(
              child: GridView.count(
                primary: false,
                crossAxisCount: 4,
                crossAxisSpacing: 5,
                mainAxisSpacing: 5,
                children: ModuleController().getAllModulesWidgets(),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
