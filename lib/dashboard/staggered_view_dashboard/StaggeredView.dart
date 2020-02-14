import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:flutter/material.dart';
import '../progress_bar/progress_bar.dart';

Material progress(ProgressBar progressBar) {
  return Material(
    color: Colors.white,
    elevation: 14.0,
    shadowColor: Colors.black,
    borderRadius: BorderRadius.circular(24.0),
    child: ProgressBar(),
  );
}

Material persondetails(String infnumber, String special) {
  return Material(
      color: Colors.white,
      elevation: 14.0,
      shadowColor: Colors.black,
      borderRadius: BorderRadius.circular(24.0),
      child: Padding(
        padding: EdgeInsets.all(8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(infnumber, style: TextStyle(fontSize: 20)),
            Text(special, style: TextStyle(fontSize: 20))
          ],
        ),
      ));
}

Material grades(String heading, double grades) {
  return Material(
      color: Colors.white,
      elevation: 14.0,
      shadowColor: Colors.black,
      borderRadius: BorderRadius.circular(24.0),
      child: Padding(
        padding: EdgeInsets.all(8),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(heading, style: TextStyle(fontSize: 20)),
            Text(grades.toString(), style: TextStyle(fontSize: 20))
          ],
        ),
      ));
}

Material module(String heading) {
  return Material(
      color: Colors.white,
      elevation: 14.0,
      shadowColor: Colors.black,
      borderRadius: BorderRadius.circular(24.0),
      child: Padding(
        padding: EdgeInsets.all(8),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(heading, style: TextStyle(fontSize: 25)),
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
    //double screenWidth = MediaQuery.of(context).size.width;
    return MaterialApp(
      debugShowCheckedModeBanner: true,
      home: Scaffold(
        body: StaggeredGridView.count(
          crossAxisCount: 2,
          crossAxisSpacing: 5,
          mainAxisSpacing: 5,
          children: <Widget>[
            progress(ProgressBar()),
            persondetails("inf2730", "Software Konstruktion"),
            grades("Notendurchschnitt:", 5.0),
            module("Deine Module")
          ],
          staggeredTiles: [
            StaggeredTile.extent(1, screenHeight / 3),
            StaggeredTile.extent(1, screenHeight / 6),
            StaggeredTile.extent(1, screenHeight / 6),
            StaggeredTile.extent(2, screenHeight / 2),
          ],
        ),
      ),
    );
  }
}
