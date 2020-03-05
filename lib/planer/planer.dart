import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class Planer extends StatefulWidget {
  const Planer({Key key}) : super(key: key);
  @override
  State<StatefulWidget> createState() {
    return _PlanerState();
  }
}

class _PlanerState extends State<Planer> with SingleTickerProviderStateMixin {
  get http => null;

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('LSF Frontend'),
      ),
      body: FutureBuilder(
        future: loadPage(),
        builder: (BuildContext context, AsyncSnapshot snap) {
          if (snap.connectionState == ConnectionState.done) {
            return WebView(
              initialUrl: 'https://campus.hs-worms.de/apps/WhatsUp/index.html',
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
              ],
            );
          }
        },
      ),
    );
  }

  Future<void> loadPage() async {
    await http.get('https://campus.hs-worms.de/apps/WhatsUp/index.html');
  }
}
