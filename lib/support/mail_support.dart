import 'package:flutter/material.dart';
import '../drawer/drawer.dart';

class MailSupport extends StatefulWidget {
  @override
  MailSupportState createState() => MailSupportState();
}

class MailSupportState extends State<MailSupport> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("E-Mail Support"),
      ),
      drawer: OwnDrawer(),
      /*body: 
      ListView(padding: EdgeInsets.zero, children: [
        ListTile(
          leading: Icon(Icons.help),
          title: Text('MailSupport'),
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
          title: Text('MailSupport'),
          onTap: () {
            //Navigator.pushNamed(context, '/');
          },
        ),
      ]),*/   
    );
  }
}