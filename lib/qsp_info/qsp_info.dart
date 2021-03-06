import 'dart:io';
import 'package:MyStudyBuddy2/link/link.dart';
import 'package:MyStudyBuddy2/model/module.dart';
import 'package:MyStudyBuddy2/qsp_info/qsp_info_icons.dart';
import 'package:MyStudyBuddy2/singleton/module_controller.dart';
import 'package:MyStudyBuddy2/singleton/profile_controller.dart';
import 'package:MyStudyBuddy2/theme/styles.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

class QSPInfo extends StatefulWidget {
  QSPInfo();

  @override
  QSPInfoState createState() => QSPInfoState();
}

class QSPInfoState extends State<QSPInfo> {
  @override
  void initState() {
    super.initState();
    qspModule();
  }

  @override
  Widget build(BuildContext context) {
    return (Platform.isIOS)
        ? Scaffold(
            appBar: CupertinoNavigationBar(
              actionsForegroundColor: CupertinoColors.activeOrange,
              middle: Text(
                "QSP Auswahl",
                style: Styles.navBarTitle,
              ),
            ),
            body: Column(
              children: getColumnChildren(),
            ),
          )
        : SafeArea(
            child: Scaffold(
              body: Column(
                children: getColumnChildren(),
              ),
            ),
          );
  }

  List<Widget> getColumnChildren() {
    List<Widget> _list = List<Widget>();
    if (!Platform.isIOS) {
      _list.add(
        Container(
          color: Colors.orange,
          child: Row(
            children: <Widget>[
              Align(
                alignment: Alignment.topLeft,
                child: OutlineButton(
                    child: Padding(
                      padding: const EdgeInsets.only(top: 3, bottom: 3),
                      child: Icon(
                        Icons.arrow_back,
                        size: 36,
                      ),
                    ),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.only(
                      topRight: Radius.circular(15),
                      bottomRight: Radius.circular(15),
                    )),
                    onPressed: () {
                      Navigator.of(context).pop();
                    }),
              ),
              Align(
                  alignment: Alignment.topCenter,
                  child: Padding(
                      padding:
                          const EdgeInsets.only(left: 20, top: 3, bottom: 3),
                      child: Text(
                        "QSP Auswahl",
                        style: TextStyle(fontSize: 25),
                      ))),
            ],
          ),
        ),
      );
    }
    _list.add(Expanded(
        child: SingleChildScrollView(
      child: Column(
        children: <Widget>[
          qspdetails(
              QSPInfoIcons.software_icon,
              "Software Engineering and Development (SED)",
              "Die Module dieses Qualifikationsschwerpunkts vertiefen klassische Informatik-Themen, " +
                  "die auf die professionelle Konstruktion komplexer Software-Anwendungen vorbereiten.",
              ProfileController().getSED() / 5,
              ProfileController().getSED().toString() + "/5",
              "Für mehr Infos hier klicken",
              "https://www.hs-worms.de/software-konstruktion/"),
          qspdetails(
              QSPInfoIcons.medieninformatik_icon,
              "Visual Computing (VC)",
              "Der Schwerpunkt Visual Computing konzentriert sich auf die Teile der Informatik und ihres Umfelds," +
                  "die in direktem Kontakt zu Benutzer/innen, also zu Menschen stehen.",
              ProfileController().getVC() / 5,
              ProfileController().getVC().toString() + "/5",
              "Für mehr Infos hier klicken",
              "https://www.hs-worms.de/medieninformatik/"),
          qspdetails(
              QSPInfoIcons.cloud_icon,
              "Security and Networks (SN)",
              "Im Qualifikationsschwerpunkt „Security and Networks“ dreht es sich verstärkt um Themen der Infrastruktur, " +
                  "d.h. insbesondere Rechnersysteme und Netzwerke,die zur Bereitstellung der heutigen netzwerkbasierten" +
                  "Services erforderlich sind.",
              ProfileController().getNC() / 5,
              ProfileController().getNC().toString() + "/5",
              "Für mehr Infos hier klicken",
              "https://www.hs-worms.de/cloud-internet/"),
          if (Platform.isIOS)
            Container(
              height: 25.0,
            )
        ],
      ),
    )));
    return _list;
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
      padding: (Platform.isIOS)
          ? const EdgeInsets.symmetric(vertical: 10.0, horizontal: 15.0)
          : const EdgeInsets.all(3.0),
      child: Material(
        elevation: (Platform.isIOS) ? 0.0 : 14.0,
        borderRadius: BorderRadius.circular((Platform.isIOS) ? 15 : 24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: (Platform.isIOS)
                  ? const EdgeInsets.fromLTRB(18.0, 18.0, 18.0, 8)
                  : const EdgeInsets.all(10.0),
              child: FittedBox(
                fit: BoxFit.cover,
                child: Row(
                  children: <Widget>[
                    Icon(icon, size: 40),
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Text(qspTitle,
                          style: (Platform.isIOS)
                              ? Styles.qspDetailsTitle
                              : TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 14)),
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: (Platform.isIOS)
                  ? const EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0)
                  : const EdgeInsets.all(10.0),
              child: Row(
                children: <Widget>[
                  Flexible(
                      child: Text(
                    qspInfo,
                    style: (Platform.isIOS)
                        ? Styles.qspDetailsText
                        : TextStyle(fontSize: 15),
                  )),
                ],
              ),
            ),
            Column(crossAxisAlignment: CrossAxisAlignment.center, children: <
                Widget>[
              Row(
                children: <Widget>[
                  (Platform.isIOS)
                      ? (MediaQuery.of(context).size.width < 650)
                          ? Container(
                              width: 150,
                              child: CupertinoButton(
                                  padding: EdgeInsets.only(left: 20.0),
                                  child: Text(
                                    urltitle,
                                    style: Styles.qspLink,
                                  ),
                                  onPressed: () {
                                    _launchURL(url);
                                  }))
                          : CupertinoButton(
                              padding: EdgeInsets.only(left: 20.0),
                              child: Text(
                                urltitle,
                                style: Styles.qspLink,
                              ),
                              onPressed: () {
                                _launchURL(url);
                              })
                      : Expanded(
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
                  if (Platform.isIOS) Expanded(child: Container()),
                  (Platform.isIOS)
                      ? Padding(
                          padding: const EdgeInsets.only(right: 20.0),
                          child: CupertinoButton(
                              padding: EdgeInsets.only(left: 15, right: 15),
                              color: CupertinoColors.activeOrange,
                              child: Text(
                                "QSP planen",
                                style: Styles.qspLink,
                              ),
                              onPressed: () {
                                ProfileController().getQSPController().text =
                                    qspTitle;
                                Navigator.of(context).pop();
                              }),
                        )
                      : Expanded(
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
              Padding(
                padding: (Platform.isIOS)
                    ? const EdgeInsets.only(
                        top: 20, left: 20, right: 20, bottom: 20.0)
                    : const EdgeInsets.only(bottom: 12, left: 9.5, right: 9.5),
                child: LinearPercentIndicator(
                  lineHeight: 20.0,
                  percent: progressBarPercent,
                  center: FittedBox(child: Text(progressBarText)),
                  linearStrokeCap: LinearStrokeCap.roundAll,
                  progressColor: (Platform.isIOS)
                      ? CupertinoColors.activeOrange
                      : Colors.amber,
                ),
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
      if (_modules[i].properties.qsp.contains("SED")) {
        sed++;
      }
      if (_modules[i].properties.qsp.contains("VC")) {
        vc++;
      }
      if (_modules[i].properties.qsp.contains("SN")) {
        nc++;
      }
    }
    ProfileController().setSED(sed);
    ProfileController().setVC(vc);
    ProfileController().setNC(nc);
  }

  void _launchURL(String link) async {
    if (await canLaunch(link)) {
      await launch(link);
    } else {
      throw 'Could not launch $link';
    }
  }
}
