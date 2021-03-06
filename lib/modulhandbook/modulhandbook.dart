import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:MyStudyBuddy2/theme/styles.dart';
import 'package:http/http.dart' as http;
import 'dart:io';

class ModuleHandbooks extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => ModuleHandbooksState();
}

class ModuleHandbooksState extends State<ModuleHandbooks> {
  @override
  Widget build(BuildContext context) {
    return (Platform.isIOS)
        ? Scaffold(
            appBar: CupertinoNavigationBar(
              actionsForegroundColor: CupertinoColors.activeOrange,
              middle: Text(
                "Modulhandbuch",
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
                        "Modulhandbuch",
                        style: TextStyle(fontSize: 25),
                      ))),
            ],
          ),
        ),
      );
    }
    _list.add(
      Expanded(
        child: FutureBuilder(
            future: loadPage(),
            builder: (BuildContext context, AsyncSnapshot snap) {
              if (snap.connectionState == ConnectionState.done) {
                return WebView(
                  initialUrl:
                      'https://hswocloud.hs-worms.de/hswocloud/index.php/s/9j6tyjaazmFKnNC',
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
                        padding:
                            EdgeInsets.only(left: 20, right: 20, bottom: 20),
                        child: Text(
                          "Es gibt ein Problem bei der Verbindung. Prüfe deine Internetverbindung",
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ]);
              }
            }),
      ),
    );
    return _list;
  }

  Future<void> loadPage() async {
    await http.get(
        'https://hswocloud.hs-worms.de/hswocloud/index.php/s/9j6tyjaazmFKnNC');
  }
}
