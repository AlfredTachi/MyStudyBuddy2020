import 'dart:async';
import 'dart:convert';
import 'dart:math';
import 'package:MyStudyBuddy2/study_quiz/resultpage.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';

class Getjson extends StatelessWidget {
  // accept the langname as a parameter

  String langname;
  Getjson(this.langname);
  String assettoload;

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

  Color colortoshow = Colors.orangeAccent[100];
  Color right = Colors.green;
  Color wrong = Colors.red;
  int marks = 0;
  int i = 1;
  // extra varibale to iterate
  int j = 1;
  int timer = 30;
  String showtimer = "30";

  Map<String, Color> btncolor = {
    "a": Colors.orangeAccent[200],
    "b": Colors.orangeAccent[200],
    "c": Colors.orangeAccent[200],
    "d": Colors.orangeAccent[200],
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
    }
    );
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
          builder: (context) => Resultpage(marks: marks, mydatatemp: mydatatemp),
        ));
      }
      btncolor["a"] = Colors.orangeAccent[200];
      btncolor["b"] = Colors.orangeAccent[200];
      btncolor["c"] = Colors.orangeAccent[200];
      btncolor["d"] = Colors.orangeAccent[200];
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
    Timer(Duration(seconds: 1),nextquestion);
  }

  Widget choicebutton(String k) {
    return Padding(
      padding: EdgeInsets.symmetric(
        vertical: 10.0,
        horizontal: 20.0,
      ),
      child: MaterialButton(
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
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    var mydatatemp = mydata[1][i.toString()];
    var mydatatempcategory = mydata[3];
    var keys = ['a', 'b', 'c', 'd'];
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
                        Navigator.of(context).pushNamedAndRemoveUntil('/quiz', ModalRoute.withName('/'));
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
        body: Column(
          children: <Widget>[
            Expanded(
              flex: 3,
              child: Container(
                padding: EdgeInsets.all(15.0),
                alignment: Alignment.bottomLeft,
                child: Row(
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.fromLTRB(10, 0, 10, 0)
                      ),
                    Text(
                      "Frage: " +j.toString()+"/"+randomArray.length.toString(),
                      style: TextStyle(
                        fontSize: 18.0,
                        fontWeight: FontWeight.bold
                      ),
                      textAlign: TextAlign.left,
                    ),
                    Text("    Kategorie: " + mydatatempcategory[i.toString()],
                      style: TextStyle(
                        fontSize: 18.0,
                        fontWeight: FontWeight.bold
                      ),
                      textAlign: TextAlign.right,
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              flex: 3,
              child: Container(
                padding: EdgeInsets.all(15.0),
                alignment: Alignment.bottomLeft,
                child: Text(
                  mydata[0][i.toString()],
                  style: TextStyle(
                        fontSize: 20.0,
                        fontWeight: FontWeight.w500
                  ),
                ),
              ),
            ),
            Expanded(
              flex: 6,
              child: Container(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    for (int k = 0; k < mydatatemp.length; k++)
                      choicebutton(keys[k]),
                  ],
                ),
              ),
            ),
            Expanded(
              flex: 1,
              child: Container(
                alignment: Alignment.topCenter,
                child: Center(
                  child: Text(
                    showtimer,
                    style: TextStyle(
                      fontSize: 35.0,
                      fontWeight: FontWeight.w700,
                    ),
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
