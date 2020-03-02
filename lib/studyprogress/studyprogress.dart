import 'package:MyStudyBuddy2/local_database/local_database.dart';
import 'package:flutter/material.dart';
import 'package:MyStudyBuddy2/studyprogress/staggered_view_studyprogress/staggered_view_studyprogress.dart';
import 'package:MyStudyBuddy2/exam_results/exam_result.dart';

class Studyprogress extends StatefulWidget {
  @override
  StudyprogressState createState() => StudyprogressState();
}

class StudyprogressState extends State<Studyprogress> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Studienverlauf"),
          actions: <Widget>[
            IconButton(
                icon: Icon(Icons.cloud_download),
                onPressed: () {
                  _downloadLSFData(context);
                })
          ],
        ),
        body: StaggeredView());
  }
}

Future<void> _downloadLSFData(BuildContext context) {
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
                  child: TextField(
                    autofocus: true,
                    decoration: InputDecoration(
                      labelText: "Anmeldename",
                      hintText: "z.B. inf9876",
                    ),
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
                  child: TextField(
                    autofocus: true,
                    obscureText: true,
                    decoration: InputDecoration(
                      labelText: "Passwort",
                      hintText: "Passwort eingeben",
                    ),
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
                final db = await DBProvider.db;
                await getExamResultsFromLSFServer(userName, userPassword);
                final grades = await db.getAllExamGrades();
                print(grades);
              } catch (err) {
                print("err");
              }
              Navigator.of(context).pop();
            },
          )
        ],
      );
    },
  );
}
