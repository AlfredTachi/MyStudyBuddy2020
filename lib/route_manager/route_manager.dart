import 'package:MyStudyBuddy2/dashboard/dashboard.dart';
import 'package:MyStudyBuddy2/grades_prognosis/grades_prognosis.dart';
import 'package:MyStudyBuddy2/mensa_plan/mensa_plan.dart';
import 'package:MyStudyBuddy2/weather/weather.dart';
import 'package:MyStudyBuddy2/settings/settings.dart';
import 'package:flutter/material.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case '/':
        return MaterialPageRoute(builder: (_) => Dashboard());
      case '/mensa_plan':
        return MaterialPageRoute(builder: (_) => MensaPlan());
      case '/weather':
        return MaterialPageRoute(builder: (_) => Weather());
      case '/settings':
        return MaterialPageRoute(builder: (_) => Settings());
      case '/grades_prognosis':
        return MaterialPageRoute(builder: (_) => GradesPrognosis());
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
