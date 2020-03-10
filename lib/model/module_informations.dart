import 'package:MyStudyBuddy2/model/module.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

Future<Widget> moduleInformations(Module module) async {
  return Get.dialog(AlertDialog(
      contentPadding: EdgeInsets.all(8),
      title: Text(""),
      content: Column(children:infomationTile(module))));
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
