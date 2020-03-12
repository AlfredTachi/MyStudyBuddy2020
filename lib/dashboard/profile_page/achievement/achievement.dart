import 'package:achievement_view/achievement_view.dart';
import 'package:achievement_view/achievement_widget.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AchievementPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => AchievementPageState();
}

class AchievementPageState extends State<AchievementPage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text("Errungenschaften"),
        ),
        body: FutureBuilder(
            future: Achievement().loadAchievements(),
            builder: (BuildContext _con, AsyncSnapshot _snap) {
              if (_snap.connectionState == ConnectionState.done) {
                return ListView.builder(
                  itemCount: Achievement().allAchivements.length,
                  itemBuilder: (BuildContext _context, int _index) {
                    AchivementProperties prop =
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
  }
}

class Achievement {
  //Singleton
  Achievement._internal();
  factory Achievement() => _instance;
  //Instance
  static final Achievement _instance = Achievement._internal();

  List<AchivementProperties> allAchivements = [
    AchivementProperties(
      id: 0,
      icon: AssetImage("assets/icons/achievement/schaf.png"),
      title: "Mein Studium",
      description: "Besuche zum ersten mal die \"Mein Studium\" Seite.",
      isDone: false,
    ),
    AchivementProperties(
      id: 1,
      icon: AssetImage("assets/icons/achievement/1.png"),
      title: "Ich bin schon fast 12!",
      description: "Schließe das erste Semester ab! (30 CP)",
      isDone: false,
    ),
    AchivementProperties(
      id: 2,
      icon: AssetImage("assets/icons/achievement/2.png"),
      title: "Wie lange noch?",
      description: "Schließe das zweite Semester ab! (60 CP).",
      isDone: false,
    ),
    AchivementProperties(
      id: 3,
      icon: AssetImage("assets/icons/achievement/3.png"),
      title: "Angehender Informatiker",
      description: "Schließe das dritte Semester ab! (90 CP).",
      isDone: false,
    ),
    AchivementProperties(
      id: 4,
      icon: AssetImage("assets/icons/achievement/4.png"),
      title: "Nicht mehr lange!",
      description: "Schließe das vierte Semester ab! (120 CP).",
      isDone: false,
    ),
    AchivementProperties(
      id: 5,
      icon: AssetImage("assets/icons/achievement/5.png"),
      title: "Viel Spaß bei TOP!",
      description: "Schließe das fünfte Semester ab! (150 CP).",
      isDone: false,
    ),
    AchivementProperties(
      id: 6,
      icon: AssetImage("assets/icons/achievement/6.png"),
      title: "Ist das schon das Ende?",
      description: "Schließe das sechste Semester ab! (180 CP).",
      isDone: false,
    ),
    AchivementProperties(
      id: 7,
      icon: AssetImage("assets/icons/achievement/7.png"),
      title: "Wie, ich mache den Master?",
      description: "Schliese das siebte Semester ab! (210 CP).",
      isDone: false,
    ),
    AchivementProperties(
      id: 8,
      icon: AssetImage("assets/icons/achievement/schaf.png"),
      title: "Frohes(?) Schaffen",
      description: "Versuche deine Daten aus dem LSF zu ziehen.",
      isDone: false,
    ),
    AchivementProperties(
      id: 9,
      icon: AssetImage("assets/icons/achievement/schaf.png"),
      title: "Planer",
      description: "Plane dein erstes Modul ein.",
      isDone: false,
    ),
    AchivementProperties(
      id: 10,
      icon: AssetImage("assets/icons/achievement/schaf.png"),
      title: "Hungeriger Studi!",
      description: "Öffne den Mensaplan.",
      isDone: false,
    ),
  ];

  showAchievement(BuildContext context, int id) async {
    await loadAchievements();
    AchivementProperties _prop =
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

  Future<void> setAchievementToDone(AchivementProperties _prop) async {
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

class AchivementProperties {
  AssetImage icon;
  String title;
  String description;
  int id;
  bool isDone;

  AchivementProperties(
      {this.id, this.icon, this.title, this.description, this.isDone});

  factory AchivementProperties.fromJson(Map<String, dynamic> json) {
    return AchivementProperties(
      icon: json["icon"],
      description: json["description"],
      id: json["id"],
      title: json["title"],
    );
  }
}
