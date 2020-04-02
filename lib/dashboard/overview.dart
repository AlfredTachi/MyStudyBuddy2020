import 'package:MyStudyBuddy2/singleton/module_controller.dart';
import 'package:MyStudyBuddy2/singleton/tile_controller.dart';
import 'package:MyStudyBuddy2/ios_list_design/cupertino_settings_icon.dart';
import 'package:MyStudyBuddy2/ios_list_design/cupertino_settings_group.dart';
import 'package:MyStudyBuddy2/studyprogress/studyprogress.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'dart:io';

class Overview extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => OverviewState();
}

class OverviewState extends State<Overview> {
  GlobalKey _key = new GlobalKey();

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: getSlivers(),
    );
  }

  List<SettingsItem> getList() {
    List<SettingsItem> list = List<SettingsItem>();
    for (var tile in TileController().getTiles()) {
      list.add(SettingsItem(
        label: tile.text,
        icon: SettingsIcon(
          icon: tile.leading,
          backgroundColor: tile.iosBackgroundColor,
        ),
        content: SettingsNavigationIndicator(),
        onPress: () {
          if (tile.route != "/studyprogress") {
            Navigator.of(context).pushNamed(tile.route);
          } else {
            ModuleController().studyProgressKey = _key;
            print("Setting StudyProgressKey to: " +
                ModuleController().studyProgressKey.toString());
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (_) => Studyprogress(
                  key: _key,
                ),
              ),
            );
          }
        },
      ));
    }
    return list;
  }

  List<Widget> getSlivers() {
    List<Widget> _slivers = List<Widget>();
    if (!Platform.isIOS) {
      _slivers.add(SliverAppBar(
        pinned: true,
        floating: true,
        expandedHeight: 200.0,
        flexibleSpace: FlexibleSpaceBar(
          background: FittedBox(
            fit: BoxFit.fill,
            child: Image.asset(
              'assets/images/header.png',
            ),
          ),
        ),
      ));
    }
    _slivers.add(SliverList(
      delegate: (Platform.isIOS)
          ? SliverChildListDelegate(<Widget>[
              Image.asset("assets/images/header.png"),
              SettingsGroup(
                items: getList(),
              )
            ])
          : SliverChildBuilderDelegate((BuildContext context, int index) {
              return ListTile(
                leading: Icon(TileController().getTiles()[index].leading),
                trailing: Icon(
                  Icons.arrow_forward_ios,
                  color: Colors.orange,
                ),
                title: Text(
                  TileController().getTiles()[index].text,
                  style: TextStyle(fontSize: 20),
                ),
                onTap: () {
                  if (TileController().getTiles()[index].route !=
                      "/studyprogress") {
                    Navigator.of(context)
                        .pushNamed(TileController().getTiles()[index].route);
                  } else {
                    ModuleController().studyProgressKey = _key;
                    print("Setting StudyProgressKey to: " +
                        ModuleController().studyProgressKey.toString());
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (_) => Studyprogress(
                          key: _key,
                        ),
                      ),
                    );
                  }
                },
              );
            }, childCount: TileController().getTiles().length),
    ));
    return _slivers;
  }
}
