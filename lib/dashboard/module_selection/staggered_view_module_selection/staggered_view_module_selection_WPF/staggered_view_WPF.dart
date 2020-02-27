import 'package:MyStudyBuddy2/singleton/module_controller.dart';
import 'package:flutter/material.dart';

class StaggeredViewWPF extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _StaggeredViewState();
  }
}

class _StaggeredViewState extends State<StaggeredViewWPF> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Container(
            padding: EdgeInsets.fromLTRB(8, 8, 8, 8),
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
    );
  }
}
