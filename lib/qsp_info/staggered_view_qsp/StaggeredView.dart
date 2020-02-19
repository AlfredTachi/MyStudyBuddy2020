import 'package:MyStudyBuddy2/qsp_info/q_s_p_info_icons_icons.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:flutter/material.dart';

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
                Column(children: <Widget>[
                  Icon(icon, size: 40),
                ]),
                Column(children: <Widget>[
                  Text("  "),
                ]),                
                Column(children: <Widget>[
                  Text(qsptitle),
                ])
              ],
            ),
             Row(children: <Widget>[Text("")]),
            Row(children: <Widget>[Flexible(child: Text(qspinfo))]),
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
    return Material(
      child: Scaffold(
        body: StaggeredGridView.count(
          crossAxisCount: 1,
          crossAxisSpacing: 5,
          mainAxisSpacing: 5,
          children: <Widget>[
            qspdetails(QSPInfoIcons.software_icon, "Software-Konstruktion",
                "Die Module dieses Qualifikations schwerpunkts vertiefen klassische Informatik-Themen, die auf die professionelle Konstruktion komplexer Software-Anwendungen vorbereiten."),
            qspdetails(QSPInfoIcons.medieninformatik_icon, "Medieninformatik",
                "Die Medieninformatik konzentriert sich auf die Teile der Informatik und ihres Umfelds, die in direktem Kontakt zu Benutzer/innen, also zu Menschen stehen."),
            qspdetails(QSPInfoIcons.cloud_icon, "Cloud und Internet",
                "Im Qualifikationsschwerpunkt „Cloud und Internet“ dreht es sich verstärkt um Themen der Infrastruktur, d.h. insbesondere Rechnersysteme und Netzwerke,die zur Bereitstellung der heutigen netzwerkbasierten Services erforderlich sind.")
          ],
          staggeredTiles: [
            StaggeredTile.extent(1, screenHeight / 2),
            StaggeredTile.extent(1, screenHeight / 2),
            StaggeredTile.extent(1, screenHeight / 2),
          ],
        ),
      ),
    );
  }
}
