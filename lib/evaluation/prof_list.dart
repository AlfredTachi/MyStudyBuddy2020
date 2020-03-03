import 'package:MyStudyBuddy2/evaluation/module_list.dart';
import 'package:flutter/material.dart';

class ProfList extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return ProfListState();
  }

}

class ProfListState extends State<ProfList>{
  List<Proffesors> listeProffs = [
    (Proffesors('Prof. Dr. Herbert Thielen', 'N 317', 'herbert.thielen@hs-worms.de', '+49(0)6241.509-209')),
    (Proffesors('Prof. Dr. Bernd Ruhland','N 307','bernd.ruhland@hs-worms.de','+49(0)6241.509-201')),
    (Proffesors('Prof. Dr. Jutta Binder-Hobbach','N 335','jutta.binder-hobbach@hs-worms.de','+49(0)6241.509-264')),
    (Proffesors('Prof. Dr. Zdravko Bozakov','N 336','zdravko.bozakov@hs-worms.de','+49(0)6241.509-267')),
    (Proffesors('Prof. Dr. Alexander Fülleborn','N 328','alexander.fülleborn@hs-worms.de','+49(0)6241.509-257')),
    (Proffesors('Prof. Dr. Elisabeth Heinemann','N 324','elisabeth.heinemann@hs-worms.de','+49(0)6241.509-256')),
    (Proffesors('Prof. Dr. Ralf Keidel','N 015','ralf.keidel@hs-worms.de','+49(0)6241.509-263')),
    (Proffesors('Prof. Dr. Werner König','N 315','werner.koenig@hs-worms.de','+49(0)6241.509-182')),
    (Proffesors('Prof. Dr. Stephan Kurpjuweit','N 329','stephan.kurpjuweit@hs-worms.de','+49(0)6241.509-241')),
    (Proffesors('Prof. Dr. Steffen Wendzel','N 334','steffen.wendzel@hs-worms.de','+49(0)6241.509-213')),
    (Proffesors('Prof. Dr. Alexander Wiebel','N 331','wiebel@hs-worms.de','+49(0)6241.509-268')),
    (Proffesors('Prof. Dr. Eberhard Kurz','N 333','eberhard.kurz@hs-worms.de','+49(0)6241.509-214'))
];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Professoren")),
      body: 
      new ListView.builder(     
        itemCount: listeProffs.length,
        itemBuilder: (BuildContext context, int index){
          return new ListTile(
            title: Text(listeProffs[index].name),
            onTap: ()=>Navigator.push(context,MaterialPageRoute(builder: (context) => ModuleList()),)
                       
          );
        },       
         
      ),
     
    );
  }             
}

class Proffesors{
  String name;
  String raum;
  String email;
  String telefon;

  Proffesors(this.name, this.raum, this.email, this.telefon);
  
  String toString(){
    return '{${this.name}, ${this.raum}, ${this.email}, ${this.telefon}}';
  }
}