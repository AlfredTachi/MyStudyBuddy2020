import 'package:flutter/material.dart';
import '../drawer/drawer.dart';

class Settings extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _SettingsState();
  }
}

class _SettingsState extends State<Settings> {
  bool darkModeVal = false;
  bool notifaicationVal = false;

  onDarkMode(bool newVal) {
    setState(() {
      darkModeVal = newVal;
      
    });
  }

  onNotification(bool newVal) {
    setState(() {
      notifaicationVal = newVal;
    });
  }

  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text("Einstellungen")),
        drawer: OwnDrawer(),
        body: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Card(
                color: Colors.white,
                margin: EdgeInsets.all(1.0),
                child: ListTile(
                  leading: Text("Dark Mode"),
                  trailing: Switch(
                      value: darkModeVal,
                      onChanged: (newVal) {
                        onDarkMode(newVal);
                      }),
                ),
              ),
              Card(
                  color: Colors.white,
                  margin: EdgeInsets.all(1.0),
                  child: ListTile(
                      leading: Text("Notification"),
                      trailing: Switch(
                          value: notifaicationVal,
                          onChanged: (newVal) {
                            onNotification(newVal);
                          }))),
              Card(
                  color: Colors.white,
                  margin: EdgeInsets.all(1.0),
                  child: ListTile(
                      leading: Text("Allgemein"),
                      trailing: Icon(Icons.edit)
              )),
              Card(
                  color: Colors.white,
                  margin: EdgeInsets.all(1.0),
                  child: ListTile(
                      leading: Text("App Einstellungen"),
                      trailing: Icon(Icons.refresh))),
            ],
          ),
        ));
  }
}
