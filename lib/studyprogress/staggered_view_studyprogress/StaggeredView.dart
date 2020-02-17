import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:flutter/material.dart';

Material semester(String heading) {
  return Material(
      color: Colors.white,
      elevation: 2.0,
      shadowColor: Colors.black,
      borderRadius: BorderRadius.circular(12.0),
      child: Padding(
        padding: EdgeInsets.all(8),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Row(children: <Widget>[
              Align(
                alignment: Alignment.topLeft,
                child: Container(
                  child: Text(heading,
                      style: TextStyle(fontSize: 20, color: Color(0xFF0D3661))),
                ),
              ),
              Expanded(
                child: new Container(
                    margin: const EdgeInsets.only(left: 10.0, right: 10.0),
                    child: Divider(
                      color: Color(0xFF0D3661),
                      height: 36,
                      thickness: 1,
                    )),
              ),
            ]),
            Row(
              children: <Widget>[
                module("test!"),
              ],
            ),
          ],
        ),
      ));
}

Material module(String heading) {
  return Material(
      color: Color(0xFF0D3661),
      elevation: 1.0,
      shadowColor: Colors.black,
      borderRadius: BorderRadius.circular(12.0),
      child: Padding(
        padding: EdgeInsets.all(4),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Row(children: <Widget>[
              Align(
                alignment: Alignment.center,
                child: Container(
                  height: 40,
                  width: 40,
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

class StaggeredView extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _StaggeredViewState();
  }
}

class _StaggeredViewState extends State<StaggeredView> {
  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    return MaterialApp(
      debugShowCheckedModeBanner: true,
      home: Scaffold(
        body: StaggeredGridView.count(
          padding: EdgeInsets.all(8.0),
          crossAxisCount: 2,
          crossAxisSpacing: 5,
          mainAxisSpacing: 5,
          children: [
            Stack(
              children: ListMySemester(),
              //semester("1. Semester"),
            ),
          ],
          staggeredTiles: [
            StaggeredTile.extent(2, screenHeight / 4),
          ],
        ),
      ),
    );
  }
}

List<Widget> ListMySemester() {
  List<Widget> list = new List();
  for (int i = 0; i < 5; i++) {
    list.add(semester((i + 1).toString() + " Semester"));
    //list.add(new Text((i + 1).toString() + " Semester"));
    i++;
  }
  return list;
}
