import 'package:MyStudyBuddy2/dashboard/progress_bar/progress_bar.dart';
import 'package:MyStudyBuddy2/local_database/local_database.dart';
import 'package:flutter/material.dart';

class Dashboard extends StatefulWidget {
  @override
  DashboardState createState() => DashboardState();
}

class DashboardState extends State<Dashboard> {
  int _creditPoints = 0;
  int _maxCreditPoints = 210;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Mein Studium"),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.person),
            onPressed: () {
              Navigator.of(context).pushNamed("/profilePage");
            },
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, "/modulSelection")
              .whenComplete(() => updateView());
        },
        tooltip: 'Modul hinzufügen',
        child: Icon(Icons.add),
      ),
      body: SafeArea(
        child: Column(
          children: <Widget>[
            Expanded(
              flex: 4,
              child: Container(
                child: ProgressBar(_creditPoints, _maxCreditPoints),
              ),
            ),
            Expanded(
              flex: 6,
              child: Container(
                decoration: BoxDecoration(
                    borderRadius:
                        BorderRadius.vertical(top: Radius.circular(30)),
                    gradient: LinearGradient(
                      begin: Alignment.topRight,
                      end: Alignment.bottomLeft,
                      colors: [
                        Colors.orange,
                        Colors.deepOrange,
                      ],
                    )),
                child: Column(
                  children: <Widget>[
                    Expanded(
                      flex: 3,
                      child: Padding(
                        padding: const EdgeInsets.only(top: 30),
                        child: SingleChildScrollView(
                          child: Column(
                            children: <Widget>[
                              Row(
                                children: <Widget>[
                                  Padding(
                                    padding: EdgeInsets.only(
                                        left: 15, top: 5, bottom: 15),
                                    child: Text(
                                      "Deine Module",
                                      style: TextStyle(
                                          fontSize: 25, color: Colors.black54),
                                    ),
                                  ),
                                ],
                              ),
                              Container(
                                padding: EdgeInsets.only(left: 5, right: 5),
                                alignment: Alignment.topLeft,
                                child: Center(
                                  child: FutureBuilder(
                                    future: getFutureData(),
                                    builder: (BuildContext context,
                                        AsyncSnapshot snapshot) {
                                      // if (snapshot.hasData) {
                                      //   return Center(
                                      //     child: Wrap(
                                      //         direction: Axis.horizontal,
                                      //         spacing: 0,
                                      //         runSpacing: 5,
                                      //         children: getFutureData()),
                                      //   );
                                      // } else {
                                      return Center(
                                        child: Align(
                                          heightFactor: 10,
                                          child: FittedBox(
                                            child: Text(
                                              "Du hast zurzeit keine Module geplant!",
                                              style: TextStyle(
                                                  color: Colors.black45),
                                            ),
                                          ),
                                        ),
                                      );
                                      // }
                                    },
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  getFutureData() async {
    ///TODO Dashboard fixen
    var module = await DBProvider.db.getModule(151);
    String title = module.title;
    return title;
  }

  updateView() {
    setState(() {});
  }
}
