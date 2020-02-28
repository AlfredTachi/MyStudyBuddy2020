import 'package:MyStudyBuddy2/dashboard/profile_page/profile_page.dart';
import 'package:MyStudyBuddy2/exam_results/exam_result.dart';
import 'package:MyStudyBuddy2/local_database/local_database.dart';
import 'package:MyStudyBuddy2/mensa_plan/mensa_plan.dart';
import 'package:MyStudyBuddy2/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

import './route_manager/route_manager.dart';
import 'package:MyStudyBuddy2/modules/module.dart';

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
  void initState() {
    super.initState();
    getModulesFromFile();
    try {
      getExamResultsFromLSFServer("", "");
    } catch (err) {
      print(err);
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Provider.of<ThemeChanger>(context);
    testDatabase();

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
              title: Text("Mein Profil"),
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              title: Text("Mein Studium"),
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
        return ProfilePage();
      case 1:
        return Overview();
      case 2:
        return MensaPlan();
      default:
        return Overview();
    }
  }
}

void testDatabase() async {
  final db = DBProvider.db;

  final modules = await db.getAllModules();
  print(modules.toString());
  final examResults = await db.getAllExamResults();
  print(examResults.toString());
  final skModule = await db.getModule(111);
  print(skModule.toString());
  final skResult = await db.getExamResult(111);
  print(skResult.toString());
  final nonExistingModule = await db.getModule(6000);
  print(nonExistingModule.toString());
  final nonExistingExamResult = await db.getExamResult(6000);
  print(nonExistingExamResult.toString());
}
