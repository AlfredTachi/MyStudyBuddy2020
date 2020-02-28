import 'package:flutter/material.dart';


var finalScore = 0;
var questionNumber = 0;
var quiz = new StudyQuiz();

var _questions = [
    "The three pillars of empirical process control are:",
    "What is the recommended size for a Development Team (within the Scrum Team)?"
  ];

class StudyQuiz{




  var choices = [
    ["Planning, Inspection, Adaptation","Transparency, Eliminating Waste, Kaizen","Planning, Demonstration, Retrospective","Inspection, Transparency, Adaptation"],
    ["9",  "minimal 7","7 plus or minus 2","3 to 9"]
  ];


  var correctAnswers = [
"Inspection, Transparency, Adaptation",
"3 to 9"
  ];
}

class ScrumQuiz extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return new ScrumQuizState();
  }
}

class ScrumQuizState extends State<ScrumQuiz> {
  @override
  Widget build(BuildContext context) {
    return new WillPopScope(
        onWillPop: () async => false,
        child: Scaffold(

          body: new Container(
            margin: const EdgeInsets.all(10.0),
            alignment: Alignment.topCenter,
            child: new Column(
              children: <Widget>[
                new Padding(padding: EdgeInsets.all(20.0)),

                new Container(
                  alignment: Alignment.centerRight,
                  child: new Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[

                      new Text("Question ${questionNumber + 1} of ${_questions.length}",
                        style: new TextStyle(
                            fontSize: 22.0
                        ),),

                      new Text("Score: $finalScore",
                        style: new TextStyle(
                            fontSize: 22.0
                        ),)
                    ],
                  ),
                ),

                new Padding(padding: EdgeInsets.all(10.0)),
                new Text(_questions[questionNumber],
                  style: new TextStyle(
                    fontSize: 20.0,
                  ),),

                new Padding(padding: EdgeInsets.all(10.0)),

                new Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[

                    //button 1
                    new MaterialButton(
                      minWidth: 120.0,
                      color: Colors.blueGrey,
                      onPressed: (){
                        if(quiz.choices[questionNumber][0] == quiz.correctAnswers[questionNumber]){
                          debugPrint("Correct");
                          finalScore++;
                        }else{
                          debugPrint("Wrong");
                        }
                        updateQuestion();
                      },
                      child: FittedBox(
                      fit:BoxFit.cover,
                      child: new Text(quiz.choices[questionNumber][0],
                          style: new TextStyle(
                              fontSize: 20.0,
                              color: Colors.white
                          ),),
                      ),
                    ),

                    //button 2
                    new MaterialButton(
                      minWidth: 120.0,
                      color: Colors.blueGrey,
                      onPressed: (){

                        if(quiz.choices[questionNumber][1] == quiz.correctAnswers[questionNumber]){
                          debugPrint("Correct");
                          finalScore++;
                        }else{
                          debugPrint("Wrong");
                        }
                        updateQuestion();
                      },
                      child: FittedBox(
                        fit:BoxFit.cover,
                          child: new Text(quiz.choices[questionNumber][1],
                          style: new TextStyle(
                              fontSize: 20.0,
                              color: Colors.white
                          ),),
                      ),
                    ),

                  ],
                ),





                    //button 3
                    new MaterialButton(
                      minWidth: 120.0,
                      color: Colors.blueGrey,
                      onPressed: (){

                        if(quiz.choices[questionNumber][2] == quiz.correctAnswers[questionNumber]){
                          debugPrint("Correct");
                          finalScore++;
                        }else{
                          debugPrint("Wrong");
                        }
                        updateQuestion();
                      },
                      child: FittedBox(
                          fit:BoxFit.cover,
                          child: new Text(quiz.choices[questionNumber][2],
                          style: new TextStyle(
                              fontSize: 20.0,
                              color: Colors.white
                          ),),
                      ),
                    ),

                    //button 4
                    new MaterialButton(
                      minWidth: 120.0,
                      color: Colors.blueGrey,
                      onPressed: (){

                        if(quiz.choices[questionNumber][3] == quiz.correctAnswers[questionNumber]){
                          debugPrint("Correct");
                          finalScore++;
                        }else{
                          debugPrint("Wrong");
                        }
                        updateQuestion();
                      },
                      child: FittedBox(
                          fit:BoxFit.cover,
                          child: new Text(quiz.choices[questionNumber][3],
                          style: new TextStyle(
                              fontSize: 20.0,
                              color: Colors.white
                          ),),
                      ),
                    ),

                  
                

                new Padding(padding: EdgeInsets.all(15.0)),

                new Container(
                  alignment: Alignment.bottomCenter,
                  child:  new MaterialButton(
                      minWidth: 240.0,
                      height: 30.0,
                      color: Colors.red,
                      onPressed: resetQuiz,
                      child: new Text("Quit",
                        style: new TextStyle(
                            fontSize: 18.0,
                            color: Colors.white
                        ),)
                  )
                ),




              ],
            ),
          ),

      )
    );
  }

  void resetQuiz(){
    setState(() {
      Navigator.pushNamed(context, '/quiz');
      finalScore = 0;
      questionNumber = 0;
    });
  }



  void updateQuestion(){
    setState(() {
      if(questionNumber == _questions.length - 1){
        Navigator.push(context, new MaterialPageRoute(builder: (context)=> new Summary(score: finalScore,)));

      }else{
        questionNumber++;
      }
    });
  }
}


class Summary extends StatelessWidget{
  final int score;
  Summary({Key key, @required this.score}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return new WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(

        body: new Container(
          child: new Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[

              Center(
                child: new Text("Final Score:$score"+"/"+_questions.length.toString(),
                  style: new TextStyle(
                      fontSize: 35.0
                  ),),
              ),

              new Padding(padding: EdgeInsets.all(30.0)),

              Center(
                child: new MaterialButton(
                  color: Colors.red,
                  onPressed: (){
                    questionNumber = 0;
                    finalScore = 0;
                    Navigator.pushNamed(context,'/quiz');
                  },
                  child: new Text("Reset Quiz",
                    style: new TextStyle(
                        fontSize: 20.0,
                        color: Colors.white
                    ),),),
              )

            ],
          ),
        ),


      ),
    );
  }


}