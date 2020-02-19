import 'package:MyStudyBuddy2/drawer/drawer.dart';
import 'package:MyStudyBuddy2/study_quiz/scrum_quiz.dart';
import 'package:MyStudyBuddy2/study_quiz/study_quiz.dart';
import 'package:flutter/material.dart';


class QuizStart extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return QuizStartState();
  }

}

class QuizStartState extends State<QuizStart>{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Study Quiz')),
      drawer: OwnDrawer(),
      body: new Container(
          margin: const EdgeInsets.all(15.0),
       child: new Column(
          
         crossAxisAlignment: CrossAxisAlignment.stretch,
         mainAxisAlignment: MainAxisAlignment.center,
         children: <Widget>[
          new Card(
            margin:EdgeInsets.all(8.0) ,
            elevation: 5.0,
            child: Center(child: Text('Frohes Schaffen!')),
            
          ),
          Padding(padding: EdgeInsets.only(bottom: 15.0)),
           new MaterialButton(
             height: 50.0,
               color: Colors.green,
               onPressed: startTesten,
               child: new Text("Testen Quiz",
                 style: new TextStyle(
                     fontSize: 18.0,
                     color: Colors.white
                 ),)
           ),
           Padding(padding: EdgeInsets.all(8.0)),
           new MaterialButton(
             height: 50.0,
               color: Colors.red,
               onPressed: startScrum,
               child: new Text("Scrum Quiz",
                 style: new TextStyle(
                     fontSize: 18.0,
                     color: Colors.white
                 ),)
           )
         ],
       ),
     ),
      

    );
  }
void startTesten(){
   setState(() {
     Navigator.push(context, new MaterialPageRoute(builder: (context)=> new TestenQuiz()));
   });
  }
void startScrum(){
   setState(() {
     Navigator.push(context, new MaterialPageRoute(builder: (context)=> new ScrumQuiz()));
   });
  }

}