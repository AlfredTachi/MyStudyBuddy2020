import 'package:MyStudyBuddy2/campus_plan/campus_plan.dart';
import 'package:MyStudyBuddy2/dashboard/dashboard.dart';
import 'package:MyStudyBuddy2/dashboard/module_selection/module_selection.dart';
import 'package:MyStudyBuddy2/dashboard/module_selection/module_selection_QSP.dart';
import 'package:MyStudyBuddy2/dashboard/module_selection/module_selection_WPF.dart';
import 'package:MyStudyBuddy2/dashboard/profile_page/achievement/achievement.dart';
import 'package:MyStudyBuddy2/dashboard/profile_page/profile_page.dart';
import 'package:MyStudyBuddy2/grades_prognosis/grades_list.dart';
import 'package:MyStudyBuddy2/planer/planer.dart';
import 'package:MyStudyBuddy2/qsp_info/qsp_info.dart';
import 'package:MyStudyBuddy2/study_quiz/home.dart';
import 'package:MyStudyBuddy2/studyprogress/studyprogress.dart';
import 'package:MyStudyBuddy2/grades_prognosis/grades_prognosis.dart';
import 'package:MyStudyBuddy2/mensa_plan/mensa_plan.dart';
import 'package:MyStudyBuddy2/modulhandbook/modulhandbook.dart';
import 'package:MyStudyBuddy2/support/faq.dart';
import 'package:MyStudyBuddy2/support/moral_support.dart';
import 'package:MyStudyBuddy2/support/quickaccess.dart';
import 'package:MyStudyBuddy2/support/support.dart';
import 'package:MyStudyBuddy2/weather/weather.dart';
import 'package:MyStudyBuddy2/support/impresssum.dart';
import 'package:MyStudyBuddy2/support/privacyPolice/privacyPolice.dart';
import 'package:flutter/material.dart';
import 'package:MyStudyBuddy2/support/privacyPolice/lsfPrivacyPolice.dart';
import 'package:MyStudyBuddy2/support/privacyPolice/ourPrivacyPolice.dart';
import 'package:MyStudyBuddy2/support/privacyPolice/StudierendenwerkPrivacyPolice.dart';
import '../dashboard/module_selection/module_selection.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case '/dashboard':
        return MaterialPageRoute(builder: (_) => Dashboard());
      case '/profilePage':
        return MaterialPageRoute(builder: (_) => ProfilePage());
      case '/modulSelection':
        return MaterialPageRoute(builder: (_) => ModuleSelection());
      case '/modulSelectionQSP':
        return MaterialPageRoute(builder: (_) => ModuleSelectionQSP());
      case '/modulSelectionWPF':
        return MaterialPageRoute(builder: (_) => ModuleSelectionWPF());
      case '/studyprogress':
        return MaterialPageRoute(builder: (_) => Studyprogress());
      case '/mensaPlan':
        return MaterialPageRoute(builder: (_) => MensaPlan());
      case '/weather':
        return MaterialPageRoute(builder: (_) => Weather());
      case '/moduleHandbook':
        return MaterialPageRoute(builder: (_) => ModuleHandbooks());
      case '/supportMain':
        return MaterialPageRoute(builder: (_) => Support());
      case '/supportMain/FAQ':
        return MaterialPageRoute(builder: (_) => FAQ());
      case '/supportMain/quickaccess':
        return MaterialPageRoute(builder: (_) => Quickaccess());
      case '/map':
        return MaterialPageRoute(builder: (_) => CampusPlan());
      case '/gradesPrognosis':
        return MaterialPageRoute(builder: (_) => GradesPrognosis());
      case '/planer':
        return MaterialPageRoute(builder: (_) => Planer());
      case '/qspinfo':
        return MaterialPageRoute(builder: (_) => QSPInfo());
      case '/quiz':
        return MaterialPageRoute(builder: (_) => Homepage());
      case '/supportMain/quickAccess/moralSupport':
        return MaterialPageRoute(builder: (_) => MoralSupport());
      case '/supportMain/impressum':
        return MaterialPageRoute(builder: (_) => Impressum());
      case '/supportMain/privacyPolice/privacyPolice':
        return MaterialPageRoute(builder: (_) => PrivacyPolice());
      case '/supportMain/privacyPolice/lsfPrivacyPolice':
        return MaterialPageRoute(builder: (_) => LsfPrivacyPolice());
      case '/supportMain/privacyPolice/ourPrivacyPolice':
        return MaterialPageRoute(builder: (_) => OurPrivacyPolice());
      case '/supportMain/privacyPolice/studierendenwerkPrivacyPolice':
        return MaterialPageRoute(builder: (_)=> StudierendenwerkPrivacyPolice());
      case '/gradesList':
        return MaterialPageRoute(builder: (_) => GradesList());
      case '/achievement':
        return MaterialPageRoute(builder: (_) => AchievementPage());
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
          child: Text('No matching route found!'),
        ),
      );
    });
  }
}
