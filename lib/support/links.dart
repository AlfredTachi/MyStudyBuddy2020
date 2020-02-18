import 'package:flutter/material.dart';
import '../drawer/drawer.dart';

class Links extends StatefulWidget {
  @override
  LinksState createState() => LinksState();
}

class LinksState extends State<Links> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Nützliche Links"),
      ),
      drawer: OwnDrawer(),
      /*body: 
      ListView(padding: EdgeInsets.zero, children: [
        ListTile(
          leading: Icon(Icons.help),
          title: Text('Links'),
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
          title: Text('Links'),
          onTap: () {
            //Navigator.pushNamed(context, '/');
          },
        ),
      ]),*/   
    );
  }
}