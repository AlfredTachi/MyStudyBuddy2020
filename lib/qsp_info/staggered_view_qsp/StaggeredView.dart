import 'package:MyStudyBuddy2/qsp_info/q_s_p_info_icons_icons.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:flutter/material.dart';
import 'package:percent_indicator/percent_indicator.dart';

/*Material progress(ProgressBar progressBar) {
  return Material(
    elevation: 14.0,
    borderRadius: BorderRadius.circular(24.0),
    child: ProgressBar(),
  );
}*/

Material qspdetails(
  IconData icon,
  String qsptitle,
  String qspinfo,
  BuildContext context,
  double percent,
  String text,
) {
  return Material(
      elevation: 14.0,
      borderRadius: BorderRadius.circular(24.0),
      child: Padding(
        padding: EdgeInsets.all(8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Padding(padding: EdgeInsets.fromLTRB(0,0,0,25)),
                Column(children: <Widget>[
                  Padding(padding: EdgeInsets.fromLTRB(0,0,25,0)),
                  Icon(icon, size: 40),
                ]),
                Column(children: <Widget>[Text("  ")]),
                Column(children: <Widget>[
                  Padding(padding: EdgeInsets.fromLTRB(25.0,0,0,0)),                  
                  Text(qsptitle),
                ]),
              ],
            ),
            Row(children: <Widget>[Text(" ")]),
            Row(
              children: <Widget>[
                Padding(padding: EdgeInsets.fromLTRB(15,0,0,15)),
                Flexible(child: Text(qspinfo)),
              ],
            ),
            Row(
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.fromLTRB(15,15,0,0),
                  child: new LinearPercentIndicator(
                              width: MediaQuery.of(context).size.width - 50,
                              lineHeight: 20.0,
                              percent: percent,
                              center: Text(text),
                              linearStrokeCap: LinearStrokeCap.roundAll,
                              progressColor: Colors.amber,
                          ),
                  ),
                ]
              ),
            ],
          ),
        )
      );
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
    return Material(
      child: Scaffold(
        body: StaggeredGridView.count(
          crossAxisCount: 1,
          crossAxisSpacing: 5,
          mainAxisSpacing: 5,
          children: <Widget>[
            qspdetails(
              QSPInfoIcons.software_icon,
              "Software-Konstruktion",
              "Die Module dieses Qualifikations schwerpunkts vertiefen klassische Informatik-Themen," +
                  "die auf die professionelle Konstruktion komplexer Software-Anwendungen vorbereiten.",
              context,
              3/5,
              "3/5"
            ),
            qspdetails(
              QSPInfoIcons.medieninformatik_icon,
              "Medieninformatik",
              "Die Medieninformatik konzentriert sich auf die Teile der Informatik und ihres Umfelds," +
                  "die in direktem Kontakt zu Benutzer/innen, also zu Menschen stehen.",
              context,
              2/5,
              "2/5"
            ),
            qspdetails(
              QSPInfoIcons.cloud_icon,
              "Cloud und Internet",
              "Im Qualifikationsschwerpunkt „Cloud und Internet“ dreht es sich verstärkt um Themen der Infrastruktur, " +
                  "d.h. insbesondere Rechnersysteme und Netzwerke,die zur Bereitstellung der heutigen netzwerkbasierten" +
                  "Services erforderlich sind.",
              context,
              5/5,
              "5/5"
            )
          ],
          staggeredTiles: [
            StaggeredTile.extent(1, screenHeight / 3),
            StaggeredTile.extent(1, screenHeight / 3.2),
            StaggeredTile.extent(1, screenHeight / 2.75),
          ],
        ),
      ),
    );
  }
}
