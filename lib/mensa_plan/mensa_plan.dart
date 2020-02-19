import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/semantics.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'dart:io';

import 'package:MyStudyBuddy2/drawer/drawer.dart';

class MensaPlan extends StatefulWidget {
  @override
  MensaPlanState createState() => MensaPlanState();
}

class MensaPlanState extends State<MensaPlan> {
  num _viewIndex = 0;
  bool _hasLoaded = false;

  @override
  Widget build(BuildContext context) {
    if (Platform.isIOS) {
      return getCupertinoDesign();
    } else {
      return getMaterialDesign();
    }
  }

  Widget getMaterialDesign() {
    return Scaffold(
      appBar: AppBar(
        title: Text("Mensa Plan"),
      ),
      drawer: OwnDrawer(),
      body: IndexedStack(
        index: _viewIndex,
        children: <Widget>[
          Center(child: CircularProgressIndicator()),
          WebView(
            initialUrl: 'https://stw-vp.de/de/mensa-webapp',
            javascriptMode: JavascriptMode.unrestricted,
            onPageStarted: checkTimeOut,
            onPageFinished: pageFinishedLoading,
          ),
          Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.only(left: 20, right: 20, bottom: 20),
                  child: Text(
                    "Es gibt ein Problem bei der Verbindung. Prüfe deine Internetverbindung",
                    textAlign: TextAlign.center,
                  ),
                ),
                IconButton(
                    icon: Icon(Icons.refresh),
                    onPressed: () {
                      pageReload();
                    })
              ]),
        ],
      ),
    );
  }

  Widget getCupertinoDesign() {
    return getMaterialDesign();
  }

  void pageReload() {
    setState(() {
      Navigator.popAndPushNamed(context, '/mensa_plan');
    });
  }

  void pageFinishedLoading(String url) {
    setState(() {
      _hasLoaded = true;
      _viewIndex = 1;
    });
  }

  void checkTimeOut(String url) async {
    Future.delayed(Duration(seconds: 10), () {
      setState(() {
        if (_hasLoaded == false) {
          _viewIndex = 2;
        }
      });
    });
  }
}
