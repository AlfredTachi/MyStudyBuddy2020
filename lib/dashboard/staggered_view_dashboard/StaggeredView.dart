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

Material persondetails(
    IconData icon, String infnumber, IconData icontwo, String special) {
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
            Row(
              children: <Widget>[
                Icon(icon),
                Text(infnumber, style: TextStyle(fontSize: 20)),
              ],
            ),
            Row(
              children: <Widget>[
                Icon(icontwo),
                Flexible(child: Text(special, style: TextStyle(fontSize: 20))),
              ],
            )
          ],
        ),
      ));
}

Material grades(IconData icon, String heading, double grades) {
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
            Icon(icon),
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
            persondetails(
                Icons.person, "inf2730", Icons.work, "Software Konstruktion"),
            grades(Icons.local_library, "Notendurchschnitt:", 5.0),
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
