import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:flutter/material.dart';
import '../drawer/drawer.dart';

Material gradesAverage(IconData icon, String text, double grade) {
  return Material(
    color: Colors.white,
    elevation: 14.0,
    shadowColor: Colors.black,
    borderRadius: BorderRadius.circular(24.0),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Padding(padding:EdgeInsets.all(5),child: Icon(icon)),
        Padding(padding:EdgeInsets.all(5),child: Text(text, style: TextStyle(fontSize: 30))),
        Padding(
          padding:EdgeInsets.all(5),
          child: Text(
            grade.toString(),
            style: TextStyle(fontSize: 30),
          ),
        )
      ],
    ),
  );
}

Material bestPossible(String best, IconData icon, double grade) {
  return Material(
    color: Colors.white,
    elevation: 14.0,
    shadowColor: Colors.black,
    borderRadius: BorderRadius.circular(24.0),
    child: Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
        Text(
          best,
          style: TextStyle(fontSize: 20),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Icon(icon, size: 30, color: Colors.green),
            Text(grade.toString(), style: TextStyle(fontSize: 30))
          ],
        ),
      ]),
    ),
  );
}

Material worstPossible(String worst, IconData icon, double grade) {
  return Material(
    color: Colors.white,
    elevation: 14.0,
    shadowColor: Colors.black,
    borderRadius: BorderRadius.circular(24.0),
    child: Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
        Text(
          worst,
          style: TextStyle(fontSize: 20),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Icon(icon, size: 30, color: Colors.red),
            Text(grade.toString(), style: TextStyle(fontSize: 30))
          ],
        ),
      ]),
    ),
  );
}

Material openModules(String modules) {
  return Material(
    color: Colors.white,
    elevation: 14.0,
    shadowColor: Colors.black,
    borderRadius: BorderRadius.circular(24.0),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(top: 8.0),
          child: Text(
            modules,
            style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
          ),
        )
      ],
    ),
  );
}

class GradesPrognosis extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _GradesPrognosisState();
  }
}

class _GradesPrognosisState extends State<GradesPrognosis> {
  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    return 
        Scaffold(
            appBar: AppBar(title: Text('Notenübersicht')),
            drawer: OwnDrawer(),
            body: StaggeredGridView.count(
                crossAxisCount: 2,
                crossAxisSpacing: 5,
                mainAxisSpacing: 5,
                children: <Widget>[
                  gradesAverage(Icons.check, "Notendurchschnitt:", 5.0),
                  bestPossible("Best case:", Icons.thumb_up, 5.0),
                  worstPossible(
                      "Worse case:", Icons.thumb_down, 5.0),
                  openModules("Aktuell geplante Module:")
                ],
                staggeredTiles: [
                  StaggeredTile.extent(2, screenHeight / 4),
                  StaggeredTile.extent(1, screenHeight / 5),
                  StaggeredTile.extent(1, screenHeight / 5),
                  StaggeredTile.extent(2, screenHeight / 2),
                ]));
  }
}
