import 'package:MyStudyBuddy2/drawer/drawer.dart';
import 'package:smooth_star_rating/smooth_star_rating.dart';
import 'package:flutter/material.dart';

class Evaluation extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return EvaluationState();
  }
}

class EvaluationState extends State<Evaluation> {
  List<String> evaluationQuestions = [
    "Professor erscheint gut vorbereitet",
    "Professor scheint fachlich kompetent",
    "Professor kann ein Youtube-Video anhalten",
    "Professor versteht sein eigenes Fach"
  ];
  List<double> ratings =[0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text('Evaluation')),
        drawer: OwnDrawer(),
        body: ListView.builder(
            scrollDirection: Axis.vertical,
            itemCount: evaluationQuestions.length,
            shrinkWrap: true,
            itemBuilder: (BuildContext context, int index) => Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height / 7,
                  child: Card(
                    elevation: 8.0,
                    child: ListTile(

                      title: Center(
                        child: Column(
                        children: <Widget>[
                          Text(evaluationQuestions[index],
                              style: TextStyle(fontSize: 18)),

                          Padding(padding: EdgeInsets.only(bottom: 30.0)),
                          Center(
                            child: Row(
                              children: <Widget>[
                                Text(
                                  'stimme nicht zu',
                                  style: TextStyle(fontSize: 15),
                                ),
                                Padding(padding: EdgeInsets.only(right: 20.0)),
                                SmoothStarRating(
                                  rating: ratings[index],
                                  size: 20,
                                  filledIconData: Icons.star,
                                  halfFilledIconData: Icons.star_half,
                                  defaultIconData: Icons.star_border,
                                  starCount: 5,
                                  allowHalfRating: false,
                                  spacing: 1.0,
                                  onRatingChanged: (value) {
                                    setState(() {
                                      ratings[index] = value;
                                    });
                                  },
                                ),
                                Padding(padding: EdgeInsets.only(right: 20.0)),
                                Text('stimme voll zu',
                                    style: TextStyle(fontSize: 15))
                              ],
                            ),
                          )
                        ],
                    ),
                      )),
                  ),
                )));
  }
}
