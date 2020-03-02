import 'package:MyStudyBuddy2/local_database/local_database.dart';
import 'package:flutter/material.dart';
import 'package:MyStudyBuddy2/studyprogress/staggered_view_studyprogress/staggered_view_studyprogress.dart';
import 'package:MyStudyBuddy2/exam_results/exam_result.dart';
import 'dart:io';

class Studyprogress extends StatefulWidget {
  @override
  StudyprogressState createState() => StudyprogressState();
}

class StudyprogressState extends State<Studyprogress> {
  BuildContext scaffoldContext;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Studienverlauf"),
          actions: <Widget>[
            Builder(builder: (BuildContext context) {
              scaffoldContext = context;
              return IconButton(
                  icon: Icon(Icons.cloud_download),
                  onPressed: () {
                    _downloadLSFData(context);
                  });
            })
          ],
        ),
        body: StaggeredView());
  }

  Future<void> _downloadLSFData(BuildContext context,
      [String name = "", String password = ""]) {
    String userName = '';
    String userPassword = '';
    return showDialog<void>(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("LSF Login"),
          content: Column(
            children: <Widget>[
              Row(
                children: <Widget>[
                  Expanded(
                    child: TextFormField(
                      autofocus: true,
                      decoration: InputDecoration(
                        labelText: "Anmeldename",
                        hintText: "z.B. inf9876",
                      ),
                      initialValue: name,
                      onChanged: (value) {
                        userName = value;
                      },
                    ),
                  ),
                ],
              ),
              Row(
                children: <Widget>[
                  Expanded(
                    child: TextFormField(
                      autofocus: true,
                      obscureText: true,
                      decoration: InputDecoration(
                        labelText: "Passwort",
                        hintText: "Passwort eingeben",
                      ),
                      initialValue: password,
                      onChanged: (value) {
                        userPassword = value;
                      },
                    ),
                  ),
                ],
              ),
            ],
          ),
          actions: <Widget>[
            FlatButton(
              child: Text("Abbrechen"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            FlatButton(
              child: Text("Daten holen"),
              onPressed: () async {
                try {
                  Navigator.of(context).pop();
                  createSnackBar("Lädt");
                  int success =
                      await getExamResultsFromLSFServer(userName, userPassword);
                  switch (success) {
                    case 0:
                      Scaffold.of(scaffoldContext).hideCurrentSnackBar();
                      success = null;
                      createSnackBar("Das Laden der LSF Daten war erfolgreich");
                      break;
                    case 1:
                      Scaffold.of(scaffoldContext).hideCurrentSnackBar();
                      success = null;
                      createSnackBarWithReloadButton(
                          "Die Logindaten waren leider falsch");
                      break;
                    case 2:
                      Scaffold.of(scaffoldContext).hideCurrentSnackBar();
                      success = null;
                      createSnackBarWithReloadButton(
                          "Das hat leider nicht geklappt. Prüfe deine Internetverbindung!",
                          name,
                          password);
                      break;
                    case 3:
                      Scaffold.of(scaffoldContext).hideCurrentSnackBar();
                      success = null;
                      createSnackBarWithReloadButton(
                          "Timeout! Prüfe deine Internetverbindung!");
                      break;
                    default:
                      success = null;
                      createSnackBarWithReloadButton(
                          "Ein unbekannter Fehler ist aufgetreten!");
                  }
                } catch (err) {
                  print(err);
                }
              },
            ),
          ],
        );
      },
    );
  }

  void createSnackBarWithReloadButton(String text,
      [String name, String password]) {
    final snackBar = SnackBar(
      content: Text(text),
      action: SnackBarAction(
        label: "Nochmal versuchen",
        onPressed: () {
          _downloadLSFData(context, name, password);
        },
      ),
      duration: Duration(seconds: 7),
    );
    Scaffold.of(scaffoldContext).showSnackBar(snackBar);
  }

  void createSnackBar(String text) {
    final snackBar = SnackBar(
      content: Text(text),
      duration: Duration(seconds: 7),
    );
    Scaffold.of(scaffoldContext).showSnackBar(snackBar);
  }
}
