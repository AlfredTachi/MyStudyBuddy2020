import 'package:MyStudyBuddy2/link/link.dart';
import 'package:flutter/material.dart';

class Quickaccess extends StatefulWidget {
  @override
  QuickaccessState createState() => QuickaccessState();
}

List<Widget> links = [
  Link(
      child: Text('HS Worms Website', textAlign: TextAlign.center),
      url: 'https://www.hs-worms.de/'),
  Link(
      child: Text('moodle', textAlign: TextAlign.center),
      url: 'https://moodle.hs-worms.de/moodle/'),
  Link(
      child: Text('LSF', textAlign: TextAlign.center),
      url: 'https://lsf.hs-worms.de/qisserver/rds?state=user&type=0'),
  Link(
      child: Text('Webmailer', textAlign: TextAlign.center),
      url: 'https://webmailer2.hs-worms.de/roundcube/'),
  Link(
      child: Text('Studierendenvertretungen', textAlign: TextAlign.center),
      url:
          'https://www.hs-worms.de/hochschule/hochschule-worms/gremien/studierendenvertretungen/'),
  Link(
      child: Text('Fachschaft Informatik', textAlign: TextAlign.center),
      url: 'https://fsinf.hs-worms.de/'),
  Text('Moralische Unterstützung', textAlign: TextAlign.center),
];

void goToMoralSupport(BuildContext context) {
  Navigator.of(context).pushNamed("/supportMain/quickAccess/moralSupport");
}

class QuickaccessState extends State<Quickaccess> {
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
                        
                           onPressed: () => Navigator.pop(context, false),
                        ),
                  ),
                  Align(
                    alignment: Alignment.topCenter,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 20, top: 3, bottom: 3),
                      child: Text("Schnelleinstieg", style: TextStyle(fontSize: 25)),
                    ),
                  )
                ],
              ),
            ),
              ListView.builder(
                  scrollDirection: Axis.vertical,
                  itemCount: links.length,
                  shrinkWrap: true,
                  itemBuilder: (BuildContext context, int index) {
                    if (index != 6) {
                      return Container(
                          width: MediaQuery.of(context).size.width,
                          child: Card(
                            margin: new EdgeInsets.symmetric(
                                horizontal: 10.0, vertical: 6.0),
                            elevation: 8.0,
                            child: ListTile(
                                contentPadding: EdgeInsets.symmetric(
                                    horizontal: 20.0, vertical: 10.0),
                                leading: links[index]),
                          ));
                    } else if (links[index].runtimeType == Text) {
                      return Container(
                          width: MediaQuery.of(context).size.width,
                          child: GestureDetector(
                            onTap: () {
                              goToMoralSupport(context);
                            },
                            child: Card(
                              margin: new EdgeInsets.symmetric(
                                  horizontal: 10.0, vertical: 6.0),
                              elevation: 8.0,
                              child: ListTile(
                                  contentPadding: EdgeInsets.symmetric(
                                      horizontal: 20.0, vertical: 10.0),
                                  leading: links[index]),
                            ),
                          ));
                    } else {
                      return Container(
                          width: MediaQuery.of(context).size.width,
                          child: Card(
                            margin: new EdgeInsets.symmetric(
                                horizontal: 10.0, vertical: 6.0),
                            elevation: 8.0,
                            child: ListTile(
                                contentPadding: EdgeInsets.symmetric(
                                    horizontal: 20.0, vertical: 10.0),
                                leading: links[index]),
                          ));
                    }
                  }),
            ],
          )),
    );
  }
}
