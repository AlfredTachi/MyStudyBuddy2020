import 'package:MyStudyBuddy2/drawer/drawer.dart';
import 'package:MyStudyBuddy2/evaluation/module_list.dart';
import 'package:flutter/material.dart';

class ProfList extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return ProfListState();
  }

}

class ProfListState extends State<ProfList>{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(title: Text("Professoren")),
      drawer: OwnDrawer(),
      body: 
      MaterialButton(
             height: 50.0,
             minWidth: MediaQuery.of(context).size.width,
               color: Colors.transparent,
               onPressed: goToModuleList,
               child: new Text("Name",
                 style: new TextStyle(
                     fontSize: 18.0,

                 ),)
           )
    );
  }
void goToModuleList(){
   setState(() {
     Navigator.push(context, new MaterialPageRoute(builder: (context)=> ModuleList()));
   });
  }
}
