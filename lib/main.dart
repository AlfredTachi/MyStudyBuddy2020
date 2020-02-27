import 'package:MyStudyBuddy2/dashboard/dashboard.dart';
import 'package:MyStudyBuddy2/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

import './route_manager/route_manager.dart';

void main() {
  runApp(new MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
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
        navigatorKey: Get.key,
        initialRoute: '/',
        onGenerateRoute: RouteGenerator.generateRoute,
        debugShowCheckedModeBanner: true,
        theme: theme.getTheme(),
        home: Scaffold(
          body: Dashboard(),
        ));
  }
}
