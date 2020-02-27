import 'package:MyStudyBuddy2/link/link.dart';
import 'package:MyStudyBuddy2/qsp_info/qsp_info_icons.dart';
import 'package:flutter/material.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

class QSPInfo extends StatefulWidget {

  QSPInfo();

  @override
  QSPInfoState createState() => QSPInfoState();
}

class QSPInfoState extends State<QSPInfo> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("QSP Informationen"),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              qspdetails(
                  QSPInfoIcons.software_icon,
                  "Software Engineering and Development (SED)",
                  "Die Module dieses Qualifikationsschwerpunkts vertiefen klassische Informatik-Themen," +
                      "die auf die professionelle Konstruktion komplexer Software-Anwendungen vorbereiten.",
                  context,
                  3 / 5,
                  "3/5",
                  "Für mehr Infos hier klicken",
                  "https://www.hs-worms.de/software-konstruktion/"),
              qspdetails(
                  QSPInfoIcons.medieninformatik_icon,
                  "Visual Computing (VC)",
                  "Die Medieninformatik konzentriert sich auf die Teile der Informatik und ihres Umfelds," +
                      "die in direktem Kontakt zu Benutzer/innen, also zu Menschen stehen.",
                  context,
                  2 / 5,
                  "2/5",
                  "Für mehr Infos hier klicken",
                  "https://www.hs-worms.de/medieninformatik/"),
              qspdetails(
                  QSPInfoIcons.cloud_icon,
                  "Security and Networks (SN)",
                  "Im Qualifikationsschwerpunkt „Cloud und Internet“ dreht es sich verstärkt um Themen der Infrastruktur, " +
                      "d.h. insbesondere Rechnersysteme und Netzwerke,die zur Bereitstellung der heutigen netzwerkbasierten" +
                      "Services erforderlich sind.",
                  context,
                  5 / 5,
                  "5/5",
                  "Für mehr Infos hier klicken",
                  "https://www.hs-worms.de/cloud-internet/")
            ],
          ),
        ));
  }

  Widget qspdetails(
    IconData icon,
    String qsptitle,
    String qspinfo,
    BuildContext context,
    double percent,
    String text,
    String urltitle,
    String url,
  ) {
    return Padding(
      padding: const EdgeInsets.all(3.0),
      child: Material(
        elevation: 14.0,
        borderRadius: BorderRadius.circular(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: FittedBox(
                fit: BoxFit.cover,
                child: Row(
                  children: <Widget>[
                    Icon(icon, size: 40),
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Text(qsptitle,
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 14)),
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Row(
                children: <Widget>[
                  Flexible(
                      child: Text(
                    qspinfo,
                    style: TextStyle(fontSize: 15),
                  )),
                ],
              ),
            ),
            Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Link(
                        child: Text(
                          urltitle,
                          style:
                              TextStyle(color: Colors.blue[700], fontSize: 14),
                        ),
                        url: url),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.only(bottom: 12),
                        child: FittedBox(
                          fit: BoxFit.cover,
                          child: LinearPercentIndicator(
                            width: MediaQuery.of(context).size.width - 50,
                            lineHeight: 20.0,
                            percent: percent,
                            center: FittedBox(child: Text(text)),
                            linearStrokeCap: LinearStrokeCap.roundAll,
                            progressColor: Colors.amber,
                          ),
                        ),
                      )
                    ],
                  )
                ]),
          ],
        ),
      ),
    );
  }
}
