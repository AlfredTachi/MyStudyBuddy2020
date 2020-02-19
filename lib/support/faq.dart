import 'package:flutter/material.dart';

class FAQ extends StatefulWidget {
  @override
  FAQState createState() => FAQState();
}

class FAQState extends State<FAQ> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("FAQ"),
        leading: IconButton(icon:Icon(Icons.arrow_back),
        onPressed:() => Navigator.pop(context, false),
      ),
          ),
     body: 
      ListView(padding: EdgeInsets.zero, children: [
        ExpansionTile(
           title: Text('Wo finde ich das Rechenzentrum (RZ)?'),
           children: <Widget>[
             Text("Das Servicebüro in Raum A 105 ist die Anlaufstelle für Studierende und Bedienstete in allen Fragen rund um die Computernutzung an der Hochschule.",
             textAlign: TextAlign.center,
             )
           ],
        ),
        ExpansionTile(
           title: Text('Wie lange hat das RZ geöffnet?'),
           children: <Widget>[
             Text("Mo-Do: 08:00 - 12:00 Uhr und 12:45 - 16:00 Uhr, Fr: nur bis 14:00 Uhr",
             textAlign: TextAlign.center,
             ),
           ],
        ),
        ExpansionTile(
           title: Text('BAföG - Was ist das?'),
           children: <Widget>[
             Text("Gesetz, das die Förderung von bedürftigen Auszubildenden, Schülern und Schülerinnen sowie Studierenden regelt." +
             "Ziel ist es, allen jungen Menschen die Möglichkeit zu geben, unabhängig von ihrer sozialen und wirtschaftlichen"+
             "Situation eine Ausbildung zu absolvieren, die ihren Fähigkeiten und Interessen entspricht.",
             textAlign: TextAlign.center,
             )
           ],
        ),
        ExpansionTile(
           title: Text('Bin ich dem Grunde nach BAföG berechtigt?'),
           children: <Widget>[
             Text("BAföG berechtigt sind deutsche aber auch ausländische Studierende.Durch BAföG gefördert wird in der Regel ein Erststudium (Bachelorstudiengang),"+
             "wenn es vor Vollendung des 30. Lebensjahres, und ein Masterstudium, wenn es vor Vollendung des 35. Lebensjahres aufgenommen wird.",
             textAlign: TextAlign.center,
             )
           ],
           ),
      ]),
    );
  }
}