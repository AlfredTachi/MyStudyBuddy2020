import 'package:MyStudyBuddy2/singleton/module_controller.dart';
import 'package:MyStudyBuddy2/singleton/profile_controller.dart';
import 'package:flutter/material.dart';
import 'package:liquid_progress_indicator/liquid_progress_indicator.dart';

class Dashboard extends StatefulWidget {
  @override
  DashboardState createState() => DashboardState();
}

class DashboardState extends State<Dashboard> {
  @override
  Widget build(BuildContext context) {
    double spacing = MediaQuery.of(context).size.width / 1.8;
    return SafeArea(
      child: Scaffold(
        floatingActionButton: FloatingActionButton(
          backgroundColor: Color(0xFF013D62),
          onPressed: () {
            Navigator.pushNamed(context, "/modulSelection")
                .whenComplete(() => updateView());
          },
          tooltip: 'Modul hinzufügen',
          child: Icon(Icons.add),
        ),
        body: Column(
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
                    ProfileController().showAchievement(context);
                  },
                )),
            Container(
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: SizedBox(
                  height: spacing,
                  width: spacing,
                  child: LiquidCircularProgressIndicator(
                    value: ProfileController().getEarnedCP() /
                        ProfileController().getMaxCP(),
                    valueColor: AlwaysStoppedAnimation(
                      Color(0xAA013D62),
                    ),
                    backgroundColor: Colors.white,
                    borderColor: Color(0xCC013D62),
                    borderWidth: 5.0,
                    direction: Axis.vertical,
                    center: Text(
                      ProfileController().getProgressText(),
                      style: TextStyle(
                          color: Colors.blueGrey[900],
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ),
            ),
            Expanded(
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
                child: Padding(
                  padding: const EdgeInsets.only(top: 30),
                  child: SingleChildScrollView(
                    child: Column(
                      children: <Widget>[
                        Row(
                          children: <Widget>[
                            Padding(
                              padding:
                                  EdgeInsets.only(left: 15, top: 5, bottom: 15),
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
                          child: (ModuleController()
                                      .getSelectedModules()
                                      .length !=
                                  0)
                              ? Center(
                                  child: Wrap(
                                      direction: Axis.horizontal,
                                      spacing: 0,
                                      runSpacing: 5,
                                      children: ModuleController().getAllSelectedModulesWidgets()),
                                )
                              : Center(
                                  child: Align(
                                    heightFactor: 5,
                                    child: FittedBox(
                                      child: Text(
                                        "Du hast zurzeit keine Module geplant!",
                                        style: TextStyle(color: Colors.black45),
                                      ),
                                    ),
                                  ),
                                ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  updateView() {
    setState(() {});
  }
}
