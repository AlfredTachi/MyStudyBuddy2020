
import 'package:flutter/material.dart';
import 'package:MyStudyBuddy2/dashboard/module_selection/staggered_view_module_selection/staggered_view_module_selection.dart';
import 'package:flutter_custom_dialog/flutter_custom_dialog.dart';

class ModuleSelection extends StatefulWidget {
  @override
  ModuleSelectionState createState() => ModuleSelectionState();
}

class ModuleSelectionState extends State<ModuleSelection> {
  @override
  void initState() {
    
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    YYDialog.init(context);
    return Scaffold(
        body: StaggeredView());
  }

  
}
