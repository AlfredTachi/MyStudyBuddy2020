import 'package:MyStudyBuddy2/ios_list_design/cupertino_settings_icon.dart';
import 'package:MyStudyBuddy2/ios_list_design/cupertino_settings_group.dart';
import 'package:MyStudyBuddy2/singleton/module_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'dart:io';
import 'package:MyStudyBuddy2/theme/styles.dart';

class GradesList extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return GradesListState();
  }
}

class GradesListState extends State<GradesList> {
  @override
  Widget build(BuildContext context) {
    List<Widget> getColumnChildren() {
      List<Widget> _list = List<Widget>();
      if (!Platform.isIOS) {
        _list.add(
          Container(
            color: Colors.orange,
            child: Row(
              children: <Widget>[
                Align(
                  alignment: Alignment.topLeft,
                  child: OutlineButton(
                      child: Padding(
                        padding: const EdgeInsets.only(top: 3, bottom: 3),
                        child: Icon(
                          Icons.arrow_back,
                          size: 36,
                        ),
                      ),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.only(
                        topRight: Radius.circular(15),
                        bottomRight: Radius.circular(15),
                      )),
                      onPressed: () {
                        Navigator.of(context).pop();
                      }),
                ),
                Align(
                    alignment: Alignment.topCenter,
                    child: Padding(
                        padding:
                            const EdgeInsets.only(left: 20, top: 3, bottom: 3),
                        child: Text(
                          "Notenliste",
                          style: TextStyle(fontSize: 25),
                        ))),
              ],
            ),
          ),
        );
      }
      if (Platform.isIOS) {
        _list.add(Container(
          color: Styles.scaffoldBackground,
          child: CustomScrollView(
            slivers: <Widget>[
              SliverSafeArea(
                top: true,
                sliver: SliverList(
                  delegate: SliverChildListDelegate(
                    <Widget>[
                      SettingsGroup(
                        items: getList(),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ));
      } else {
        _list.add(Expanded(
          child: SingleChildScrollView(
            child: Column(
              children: createList(),
            ),
          ),
        ));
      }
      return _list;
    }

    return (Platform.isIOS)
        ? Scaffold(
            appBar: CupertinoNavigationBar(
              actionsForegroundColor: CupertinoColors.activeOrange,
              middle: Text(
                "Notenliste",
                style: Styles.navBarTitle,
              ),
            ),
            body: getColumnChildren()[0]
          )
        : SafeArea(
            child: Scaffold(
              body: Column(
                children: getColumnChildren(),
              ),
            ),
          );
  }

  List<SettingsItem> getList() {
    List<double> grades = ModuleController().getAllDoneGrades();
    List<String> doneModules = ModuleController().getAllDoneModulesNames();
    List<SettingsItem> _items = new List<SettingsItem>();
    for (int i = 0; i < grades.length; i++) {
      SettingsItem _listItem = SettingsItem(
        label: doneModules[i],
        subtitle: grades[i].toString(),
      );
      _items.add(_listItem);
    }
    return _items;
  }

  List<Widget> createList() {
    List<double> grades = ModuleController().getAllDoneGrades();
    List<String> doneModules = ModuleController().getAllDoneModulesNames();
    List<Widget> _items = new List<Widget>();
    for (int i = 0; i < grades.length; i++) {
      Widget _listItem = Container(
        decoration: BoxDecoration(border: Border(bottom: BorderSide())),
        child: ListTile(
          title: Text("${doneModules[i]}"),
          subtitle: Text("${grades[i]}"),
        ),
      );
      _items.add(_listItem);
    }
    return _items;
  }
}
