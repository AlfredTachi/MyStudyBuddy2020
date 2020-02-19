import 'package:flutter/material.dart';
import 'package:MyStudyBuddy2/studyprogress/staggered_view_studyprogress/staggered_view.dart';
import '../drawer/drawer.dart';

class Studyprogress extends StatefulWidget {
  @override
  StudyprogressState createState() => StudyprogressState();
}

class StudyprogressState extends State<Studyprogress> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Studienverlauf"),
      ),
      drawer: OwnDrawer(),
      body:StaggeredView()
    );
  }
}