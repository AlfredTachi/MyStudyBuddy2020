import 'package:MyStudyBuddy2/dashboard/module_selection/staggered_view_module_selection/staggered_view_module_selection_WPF/staggered_view_WPF.dart';
import 'package:flutter/material.dart';

class ModuleSelectionWPF extends StatefulWidget {
  @override
  ModuleSelectionWPFState createState() => ModuleSelectionWPFState();
}

class ModuleSelectionWPFState extends State<ModuleSelectionWPF> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("WPF Auswahl"),
      ),
      body:StaggeredViewWPF()
    );
  }
}