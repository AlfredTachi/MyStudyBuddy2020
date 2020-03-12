import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';

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
        body: ListView.builder(
          itemCount: Achievement().allAchivements.length,
          itemBuilder: (BuildContext _context, int _index) {
            AchivementProperties prop = Achievement().allAchivements[_index];
            return ListTile(
              contentPadding: EdgeInsets.all(10),
              isThreeLine: true,
              leading: ImageIcon(
                prop.icon,
                size: 40,
              ),
              title: Text(
                prop.title,
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              subtitle: AutoSizeText(prop.description, maxFontSize: 18,)
            );
          },
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

  List<AchivementProperties> allAchivements = [
    AchivementProperties(
      id: 0,
      icon: AssetImage("assets/icons/achievement/schaf.png"),
      title: "Neuankömmling",
      description: "Starte die App zum ersten mal.",
    ),
    AchivementProperties(
      id: 1,
      icon: AssetImage("assets/icons/achievement/1.png"),
      title: "Ich bin schon fast 12!",
      description: "Schliese das erste Semester ab! (30 CP)",
    ),
    AchivementProperties(
      id: 2,
      icon: AssetImage("assets/icons/achievement/2.png"),
      title: "Wie lange noch?",
      description: "Schliese das zweite Semester ab! (60 CP).",
    ),
    AchivementProperties(
      id: 3,
      icon: AssetImage("assets/icons/achievement/3.png"),
      title: "Schwerpunkt Experte",
      description: "Schliese das dritte Semester ab! (90 CP).",
    ),
    AchivementProperties(
      id: 4,
      icon: AssetImage("assets/icons/achievement/4.png"),
      title: "Nicht mehr lange!",
      description: "Schliese das vierte Semester ab! (120 CP).",
    ),
    AchivementProperties(
      id: 5,
      icon: AssetImage("assets/icons/achievement/5.png"),
      title: "Viel Spaß bei TOP!",
      description: "Schliese das fünfte Semester ab! (150 CP).",
    ),
    AchivementProperties(
      id: 6,
      icon: AssetImage("assets/icons/achievement/6.png"),
      title: "Ist das schon das Ende?",
      description: "Schliese das sechste Semester ab! (180 CP).",
    ),
    AchivementProperties(
      id: 7,
      icon: AssetImage("assets/icons/achievement/7.png"),
      title: "Wie ich mache den Master?",
      description: "Schliese das siebte Semester ab! (210 CP).",
    ),
  ];
}

class AchivementProperties {
  AssetImage icon;
  String title;
  String description;

  int id;
  bool isDone = false;

  AchivementProperties({this.id, this.icon, this.title, this.description});
}
