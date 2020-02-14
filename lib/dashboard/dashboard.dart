import 'package:flutter/material.dart';
import 'progress_bar/progress_bar.dart';
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
      body: Column(
        children: <Widget>[
          Material(
            elevation: 15,
            child: Container(
                height: MediaQuery.of(context).size.height / 3.5,
                child: Row(
                  children: <Widget>[
                    Container(
                        height: 200,
                        width: 200,
                        padding: EdgeInsets.all(10),
                        child: ProgressBar()),
                    VerticalDivider(),
                    Container(
                      alignment: Alignment.center,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Row(
                            children: <Widget>[Icon(Icons.headset), Text("0")],
                          ),
                          Row(
                            children: <Widget>[
                              Icon(Icons.gps_not_fixed),
                              Text("Noch keinen")
                            ],
                          ),
                          Row(
                            children: <Widget>[
                              Icon(Icons.person),
                              Text("inf2802")
                            ],
                          )
                        ],
                      ),
                    ),
                  ],
                )),
          ),
          Divider(),
          Material(
            elevation: 15,
            child: Container(
                padding: EdgeInsets.all(15),
                child: Row(
                  children: <Widget>[
                    Icon(Icons.library_books),
                    Text(
                      " Dein 1. Semester",
                      style: TextStyle(
                        fontSize: 24,
                      ),
                    ),
                  ],
                )),
          ),
          Divider(),
          Expanded(
            flex: 2,
            child: Material(
              elevation: 15,
              child: Container(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Center(
                      child: Text(
                        "Du hast zurzeit keine Module geplant!",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        tooltip: 'Modul hinzufügen',
        child: Icon(Icons.add),
      ),
    );
  }
}
