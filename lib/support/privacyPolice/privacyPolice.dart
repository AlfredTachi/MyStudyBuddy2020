import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:MyStudyBuddy2/theme/ios_quick_access_icons.dart';
import 'package:MyStudyBuddy2/ios_list_design/cupertino_settings_group.dart';
import 'package:MyStudyBuddy2/ios_list_design/cupertino_settings_icon.dart';
import 'package:MyStudyBuddy2/theme/styles.dart';

class PrivacyPolice extends StatefulWidget {
  @override
  PrivacyPoliceState createState() => PrivacyPoliceState();
}

class PrivacyPoliceState extends State<PrivacyPolice> {
  @override
  Widget build(BuildContext context) {
    return (Platform.isIOS)
        ? Scaffold(
            appBar: CupertinoNavigationBar(
              actionsForegroundColor: CupertinoColors.activeOrange,
              middle: Text(
                "Datenschutzerklärungen",
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
                          child: Text("Datenschutzerklärung",
                              style: TextStyle(fontSize: 25)),
                        ),
                      )
                    ],
                  ),
                ),
                Expanded(
                    child: SingleChildScrollView(
                  child: Column(children: createList()),
                ))
              ],
            )),
          );
  }

  List<Widget> createList() {
    List<Widget> _items = [
      ListTile(
        leading: Icon(IOSQuickAccessIcons.hslogo),
        title: Text('Unsere Datenschutzerklärung'),
        onTap: () {
          Navigator.pushNamed(
              context, '/supportMain/privacyPolice/ourPrivacyPolice');
        },
      ),
      ListTile(
        leading: Icon(Icons.settings),
        title: Text('Studierendenwerk (Mensaplan)'),
        onTap: () {
          Navigator.pushNamed(context,
              '/supportMain/privacyPolice/studierendenwerkPrivacyPolice');
        },
      ),
      ListTile(
        leading: Icon(IOSQuickAccessIcons.lsflogo),
        title: Text('LSF (Laden der LSF Prüfungsergebnisse)'),
        onTap: () {
          Navigator.pushNamed(
              context, '/supportMain/privacyPolice/lsfPrivacyPolice');
        },
      ),
      ListTile(
        leading: Icon(Icons.tag_faces),
        title: Text('Moralische Unterstützung (DogAPI)'),
        onTap: () {
          Navigator.pushNamed(
              context, '/supportMain/privacyPolice/dogAPIPrivacyPolice');
        },
      ),
    ];

    return _items;
  }

  List<SettingsItem> getList() {
    return <SettingsItem>[
      SettingsItem(
        icon: SettingsIcon(
          icon: IOSQuickAccessIcons.hslogo,
          backgroundColor: Styles.hsBlue,
        ),
        label: "Hochschule",
        subtitle: "Diese App",
        content: SettingsNavigationIndicator(),
        onPress: () {
          Navigator.pushNamed(
              context, '/supportMain/privacyPolice/ourPrivacyPolice');
        },
      ),
      SettingsItem(
        icon: SettingsIcon(
          icon: Icons.settings,
          backgroundColor: CupertinoColors.systemBlue,
        ),
        label: "Studierendenwerk",
        subtitle: "Mensaplan",
        content: SettingsNavigationIndicator(),
        onPress: () {
          _launchURL("https://stw-vp.de/de/datenschutz/");
        },
      ),
      SettingsItem(
        icon: SettingsIcon(
          icon: IOSQuickAccessIcons.lsflogo,
          backgroundColor: CupertinoColors.systemGrey,
        ),
        label: "LSF",
        subtitle: "Laden der LSF Daten",
        content: SettingsNavigationIndicator(),
        onPress: () {
          _launchURL(
              "https://www.hs-worms.de/fileadmin/media/SG2/Informieren/Datenschutz/Datenschutzinformationen_aktuell.pdf");
        },
      ),
      SettingsItem(
        icon: SettingsIcon(
          icon: IconData(0xf2d8,
                  fontFamily: CupertinoIcons.iconFont,
                  fontPackage: CupertinoIcons.iconFontPackage),
          backgroundColor: CupertinoColors.systemRed,
        ),
        label: "Moralische Unterstützung",
        subtitle: "DogAPI",
        content: SettingsNavigationIndicator(),
        onPress: () {
          _launchURL(
              "https://thedogapi.com/privacy");
        },
      ),
    ];
  }

  void _launchURL(String link) async {
    if (await canLaunch(link)) {
      await launch(link);
    } else {
      throw 'Could not launch $link';
    }
  }
}
