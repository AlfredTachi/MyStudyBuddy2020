import 'dart:io';
import 'package:MyStudyBuddy2/singleton/module_controller.dart';
import 'package:MyStudyBuddy2/singleton/profile_controller.dart';
import 'package:MyStudyBuddy2/theme/styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class StaggeredView extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _StaggeredViewState();
  }
}

class _StaggeredViewState extends State<StaggeredView> {
  @override
  Widget build(BuildContext context) {
    return (Platform.isIOS)
        ? Scaffold(
            appBar: CupertinoNavigationBar(
              actionsForegroundColor: CupertinoColors.activeOrange,
              middle: Text(
                "Modulauswahl",
                style: Styles.navBarTitle,
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
                                  "Modulauswahl",
                                  style: TextStyle(fontSize: 25),
                                ))),
                      ],
                    ),
                  ),
                  Expanded(
                    child: SingleChildScrollView(
                      child: Column(
                        children: generateSemesterTiles(),
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
        height: 25.0,
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
                  children: ModuleController()
                      .getOnlyNotDoneSemesterModulesWidgets(titleIndex),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
