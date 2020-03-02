import 'package:MyStudyBuddy2/singleton/module_controller.dart';
import 'package:flutter/material.dart';

class StaggeredViewMedia extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _StaggeredViewState();
  }
}

class _StaggeredViewState extends State<StaggeredViewMedia> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Row(
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.fromLTRB(8, 8, 0, 0),
                    child: Text("Visual Computing",
                        style: TextStyle(fontSize: 25)),
                  ),
                ],
              ),
              Container(
                padding: EdgeInsets.fromLTRB(0, 8, 0, 0),
                child: Center(
                  child: Wrap(
                    direction: Axis.horizontal,
                    runSpacing: 5,
                    children: ModuleController().getAllModulesWidgets(),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
