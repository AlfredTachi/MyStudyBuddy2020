import 'dart:io';
import 'package:MyStudyBuddy2/theme/ios_quick_access_icons.dart';

import 'package:device_info/device_info.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_mailer/flutter_mailer.dart';
import 'package:MyStudyBuddy2/theme/styles.dart';
import 'package:MyStudyBuddy2/ios_list_design/cupertino_settings_icon.dart';
import 'package:MyStudyBuddy2/ios_list_design/cupertino_settings_group.dart';
import 'package:package_info/package_info.dart';

class Support extends StatefulWidget {
  @override
  SupportState createState() => SupportState();
}

class SupportState extends State<Support> {
  final MailOptions mailOptions = MailOptions(
    subject: 'Support My Study Buddy',
    recipients: ['inf2671@hs-worms.de'],
  );

  @override
  Widget build(BuildContext context) {
    return (Platform.isIOS)
        ? Scaffold(
            appBar: CupertinoNavigationBar(
              actionsForegroundColor: CupertinoColors.activeOrange,
              middle: Text(
                "Hilfe",
                style: Styles.navBarTitle,
              ),
            ),
            body: CustomScrollView(
              slivers: <Widget>[
                SliverSafeArea(
                  top: false,
                  sliver: SliverList(
                    delegate: SliverChildListDelegate(
                      <Widget>[
                        SettingsGroup(
                          items: getList(),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          )
        : SafeArea(
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
                          padding: const EdgeInsets.only(
                              left: 20, top: 3, bottom: 3),
                          child: Text("Hilfe", style: TextStyle(fontSize: 25)),
                        ),
                      )
                    ],
                  ),
                ),
                Expanded(
                    child: SingleChildScrollView(
                        child: Column(children: createList()))),
              ],
            )),
          );
  }

  List<SettingsItem> getList() {
    return <SettingsItem>[
      SettingsItem(
        icon: SettingsIcon(
          icon: IOSQuickAccessIcons.questionmark_circle,
          backgroundColor: CupertinoColors.systemYellow,
        ),
        label: "FAQ",
        content: SettingsNavigationIndicator(),
        onPress: () {
          faqPressed();
        },
      ),
      SettingsItem(
        icon: SettingsIcon(
          icon: IOSQuickAccessIcons.speedometer,
          backgroundColor: CupertinoColors.systemGreen,
        ),
        label: "Schnelleinstieg",
        content: SettingsNavigationIndicator(),
        onPress: () {
          quickaccessPressed();
        },
      ),
      SettingsItem(
        icon: SettingsIcon(
          icon: IOSQuickAccessIcons.envelope_fill,
          backgroundColor: CupertinoColors.systemRed,
        ),
        label: "E-Mail Support",
        content: SettingsNavigationIndicator(),
        onPress: () {
          mailPressed();
        },
      ),
      SettingsItem(
        icon: SettingsIcon(
          icon: IOSQuickAccessIcons.info_circle,
          backgroundColor: CupertinoColors.systemOrange,
        ),
        label: "Impressum",
        content: SettingsNavigationIndicator(),
        onPress: () {
          impressumPressed();
        },
      ),
      SettingsItem(
        icon: SettingsIcon(
          icon: IOSQuickAccessIcons.lock_shield_fill,
          backgroundColor: CupertinoColors.systemBlue,
        ),
        label: "Datenschutz",
        content: SettingsNavigationIndicator(),
        onPress: () {
          privacyPolicePressed();
        },
      ),
    ];
  }

  List<Widget> createList() {
    List<Widget> _items = [
      ListTile(
        leading: Icon(Icons.help),
        title: Text("FAQ", style: TextStyle(fontSize: 20)),
        onTap: () {
          faqPressed();
        },
      ),
      ListTile(
        leading: Icon(Icons.book),
        title: Text("Schnelleinstieg", style: TextStyle(fontSize: 20)),
        onTap: () {
          quickaccessPressed();
        },
      ),
      ListTile(
          leading: Icon(Icons.mail),
          title: Text('E-Mail Support', style: TextStyle(fontSize: 20)),
          onTap: () {
            mailPressed();
          }),
      ListTile(
          leading: Icon(Icons.info),
          title: Text("Impressum", style: TextStyle(fontSize: 20)),
          onTap: () {
            impressumPressed();
          }),
      ListTile(
          leading: Icon(Icons.lock),
          title: Text("Datenschutz", style: TextStyle(fontSize: 20)),
          onTap: () {
            privacyPolicePressed();
          }),
    ];

    return _items;
  }

  void faqPressed() {
    Navigator.pushNamed(context, "/supportMain/FAQ");
  }

  void quickaccessPressed() {
    Navigator.pushNamed(context, "/supportMain/quickaccess");
  }

  void mailPressed() async {
    final MailOptions mailOptions = MailOptions(
      subject: "Support MyStudyBuddy2" +
          ", App Version: " +
          await getAppVersion() +
          ", " +
          await getOperatingSystem(),
      recipients: ["aninf-mm@hs-worms.de"],
    );
    try {
      await FlutterMailer.send(mailOptions);
    } catch (error) {}
  }

  void impressumPressed() {
    Navigator.pushNamed(context, '/supportMain/impressum');
  }

  void privacyPolicePressed() {
    Navigator.pushNamed(context, '/supportMain/privacyPolice/privacyPolice');
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

    if (!Platform.isIOS) {
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
