import 'package:flutter/material.dart';
import '../dashboard/staggered_view_dashboard/StaggeredView.dart';
import '../drawer/drawer.dart';
import 'package:MyStudyBuddy2/dashboard/moduleSelection/moduleSelection.dart';

class Dashboard extends StatefulWidget {
  @override
  DashboardState createState() => DashboardState();
}

class DashboardState extends State<Dashboard> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Übersicht"),
      ),
      drawer: OwnDrawer(),
      body: StaggeredView(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => ModuleSelection()),
          );
        },
        tooltip: 'Modul hinzufügen',
        child: Icon(Icons.add),
      ),
    );
  }
}
