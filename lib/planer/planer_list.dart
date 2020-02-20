import 'package:MyStudyBuddy2/planer/upcoming_events.dart';
import 'package:flutter/material.dart';

class PlanerList extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _PlanerListState();
  }
}
List<String> appointments = List<String>();

class _PlanerListState extends State<PlanerList> {
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: ListView.builder(
      scrollDirection: Axis.vertical,
      itemCount: appointments.length,
      shrinkWrap: true,
      itemBuilder: (BuildContext context, int index) => Container(
          width: MediaQuery.of(context).size.width,
          child: Card(
              margin: new EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
              elevation: 8.0,
              child: ListTile(
                onTap: (){
                  setState(() {
                  events.add(appointments[index]);
                  appointments.remove(appointments[index]);
                  });
                },
                contentPadding:
                EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
                leading: Container(
                    child: Text(
                  appointments[index],
                  style: TextStyle(fontSize: 22),
                )),
                trailing: Icon(Icons.favorite, color: Colors.red),
              ))),
    ));
  }
}
