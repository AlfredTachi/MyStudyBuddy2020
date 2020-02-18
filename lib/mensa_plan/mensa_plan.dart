import 'package:MyStudyBuddy2/drawer/drawer.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:webview_flutter/webview_flutter.dart';

class MensaPlan extends StatefulWidget {
  @override
  MensaPlanState createState() => MensaPlanState();
}

class MensaPlanState extends State<MensaPlan> {
  Map<String, double> dataMap = new Map();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: WebViewContainer('https://stw-vp.de/de/mensa-webapp'),
    );
  }
}

class _WebViewContainerState extends State<WebViewContainer> {
  var _url;
  final _key = UniqueKey();
  _WebViewContainerState(this._url);
  num _stackToView = 1;

  void _handleLoad(String value) {
    setState(() {
      _stackToView = 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Mensa Plan'),
        ),
        drawer: OwnDrawer(),
        body: IndexedStack(
          index: _stackToView,
          children: [
            Column(
              children: <Widget>[
                Expanded(
                    child: WebView(
                  key: _key,
                  javascriptMode: JavascriptMode.unrestricted,
                  initialUrl: _url,
                  onPageFinished: _handleLoad,
                )),
              ],
            ),
            Container(
              color: Colors.white,
              child: Center(
                child: CircularProgressIndicator(),
              ),
            ),
          ],
        ));
  }
}

class WebViewContainer extends StatefulWidget {
  final url;
  WebViewContainer(this.url);
  @override
  createState() => _WebViewContainerState(this.url);
}
