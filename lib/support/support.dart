import 'package:flutter/material.dart';
import 'package:flutter_mailer/flutter_mailer.dart';

class Support extends StatefulWidget {
  @override
  SupportState createState() => SupportState();
}

class SupportState extends State<Support> {
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
                      onPressed: () {
                        Navigator.of(context).pop();
                      }),
                ),
                Align(
                  alignment: Alignment.topCenter,
                                child: Padding(
                    padding: const EdgeInsets.only(left: 20, top: 3, bottom: 3),
                    child: Text("Hilfe",style:TextStyle(fontSize: 25)),
                  ),
                )
              ],
            ),
          ),
          Expanded(
              child:
                  SingleChildScrollView(child: Column(children: createList()))),
        ],
      )),
    );
  }

  List<Widget> createList() {
    final MailOptions mailOptions = MailOptions(
      subject: 'Support My Study Buddy',
      recipients: ['inf2671@hs-worms.de'],
    );
    List<Widget> _items = [
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
          onTap: () {
            Navigator.pushNamed(
                context, '/supportMain/privacyPolice/privacyPolice');
          }),
    ];

    return _items;
  }
}
