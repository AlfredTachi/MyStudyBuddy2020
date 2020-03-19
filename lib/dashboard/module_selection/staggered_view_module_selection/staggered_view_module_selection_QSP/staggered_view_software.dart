import 'package:MyStudyBuddy2/singleton/module_controller.dart';
import 'package:flutter/material.dart';

class StaggeredViewSoftware extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _StaggeredViewState();
  }
}

class _StaggeredViewState extends State<StaggeredViewSoftware> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Stack(
          children: <Widget>[
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
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
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(children: [
                          FittedBox(
                              child: Text('Software Engineering ',
                                  style: TextStyle(fontSize: 25))),
                          Center(
                              child: Text('and Development',
                                  style: TextStyle(fontSize: 25)))
                        ]),
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: EdgeInsets.only(top: 8),
                  child: Center(
                    child: Wrap(
                      direction: Axis.horizontal,
                      runSpacing: 5,
                      children: ModuleController().getQSPModulesWidgets(
                          "Software Engineering and Development"),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
