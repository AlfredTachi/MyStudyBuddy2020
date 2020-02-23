import 'package:MyStudyBuddy2/model/module.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:flutter/material.dart';

Module myModule = Module(0, "");
final List<Widget> myModules = [];

Material module(String heading) {
  return Material(
      color: Color(0xFF013D62),
      elevation: 3.0,
      shadowColor: Colors.black,
      borderRadius: BorderRadius.circular(12.0),
      child: Padding(
        padding: EdgeInsets.all(12),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Row(children: <Widget>[
              Align(
                alignment: Alignment.center,
                child: Container(
                  child: Center(
                    child: Text(heading,
                        style: TextStyle(fontSize: 20, color: Colors.white)),
                  ),
                ),
              ),
            ]),
          ],
        ),
      ));
}

class StaggeredViewWPF extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _StaggeredViewState();
  }
}

class _StaggeredViewState extends State<StaggeredViewWPF> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Expanded(
            child: new Container(
              padding: EdgeInsets.fromLTRB(8, 8, 8, 0),
              child: StaggeredGridView.count(
                padding: EdgeInsets.all(8.0),
                crossAxisCount: 4,
                crossAxisSpacing: 5,
                mainAxisSpacing: 5,
                children: myModules(),
                staggeredTiles: myModulesTiles(context),
              ),
            ),
          ),
        ],
      ),
    );
  }

  List<StaggeredTile> myModulesTiles(context) {
    List<StaggeredTile> list = new List();
    double screenHeight = MediaQuery.of(context).size.height;
    for (int i = 1; i <= 5; i++) {
      list.add(StaggeredTile.extent(1, screenHeight / 8));
    }
    return list;
  }

  List<Widget> myModules() {
    List<Widget> list = new List();
    for (int i = 1; i <= 7; i++) {
      myModule = Module(i, (i.toString() + ". M").toString());
      list.add(myModule.module());
    }
    return list;
  }
}
