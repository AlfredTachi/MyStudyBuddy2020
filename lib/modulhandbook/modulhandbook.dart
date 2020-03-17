import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'dart:io';


class ModuleHandbooks extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => ModuleHandbooksState();
}

class ModuleHandbooksState extends State<ModuleHandbooks> {
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
    return SafeArea(
          child: Scaffold(
        body: Column(
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
            Expanded(
                        child: IndexedStack(
                index: _viewIndex,
                children: <Widget>[
                  Center(child: CircularProgressIndicator()),
                  WebView(
                    initialUrl: 'https://hswocloud.hs-worms.de/hswocloud/index.php/s/9j6tyjaazmFKnNC',
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
            ),
          ],
        ),
      ),
    );
  }

  Widget getCupertinoDesign() {
    return getMaterialDesign();
  }

  void pageReload() {
    setState(() {
      Navigator.popAndPushNamed(context, '/modulhandbook');
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