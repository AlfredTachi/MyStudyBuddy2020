import 'package:MyStudyBuddy2/dashboard/dashboard.dart';
import 'package:MyStudyBuddy2/studyprogress/studyprogress.dart';
import 'package:flutter/material.dart';


class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {

    switch (settings.name) {
      case '/':
      return MaterialPageRoute(builder: (_)=> Dashboard());
      case '/semesterverlauf':
      return MaterialPageRoute(builder: (_)=> Studyprogress());      
      default:
        return _errorRoute();
    }
  }

  static Route<dynamic> _errorRoute() {
    return MaterialPageRoute(builder: (_) {
      return Scaffold(
        appBar: AppBar(
          title: Text('Error'),
        ),
        body: Center(
          child: Text('ERROR'),
        ),
      );
    });
  }
}