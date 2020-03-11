import 'package:achievement_view/achievement_view.dart';
import 'package:flutter/material.dart';

class AchievmentsPage  {
  String title;
  String subTitle;
  
  AchievmentsPage(this.title, this.subTitle);

 Widget achievementContext(BuildContext context){
    AchievementView(
    context,
    icon: Icon(Icons.child_care),
        title: title,
        subTitle: subTitle,
        listener: (status){
          print(status);
        }
    ).show();
  }

  
}