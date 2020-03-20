import 'package:flutter/material.dart';
import 'package:MyStudyBuddy2/studyprogress/staggered_view_studyprogress/staggered_view_studyprogress.dart';

class Studyprogress extends StatefulWidget {
  Studyprogress({Key key}) : super(key: key);

  @override
  StudyprogressState createState() => StudyprogressState();
}

class StudyprogressState extends State<Studyprogress> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(body: StaggeredView());
  }

  update() {
    setState(() {});
  }
}
