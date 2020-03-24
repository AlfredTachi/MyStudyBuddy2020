import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:MyStudyBuddy2/link/link.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:MyStudyBuddy2/theme/styles.dart';
import 'dart:io';

class OurPrivacyPolice extends StatefulWidget {
  @override
  OurPrivacyPoliceState createState() => OurPrivacyPoliceState();
}

class OurPrivacyPoliceState extends State<OurPrivacyPolice> {
  get http => null;

  @override
  Widget build(BuildContext context) {
    if (Platform.isIOS) {
      return getCupertinoDesign();
    } else {
      return getMaterialDesign();
    }
  }

  Widget getMaterialDesign() {
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: <Widget>[
            Container(
              color: Colors.orange,
              child: Align(
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
            ),
            Expanded(
              child: FutureBuilder(
                future: loadPage(),
                builder: (BuildContext context, AsyncSnapshot snap) {
                  if (snap.connectionState == ConnectionState.done) {
                    return WebView(
                      initialUrl:
                          "https://atlas.ai.it.hs-worms.de/datenschutz/",
                      javascriptMode: JavascriptMode.unrestricted,
                    );
                  } else if (snap.connectionState == ConnectionState.waiting) {
                    return Center(
                        child: (Platform.isIOS)
                            ? CupertinoActivityIndicator()
                            : CircularProgressIndicator());
                  } else {
                    return Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Padding(
                            padding: EdgeInsets.only(
                                left: 20, right: 20, bottom: 20),
                            child: Text(
                              "Es gibt ein Problem bei der Verbindung. Prüfe deine Internetverbindung",
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ]);
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> loadPage() async {
    await http.get("https://atlas.ai.it.hs-worms.de/datenschutz/");
  }

  Widget getCupertinoDesign() {
    final Link datenschutzLink = Link(
      child: Text("https://atlas.ai.it.hs-worms.de/datenschutz/"),
      url: "https://atlas.ai.it.hs-worms.de/datenschutz/",
    );
    return Scaffold(
      appBar: CupertinoNavigationBar(
        actionsForegroundColor: CupertinoColors.activeOrange,
        middle: Text(
          "Datenschutzerklärung",
          style: Styles.navBarTitle,
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Padding(
                padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 15.0),
                child: PhysicalModel(
                    shape: BoxShape.rectangle,
                    borderRadius: BorderRadius.circular(15),
                    color: CupertinoColors.white,
                    child: Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Center(
                            child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                              Padding(
                                padding: const EdgeInsets.only(bottom: 10.0),
                                child: Text(
                                  "Diese App speichert alle Nutzerdaten ausschließlich auf Ihrem lokalen Gerät. Eine Übertragung finden nur durch den Aufruf von verlinkten Webseiten oder die Nutzung von APIs (LSF Daten abrufen, \"Moralische Unterstützung\").",
                                  textAlign: TextAlign.center,
                                  style: Styles.detailsDescriptionText,
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(bottom: 10.0),
                                child: Text(
                                  "Welche Daten übertragen werden, finden Sie in den Datenschutzerklärungen der jeweiligen Dienste und Webseiten. Die Datenschutzerklärungen, die nicht über die verlinkten Webseiten verfügbar sind, wurden unter dem Menüpunkt \"Hilfe > Datenschutz\" verlinkt.",
                                  textAlign: TextAlign.center,
                                  style: Styles.detailsDescriptionText,
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(bottom: 10.0),
                                child: Text(
                                  "Zusätzlich finden Sie hier die allgemeine Datenschutzerklärung des Studiengangs Angewandte Informatik der Hochschule Worms: ",
                                  textAlign: TextAlign.center,
                                  style: Styles.detailsDescriptionText,
                                ),
                              ),
                              CupertinoButton(
                                  minSize:
                                      Styles.detailsDescriptionText.fontSize,
                                  padding: EdgeInsets.all(0),
                                  child: datenschutzLink.child,
                                  onPressed: () {
                                    datenschutzLink.press();
                                  }),
                            ]))))),
          ],
        ),
      ),
    );
  }
}
