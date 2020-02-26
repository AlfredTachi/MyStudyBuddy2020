import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfilePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => ProfilePageState();
}

class ProfilePageState extends State<ProfilePage> {
  TextEditingController _ctrl = new TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Mein Profil"),
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Row(
              children: <Widget>[
                Flexible(
                  child: Text("Deine Inf: "),
                ),
                Flexible(
                  child: TextField(
                    controller: _ctrl,
                    keyboardType: TextInputType.number,
                    textAlignVertical: TextAlignVertical.bottom,
                    textAlign: TextAlign.left,
                  ),
                ),
              ],
            ),
            Row(
              children: <Widget>[
                Flexible(
                  child: Text("Deine Inf: "),
                ),
                Flexible(
                  child: TextField(
                    controller: _ctrl,
                    keyboardType: TextInputType.number,
                    textAlignVertical: TextAlignVertical.bottom,
                    textAlign: TextAlign.left,
                  ),
                ),
              ],
            ),
            Text("Deine Matrikelnummer: 172391"),
            Text("Angestrebter Schwerpunkt: "),
            RaisedButton(
                child: Text("Speichern"),
                onPressed: () {
                  saveData();
                })
          ],
        ));
  }

  void saveData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
  }

  void loadData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
  }
}
