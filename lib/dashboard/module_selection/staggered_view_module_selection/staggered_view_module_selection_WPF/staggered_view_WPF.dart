import 'dart:io';
import 'package:MyStudyBuddy2/theme/styles.dart';
import 'package:MyStudyBuddy2/singleton/module_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class StaggeredViewWPF extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _StaggeredViewState();
  }
}

class _StaggeredViewState extends State<StaggeredViewWPF> {
  @override
  Widget build(BuildContext context) {
    return (Platform.isIOS)
        ? Scaffold(
            appBar: CupertinoNavigationBar(
              actionsForegroundColor: CupertinoColors.activeOrange,
              middle: Text(
                "WPF Auswahl",
                style: Styles.navBarTitle,
              ),
            ),
            body: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.only(top: 10.0, bottom: 25.0, left: 15.0, right: 15.0),
                child: PhysicalModel(
                  shape: BoxShape.rectangle,
                  borderRadius: BorderRadius.circular(15),
                  color: CupertinoColors.white,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        Center(
                          child: Wrap(
                            direction: Axis.horizontal,
                            runSpacing: 5,
                            children: ModuleController().getWPFModulesWidgets(),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
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
                                  "WPF Auswahl",
                                  style: TextStyle(fontSize: 25),
                                ))),
                      ],
                    ),
                  ),
                  Expanded(
                    child: SingleChildScrollView(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          Container(
                            padding: EdgeInsets.only(
                                top: 8, bottom: 8, left: 8, right: 8),
                            child: Center(
                              child: Wrap(
                                direction: Axis.horizontal,
                                runSpacing: 5,
                                children:
                                    ModuleController().getWPFModulesWidgets(),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
  }
}
