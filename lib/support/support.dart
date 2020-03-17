import 'package:flutter/material.dart';
import 'package:flutter_mailer/flutter_mailer.dart';
import 'package:url_launcher/url_launcher.dart';

class Support extends StatefulWidget {
  @override
  SupportState createState() => SupportState();
}

class SupportState extends State<Support> {
  @override
  Widget build(BuildContext context) {
    final MailOptions mailOptions = MailOptions(
      subject: 'Support My Study Buddy',
      recipients: ['inf2671@hs-worms.de'],
    );
    return Scaffold(
      appBar: AppBar(
        title: Text("Hilfe"),
      ),
      body: ListView(padding: EdgeInsets.zero, children: [
        ListTile(
          leading: Icon(Icons.help),
          title: Text('FAQ'),
          onTap: () {
            Navigator.pushNamed(context, '/supportMain/FAQ');
          },
        ),
        ListTile(
          leading: Icon(Icons.book),
          title: Text('Schnelleinstieg'),
          onTap: () {
            Navigator.pushNamed(context, '/supportMain/quickaccess');
          },
        ),
        ListTile(
            leading: Icon(Icons.mail),
            title: Text('E-Mail Support'),
            onTap: () async {
              try {
                await FlutterMailer.send(mailOptions);
              } catch (error) {}
            }),
        ListTile(
            leading: Icon(Icons.info),
            title: Text('Impressum'),
            onTap: () {
                Navigator.pushNamed(context, '/supportMain/impressum');
                }),
        ListTile(
            leading: Icon(Icons.lock),
            title: Text('Datenschutz'),
            onTap: (){
              Navigator.pushNamed(context, '/supportMain/privacyPolice/privacyPolice');
            }),
      ]),
    );
  }
}
