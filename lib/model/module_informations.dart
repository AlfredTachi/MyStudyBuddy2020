import 'package:MyStudyBuddy2/model/module.dart';
import 'package:MyStudyBuddy2/singleton/information_tile_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

Future<Widget> moduleInforations(Module module) async {
  return Get.dialog(AlertDialog(
      contentPadding: EdgeInsets.fromLTRB(8, 8, 8, 8),
      title: Text(""),
      content: Column(children:infomationTile(module))));
}

List<Widget> infomationTile(Module module) {
  List<Widget> tiles = List<Widget>();
  List<String> title = ["Modul Name", "Note", "Modul ID", "Credit Points"];
  List<String> subtitle = [
    module.title,
    module.getGrade().toString(),
    module.id.toString(),
    "6"
  ];

  for (int i = 0; i < title.length; i++) {
    tiles.add(ListTile(
      title: Text(title[i]),
      subtitle: Text(subtitle[i]),
    ));
  }
  return tiles;
}
