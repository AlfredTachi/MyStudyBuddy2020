import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:MyStudyBuddy2/theme/styles.dart';
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
    void pressed() {
      Navigator.of(context).pushReplacement(MaterialPageRoute(
        builder: (context) => GetJson(langname),
      ));
    }

    return Padding(
      padding: EdgeInsets.symmetric(
        vertical: 10.0,
        horizontal: 15.0,
      ),
      child: (Platform.isIOS)
          ? CupertinoButton(
              borderRadius: BorderRadius.circular(15),
              color: CupertinoColors.activeOrange,
              child: Padding(
                padding: const EdgeInsets.only(bottom: 25.0, top: 25.0),
                child: Column(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(bottom: 25.0),
                      child: Text(
                        langname,
                        style: (MediaQuery.of(context).size.width < 650) ? Styles.detailsTitleText.copyWith(fontSize: 25): Styles.detailsTitleText,
                      ),
                    ),
                    Text(
                      des,
                      style: Styles.detailsDescriptionText,
                    )
                  ],
                ),
              ),
              onPressed: () {
                pressed();
              },
            )
          : InkWell(
              onTap: () {
                pressed();
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
    return (Platform.isIOS)
        ? Scaffold(
            appBar: CupertinoNavigationBar(
              actionsForegroundColor: CupertinoColors.activeOrange,
              middle: Text(
                "Studi Quiz",
                style: Styles.navBarTitle,
              ),
            ),
            body: Column(children: getColumnChildren()),
          )
        : SafeArea(
            child: Scaffold(
              body: Column(
                children: getColumnChildren(),
              ),
            ),
          );
  }

  List<Widget> getColumnChildren() {
    List<Widget> _list = List<Widget>();
    if (!Platform.isIOS) {
      _list.add(
        Container(
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
                      padding:
                          const EdgeInsets.only(left: 20, top: 3, bottom: 3),
                      child: Text(
                        "Studi Quiz",
                        style: TextStyle(fontSize: 25),
                      ))),
            ],
          ),
        ),
      );
    }
    _list.add(
      Expanded(
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              customcard("1. Semester", des[0]),
              customcard("2. Semester", des[1]),
              customcard("3. Semester", des[2]),
              customcard("4. Semester", des[3]),
              customcard("5. Semester", des[4]),
              if(Platform.isIOS) Container(
                height: 25,
              )
            ],
          ),
        ),
      ),
    );
    return _list;
  }
}
