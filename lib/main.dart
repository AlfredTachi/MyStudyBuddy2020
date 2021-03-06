import 'package:MyStudyBuddy2/dashboard/dashboard.dart';
import 'package:MyStudyBuddy2/local_database/local_database.dart';
import 'package:MyStudyBuddy2/mensa_plan/mensa_plan.dart';
import 'package:MyStudyBuddy2/singleton/module_controller.dart';
import 'package:MyStudyBuddy2/theme/ios_quick_access_icons.dart';
import 'package:MyStudyBuddy2/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'dart:io';
import 'package:provider/provider.dart';
import 'package:MyStudyBuddy2/singleton/profile_controller.dart';

import './route_manager/route_manager.dart';

import 'dashboard/overview.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);
    return ChangeNotifierProvider<ThemeChanger>(
      create: (_) => ThemeChanger(baselight()),
      child: MaterialAppWithTheme(),
    );
  }
}

int _currentIndex = 1;

class MaterialAppWithTheme extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => MaterialAppWithThemeState();
}

class MaterialAppWithThemeState extends State<MaterialAppWithTheme> {
  GlobalKey key = new GlobalKey();

  @override
  Widget build(BuildContext context) {
    final theme = Provider.of<ThemeChanger>(context);
    DBProvider.db.initDB();
    ProfileController().loadData();
    return MaterialApp(
      navigatorKey: Get.key,
      initialRoute: '/',
      theme: theme.getTheme(),
      onGenerateRoute: RouteGenerator.generateRoute,
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: getCorrectPage(_currentIndex),
        bottomNavigationBar: (Platform.isIOS)
            ? CupertinoTabBar(
                activeColor: CupertinoColors.activeOrange,
                currentIndex: _currentIndex,
                onTap: (_index) {
                  setState(() {
                    _currentIndex = _index;
                  });
                },
                items: getBottomNavigationBarItems())
            : BottomNavigationBar(
                selectedItemColor: Colors.orange,
                currentIndex: _currentIndex,
                onTap: (_index) {
                  setState(() {
                    _currentIndex = _index;
                  });
                },
                items: getBottomNavigationBarItems(),
              ),
      ),
    );
  }

  List<BottomNavigationBarItem> getBottomNavigationBarItems() {
    return [
      BottomNavigationBarItem(
        icon: Icon(
          (Platform.isIOS) ? IOSQuickAccessIcons.person : Icons.person,
          size: (Platform.isIOS) ? 24 : null,
        ),
        title: Text("Mein Studium"),
      ),
      BottomNavigationBarItem(
        icon: Icon(
          (Platform.isIOS)
              ? IOSQuickAccessIcons.list_bullet_below_rectangle
              : Icons.home,
          size: (Platform.isIOS) ? 24 : null,
        ),
        title: Text("Übersicht"),
      ),
      BottomNavigationBarItem(
        icon: Icon(
          (Platform.isIOS) ? IOSQuickAccessIcons.studentdesk : Icons.restaurant,
          size: (Platform.isIOS) ? 24 : null,
        ),
        title: Text("Mensaplan"),
      ),
    ];
  }

  Widget getCorrectPage(int _index) {
    print("Setting key: " + key.toString());
    ModuleController().key = key;
    switch (_index) {
      case 0:
        return Dashboard(key: key);
      case 1:
        return Overview();
      case 2:
        return MensaPlan();
      default:
        return Overview();
    }
  }
}
