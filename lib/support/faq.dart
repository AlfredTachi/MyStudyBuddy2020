import 'package:flutter/material.dart';
import '../drawer/drawer.dart';

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
      ),
      drawer: OwnDrawer(),
      /*body: 
      ListView(padding: EdgeInsets.zero, children: [
        ListTile(
          leading: Icon(Icons.help),
          title: Text('FAQ'),
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
          title: Text('FAQ'),
          onTap: () {
            //Navigator.pushNamed(context, '/');
          },
        ),
      ]),*/   
    );
  }
}