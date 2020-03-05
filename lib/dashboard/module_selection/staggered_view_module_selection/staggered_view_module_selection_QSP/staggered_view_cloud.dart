import 'package:MyStudyBuddy2/singleton/module_controller.dart';
import 'package:flutter/material.dart';

class StaggeredViewCloud extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _StaggeredViewState();
  }
}

class _StaggeredViewState extends State<StaggeredViewCloud> {
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
                    padding: EdgeInsets.only(left: 8, top: 8),     
                    child: Text("Security and Network",
                        style: TextStyle(fontSize: 25)),
                  ),
                ],
              ),
              Container(
                padding: EdgeInsets.only(top: 8),
                child: Center(
                  child: Wrap(
                    direction: Axis.horizontal,
                    runSpacing: 5,
                    children: ModuleController().getQSPModulesWidgets("Security and Network"),
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
