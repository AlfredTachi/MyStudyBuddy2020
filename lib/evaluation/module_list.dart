import 'package:MyStudyBuddy2/drawer/drawer.dart';
import 'package:MyStudyBuddy2/evaluation/evaluation.dart';
import 'package:flutter/material.dart';

class ModuleList extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {

    return ModuleListState();
  }

}

class ModuleListState extends State<ModuleList>{
  @override
  Widget build(BuildContext context) {
 
    return Scaffold(
      appBar: AppBar(title: Text("Professoren")),
      drawer: OwnDrawer(),
      body: 
      MaterialButton(
             height: 50.0,
             minWidth: MediaQuery.of(context).size.width,
               color: Colors.transparent,
               onPressed:goToEvaluation,
               child: new Text("Modul 1",
                 style: new TextStyle(
                     fontSize: 18.0,

                 ),)
           )
    );
  }
void goToEvaluation(){
   setState(() {
     Navigator.push(context, new MaterialPageRoute(builder: (context)=> Evaluation()));
   });
  }
}