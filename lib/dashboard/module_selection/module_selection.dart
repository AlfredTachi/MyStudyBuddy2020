import 'package:MyStudyBuddy2/singleton/module_controller.dart';
import 'package:flutter/material.dart';
import 'package:MyStudyBuddy2/dashboard/module_selection/staggered_view_module_selection/staggered_view_module_selection.dart';
import 'package:flutter_custom_dialog/flutter_custom_dialog.dart';

class ModuleSelection extends StatefulWidget {
  ModuleSelection({Key key}) : super(key: key);

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
    print("Setting ModuleSelectionKey to: " +
        ModuleController().moduleSelectionKey.toString());
    YYDialog.init(context);
    return Scaffold(body: StaggeredView());
  }
}
