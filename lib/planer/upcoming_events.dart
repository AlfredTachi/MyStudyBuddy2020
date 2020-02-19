import 'package:flutter/material.dart';
import './planer_list.dart';

class EventList extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _EventListState();
  }
}
List<String> events = ["ein Termin", "ein anderer Termin", "3", "4", "5","noch mehr","und so","whoooop"];
class _EventListState extends State<EventList> {

  int removePos;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: ListView.builder(
      scrollDirection: Axis.vertical,
      itemCount: events.length,
      shrinkWrap: true,
      itemBuilder: (BuildContext context, int index) => Container(
          width: MediaQuery.of(context).size.width,
          child: Card(
              margin: new EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
              elevation: 8.0,
              child: ListTile(
                onTap: (){
                  setState(() {
                  appointments.add(events[index]);
                  events.remove(events[index]);
                  });

                },
                contentPadding:
                    EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
                leading: Container(
                    child: Text(
                  events[index],
                  style: TextStyle(fontSize: 22),
                )),
                trailing: Icon(Icons.favorite),
              ))),
    ));
  }
}
