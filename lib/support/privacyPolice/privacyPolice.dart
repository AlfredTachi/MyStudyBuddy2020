import 'package:flutter/material.dart';

class PrivacyPolice extends StatefulWidget {
  @override
  PrivacyPoliceState createState() => PrivacyPoliceState();
}

class PrivacyPoliceState extends State<PrivacyPolice> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Datenschutzerklärungen"),
      ),
      body: ListView(padding: EdgeInsets.zero, children: [
        ListTile(
          leading: Icon(Icons.account_circle),
          title: Text('Unsere Datenschutzerklärung'),
          onTap: () {
            Navigator.pushNamed(context, '/supportMain/privacyPolice/ourPrivacyPolice');
          },
        ),
        ListTile(
          leading: Icon(Icons.settings),
          title: Text('Studierendenwerk Datenschutzerklärung'),
          onTap: () {
            Navigator.pushNamed(context, '/supportMain/privacyPolice/studierendenwerkPrivacyPolice');
          },
        ),
        ListTile(
          leading: Icon(Icons.lock_outline),
          title: Text('LSF Datenschutzerklärung'),
          onTap: () {
            Navigator.pushNamed(context, '/supportMain/privacyPolice/lsfPrivacyPolice');
          },
        ),
      ]),
    );
  }
}
