import 'package:MyStudyBuddy2/dashboard/module_selection/module_selection.dart';
import 'package:MyStudyBuddy2/dashboard/profile_page/achievement/achievement.dart';
import 'package:MyStudyBuddy2/singleton/module_controller.dart';
import 'package:MyStudyBuddy2/singleton/profile_controller.dart';
import 'package:MyStudyBuddy2/theme/ios_quick_access_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'dart:io';
import 'package:liquid_progress_indicator/liquid_progress_indicator.dart';
import 'package:MyStudyBuddy2/theme/styles.dart';
import 'package:MyStudyBuddy2/theme/theme.dart';

class Dashboard extends StatefulWidget {
  Dashboard({Key key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => DashboardState();
}

class DashboardState extends State<Dashboard> {
  GlobalKey _key = new GlobalKey();
  @override
  void initState() {
    ProfileController().sumAllCP();
    ProfileController().loadData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Achievement().showAchievement(context, 0);
    });
    updateView();
    double spacing = MediaQuery.of(context).size.width / 1.8;

    void profilePageButtonPressed() {
      Navigator.of(context).pushNamed("/profilePage");
    }

    void addModuleButtonPressed() {
      ModuleController().moduleSelectionKey = _key;
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (_) => ModuleSelection(
                    key: _key,
                  ))).whenComplete(() => updateView());
    }

    List<Widget> getColumnChildren() {
      List<Widget> _list = List<Widget>();
      if (!Platform.isIOS) {
        _list.add(Align(
            alignment: Alignment.topRight,
            child: IconButton(
              icon: Icon(
                Icons.person,
                color: Color(0xCC013D62),
              ),
              onPressed: () {
                profilePageButtonPressed();
              },
            )));
      }
      _list.add(
        Container(
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: SizedBox(
                height: spacing,
                width: spacing,
                child: drawLiquidProgressBar()),
          ),
        ),
      );
      _list.add(
        Expanded(
          child: Padding(
            padding: (Platform.isIOS)
                ? const EdgeInsets.symmetric(vertical: 10.0, horizontal: 15.0)
                : const EdgeInsets.all(0),
            child: Container(
              decoration: BoxDecoration(
                  borderRadius: (Platform.isIOS)
                      ? BorderRadius.circular(15)
                      : BorderRadius.vertical(top: Radius.circular(30)),
                  gradient: LinearGradient(
                    begin: Alignment.topRight,
                    end: Alignment.bottomLeft,
                    colors: (Platform.isIOS)
                        ? [
                            CupertinoColors.systemOrange,
                            CupertinoColors.systemOrange
                          ]
                        : [
                            Colors.orange,
                            Colors.deepOrange,
                          ],
                  )),
              child: Padding(
                padding: const EdgeInsets.only(top: 30),
                child: SingleChildScrollView(
                  child: Column(
                    children: <Widget>[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Padding(
                            padding:
                                EdgeInsets.only(left: 15, top: 5, bottom: 15),
                            child: Text(
                              "Meine Module",
                              style: (Platform.isIOS)
                                  ? Styles.detailsTitleText
                                  : TextStyle(
                                      fontSize: 25, color: Colors.black54),
                            ),
                          ),
                          (Platform.isIOS)
                              ? Builder(
                                  builder: (BuildContext context) {
                                    return Padding(
                                      padding: EdgeInsets.only(
                                          bottom: 10, right: 10),
                                      child: CupertinoButton(
                                        padding: EdgeInsets.all(0),
                                        child: Icon(
                                          IOSQuickAccessIcons.plus_circle,
                                          color: CupertinoColors.black,
                                          size: 35,
                                        ),
                                        onPressed: () {
                                          addModuleButtonPressed();
                                        },
                                      ),
                                    );
                                  },
                                )
                              : Container(),
                        ],
                      ),
                      Container(
                        padding: EdgeInsets.only(left: 5, right: 5),
                        alignment: Alignment.topLeft,
                        child:
                            (ModuleController().getSelectedModules().length !=
                                    0)
                                ? Center(
                                    child: Wrap(
                                        direction: Axis.horizontal,
                                        spacing: 0,
                                        runSpacing: 5,
                                        children: ModuleController()
                                            .getAllSelectedModulesWidgets()),
                                  )
                                : Center(
                                    child: Align(
                                      heightFactor: 5,
                                      child: FittedBox(
                                        child: Text(
                                          "Du hast zurzeit keine Module geplant!",
                                          style: TextStyle(
                                              fontSize: 18,
                                              color: Colors.black45),
                                        ),
                                      ),
                                    ),
                                  ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      );
      return _list;
    }

    return Scaffold(
      appBar: (Platform.isIOS)
          ? CupertinoNavigationBar(
              middle: Text(
                "Mein Studium",
                style: Styles.navBarTitle,
              ),
              trailing: Builder(
                builder: (BuildContext context) {
                  return CupertinoButton(
                    padding: EdgeInsets.zero,
                    child: Icon(
                      IOSQuickAccessIcons.person_circle,
                      color: CupertinoColors.activeOrange,
                      size: 25,
                    ),
                    onPressed: () {
                      profilePageButtonPressed();
                    },
                  );
                },
              ),
            )
          : null,
      floatingActionButton: (Platform.isIOS)
          ? null
          : FloatingActionButton(
              backgroundColor: Color(0xFF013D62),
              onPressed: () {
                addModuleButtonPressed();
              },
              tooltip: 'Modul hinzufügen',
              child: Icon(Icons.add),
            ),
      body: SafeArea(
        child: Column(
          children: getColumnChildren(),
        ),
      ),
    );
  }

  Widget drawLiquidProgressBar() {
    return LiquidCircularProgressIndicator(
      value: ProfileController().getCPForLiquidProgressBar(),
      valueColor: AlwaysStoppedAnimation(
        Color(0xAA013D62),
      ),
      backgroundColor:
          Provider.of<ThemeChanger>(context).getTheme().scaffoldBackgroundColor,
      borderColor: Color(0xCC013D62),
      borderWidth: 5.0,
      direction: Axis.vertical,
      center: Text(
        ProfileController().getProgressText(),
        style: (Platform.isIOS)
        ? Styles.liquidCircularProgressIndicatorText
        : TextStyle(
            fontSize: 20,
            color: Colors.blueGrey[900],
            fontWeight: FontWeight.bold),
      ),
    );
  }

  void updateView() {
    setState(() {});
  }
}
