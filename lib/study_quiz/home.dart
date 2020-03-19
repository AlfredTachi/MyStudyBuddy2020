import 'package:flutter/material.dart';
import 'package:MyStudyBuddy2/study_quiz/quizpage.dart';

class Homepage extends StatefulWidget {
  @override
  _HomepageState createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  List<String> des = [
    "Mit diesem Quiz könnt ihr euer Wissen aus dem 1. Semster testen.",
    "Mit diesem Quiz könnt ihr euer Wissen aus dem 2. Semster testen.",
    "Mit diesem Quiz könnt ihr euer Wissen aus dem 3. Semster testen.",
    "Mit diesem Quiz könnt ihr euer Wissen aus dem 4. Semster testen.",
    "Mit diesem Quiz könnt ihr euer Wissen aus dem 5. Semster testen.",
  ];

  Widget customcard(String langname, String des) {
    return Padding(
      padding: EdgeInsets.symmetric(
        vertical: 10.0,
        horizontal: 15.0,
      ),
      child: InkWell(
        onTap: () {
          Navigator.of(context).pushReplacement(MaterialPageRoute(
            builder: (context) => GetJson(langname),
          ));
        },
        child: Material(
          child: Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(25.0),
                gradient: LinearGradient(
                  begin: Alignment.topRight,
                  end: Alignment.bottomLeft,
                  colors: [
                    Colors.orange,
                    Colors.deepOrange,
                  ],
                )),
            height: MediaQuery.of(context).size.height * 0.2,
            width: MediaQuery.of(context).size.width * 0.9,
            child: Column(
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.symmetric(
                    vertical: 10.0,
                  ),
                ),
                Center(
                  child: Text(
                    langname,
                    style: TextStyle(
                      fontSize: 20.0,
                      color: Colors.white,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(20.0),
                  child: Text(
                    des,
                    style: TextStyle(
                      fontSize: 18.0,
                      color: Colors.white,
                    ),
                    maxLines: 5,
                    textAlign: TextAlign.justify,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
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
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: <Widget>[
                    customcard("1. Semester", des[0]),
                    customcard("2. Semester", des[1]),
                    customcard("3. Semester", des[2]),
                    customcard("4. Semester", des[3]),
                    customcard("5. Semester", des[4]),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
