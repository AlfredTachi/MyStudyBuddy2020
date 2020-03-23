import 'dart:io';
import 'package:MyStudyBuddy2/link/link.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:MyStudyBuddy2/theme/styles.dart';
import 'package:MyStudyBuddy2/ios_list_design/cupertino_settings_group.dart';
import 'package:MyStudyBuddy2/ios_list_design/cupertino_settings_icon.dart';
import 'package:MyStudyBuddy2/theme/ios_quick_access_icons.dart';
import 'package:url_launcher/url_launcher.dart';

class Quickaccess extends StatefulWidget {
  @override
  QuickaccessState createState() => QuickaccessState();
}

List<Widget> links = [
  Link(
      child: Text('HS Worms Website', textAlign: TextAlign.center),
      url: 'https://www.hs-worms.de/'),
  Link(
      child: Text('moodle', textAlign: TextAlign.center),
      url: 'https://moodle.hs-worms.de/moodle/'),
  Link(
      child: Text('LSF', textAlign: TextAlign.center),
      url: 'https://lsf.hs-worms.de/qisserver/rds?state=user&type=0'),
  Link(
      child: Text('Webmailer', textAlign: TextAlign.center),
      url: 'https://webmailer2.hs-worms.de/roundcube/'),
  Link(
      child: Text('Studierendenvertretungen', textAlign: TextAlign.center),
      url:
          'https://www.hs-worms.de/hochschule/hochschule-worms/gremien/studierendenvertretungen/'),
  Link(
      child: Text('Fachschaft Informatik', textAlign: TextAlign.center),
      url: 'https://fsinf.hs-worms.de/'),
  Text('Moralische Unterstützung', textAlign: TextAlign.center),
];

void goToMoralSupport(BuildContext context) {
  Navigator.of(context).pushNamed("/supportMain/quickAccess/moralSupport");
}

class QuickaccessState extends State<Quickaccess> {
  @override
  Widget build(BuildContext context) {
    return (Platform.isIOS)
        ? Scaffold(
            appBar: CupertinoNavigationBar(
              actionsForegroundColor: CupertinoColors.activeOrange,
              middle: Text(
                "Schnelleinstieg",
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
                          onPressed: () => Navigator.pop(context, false),
                        ),
                      ),
                      Align(
                        alignment: Alignment.topCenter,
                        child: Padding(
                          padding: const EdgeInsets.only(
                              left: 20, top: 3, bottom: 3),
                          child: Text("Schnelleinstieg",
                              style: TextStyle(fontSize: 25)),
                        ),
                      )
                    ],
                  ),
                ),
                ListView.builder(
                    scrollDirection: Axis.vertical,
                    itemCount: links.length,
                    shrinkWrap: true,
                    itemBuilder: (BuildContext context, int index) {
                      if (index != 6) {
                        return Container(
                            width: MediaQuery.of(context).size.width,
                            child: Card(
                              margin: new EdgeInsets.symmetric(
                                  horizontal: 10.0, vertical: 6.0),
                              elevation: 8.0,
                              child: ListTile(
                                  contentPadding: EdgeInsets.symmetric(
                                      horizontal: 20.0, vertical: 10.0),
                                  leading: links[index]),
                            ));
                      } else if (links[index].runtimeType == Text) {
                        return Container(
                            width: MediaQuery.of(context).size.width,
                            child: GestureDetector(
                              onTap: () {
                                goToMoralSupport(context);
                              },
                              child: Card(
                                margin: new EdgeInsets.symmetric(
                                    horizontal: 10.0, vertical: 6.0),
                                elevation: 8.0,
                                child: ListTile(
                                    contentPadding: EdgeInsets.symmetric(
                                        horizontal: 20.0, vertical: 10.0),
                                    leading: links[index]),
                              ),
                            ));
                      } else {
                        return Container(
                            width: MediaQuery.of(context).size.width,
                            child: Card(
                              margin: new EdgeInsets.symmetric(
                                  horizontal: 10.0, vertical: 6.0),
                              elevation: 8.0,
                              child: ListTile(
                                  contentPadding: EdgeInsets.symmetric(
                                      horizontal: 20.0, vertical: 10.0),
                                  leading: links[index]),
                            ));
                      }
                    }),
              ],
            )),
          );
  }

  List<SettingsItem> getList() {
    List<SettingsItem> _list = List<SettingsItem>();
    for (var i = 0; i < links.length; i++) {
      if (links[i] is Link) {
        Link link = links[i];
        Text linkChild = link.child;
        SettingsIcon icon = SettingsIcon(icon: IconData(0x0000));
        String _url = link.url;
        switch (linkChild.data) {
          case "HS Worms Website":
            icon = SettingsIcon(
              icon: IOSQuickAccessIcons.hslogo,
              backgroundColor: Styles.hsBlue,
            );
            break;
          case "moodle":
            icon = SettingsIcon(
              icon: IOSQuickAccessIcons.moodlelogo,
              backgroundColor: CupertinoColors.activeBlue,
            );
            break;
          case "LSF":
            icon = SettingsIcon(
              icon: IOSQuickAccessIcons.lsflogo,
              backgroundColor: CupertinoColors.systemGrey,
            );
            break;
          case "Webmailer":
            icon = SettingsIcon(
              icon: IOSQuickAccessIcons.webmailerlogo,
              backgroundColor: CupertinoColors.systemTeal,
            );
            break;
          case "Studierendenvertretungen":
            icon = SettingsIcon(
              icon: IOSQuickAccessIcons.hslogo,
              backgroundColor: CupertinoColors.systemYellow,
            );
            break;
          case "Fachschaft Informatik":
            icon = SettingsIcon(
              icon: IOSQuickAccessIcons.fachschaftlogo,
              backgroundColor: CupertinoColors.activeOrange,
            );
            break;
          default:
        }
        _list.add(SettingsItem(
          label: linkChild.data,
          icon: icon,
          content: SettingsNavigationIndicator(),
          onPress: () {
            _launchURL(_url);
          },
        ));
      } else {
        Text _label = links[i];
        SettingsIcon _icon = SettingsIcon(icon: IconData(0x0000));
        switch (_label.data) {
          case "Moralische Unterstützung":
            _icon = SettingsIcon(
              icon: IconData(0xf2d8,
                  fontFamily: CupertinoIcons.iconFont,
                  fontPackage: CupertinoIcons.iconFontPackage),
              backgroundColor: CupertinoColors.systemRed,
            );
            break;
          default:
        }
        _list.add(SettingsItem(
          icon: _icon,
          label: _label.data,
          content: SettingsNavigationIndicator(),
          onPress: () {
            goToMoralSupport(context);
          },
        ));
      }
    }

    return _list;
  }

  void _launchURL(String link) async {
    if (await canLaunch(link)) {
      await launch(link);
    } else {
      throw 'Could not launch $link';
    }
  }
}
