import 'package:MyStudyBuddy2/model/module.dart';
import 'package:flutter/material.dart';

class ModuleInformationDialog extends StatefulWidget {
  final Module module;

  ModuleInformationDialog(this.module);

  @override
  State<StatefulWidget> createState() => ModuleInformationDialogState();
}

class ModuleInformationDialogState extends State<ModuleInformationDialog> {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      contentPadding: EdgeInsets.all(8),
      title: Text(""),
      content: Column(
        children: infomationTile(widget.module),
      ),
    );
  }
}

List<Widget> infomationTile(Module module) {
  List<Widget> tiles = List<Widget>();
  List<String> title = ["Modul Name", "Note", "Modul ID", "Credit Points"];
  List<String> subtitle = [
    module.properties.title,
    module.getGrade().toString(),
    module.properties.id.toString(),
    module.properties.cp.toString()
  ];

  for (int i = 0; i < title.length; i++) {
    tiles.add(ListTile(
      title: Text(title[i]),
      subtitle: Text(subtitle[i]),
    ));
  }
  return tiles;
}
