import 'package:achievement_view/achievement_view.dart';
import 'package:achievement_view/achievement_widget.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:MyStudyBuddy2/theme/styles.dart';
import 'dart:io';

class AchievementPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => AchievementPageState();
}

class AchievementPageState extends State<AchievementPage> {
  @override
  Widget build(BuildContext context) {
    List<Widget> getContainerChildren() {
      List<Widget> _list = List<Widget>();
      if (!Platform.isIOS) {
        _list.add(Container(
          color: Colors.orange,
          child: Row(
            children: <Widget>[
              Align(
                alignment: Alignment.topLeft,
                child: OutlineButton(
                    child: Padding(
                      padding: const EdgeInsets.only(top: 3, bottom: 3),
                      child: Icon(
                        Icons.arrow_back,
                        size: 36,
                      ),
                    ),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.only(
                      topRight: Radius.circular(15),
                      bottomRight: Radius.circular(15),
                    )),
                    onPressed: () {
                      Navigator.of(context).pop();
                    }),
              ),
              Align(
                alignment: Alignment.topCenter,
                child: Padding(
                  padding: const EdgeInsets.only(left: 20, top: 3, bottom: 3),
                  child:
                      Text("Errungenschaften", style: TextStyle(fontSize: 25)),
                ),
              )
            ],
          ),
        ));
      }
      _list.add(
        Expanded(
          child: FutureBuilder(
              future: Achievement().loadAchievements(),
              builder: (BuildContext _con, AsyncSnapshot _snap) {
                if (_snap.connectionState == ConnectionState.done) {
                  return ListView.builder(
                    itemCount: Achievement().allAchivements.length,
                    itemBuilder: (BuildContext _context, int _index) {
                      AchievementProperties prop =
                          Achievement().allAchivements[_index];
                      return ListTile(
                        trailing: (prop.isDone)
                            ? Icon(
                                Icons.lock_open,
                                size: 40,
                                color: Colors.green,
                              )
                            : Icon(
                                Icons.lock_outline,
                                size: 40,
                              ),
                        contentPadding: EdgeInsets.all(10),
                        enabled: true,
                        leading: ImageIcon(
                          prop.icon,
                          size: 40,
                          color: Colors.black,
                        ),
                        title: Text(
                          prop.title,
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        subtitle: Padding(
                          padding: const EdgeInsets.only(top: 3.0),
                          child: AutoSizeText(
                            prop.description,
                            maxFontSize: 17,
                          ),
                        ),
                      );
                    },
                  );
                } else {
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[CircularProgressIndicator()],
                  );
                }
              }),
        ),
      );
      return _list;
    }

    return Scaffold(
      appBar: (Platform.isIOS)
          ? CupertinoNavigationBar(
              actionsForegroundColor: CupertinoColors.activeOrange,
              middle: Text(
                "Errungenschaften",
                style: Styles.navBarTitle,
              ),
            )
          : null,
      body: SafeArea(
        child: Column(
          children: getContainerChildren(),
        ),
      ),
    );
  }
}

class Achievement {
  //Singleton
  Achievement._internal();
  factory Achievement() => _instance;
  //Instance
  static final Achievement _instance = Achievement._internal();

  List<AchievementProperties> allAchivements = [
    AchievementProperties(
      id: 0,
      icon: AssetImage("assets/icons/achievement/mein_studium.png"),
      title: "Mein Studium",
      description: "Besuche zum ersten mal die \"Mein Studium\" Seite.",
      isDone: false,
    ),
    AchievementProperties(
      id: 1,
      icon: AssetImage("assets/icons/achievement/1.png"),
      title: "Ich bin schon fast 12!",
      description: "Schließe das erste Semester ab! (30 CP)",
      isDone: false,
    ),
    AchievementProperties(
      id: 2,
      icon: AssetImage("assets/icons/achievement/2.png"),
      title: "Wie lange noch?",
      description: "Schließe das zweite Semester ab! (60 CP).",
      isDone: false,
    ),
    AchievementProperties(
      id: 3,
      icon: AssetImage("assets/icons/achievement/3.png"),
      title: "Angehender Informatiker",
      description: "Schließe das dritte Semester ab! (90 CP).",
      isDone: false,
    ),
    AchievementProperties(
      id: 4,
      icon: AssetImage("assets/icons/achievement/4.png"),
      title: "Nicht mehr lange!",
      description: "Schließe das vierte Semester ab! (120 CP).",
      isDone: false,
    ),
    AchievementProperties(
      id: 5,
      icon: AssetImage("assets/icons/achievement/5.png"),
      title: "Viel Spaß bei TOP!",
      description: "Schließe das fünfte Semester ab! (150 CP).",
      isDone: false,
    ),
    AchievementProperties(
      id: 6,
      icon: AssetImage("assets/icons/achievement/6.png"),
      title: "Ist das schon das Ende?",
      description: "Schließe das sechste Semester ab! (180 CP).",
      isDone: false,
    ),
    AchievementProperties(
      id: 7,
      icon: AssetImage("assets/icons/achievement/7.png"),
      title: "Wie, ich mache den Master?",
      description: "Schliese das siebte Semester ab! (210 CP).",
      isDone: false,
    ),
    AchievementProperties(
      id: 8,
      icon: AssetImage("assets/icons/achievement/frohes_schaffen.png"),
      title: "Frohes(?) Schaffen",
      description: "Versuche deine Daten aus dem LSF zu ziehen.",
      isDone: false,
    ),
    AchievementProperties(
      id: 9,
      icon: AssetImage("assets/icons/achievement/planer.png"),
      title: "Planer",
      description: "Plane dein erstes Modul ein.",
      isDone: false,
    ),
    AchievementProperties(
      id: 10,
      icon: AssetImage("assets/icons/achievement/hungrig.png"),
      title: "Hungriger Studi!",
      description: "Öffne den Mensaplan.",
      isDone: false,
    ),
    AchievementProperties(
      id: 11,
      icon: AssetImage("assets/icons/achievement/error.png"),
      title: "Error 404",
      description: "Erhalte als Response ein 404 Error Code.",
      isDone: false,
    ),
  ];

  showAchievement(BuildContext context, int id) async {
    await loadAchievements();
    AchievementProperties _prop =
        allAchivements.firstWhere((item) => item.id == id);

    if (_prop.isDone == false) {
      await setAchievementToDone(_prop);
      // print("Zeige!");
      AchievementView(
        context,
        icon: ImageIcon(_prop.icon),
        title: _prop.title,
        duration: Duration(seconds: 2, milliseconds: 500),
        subTitle: _prop.description,
        textStyleSubTitle: TextStyle(fontSize: 12),
        listener: (status) {
          if (status != AchievementState.closed) {
            return;
          }
        },
      ).show();
    }
  }

  Future<void> setAchievementToDoneByID(int id) async {
    AchievementProperties prop =
        allAchivements.firstWhere((item) => item.id == id);
    SharedPreferences pref = await SharedPreferences.getInstance();
    prop.isDone = true;
    pref.setBool(prop.id.toString(), prop.isDone);
    // print("Speichern!");
  }

  Future<void> setAchievementToDone(AchievementProperties _prop) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    _prop.isDone = true;
    pref.setBool(_prop.id.toString(), _prop.isDone);
    // print("Speichern!");
  }

  Future<void> loadAchievements() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    for (var i = 0; i < allAchivements.length; i++) {
      allAchivements[i].isDone =
          (pref.getBool(allAchivements[i].id.toString()) == null)
              ? false
              : true;
    }
    // print("Laden");
  }
}

class AchievementProperties {
  AssetImage icon;
  String title;
  String description;
  int id;
  bool isDone;

  AchievementProperties(
      {this.id, this.icon, this.title, this.description, this.isDone});

  factory AchievementProperties.fromJson(Map<String, dynamic> json) {
    return AchievementProperties(
      icon: json["icon"],
      description: json["description"],
      id: json["id"],
      title: json["title"],
    );
  }
}
