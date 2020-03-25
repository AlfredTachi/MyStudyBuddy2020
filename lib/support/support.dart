import 'dart:io';

import 'package:device_info/device_info.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mailer/flutter_mailer.dart';
import 'package:package_info/package_info.dart';

class Support extends StatefulWidget {
  @override
  SupportState createState() => SupportState();
}

class SupportState extends State<Support> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          body: Column(
        children: <Widget>[
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
                    padding: const EdgeInsets.only(left: 20, top: 3, bottom: 3),
                    child: Text("Hilfe", style: TextStyle(fontSize: 25)),
                  ),
                )
              ],
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              child: FutureBuilder(
                future: createList(),
                builder: (BuildContext con, AsyncSnapshot snap) {
                  List<Widget> data = snap.data;
                  if (snap.hasData) {
                    if (snap.connectionState == ConnectionState.done)
                      return Column(children: data);
                  }
                  return CircularProgressIndicator();
                },
              ),
            ),
          ),
        ],
      )),
    );
  }

  Future<List<Widget>> createList() async {
    final MailOptions mailOptions = MailOptions(
      subject: "Support MyStudyBuddy2" +
          ", App Version: " +
          await getAppVersion() +
          ", "+
          await getOperatingSystem(),
      recipients: ["aninf-mm@hs-worms.de"],
    );
    List<Widget> _items = [
      ListTile(
        leading: Icon(Icons.help),
        title: Text("FAQ", style: TextStyle(fontSize: 20)),
        onTap: () {
          Navigator.pushNamed(context, "/supportMain/FAQ");
        },
      ),
      ListTile(
        leading: Icon(Icons.book),
        title: Text("Schnelleinstieg", style: TextStyle(fontSize: 20)),
        onTap: () {
          Navigator.pushNamed(context, "/supportMain/quickaccess");
        },
      ),
      ListTile(
          leading: Icon(Icons.mail),
          title: Text("E-Mail Support", style: TextStyle(fontSize: 20)),
          onTap: () async {
            try {
              await FlutterMailer.send(mailOptions);
            } catch (error) {}
          }),
      ListTile(
          leading: Icon(Icons.info),
          title: Text("Impressum", style: TextStyle(fontSize: 20)),
          onTap: () {
            Navigator.pushNamed(context, "/supportMain/impressum");
          }),
      ListTile(
          leading: Icon(Icons.lock),
          title: Text("Datenschutz", style: TextStyle(fontSize: 20)),
          onTap: () {
            Navigator.pushNamed(
                context, "/supportMain/privacyPolice/privacyPolice");
          }),
    ];

    return _items;
  }

  Future<String> getAppVersion() async {
    return PackageInfo.fromPlatform()
        .then((PackageInfo packageInfo) => packageInfo.version)
        .catchError((err) {
      print(err);
    });
  }

  Future<String> getOperatingSystem() async {
    //Android
    String release = "";
    int sdkNumber = 0;

    //IOS
    String systemName = "";
    String version = "";

    if (Platform.isAndroid) {
      return DeviceInfoPlugin().androidInfo.then((var androidInfo) {
        release = androidInfo.version.release;
        sdkNumber = androidInfo.version.sdkInt;
        return "Android: " + release + ", SDK: " + sdkNumber.toString();
      });
    } else {
      return DeviceInfoPlugin().iosInfo.then((var iosInfo) {
        systemName = iosInfo.systemName;
        version = iosInfo.systemVersion;
        return systemName + version;
      });
    }
  }
}
