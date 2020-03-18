import 'package:flutter/material.dart';
import 'package:MyStudyBuddy2/studyprogress/staggered_view_studyprogress/staggered_view_studyprogress.dart';

class Studyprogress extends StatefulWidget {
  @override
  StudyprogressState createState() => StudyprogressState();
}

class StudyprogressState extends State<Studyprogress> {
  //BuildContext scaffoldContext;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: StaggeredView());
  }
}
