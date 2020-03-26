import 'package:MyStudyBuddy2/theme/ios_quick_access_icons.dart';
import 'package:MyStudyBuddy2/theme/styles.dart';
import 'package:MyStudyBuddy2/dashboard/profile_page/achievement/achievement.dart';
import 'package:MyStudyBuddy2/model/module.dart';
import 'package:MyStudyBuddy2/singleton/module_controller.dart';
import 'package:MyStudyBuddy2/singleton/profile_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'dart:io';

class StaggeredView extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _StaggeredViewState();
  }
}

class _StaggeredViewState extends State<StaggeredView> {
  BuildContext scaffoldContext;

  @override
  Widget build(BuildContext context) {
    return (Platform.isIOS)
        ? Scaffold(
            appBar: CupertinoNavigationBar(
              actionsForegroundColor: CupertinoColors.activeOrange,
              middle: Text(
                "Studienverlauf",
                style: Styles.navBarTitle,
              ),
              trailing: Builder(
                builder: (BuildContext context) {
                  scaffoldContext = context;
                  return CupertinoButton(
                    padding: EdgeInsets.zero,
                    child: Icon(
                      IOSQuickAccessIcons.square_and_arrow_down,
                      color: CupertinoColors.activeOrange,
                      size: 25,
                    ),
                    onPressed: () {
                      _downloadLSFData(context).whenComplete(() {
                        Achievement().showAchievement(context, 8);
                      });
                    },
                  );
                },
              ),
            ),
            body: SingleChildScrollView(
              child: Column(children: generateSemesterTiles()),
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
                                padding:
                                    const EdgeInsets.only(top: 3, bottom: 3),
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
                                child: Text(
                                  "Studienverlauf",
                                  style: TextStyle(fontSize: 25),
                                ))),
                        Expanded(
                          child: Align(
                              alignment: Alignment.topRight,
                              child: Builder(builder: (BuildContext context) {
                                scaffoldContext = context;
                                return IconButton(
                                    icon: Icon(Icons.cloud_download),
                                    iconSize: 36,
                                    onPressed: () {
                                      _downloadLSFData(context)
                                          .whenComplete(() {
                                        Achievement()
                                            .showAchievement(context, 8);
                                      });
                                    });
                              })),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: SingleChildScrollView(
                      child: Container(
                        child: Column(
                          children: generateSemesterTiles(),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
  }

  List<Widget> generateSemesterTiles() {
    List<Widget> _semesterTiles = new List<Widget>();
    if (ProfileController().getStudyTypeIndex() == 0) {
      for (int i = 1; i <= 6; i++) {
        _semesterTiles.add(semester(i));
      }
    } else if (ProfileController().getStudyTypeIndex() == 1) {
      for (int i = 1; i <= 7; i++) {
        _semesterTiles.add(semester(i));
      }
    } else if (ProfileController().getStudyTypeIndex() > 1) {
      for (int i = 1; i <= 6; i++) {
        _semesterTiles.add(semester(i));
      }
    }
    if (Platform.isIOS) {
      _semesterTiles.add(Container(
        height: 25,
      ));
    }
    return _semesterTiles;
  }

  Widget semester(int titleIndex) {
    String title = titleIndex.toString() + ". Semester";
    return Padding(
      padding: (Platform.isIOS)
          ? const EdgeInsets.symmetric(vertical: 10.0, horizontal: 15.0)
          : const EdgeInsets.only(top: 5, bottom: 5, left: 3, right: 3),
      child: Material(
        elevation: (Platform.isIOS) ? 0 : 15,
        borderRadius: BorderRadius.circular(15.0),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Row(children: <Widget>[
                Align(
                  alignment: Alignment.topLeft,
                  child: Container(
                    child: Text(title,
                        style: (Platform.isIOS)
                            ? Styles.studyprogressCardTitle
                            : TextStyle(
                                fontSize: 20,
                                color: Color(0xFF013D62),
                              )),
                  ),
                ),
                Expanded(
                  child: Container(
                      margin: const EdgeInsets.only(left: 10.0, right: 10.0),
                      child: Divider(
                        color: Color(0xFF013D62),
                        height: 36,
                        thickness: 1,
                      )),
                ),
              ]),
              Center(
                  child: Wrap(
                direction: Axis.horizontal,
                runSpacing: 5,
                children:
                    ModuleController().getAllSemesterModulesWidgets(titleIndex),
              )),
            ],
          ),
        ),
      ),
    );
  }

  _downloadLSFData(BuildContext context,
      [String name = "", String password = ""]) {
    String userName = name;
    String userPassword = password;
    return showDialog(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            "LSF Login",
            style: (Platform.isIOS) ? Styles.alertDialogTitleText : null,
          ),
          content: SingleChildScrollView(
            child: Wrap(
              // direction: Axis.vertical,
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Expanded(
                      child: TextFormField(
                        autofocus: true,
                        decoration: InputDecoration(
                          labelText: "Anmeldename",
                          hintText: "z.B. inf9876",
                        ),
                        initialValue: name,
                        onChanged: (value) {
                          userName = value;
                        },
                      ),
                    ),
                  ],
                ),
                Row(
                  children: <Widget>[
                    Expanded(
                      child: TextFormField(
                        autofocus: true,
                        obscureText: true,
                        decoration: InputDecoration(
                          labelText: "Passwort",
                          hintText: "Passwort eingeben",
                        ),
                        initialValue: password,
                        onChanged: (value) {
                          userPassword = value;
                        },
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          actions: <Widget>[
            FlatButton(
              child: Text(
                "Abbrechen",
                style: (Platform.isIOS)
                    ? TextStyle(color: CupertinoColors.destructiveRed)
                    : null,
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            FlatButton(
              child: Text("Daten holen"),
              onPressed: () async {
                try {
                  Navigator.of(context).pop();
                  createSnackBar("Lädt");
                  int success = await ModuleState()
                      .getExamResultsFromLSFServer(userName, userPassword);
                  switch (success) {
                    case 0:
                      setState(() {
                        Scaffold.of(scaffoldContext).hideCurrentSnackBar();
                        success = null;
                        createSnackBar(
                            "Das Laden der LSF Daten war erfolgreich");
                      });
                      break;
                    case 1:
                      setState(() {
                        Scaffold.of(scaffoldContext).hideCurrentSnackBar();
                        success = null;
                        createSnackBarWithReloadButton(
                            "Die Logindaten waren leider falsch",
                            userName,
                            userPassword);
                      });
                      break;
                    case 2:
                      setState(() {
                        Scaffold.of(scaffoldContext).hideCurrentSnackBar();
                        success = null;
                        createSnackBarWithReloadButton(
                            "Das hat leider nicht geklappt. Prüfe deine Internetverbindung!",
                            userName,
                            userPassword);
                      });

                      break;
                    case 3:
                      setState(() {
                        Scaffold.of(scaffoldContext).hideCurrentSnackBar();
                        success = null;
                        createSnackBarWithReloadButton(
                            "Timeout! Prüfe deine Internetverbindung!",
                            userName,
                            userPassword);
                      });
                      break;
                    default:
                      setState(() {
                        success = null;
                        createSnackBarWithReloadButton(
                            "Das Laden war nur teilweise erfolgreich. Evtl. musst du noch etwas nachtragen.",
                            userName,
                            userPassword);
                      });
                  }
                  ProfileController().sumAllCP();
                } catch (err) {
                  print(err);
                }
              },
            ),
          ],
        );
      },
    );
  }

  void createSnackBarWithReloadButton(String text,
      [String name, String password]) {
    final snackBar = SnackBar(
      content: Text(text),
      action: SnackBarAction(
        label: "Nochmal versuchen",
        onPressed: () {
          _downloadLSFData(context, name, password);
        },
      ),
      duration: Duration(seconds: 7),
    );
    Scaffold.of(scaffoldContext).showSnackBar(snackBar);
  }

  void createSnackBar(String text) {
    final snackBar = SnackBar(
      content: Text(text),
      duration: Duration(seconds: 7),
    );
    Scaffold.of(scaffoldContext).showSnackBar(snackBar);
  }
}
