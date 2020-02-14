import 'package:flutter/material.dart';
import '../dashboard/staggered_view_dashboard/StaggeredView.dart';
import '../drawer/drawer.dart';

class Dashboard extends StatefulWidget {
  @override
  DashboardState createState() => DashboardState();
}

class DashboardState extends State<Dashboard> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("MyStudyBuddy"),
      ),
      drawer: OwnDrawer(),
      body:StaggeredView(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        tooltip: 'Modul hinzufügen',
        child: Icon(Icons.add),
      ),
    );
  }
}
