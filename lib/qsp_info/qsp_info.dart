import 'package:MyStudyBuddy2/link/link.dart';
import 'package:MyStudyBuddy2/model/module.dart';
import 'package:MyStudyBuddy2/qsp_info/qsp_info_icons.dart';
import 'package:MyStudyBuddy2/singleton/module_controller.dart';
import 'package:MyStudyBuddy2/singleton/profile_controller.dart';
import 'package:flutter/material.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:validators/validators.dart';

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
                  ProfileController().getSED() / 5,
                  ProfileController().getSED().toString() + "/5",
                  "Für mehr Infos hier klicken",
                  "https://www.hs-worms.de/software-konstruktion/"),
              qspdetails(
                  QSPInfoIcons.medieninformatik_icon,
                  "Visual Computing (VC)",
                  "Die Medieninformatik konzentriert sich auf die Teile der Informatik und ihres Umfelds," +
                      "die in direktem Kontakt zu Benutzer/innen, also zu Menschen stehen.",
                  ProfileController().getVC() / 5,
                  ProfileController().getVC().toString() + "/5",
                  "Für mehr Infos hier klicken",
                  "https://www.hs-worms.de/medieninformatik/"),
              qspdetails(
                  QSPInfoIcons.cloud_icon,
                  "Security and Networks (SN)",
                  "Im Qualifikationsschwerpunkt „Cloud und Internet“ dreht es sich verstärkt um Themen der Infrastruktur, " +
                      "d.h. insbesondere Rechnersysteme und Netzwerke,die zur Bereitstellung der heutigen netzwerkbasierten" +
                      "Services erforderlich sind.",
                  ProfileController().getNC() / 5,
                  ProfileController().getNC().toString() + "/5",
                  "Für mehr Infos hier klicken",
                  "https://www.hs-worms.de/cloud-internet/")
            ],
          ),
        ));
  }

  Widget qspdetails(
    IconData icon,
    String qspTitle,
    String qspInfo,
    double progressBarPercent,
    String progressBarText,
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
                      child: Text(qspTitle,
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
                    qspInfo,
                    style: TextStyle(fontSize: 15),
                  )),
                ],
              ),
            ),
            Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.only(left: 30),
                          child: Link(
                              child: Text(
                                urltitle,
                                style: TextStyle(
                                    color: Colors.blue[700], fontSize: 14),
                              ),
                              url: url),
                        ),
                      ),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.only(bottom: 5),
                          child: Align(
                            alignment: Alignment.topRight,
                            child: RaisedButton(
                              color: Colors.orange,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(20),
                                bottomLeft: Radius.circular(20),
                              )),
                              elevation: 5,
                              onPressed: () {
                                ProfileController().getQSPController().text =
                                    qspTitle;
                                Navigator.of(context).pop();
                              },
                              child: Text("QSP planen"),
                            ),
                          ),
                        ),
                      ),
                    ],
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
                            percent: progressBarPercent,
                            center: FittedBox(child: Text(progressBarText)),
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

  void qspModule() {
    int sed = 0;
    int vc = 0;
    int nc = 0;
    List<Module> _modules = ModuleController().getAllDoneModules();
    for (var i = 0; i < _modules.length; i++) {
      if (_modules[i].qsp.contains("SED")) {
        sed++;
      }
      if (_modules[i].qsp.contains("VC")) {
        vc++;
      }
      if (_modules[i].qsp.contains("NC")) {
        nc++;
      }
    }
    ProfileController().setSED(sed);
    ProfileController().setVC(vc);
    ProfileController().setNC(nc);
  }
}
