import 'dart:async';

import 'package:MyStudyBuddy2/dashboard/profile_page/achievement/achievement.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'dart:io';

class MensaPlan extends StatefulWidget {
  @override
  MensaPlanState createState() => MensaPlanState();
}

class MensaPlanState extends State<MensaPlan> {
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
        body: FutureBuilder(
          future: loadPage(),
          builder: (BuildContext context, AsyncSnapshot snap) {
            if (snap.connectionState == ConnectionState.done) {
              WidgetsBinding.instance.addPostFrameCallback((_) {
                Achievement().showAchievement(context, 10);
              });
              return WebView(
                initialUrl: 'https://stw-vp.de/de/mensa-webapp',
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
    await http.get('https://stw-vp.de/de/mensa-webapp');
  }

  Widget getCupertinoDesign() {
    return getMaterialDesign();
  }
}
