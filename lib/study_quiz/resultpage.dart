import 'package:flutter/material.dart';
import 'package:MyStudyBuddy2/study_quiz/home.dart';

class Resultpage extends StatefulWidget {
  int marks;
  var mydatatemp;
  Resultpage({Key key, @required this.marks, @required this.mydatatemp})
      : super(key: key);
  @override
  _ResultpageState createState() => _ResultpageState(marks, mydatatemp);
}

class _ResultpageState extends State<Resultpage> {
  List<String> images = [
    "assets/images/success.png",
    "assets/images/good.png",
    "assets/images/bad.png",
  ];

  String message;
  String image;

  @override
  void initState() {
    int totalquestions = mydatatemp.length;
    int medium = (totalquestions * 0.7).toInt();
    int bad = (totalquestions * 0.4).toInt();

    print(medium);
    print(bad);
    if (marks <= bad) {
      image = images[2];
      message = "Du hast $marks/$totalquestions Punkten erreicht\n" +
          "Versuchs nochmal.";
    } else if (marks <= medium) {
      image = images[1];
      message = "Du hast $marks/$totalquestions Punkten erreicht\n" +
          "Das geht noch besser...";
    } else {
      image = images[0];
      message =
          "Du hast $marks/$totalquestions Punkten erreicht\n" + "Sehr gut :)";
    }
    super.initState();
  }

  int marks;
  var mydatatemp;
  _ResultpageState(this.marks, this.mydatatemp);
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
                    Navigator.of(context).pushReplacement(MaterialPageRoute(
                      builder: (context) => Homepage(),
                    ));
                  }),
            ),
            Expanded(
              child: Material(
                child: Container(
                  child: Column(
                    children: <Widget>[
                      Material(
                        child: Container(
                          width: MediaQuery.of(context).size.width,
                          height: MediaQuery.of(context).size.height * 0.7,
                          child: Image(
                            image: AssetImage(
                              image,
                            ),
                          ),
                        ),
                      ),
                      Padding(
                          padding: EdgeInsets.symmetric(
                            vertical: 5.0,
                            horizontal: 15.0,
                          ),
                          child: Center(
                            child: Text(
                              message,
                              style: TextStyle(
                                fontSize: 22.0,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          )),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
