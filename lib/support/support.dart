import 'package:flutter/material.dart';
import '../drawer/drawer.dart';

class Support extends StatefulWidget {
  @override
  SupportState createState() => SupportState();
}

class SupportState extends State<Support> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Hilfe"),
      ),
      drawer: OwnDrawer(),
      body: ListView(padding: EdgeInsets.zero, children: [
        ListTile(
          leading: Icon(Icons.help),
          title: Text('FAQ'),
          onTap: () {
            Navigator.pushNamed(context, '/supportMain/FAQ');
          },
        ),
        ListTile(
          leading: Icon(Icons.remove_red_eye),
          title: Text('Schnelleinstieg'),
          onTap: () {
            Navigator.pushNamed(context, '/supportMain/quickaccess');
          },
        ),
        ListTile(
          leading: Icon(Icons.mail),
          title: Text('E-Mail Support'),
          onTap: () {
            Navigator.pushNamed(context, '/supportMain/mailSupport');
          },
        ),
      ]),
    );
  }
}
