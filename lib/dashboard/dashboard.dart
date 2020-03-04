import 'package:MyStudyBuddy2/local_database/local_database.dart';
import 'package:MyStudyBuddy2/singleton/profile_controller.dart';
import 'package:flutter/material.dart';
import 'package:liquid_progress_indicator/liquid_progress_indicator.dart';

import '../local_database/local_database.dart';
import '../singleton/module_controller.dart';

class Dashboard extends StatefulWidget {
  @override
  DashboardState createState() => DashboardState();
}

class DashboardState extends State<Dashboard> {
  @override
  Widget build(BuildContext context) {
    double spacing = MediaQuery.of(context).size.width / 4.3;
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: Color(0xFF013D62),
        onPressed: () {
          Navigator.pushNamed(context, "/modulSelection")
              .whenComplete(() => updateView());
        },
        tooltip: 'Modul hinzufügen',
        child: Icon(Icons.add),
      ),
      backgroundColor: Colors.grey[50],
      body: SafeArea(
        child: Column(
          children: <Widget>[
            Align(
                alignment: Alignment.topRight,
                child: IconButton(
                  icon: Icon(
                    Icons.person,
                    color: Color(0xCC013D62),
                  ),
                  onPressed: () {
                    Navigator.of(context).pushNamed("/profilePage");
                  },
                )),
            Expanded(
              flex: 4,
              child: Container(
                padding:
                    EdgeInsets.only(bottom: 10, right: spacing, left: spacing),
                child: LiquidCircularProgressIndicator(
                  value: ProfileController().getEarnedCP() /
                      ProfileController().getMaxCP(), // Defaults to 0.5.
                  valueColor: AlwaysStoppedAnimation(
                    Color(0xAA013D62),
                  ), // Defaults to the current Theme's accentColor.
                  backgroundColor: Colors
                      .white, // Defaults to the current Theme's backgroundColor.
                  borderColor: Color(0xCC013D62),
                  borderWidth: 5.0,
                  direction: Axis
                      .vertical, // The direction the liquid moves (Axis.vertical = bottom to top, Axis.horizontal = left to right). Defaults to Axis.vertical.
                  center: Text(
                    ProfileController().getProgressText(),
                    style: TextStyle(
                        color: Colors.blueGrey[900],
                        fontWeight: FontWeight.bold),
                  ),
                ),
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
                                      "Meine Module",
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
/*                                   child: FutureBuilder(
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
                                      return */
                                  child: Center(
                                    child: Align(
                                      heightFactor: 10,
                                      child: FittedBox(
                                        child: Text(
                                          "Du hast zurzeit keine Module geplant!",
                                          style:
                                              TextStyle(color: Colors.black45),
                                        ),
                                      ),
                                    ),
                                    //);
                                    // }
                                    // },
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
    var module = await DBProvider.db.readModule(151);
    String title = module.title;
    return title;
  }

  updateView() {
    setState(() {});
  }
}
