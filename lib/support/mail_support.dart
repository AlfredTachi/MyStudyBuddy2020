import 'package:flutter/material.dart';

class MailSupport extends StatefulWidget {
  @override
  MailSupportState createState() => MailSupportState();
}

class MailSupportState extends State<MailSupport> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("FAQ"),
        leading: IconButton(icon:Icon(Icons.arrow_back),
        onPressed:() => Navigator.pop(context, false),
      ),
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
    )
    );
  }
}