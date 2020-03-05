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
    "Mit diesem Quiz könnt ihr euer Wissen aus dem 6. Semster testen.",
  ];

  Widget customcard(String langname,  String des){
    return Padding(
      padding: EdgeInsets.symmetric(
        vertical: 10.0,
        horizontal: 15.0,
      ),
      child: InkWell(
        onTap: (){
          Navigator.of(context).pushReplacement(MaterialPageRoute(
            builder: (context) => Getjson(langname),
          ));
        },
        child: Material(
          child: Container(
            decoration: BoxDecoration(
                    borderRadius:
                        BorderRadius.circular(25.0),
                    gradient: LinearGradient(
                      begin: Alignment.topRight,
                      end: Alignment.bottomLeft,
                      colors: [
                        Colors.orange,
                        Colors.deepOrange,
                      ],
                    )),
            height: MediaQuery.of(context).size.height*0.2,
            width: MediaQuery.of(context).size.width*0.8,
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
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Studi Quiz",
        ),
      ),
      body: ListView(
        children: <Widget>[
          customcard("1. Semester", des[0]),
          customcard("2. Semester", des[1]),
          customcard("3. Semester", des[2]),
          customcard("4. Semester", des[3]),
          customcard("5. Semester", des[4]),
          customcard("6. Semester", des[5]),
          
        ],
      ),
    );
  }
}