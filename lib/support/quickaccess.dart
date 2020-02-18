import 'package:flutter/material.dart';
import '../drawer/drawer.dart';

class Quickaccess extends StatefulWidget {
  @override
  QuickaccessState createState() => QuickaccessState();
}

class QuickaccessState extends State<Quickaccess> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Schnelleinstieg"),
      ),
      drawer: OwnDrawer(),
      /*body: 
      ListView(padding: EdgeInsets.zero, children: [
        ListTile(
          leading: Icon(Icons.help),
          title: Text('Quickaccess'),
          onTap: () {
            //Navigator.pushNamed(context, '/');
          },
        ),
        ListTile(
          leading: Icon(Icons.remove_red_eye),
          title: Text('Schnelleinstieg'),
          onTap: () {
            //Navigator.pushNamed(context, '/');
          },
        ),
        ListTile(
          leading: Icon(Icons.book),
          title: Text('Nützliche Links'),
          onTap: () {
            //Navigator.pushNamed(context, '/');
          },
        ),
         ListTile(
          leading: Icon(Icons.mail),
          title: Text('Quickaccess'),
          onTap: () {
            //Navigator.pushNamed(context, '/');
          },
        ),
      ]),*/   
    );
  }
}