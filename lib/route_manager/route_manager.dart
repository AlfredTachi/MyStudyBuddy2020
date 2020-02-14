import 'package:MyStudyBuddy2/dashboard/dashboard.dart';
import 'package:MyStudyBuddy2/mensa_plan/mensa_plan.dart';
import 'package:flutter/material.dart';


class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {

    switch (settings.name) {
      case '/':
      return MaterialPageRoute(builder: (_)=> Dashboard());      
      case '/mensa_plan':
      return MaterialPageRoute(builder: (_) => MensaPlan());
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