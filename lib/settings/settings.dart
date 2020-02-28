import 'package:MyStudyBuddy2/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Settings extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _SettingsState();
  }
}

bool darkModeVal = false;
bool notifaicationVal = false;

class _SettingsState extends State<Settings> {
  
  


  onNotification(bool newVal) {
    setState(() {
      notifaicationVal = newVal;
    });
  }

  @override
  Widget build(BuildContext context) {
    ThemeChanger _themeChanger = Provider.of<ThemeChanger>(context);

    onDarkMode(bool newVal) {
      setState(() {
        darkModeVal = newVal;
        if (newVal == true) {
          _themeChanger.setTheme(basedark());
        } else {
          _themeChanger.setTheme(baselight());
        }
      });
    }

    return Scaffold(
        appBar: AppBar(title: Text("Einstellungen")),
        body: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Card(
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
                  margin: EdgeInsets.all(1.0),
                  child: ListTile(
                      leading: Text("Notification"),
                      trailing: Switch(
                          value: notifaicationVal,
                          onChanged: (newVal) {
                            onNotification(newVal);
                          }))),
              Card(
                  margin: EdgeInsets.all(1.0),
                  child: ListTile(
                      leading: Text("Allgemein"), trailing: Icon(Icons.edit))),
              Card(
                  margin: EdgeInsets.all(1.0),
                  child: ListTile(
                      leading: Text("App Einstellungen"),
                      trailing: Icon(Icons.refresh))),
            ],
          ),
        ));
  }
}
