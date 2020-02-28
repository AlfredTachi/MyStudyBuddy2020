import 'package:MyStudyBuddy2/dashboard/dashboard.dart';
import 'package:MyStudyBuddy2/exam_results/exam_result.dart';
import 'package:MyStudyBuddy2/local_database/local_database.dart';
import 'package:MyStudyBuddy2/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import './route_manager/route_manager.dart';
import 'package:MyStudyBuddy2/modules/module.dart';

void main() {
  runApp(new MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    getModulesFromFile();
    try {
      getExamResultsFromLSFServer("", "");
    } catch (err) {
      print("err");
    }
    testDatabase();
    return ChangeNotifierProvider<ThemeChanger>(
        create: (_) => ThemeChanger(baselight()),
        child: MaterialAppWithTheme());
  }
}

class MaterialAppWithTheme extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final theme = Provider.of<ThemeChanger>(context);
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);
    return MaterialApp(
        initialRoute: '/',
        onGenerateRoute: RouteGenerator.generateRoute,
        debugShowCheckedModeBanner: true,
        theme: theme.getTheme(),
        home: Scaffold(
          body: Dashboard(),
        ));
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
