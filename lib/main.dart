import 'package:MyStudyBuddy2/dashboard/dashboard.dart';
import 'package:flutter/material.dart';

import './route_manager/route_manager.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: '/',
      onGenerateRoute: RouteGenerator.generateRoute,
      debugShowCheckedModeBanner: true,
      home: Scaffold(
        body: Dashboard(),
      )
    );
  }
}