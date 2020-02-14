import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'dart:async';

import 'package:MyStudyBuddy2/drawer/drawer.dart';

class MensaPlan extends StatefulWidget {
  @override
  MensaPlanState createState() => MensaPlanState();
}

class MensaPlanState extends State<MensaPlan> {
  Map<String, double> dataMap = new Map();
  Completer<WebViewController> _controller = Completer<WebViewController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("MyStudyBuddy"),
      ),
      drawer: OwnDrawer(),
      body: buildMensaWebApp(context),
    );
  }

  WebView buildMensaWebApp(BuildContext context) {
    return WebView(
        initialUrl: 'https://stw-vp.de/de/mensa-webapp/',
        javascriptMode: JavascriptMode.unrestricted,
        onWebViewCreated: (WebViewController webViewController) {
          _controller.complete(webViewController);
        });
  }
}
