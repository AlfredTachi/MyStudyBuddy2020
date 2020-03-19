import 'dart:ui';
import 'package:flutter/material.dart';

class FAQ extends StatefulWidget {
  @override
  FAQState createState() => FAQState();
}

class FAQState extends State<FAQ> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          body: Column(
        children: <Widget>[
          Container(
            color: Colors.orange,
            child: Row(
              children: <Widget>[
                Align(
                  alignment: Alignment.topLeft,
                  child: OutlineButton(
                      child: Padding(
                        padding: const EdgeInsets.only(top: 3, bottom: 3),
                        child: Icon(
                          Icons.arrow_back,
                          size: 36,
                        ),
                      ),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.only(
                        topRight: Radius.circular(15),
                        bottomRight: Radius.circular(15),
                      )),
                      onPressed: () {
                        Navigator.of(context).pop();
                      }),
                ),
                Align(
                  alignment: Alignment.topCenter,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 20, top: 3, bottom: 3),
                    child: Text("FAQ", style: TextStyle(fontSize: 25)),
                  ),
                )
              ],
            ),
          ),
          Expanded(
              child: SingleChildScrollView(
            child: Column(children: createList()),
          ))
        ],
      )),
    );
  }

  List<Widget> createList() {
    List<Widget> _items = [
      ExpansionTile(
        title: Text(
          'Wo finde ich das Rechenzentrum (RZ)?',
          textAlign: TextAlign.left,
          softWrap: true,
        ),
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(left: 17, right: 17),
            child: Text(
              "Das Servicebüro in Raum A 105 ist die Anlaufstelle für Studierende und Bedienstete in allen Fragen rund um die Computernutzung an der Hochschule.",
              textAlign: TextAlign.start,
              style: new TextStyle(fontSize: 16),
            ),
          )
        ],
      ),
      ExpansionTile(
        title: Text('Wie lange hat das RZ geöffnet?'),
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(left: 17, right: 17),
            child: Text(
              "Mo-Do: 08:00-12:00 Uhr / 12:45-16:00 Uhr, \nFr: nur bis 14:00 Uhr",
              textAlign: TextAlign.justify,
              style: new TextStyle(fontSize: 16),
            ),
          ),
        ],
      ),
      ExpansionTile(
        title: Text('BAföG - Was ist das?'),
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(left: 17, right: 17),
            child: Text(
              "Gesetz, das die Förderung von bedürftigen Auszubildenden, Schülern und Schülerinnen sowie Studierenden regelt.\n" +
                  "Ziel ist es, allen jungen Menschen die Möglichkeit zu geben, unabhängig von ihrer sozialen und wirtschaftlichen" +
                  " Situation eine Ausbildung zu absolvieren, die ihren Fähigkeiten und Interessen entspricht.",
              textAlign: TextAlign.start,
              style: new TextStyle(fontSize: 16),
            ),
          )
        ],
      ),
      ExpansionTile(
        title: Text('Bin ich dem Grunde nach BAföG berechtigt?'),
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(left: 17, right: 17),
            child: Text(
              "BAföG berechtigt sind deutsche aber auch ausländische Studierende. Durch BAföG gefördert wird in der Regel ein Erststudium (Bachelorstudiengang), " +
                  " wenn es vor Vollendung des 30. Lebensjahres, und ein Masterstudium, wenn es vor Vollendung des 35. Lebensjahres aufgenommen wird.",
              textAlign: TextAlign.start,
              style: new TextStyle(fontSize: 16),
            ),
          )
        ],
      ),
      ExpansionTile(
        title: Text('An- und Abmeldung von Prüfungen'),
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(left: 17, right: 17),
            child: Text(
              "Frist für die Anmeldung / Abmeldung ist im Sommersemester der 15.06 und im Wintersemester der 15.12." +
                  " Prüfungen werden im LSF an- und abgemeldet.",
              textAlign: TextAlign.start,
              style: new TextStyle(fontSize: 16),
            ),
          )
        ],
      ),
      ExpansionTile(
        title: Text('Wann und wo findet die Klausureinsicht statt?'),
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(left: 17, right: 17),
            child: Text(
              "Im Sommersemester an acht Terminen im April jeweils Dienstags und Donnerstag von 11:00 - 12:00 Uhr in Raum N 313 (neben dem Fachbereichsdekanat).\n" +
                  "\nIm Wintersemester an acht Terminen zwischen 15. Oktober und 15. November jeweils Dienstags und Donnerstags von 11:00 - 12:00 Uhr in Raum N 313 (neben dem Fachbereichsdekanat).",
              textAlign: TextAlign.start,
              style: new TextStyle(fontSize: 16),
            ),
          )
        ],
      ),
    ];

    return _items;
  }
}
