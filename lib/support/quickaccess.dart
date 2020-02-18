import 'package:flutter/material.dart';
import 'package:link/link.dart';

class Quickaccess extends StatefulWidget {
  @override
  QuickaccessState createState() => QuickaccessState();
}

class QuickaccessState extends State<Quickaccess> {

  void _showErrorSnackBar() {
    Scaffold.of(context).showSnackBar(
      SnackBar(
        content: Text('Oops... the URL couldn\'t be opened!'),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Schnelleinstieg"),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context, false),
        ),
      ),
      body: ListView(padding: EdgeInsets.zero, children: [
        ExpansionTile(
          title: Text('HS Worms Website'),
          children: <Widget>[
            Link(
              child: Text('Link zur Website',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.blue[900],
                  )),
              url: 'https://www.hs-worms.de/',
              onError: _showErrorSnackBar,
            ),
          ],
        ),
        ExpansionTile(
          title: Text('Moodle'),
          children: <Widget>[
            Link(
              child: Text('Link zu moodle',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.blue[900],
                  )),
              url: 'https://moodle.hs-worms.de/moodle/',
              onError: _showErrorSnackBar,
            ),
          ],
        ),
        ExpansionTile(
          title: Text('LSF'),
          children: <Widget>[
            Link(
              child: Text('Link zum LSF',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.blue[900],
                  )),
              url: 'https://lsf.hs-worms.de/qisserver/rds?state=user&type=0',
              onError: _showErrorSnackBar,
            ),
          ],
        ),
        ExpansionTile(
          title: Text('Webmailer'),
          children: <Widget>[
            Link(
              child: Text('Link zum Webmailer',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.blue[900],
                  )),
              url: 'https://webmailer2.hs-worms.de/roundcube/',
              onError: _showErrorSnackBar,
            ),
          ],
        ),
        ExpansionTile(
          title: Text('AStA'),
          children: <Widget>[
            Link(
              child: Text('Link zum AStA',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.blue[900],
                  )),
              url: 'http://asta.hs-worms.de/',
              onError: _showErrorSnackBar,
            ),
          ],
        ),
        ExpansionTile(
          title: Text('Fachschaft Informatik'),
          children: <Widget>[
            Link(
              child: Text('Link zur FS Info',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.blue[900],
                  )),
              url: 'https://fsinf.hs-worms.de/cms/',
              onError: _showErrorSnackBar,
            ),
          ],
        ),
      ]),
    );
  }
}
