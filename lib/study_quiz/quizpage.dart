import 'dart:io';
import 'dart:async';
import 'dart:convert';
import 'dart:math';
import 'package:MyStudyBuddy2/study_quiz/resultpage.dart';
import 'package:MyStudyBuddy2/theme/styles.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class GetJson extends StatelessWidget {
  // accept the langname as a parameter

  final String langname;
  GetJson(this.langname);
  static String assettoload;

  // a function
  // sets the asset to a particular JSON file
  // and opens the JSON
  setasset() {
    switch (langname) {
      case "1. Semester":
        return assettoload = "assets/1Sem.json";
      case "2. Semester":
        return assettoload = "assets/2Sem.json";
      case "3. Semester":
        return assettoload = "assets/3Sem.json";
      case "4. Semester":
        return assettoload = "assets/4Sem.json";
      default:
        return assettoload = "assets/5Sem.json";
    }
  }

  @override
  Widget build(BuildContext context) {
    // this function is called before the build so that
    // the string assettoload is avialable to the DefaultAssetBuilder
    setasset();
    // and now we return the FutureBuilder to load and decode JSON
    return FutureBuilder(
      future:
          DefaultAssetBundle.of(context).loadString(assettoload, cache: true),
      builder: (context, snapshot) {
        List mydata = json.decode(snapshot.data.toString());
        if (mydata == null) {
          return Scaffold(
            body: Center(
              child: Text(
                "Loading",
              ),
            ),
          );
        } else {
          return Quizpage(mydata: mydata);
        }
      },
    );
  }
}

class Quizpage extends StatefulWidget {
  final mydata;

  Quizpage({Key key, @required this.mydata}) : super(key: key);
  @override
  _QuizpageState createState() => _QuizpageState(mydata);
}

class _QuizpageState extends State<Quizpage> {
  var mydata;
  _QuizpageState(this.mydata);

  Color colortoshow = (Platform.isIOS)
      ? CupertinoColors.activeOrange
      : Colors.orangeAccent[100];
  Color right =
      (Platform.isIOS) ? CupertinoColors.systemGreen : Colors.green;
  Color wrong =
      (Platform.isIOS) ? CupertinoColors.destructiveRed : Colors.red;
  int marks = 0;
  int i = 1;
  // extra varibale to iterate
  int j = 1;
  int timer = 30;
  String showtimer = "30";

  Map<String, Color> btncolor = {
    "a": (Platform.isIOS)
        ? CupertinoColors.activeOrange
        : Colors.orangeAccent[200],
    "b": (Platform.isIOS)
        ? CupertinoColors.activeOrange
        : Colors.orangeAccent[200],
    "c": (Platform.isIOS)
        ? CupertinoColors.activeOrange
        : Colors.orangeAccent[200],
    "d": (Platform.isIOS)
        ? CupertinoColors.activeOrange
        : Colors.orangeAccent[200],
  };
  var randomArray;

  void randArray() {
    var mydatatemp = mydata[0];
    var distinctIds = [];
    var rand = new Random();
    while (true) {
      distinctIds.add(rand.nextInt(mydatatemp.length));
      randomArray = distinctIds.toSet().toList();
      if (randomArray.length < mydatatemp.length) {
        continue;
      } else {
        break;
      }
    }
    i = randomArray[0];
    print(randomArray);
  }

  // overriding the initstate function to start timer as this screen is created
  @override
  void initState() {
    randArray();
    starttimer();
    super.initState();
  }

  // overriding the setstate function to be called only if mounted
  @override
  void setState(fn) {
    if (mounted) {
      super.setState(fn);
    }
  }

  bool canceltimer = false;
  void starttimer() async {
    const onesec = Duration(seconds: 1);
    Timer.periodic(onesec, (Timer t) {
      setState(() {
        if (timer < 1) {
          t.cancel();
          nextquestion();
        } else if (canceltimer == true) {
          t.cancel();
        } else {
          timer = timer - 1;
        }
        showtimer = timer.toString();
      });
    });
  }

  void nextquestion() {
    var mydatatemp = mydata[0];
    isChecked = true;
    canceltimer = false;
    timer = 30;
    setState(() {
      if (j < mydatatemp.length) {
        i = randomArray[j];
        j++;
      } else {
        Navigator.of(context).pushReplacement(MaterialPageRoute(
          builder: (context) =>
              ResultPage(marks: marks, mydatatemp: mydatatemp),
        ));
      }
      btncolor["a"] = (Platform.isIOS)
          ? CupertinoColors.activeOrange
          : Colors.orangeAccent[200];
      btncolor["b"] = (Platform.isIOS)
          ? CupertinoColors.activeOrange
          : Colors.orangeAccent[200];
      btncolor["c"] = (Platform.isIOS)
          ? CupertinoColors.activeOrange
          : Colors.orangeAccent[200];
      btncolor["d"] = (Platform.isIOS)
          ? CupertinoColors.activeOrange
          : Colors.orangeAccent[200];
    });
    starttimer();
  }

  bool isChecked = true;
  void checkanswer(String k) {
    if (mydata[2][i.toString()] == mydata[1][i.toString()][k]) {
      marks = marks + 1;
      // changing the color variable to be green
      colortoshow = right;
    } else {
      colortoshow = wrong;
    }
    isChecked = false;
    setState(() {
      // applying the changed color to the particular button that was selected
      btncolor[k] = colortoshow;
      canceltimer = true;
    });
    // changed timer duration to 1 second
    Timer(Duration(seconds: 1), nextquestion);
  }

  Widget choicebutton(String k) {
    return Padding(
      padding: EdgeInsets.symmetric(
        vertical: 10.0,
        horizontal: 20.0,
      ),
      child: (Platform.isIOS)
          ? CupertinoButton(
              color: btncolor[k],
              child: AutoSizeText(mydata[1][i.toString()][k],
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 16.0,
                    color: Colors.white,
                  )),
              onPressed: () => isChecked ? checkanswer(k) : isChecked = false)
          : MaterialButton(
              onPressed: () => isChecked ? checkanswer(k) : isChecked = false,
              child: AutoSizeText(mydata[1][i.toString()][k],
                  style: TextStyle(
                    fontSize: 16.0,
                    color: Colors.white,
                  )),
              color: btncolor[k],
              splashColor: Colors.orangeAccent,
              highlightColor: Colors.orangeAccent,
              minWidth: 200.0,
              height: 45.0,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20.0)),
            ),
    );
  }

  @override
  Widget build(BuildContext context) {
    var mydatatemp = mydata[1][i.toString()];
    var mydatatempcategory = mydata[3];
    var keys = ['a', 'b', 'c', 'd'];

    Widget getBody() {
      return SingleChildScrollView(
        child: Column(
          children: <Widget>[
            (Platform.isIOS)
                ? Padding(
                    padding:
                        EdgeInsets.symmetric(vertical: 10.0, horizontal: 15.0),
                    child: PhysicalModel(
                        shape: BoxShape.rectangle,
                        borderRadius: BorderRadius.circular(15),
                        color: CupertinoColors.activeOrange,
                        child: Padding(
                            padding: EdgeInsets.all(20.0),
                            child: Center(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Padding(
                                    padding: const EdgeInsets.only(bottom: 20),
                                    child: Text(
                                        "Frage: " +
                                            j.toString() +
                                            "/" +
                                            randomArray.length.toString(),
                                        style: Styles.detailsTitleText),
                                  ),
                                  Text(
                                    mydata[0][i.toString()],
                                    style: Styles.detailsDescriptionText,
                                    textAlign: TextAlign.center,
                                  )
                                ],
                              ),
                            ))))
                : Container(
                    padding: EdgeInsets.all(15.0),
                    alignment: Alignment.bottomLeft,
                    child: Row(
                      children: <Widget>[
                        Padding(padding: EdgeInsets.fromLTRB(10, 0, 10, 0)),
                        Text(
                          "Frage: " +
                              j.toString() +
                              "/" +
                              randomArray.length.toString(),
                          style: TextStyle(
                              fontSize: 18.0, fontWeight: FontWeight.bold),
                          textAlign: TextAlign.left,
                        ),
                        Text(
                          "    Kategorie: " + mydatatempcategory[i.toString()],
                          style: TextStyle(
                              fontSize: 18.0, fontWeight: FontWeight.bold),
                          textAlign: TextAlign.right,
                        ),
                      ],
                    ),
                  ),
            if (!Platform.isIOS)
              Container(
                padding: EdgeInsets.all(15.0),
                alignment: Alignment.bottomLeft,
                child: Text(
                  mydata[0][i.toString()],
                  style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.w500),
                ),
              ),
            (Platform.isIOS)
                ? Padding(
                    padding: EdgeInsets.only(
                        left: 15.0, right: 15.0, top: 10.0, bottom: 10.0),
                    child: PhysicalModel(
                      shape: BoxShape.rectangle,
                      borderRadius: BorderRadius.circular(15),
                      color: CupertinoColors.white,
                      child: Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                for (int k = 0; k < mydatatemp.length; k++)
                                  choicebutton(keys[k])
                              ],
                            ),
                          )),
                    ),
                  )
                : Container(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        for (int k = 0; k < mydatatemp.length; k++)
                          choicebutton(keys[k]),
                      ],
                    ),
                  ),
            if (!Platform.isIOS)
              Container(
                alignment: Alignment.topCenter,
                child: Center(
                  child: Text(
                    showtimer,
                    style: (Platform.isIOS)
                        ? Styles.weatherTitle
                        : TextStyle(
                            fontSize: 35.0,
                            fontWeight: FontWeight.w700,
                          ),
                  ),
                ),
              ),
          ],
        ),
      );
    }

    return WillPopScope(
      onWillPop: () {
        return showDialog(
            context: context,
            builder: (context) => AlertDialog(
                  title: Text(
                    "Quiz abbrechen?",
                  ),
                  content: Text("Bist du dir sicher?"),
                  actions: <Widget>[
                    FlatButton(
                      onPressed: () {
                        Navigator.of(context).pushNamedAndRemoveUntil(
                            '/quiz', ModalRoute.withName('/'));
                      },
                      child: Text(
                        'Ja',
                      ),
                    ),
                    FlatButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: Text(
                        'Nein',
                      ),
                    )
                  ],
                ));
      },
      child: Scaffold(
          appBar: (Platform.isIOS)
              ? CupertinoNavigationBar(
                  actionsForegroundColor: CupertinoColors.activeOrange,
                  middle:
                      Text("Kategorie: " + mydatatempcategory[i.toString()]),
                  trailing: Text(showtimer),
                )
              : null,
          body: (Platform.isIOS)
              ? getBody()
              : SafeArea(
                  child: getBody(),
                )),
    );
  }
}
