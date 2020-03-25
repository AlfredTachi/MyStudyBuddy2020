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
              child:
                  SingleChildScrollView(child: Column(children: createList()))),
        ],
      )),
    );
  }

  List<Widget> createList() {
    final MailOptions mailOptions = MailOptions(
      subject:
          "Support My Study Buddy 2 " + getOperatingSystem() + getAppVersion(),
      recipients: ["inf2671@hs-worms.de"],
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

  String getAppVersion() {
    String version = "";
    PackageInfo.fromPlatform().then((PackageInfo packageInfo) {
      version = packageInfo.version;
    }).catchError((err) {
      print(err);
    });
    return version;
  }

  String getOperatingSystem() {
    //Android
    String release = "";
    int sdkNumber = 0;

    //IOS
    String systemName = "";
    String version = "";

    if (Platform.isAndroid) {
      DeviceInfoPlugin().androidInfo.then((var androidInfo) {
        release = androidInfo.version.release;
        sdkNumber = androidInfo.version.sdkInt;
      });
      return "Android" + release + "SDK" + sdkNumber.toString();
    } else {
      DeviceInfoPlugin().iosInfo.then((var iosInfo) {
        systemName = iosInfo.systemName;
        version = iosInfo.systemVersion;
      });
      return systemName + version;
    }
  }

  /* Future<String> getAppVersion() async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    String version = packageInfo.version;
    return version;
  }

  Future<String> getOperatingSystem() async {
    if (Platform.isAndroid) {
      var androidInfo = await DeviceInfoPlugin().androidInfo;
      var release = androidInfo.version.release;
      var sdkInt = androidInfo.version.sdkInt;
      return "Android" + release + "SDK" + sdkInt.toString();
    } else if (Platform.isIOS) {
      var iosInfo = await DeviceInfoPlugin().iosInfo;
      var systemName = iosInfo.systemName;
      var version = iosInfo.systemVersion;
      return systemName + version;
    } else {
      return "";
    }
  }*/

}
