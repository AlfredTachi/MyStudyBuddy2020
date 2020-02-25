import 'package:flutter/material.dart';
import '../dashboard/staggered_view_dashboard/staggered_view_dashboard.dart';
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
        title: Text("Übersicht"),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.person),
            onPressed: () {
              ///TODO Profilseite anzeigen
            },
          )
        ],
      ),
      drawer: OwnDrawer(),
      body: StaggeredView(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, "/modulSelection")
              .whenComplete(() => updateView());
        },
        tooltip: 'Modul hinzufügen',
        child: Icon(Icons.add),
      ),
    );
  }

  updateView() {
    setState(() {});
  }
}
