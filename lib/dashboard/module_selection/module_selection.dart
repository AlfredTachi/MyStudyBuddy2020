import 'package:flutter/material.dart';
import 'package:MyStudyBuddy2/dashboard/module_selection/staggered_view_module_selection/staggered_view_module_selection.dart';

class ModuleSelection extends StatefulWidget {
  @override
  ModuleSelectionState createState() => ModuleSelectionState();
}

class ModuleSelectionState extends State<ModuleSelection> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Modulauswahl"),
      ),
      body:StaggeredView()
    );
  }
}