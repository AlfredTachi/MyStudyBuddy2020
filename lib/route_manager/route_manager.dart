import 'package:MyStudyBuddy2/dashboard/dashboard.dart';
import 'package:MyStudyBuddy2/mensa_plan/mensa_plan.dart';
import 'package:MyStudyBuddy2/support/faq.dart';
import 'package:MyStudyBuddy2/support/support.dart';
import 'package:MyStudyBuddy2/weather/weather.dart';
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
      case '/supportMain':
        return MaterialPageRoute(builder: (_) => Support());
      case '/supportMain/FAQ':
        return MaterialPageRoute(builder: (_) => FAQ());
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
