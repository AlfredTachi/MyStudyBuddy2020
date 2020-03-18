import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:webview_flutter/webview_flutter.dart';
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
        appBar: AppBar(
      ),
        body: FutureBuilder(
          future: loadPage(),
          builder: (BuildContext context, AsyncSnapshot snap) {
            if (snap.connectionState == ConnectionState.done) {
              return WebView(
                initialUrl: "https://atlas.ai.it.hs-worms.de/datenschutz/",
                javascriptMode: JavascriptMode.unrestricted,
              );
            } else if (snap.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            } else {
              return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.only(left: 20, right: 20, bottom: 20),
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
    );
  }

  Future<void> loadPage() async {
    await http.get("https://atlas.ai.it.hs-worms.de/datenschutz/");
  }

  Widget getCupertinoDesign() {
    return getMaterialDesign();
  }
}