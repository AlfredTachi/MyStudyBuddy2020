import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:flutter/material.dart';
import '../progress_bar/progress_bar.dart';

final List<Widget> myCourses = [];

Material progress(Widget progressBar) {
  return Material(
    elevation: 14.0,
    borderRadius: BorderRadius.circular(24.0),
    child: progressBar,
  );
}

Material persondetails(IconData icon, String infnumber, IconData icontwo,
    String special, BuildContext context) {
  return Material(
      elevation: 14.0,
      borderRadius: BorderRadius.circular(24.0),
      child: Padding(
        padding: EdgeInsets.all(8),
        child: Row(
          children: <Widget>[
            Expanded(
                child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Padding(padding: EdgeInsets.only(left: 15)),
                Icon(icon),
                Text(infnumber, style: TextStyle(fontSize: 20)),
              ],
            )),
            VerticalDivider(),
            Expanded(
                child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(context, '/qspinfo');
                  },
                  child: Row(
                    children: <Widget>[
                      Icon(icontwo),
                      Text(special,
                          style: TextStyle(
                              fontSize: 20,
                              decoration: TextDecoration.underline)),
                    ],
                  ),
                )
              ],
            ))
          ],
        ),
      ));
}

Material grades(String heading, double grades) {
  return Material(
      elevation: 14.0,
      borderRadius: BorderRadius.circular(24.0),
      child: Padding(
        padding: EdgeInsets.all(8),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            FittedBox(
                fit: BoxFit.cover,
                child: Text(heading, style: TextStyle(fontSize: 20))),
            FittedBox(
                fit: BoxFit.cover,
                child: Text(grades.toString(), style: TextStyle(fontSize: 20)))
          ],
        ),
      ));
}

Material module(String heading) {
  return Material(
    elevation: 14.0,
    shadowColor: Colors.black,
    borderRadius: BorderRadius.circular(24.0),
    child: Padding(
      padding: EdgeInsets.all(8),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              Padding(
                padding: EdgeInsets.fromLTRB(16, 16, 0, 0),
                child: Text(heading, style: TextStyle(fontSize: 25)),
              ),
            ],
          ),
          Expanded(
            child: new Container(
              child: (myCourses.length == 0)
                  ? Center(child: Text("Du hast zurzeit keine Module geplant!"))
                  : GridView.count(
                      primary: false,
                      crossAxisCount: 4,
                      crossAxisSpacing: 5,
                      mainAxisSpacing: 5,
                      children: myCourses,
                    ),
            ),
          ),
        ],
      ),
    ),
  );
}

class StaggeredView extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _StaggeredViewState();
  }
}

int _creditPoints = 0;
int _maxCreditPoints = 210;

class _StaggeredViewState extends State<StaggeredView> {
  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      body: StaggeredGridView.count(
        crossAxisCount: 2,
        crossAxisSpacing: 5,
        mainAxisSpacing: 5,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(left: 5, right: 5, top: 5),
            child: progress(GestureDetector(
                onTap: () {
                  setState(() {
                    _creditPoints += 6;
                  });
                },
                child: ProgressBar(_creditPoints, _maxCreditPoints))),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 5, right: 5),
            child: persondetails(
                Icons.person, "inf2730", Icons.work, "SED", context),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 5, right: 5, bottom: 5),
            child: module("Deine Module"),
          ),
        ],
        staggeredTiles: [
          StaggeredTile.extent(2, screenHeight / 3),
          StaggeredTile.extent(2, screenHeight / 8),
          StaggeredTile.extent(2, screenHeight / 2),
        ],
      ),
    );
  }
}
