import 'package:MyStudyBuddy2/dashboard/dashboard.dart';
import 'package:MyStudyBuddy2/mensa_plan/mensa_plan.dart';
import 'package:MyStudyBuddy2/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

import './route_manager/route_manager.dart';
import 'package:MyStudyBuddy2/model/module.dart';

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
  @override
  Widget build(BuildContext context) {
    final theme = Provider.of<ThemeChanger>(context);

    return MaterialApp(
      navigatorKey: Get.key,
      initialRoute: '/',
      onGenerateRoute: RouteGenerator.generateRoute,
      debugShowCheckedModeBanner: true,
      theme: theme.getTheme(),
      home: Scaffold(
        body: getCorrectPage(_currentIndex),
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: _currentIndex,
          onTap: (_index) {
            setState(() {
              _currentIndex = _index;
              print(_currentIndex);
            });
          },
          items: [
            BottomNavigationBarItem(
              icon: Icon(Icons.person),
              title: Text("Mein Studium"),
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              title: Text("Übersicht"),
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.restaurant),
              title: Text("Mensaplan"),
            ),
          ],
        ),
      ),
    );
  }

  Widget getCorrectPage(int _index) {
    switch (_index) {
      case 0:
        return Dashboard();
      case 1:
        return Overview();
      case 2:
        return MensaPlan();
      default:
        return Overview();
    }
  }
}